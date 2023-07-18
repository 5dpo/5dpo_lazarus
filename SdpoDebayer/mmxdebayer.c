#include <string.h>
#include <stdio.h>
#include <math.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/time.h>
#include <unistd.h>
#include <mmintrin.h>
#include "mmxdebayer.h"

#define INLINE static inline __attribute__((always_inline))

INLINE __m64 load_simd(byte *src)
{
	static __v4hi mask_lo = {0xFF, 0xFF, 0xFF, 0xFF};
	return _mm_and_si64(*((__v4hi *)src), mask_lo);
}

INLINE __m64 interpolation4(byte *s1_ptr, byte *b1_ptr, byte *s_ptr, byte *b2_ptr, byte *s2_ptr)
{
	__m64 s1, b1, s, b2, s2, res;

	s1 = load_simd(s1_ptr);
	s = load_simd(s_ptr);
	s2 = load_simd(s2_ptr);
	b1 = load_simd(b1_ptr);
	b2 = load_simd(b2_ptr);
	
/*	The calculation implemented here using SIMD instructions is equivalent to:
	d1 = b1 * 2 - (s1 - s);
	d2 = b2 * 2 - (s2 - s);
	res = (d1 + d2) / 4;
	which is equivalent to:
	res = ((b1 + b2 + s) * 2 - (s1 + s2)) / 4;*/
	
	res = _mm_slli_pi16(_mm_add_pi16(_mm_add_pi16(b1, b2), s), 1);
	return _mm_srai_pi16(_mm_sub_pi16(res, _mm_add_pi16(s1, s2)), 2);
}

INLINE __m64 interpolation8(byte *s1_ptr, byte *b1_ptr, byte *s_ptr, byte *b2_ptr, byte *s2_ptr)
{
	return _mm_packs_pu16(
		interpolation4(s1_ptr, b1_ptr, s_ptr, b2_ptr, s2_ptr),
		interpolation4(s1_ptr + 8, b1_ptr + 8, s_ptr + 8, b2_ptr + 8, s2_ptr + 8));
}

#define GETP(y,x)	(&src[(y)*width + (x)])

INLINE __m64 interpol_vert(byte *src, int y, int x, int width)
{
	return interpolation8(GETP(y-2,x), GETP(y-1,x), GETP(y,x), GETP(y+1,x), GETP(y+2,x));
}

INLINE __m64 interpol_horiz(byte *src, int y, int x, int width)
{
	return interpolation8(GETP(y,x-2), GETP(y,x-1), GETP(y,x), GETP(y,x+1), GETP(y,x+2));
}

static __v8qi shift_mask = {0x7F,0x7F,0x7F,0x7F,0x7F,0x7F,0x7F,0x7F};

INLINE __m64 calc_plus(byte *src, int y, int x, int width)
{
	__m64 res1, res2;

	res1 = interpolation8(GETP(y-2,x), GETP(y-1,x), GETP(y,x), GETP(y+1,x), GETP(y+2,x));
	res2 = interpolation8(GETP(y,x-2), GETP(y,x-1), GETP(y,x), GETP(y,x+1), GETP(y,x+2));

	return _mm_add_pi8( _mm_and_si64(_mm_srli_si64(res1, 1), shift_mask) , _mm_and_si64(_mm_srli_si64(res2, 1), shift_mask) );
}

INLINE __m64 calc_cross(byte *src, int y, int x, int width)
{
	__m64 res1, res2;

	res1 = interpolation8(GETP(y-2,x-2), GETP(y-1,x-1), GETP(y,x), GETP(y+1,x+1), GETP(y+2,x+2));
	res2 = interpolation8(GETP(y-2,x+2), GETP(y-1,x+1), GETP(y,x), GETP(y+1,x-1), GETP(y+2,x-2));

	return _mm_add_pi8( _mm_and_si64(_mm_srli_si64(res1, 1), shift_mask) , _mm_and_si64(_mm_srli_si64(res2, 1), shift_mask) );
}

INLINE __m64 load_bayer(byte *src, int y, int x, int width)
{
	return _mm_packs_pu16(load_simd(GETP(y,x)), load_simd(GETP(y,x+8)));
}

INLINE void sub_write_interlaced32(byte *dest, __m64 red, __m64 green, __m64 blue)
{
	static __v8qi zero_mmx = {0,0,0,0,0,0,0,0};
	__m64 rg_hi, rg_lo, bz_hi, bz_lo;

	rg_lo = _mm_unpacklo_pi8(red, green);
	rg_hi = _mm_unpackhi_pi8(red, green);
	bz_lo = _mm_unpacklo_pi8(blue, zero_mmx);
	bz_hi = _mm_unpackhi_pi8(blue, zero_mmx);
	
	*((__m64 *)dest) = _mm_unpacklo_pi16(rg_lo, bz_lo);
	dest += 8;
	*((__m64 *)dest) = _mm_unpackhi_pi16(rg_lo, bz_lo);
	dest += 8;
	*((__m64 *)dest) = _mm_unpacklo_pi16(rg_hi, bz_hi);
	dest += 8;
	*((__m64 *)dest) = _mm_unpackhi_pi16(rg_hi, bz_hi);
}


INLINE void write_interlaced32(byte *dest, __m64 r1, __m64 g1, __m64 b1, __m64 r2, __m64 g2, __m64 b2)
{
	__m64 red_hi, red_lo, green_hi, green_lo, blue_hi, blue_lo;

	red_lo = _mm_unpacklo_pi8(r1,r2);
	red_hi = _mm_unpackhi_pi8(r1,r2);
	green_lo = _mm_unpacklo_pi8(g1,g2);
	green_hi = _mm_unpackhi_pi8(g1,g2);
	blue_lo = _mm_unpacklo_pi8(b1,b2);
	blue_hi = _mm_unpackhi_pi8(b1,b2);
	
	sub_write_interlaced32(dest, red_lo, green_lo, blue_lo);
	sub_write_interlaced32(dest + 32, red_hi, green_hi, blue_hi);
}



INLINE void sub_sub_write_interlaced16(byte *dest, __m64 red, __m64 green, __m64 blue)
{
	static __v4hi red_mask_mmx = {0xF800,0xF800,0xF800,0xF800};
	static __v4hi green_mask_mmx = {0x07E0,0x07E0,0x07E0,0x07E0};
	static __v4hi blue_mask_mmx = {0x001F,0x001F,0x001F,0x001F};

	red = _mm_and_si64(_mm_slli_si64(red, 8), red_mask_mmx);
	green = _mm_and_si64(_mm_slli_si64(green, 3), green_mask_mmx);
	blue = _mm_and_si64(_mm_srli_si64(blue, 3), blue_mask_mmx);

	*((__m64 *)dest) = _mm_or_si64(_mm_or_si64(red, green), blue);
}

INLINE void sub_write_interlaced16(byte *dest, __m64 red, __m64 green, __m64 blue)
{
	static __v8qi zero_mmx = {0,0,0,0,0,0,0,0};
	__m64 red16, green16, blue16;

	red16 = _mm_unpacklo_pi8(red, zero_mmx);
	green16 = _mm_unpacklo_pi8(green, zero_mmx);
	blue16 = _mm_unpacklo_pi8(blue, zero_mmx);
	sub_sub_write_interlaced16(dest, red16, green16, blue16);
	
	red16 = _mm_unpackhi_pi8(red, zero_mmx);
	green16 = _mm_unpackhi_pi8(green, zero_mmx);
	blue16 = _mm_unpackhi_pi8(blue, zero_mmx);
	sub_sub_write_interlaced16(dest + 8, red16, green16, blue16);
}

INLINE void write_interlaced16(byte *dest, __m64 r1, __m64 g1, __m64 b1, __m64 r2, __m64 g2, __m64 b2)
{
	__m64 red_hi, red_lo, green_hi, green_lo, blue_hi, blue_lo;

	red_lo = _mm_unpacklo_pi8(r1,r2);
	red_hi = _mm_unpackhi_pi8(r1,r2);
	green_lo = _mm_unpacklo_pi8(g1,g2);
	green_hi = _mm_unpackhi_pi8(g1,g2);
	blue_lo = _mm_unpacklo_pi8(b1,b2);
	blue_hi = _mm_unpackhi_pi8(b1,b2);

	sub_write_interlaced16(dest, red_lo, green_lo, blue_lo);
	sub_write_interlaced16(dest + 16, red_hi, green_hi, blue_hi);
}



INLINE void yuv_to_rgb4x16(byte *src, __m64 *r, __m64 *g, __m64 *b)
{
	static __v4hi 
	  mask_y = {0xFF, 0xFF, 0xFF, 0xFF},
	  mask_u = {0xFF00, 0, 0xFF00, 0}, mask_v = {0, 0xFF00, 0, 0xFF00},
	  unsign_sat = {0x4000, 0x4000, 0x4000, 0x4000},
	  gr_1 = {90,90,90,90}, gr_2 = {11453,11453,11453,11453},
	  gg_1 = {22,22,22,22}, gg_2 = {46,46,46,46}, gg_3 = {8701,8701,8701,8701},
	  gb_1 = {113,113,113,113}, gb_2 = {14484,14484,14484,14484};

	__m64 mmx_src;
	__m64 y, u, v;
	
	mmx_src = *((__v4hi *)src);
	
	y = _mm_and_si64(mmx_src, mask_y);
	u = _mm_srli_si64(_mm_and_si64(mmx_src, mask_u), 8);
	u = _mm_or_si64(u, _mm_slli_si64(u, 16));
	v = _mm_srli_si64(_mm_and_si64(mmx_src, mask_v), 8);
	v = _mm_or_si64(v, _mm_srli_si64(v, 16));
	
	//*r = y; *g = y; *b = y;
	
	y = _mm_slli_si64(y, 6);
	*r = _mm_srai_pi16(_mm_subs_pi16(_mm_adds_pi16(y, _mm_mullo_pi16(v, gr_1)), gr_2), 6);
	*g = _mm_srai_pi16(_mm_adds_pi16(_mm_subs_pi16(_mm_subs_pi16(
	                  y, _mm_mullo_pi16(u, gg_1)), _mm_mullo_pi16(v, gg_2)), gg_3), 6);
	*b = _mm_srai_pi16(_mm_subs_pi16(_mm_adds_pi16(y, _mm_mullo_pi16(u, gb_1)), gb_2), 6);
	
	*r = _mm_sub_pi16(_mm_adds_pi16(*r, unsign_sat), unsign_sat);
	*g = _mm_sub_pi16(_mm_adds_pi16(*g, unsign_sat), unsign_sat);
	*b = _mm_sub_pi16(_mm_adds_pi16(*b, unsign_sat), unsign_sat);
}







void debayer32(byte *src, byte *dest, int width, int height, int offset)
{
	__m64 r1, g1, b1, r2, g2, b2;
	int x, y;

	for (y = 4; y < height-4; y++) {

		// horizontal interpolation
		for (x = 0; x < width; x += 16) {
			b1 = interpol_vert(src, y, x, offset);
			g1 = load_bayer(src, y, x, offset);
			r1 = interpol_horiz(src, y, x, offset);

			b2 = calc_cross(src, y, x+1, offset);
			g2 = calc_plus(src, y, x+1, offset);
			r2 = load_bayer(src, y, x+1, offset);

			write_interlaced32(&dest[(y * width + x) * 4], r1, g1, b1, r2, g2, b2);
		}
		y++;
		for (x = 0; x < width; x += 16) {
			b1 = load_bayer(src, y, x, offset);
			g1 = calc_plus(src, y, x, offset);
			r1 = calc_cross(src, y, x, offset);

			b2 = interpol_horiz(src, y, x+1, offset);
			g2 = load_bayer(src, y, x+1, offset);
			r2 = interpol_vert(src, y, x+1, offset);

			write_interlaced32(&dest[(y * width + x) * 4], r1, g1, b1, r2, g2, b2);
		}
	}

	// empty the multimedia state
	_mm_empty();
}

void debayer32_gbrg(byte *src, byte *dest, int width, int height, int offset)
{
	__m64 r1, g1, b1, r2, g2, b2;
	int x, y;

	for (y = 4; y < height-4; y ++) {

		for (x = 0; x < width; x += 16) {
			r1 = interpol_vert(src, y, x, offset);
			g1 = load_bayer(src, y, x, offset);
			b1 = interpol_horiz(src, y, x, offset);

			r2 = calc_cross(src, y, x+1, offset);
			g2 = calc_plus(src, y, x+1, offset);
			b2 = load_bayer(src, y, x+1, offset);

			write_interlaced32(&dest[(y * width + x) * 4], r1, g1, b1, r2, g2, b2);
		}
		y++;
		for (x = 0; x < width; x += 16) {
			r1 = load_bayer(src, y, x, offset);
			g1 = calc_plus(src, y, x, offset);
			b1 = calc_cross(src, y, x, offset);

			r2 = interpol_horiz(src, y, x+1, offset);
			g2 = load_bayer(src, y, x+1, offset);
			b2 = interpol_vert(src, y, x+1, offset);

			write_interlaced32(&dest[(y * width + x) * 4], r1, g1, b1, r2, g2, b2);
		}
	}

	// empty the multimedia state
	_mm_empty();
}


void debayer32_lum(byte *src, byte *dest, byte *dest_lum, int width, int height, int offset)
{
	__m64 r1, g1, b1, r2, g2, b2;
	int x, y, i;

	for (y = 4; y < height-4; y++) {

		// horizontal interpolation
		for (x = 0; x < width; x += 16) {
			b1 = interpol_vert(src, y, x, offset);
			g1 = load_bayer(src, y, x, offset);
			r1 = interpol_horiz(src, y, x, offset);

			b2 = calc_cross(src, y, x+1, offset);
			g2 = calc_plus(src, y, x+1, offset);
			r2 = load_bayer(src, y, x+1, offset);

			write_interlaced32(&dest[(y * width + x) * 4], r1, g1, b1, r2, g2, b2);
			for (i = 0; i < 16; i++) {
				dest_lum[(y * width + x) + i] = (byte)((dest[(y * width + x) * 4 + i * 4 + 0] +
                                                        dest[(y * width + x) * 4 + i * 4 + 1] +
                                                        dest[(y * width + x) * 4 + i * 4 + 2]) / 3);
			}
		}
		y++;
		for (x = 0; x < width; x += 16) {
			b1 = load_bayer(src, y, x, offset);
			g1 = calc_plus(src, y, x, offset);
			r1 = calc_cross(src, y, x, offset);

			b2 = interpol_horiz(src, y, x+1, offset);
			g2 = load_bayer(src, y, x+1, offset);
			r2 = interpol_vert(src, y, x+1, offset);

			write_interlaced32(&dest[(y * width + x) * 4], r1, g1, b1, r2, g2, b2);
			for (i = 0; i < 16; i++) {
				dest_lum[(y * width + x) + i] = (byte)((dest[(y * width + x) * 4 + i * 4 + 0] +
                                                        dest[(y * width + x) * 4 + i * 4 + 1] +
                                                        dest[(y * width + x) * 4 + i * 4 + 2]) / 3);
			}
		}
	}

	// empty the multimedia state
	_mm_empty();
}


void debayer16(byte *src, byte *dest, int width, int height, int offset)
{
	__m64 r1, g1, b1, r2, g2, b2;
	int x, y;

	for (y = 4; y < height-4; y += 2) {

		// horizontal interpolation
		for (x = 0; x < width; x += 16) {
			r1 = load_bayer(src, y, x, offset);
			g1 = calc_plus(src, y, x, offset);
			b1 = calc_cross(src, y, x, offset);

			r2 = interpol_horiz(src, y, x+1, offset);
			g2 = load_bayer(src, y, x+1, offset);
			b2 = interpol_vert(src, y, x+1, offset);

			write_interlaced16(&dest[(y * width + x) * 2], r1, g1, b1, r2, g2, b2);
		}
		for (x = 0; x < width; x += 16) {
			r1 = interpol_vert(src, y+1, x, offset);
			g1 = load_bayer(src, y+1, x, offset);
			b1 = interpol_horiz(src, y+1, x, offset);

			r2 = calc_cross(src, y+1, x+1, offset);
			g2 = calc_plus(src, y+1, x+1, offset);
			b2 = load_bayer(src, y+1, x+1, offset);

			write_interlaced16(&dest[((y + 1) * width + x) * 2], r1, g1, b1, r2, g2, b2);
		}
	}

	// empty the multimedia state
	_mm_empty();
}

void debayer16_gbrg(byte *src, byte *dest, int width, int height, int offset)
{
	__m64 r1, g1, b1, r2, g2, b2;
	int x, y;

	for (y = 4; y < height-4; y ++) {

		for (x = 0; x < width; x += 16) {
			r1 = interpol_vert(src, y, x, offset);
			g1 = load_bayer(src, y, x, offset);
			b1 = interpol_horiz(src, y, x, offset);

			r2 = calc_cross(src, y, x+1, offset);
			g2 = calc_plus(src, y, x+1, offset);
			b2 = load_bayer(src, y, x+1, offset);

			write_interlaced16(&dest[(y * width + x) * 2], r1, g1, b1, r2, g2, b2);
		}
		y++;
		for (x = 0; x < width; x += 16) {
			r1 = load_bayer(src, y, x, offset);
			g1 = calc_plus(src, y, x, offset);
			b1 = calc_cross(src, y, x, offset);

			r2 = interpol_horiz(src, y, x+1, offset);
			g2 = load_bayer(src, y, x+1, offset);
			b2 = interpol_vert(src, y, x+1, offset);

			write_interlaced16(&dest[(y * width + x) * 2], r1, g1, b1, r2, g2, b2);
		}
	}

	// empty the multimedia state
	_mm_empty();
}



void yuv_rgb16(byte *src, byte *dest, int width, int height, int offset)
{
	__m64 r1, g1, b1, r2, g2, b2;
	int x, y;

	for (y = 0; y < height; y ++, src += offset) {

		for (x = 0; x < width; x += 8) {
			yuv_to_rgb4x16(&src[x*2], &r1, &g1, &b1);
			yuv_to_rgb4x16(&src[x*2 + 8], &r2, &g2, &b2);

			r1 = _mm_packs_pu16(r1, r2);
			g1 = _mm_packs_pu16(g1, g2);
			b1 = _mm_packs_pu16(b1, b2);

			sub_write_interlaced16(&dest[(y * width + x) * 2], r1, g1, b1);
		}
	}

	// empty the multimedia state
	_mm_empty();
}


void yuv_rgb32(byte *src, byte *dest, int width, int height, int offset)
{
	__m64 r1, g1, b1, r2, g2, b2;
	int x, y;

	for (y = 0; y < height; y ++, src += offset) {

		for (x = 0; x < width; x += 8) {
			yuv_to_rgb4x16(&src[x*2], &r1, &g1, &b1);
			yuv_to_rgb4x16(&src[x*2 + 8], &r2, &g2, &b2);

			r1 = _mm_packs_pu16(r1, r2);
			g1 = _mm_packs_pu16(g1, g2);
			b1 = _mm_packs_pu16(b1, b2);

			sub_write_interlaced32(&dest[(y * width + x) * 4], b1, g1, r1);
		}
	}

	// empty the multimedia state
	_mm_empty();
}


INLINE void mmx16to32(__m64 *reg)
{
    static __v8qi red_mask_mmx =   { 0x00, 0x00, 0xF8, 0x00, 0x00, 0x00, 0xF8, 0x00 };
    static __v8qi green_mask_mmx = { 0x00, 0xFC, 0x00, 0x00, 0x00, 0xFC, 0x00, 0x00 };
    static __v8qi blue_mask_mmx =  { 0xF8, 0x00, 0x00, 0x00, 0xF8, 0x00, 0x00, 0x00 };

    static __v8qi blue_red_mask2_mmx = { 0x07, 0x00, 0x07, 0x00, 0x07, 0x00, 0x07, 0x00 };
    static __v8qi green_mask2_mmx =  { 0x00, 0x03, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00 };

    __m64 red, green, blue;

    green = _mm_and_si64(_mm_slli_si64(*reg, 5), green_mask_mmx);
    red = _mm_and_si64(_mm_slli_si64(*reg, 8), red_mask_mmx);
    blue = _mm_and_si64(_mm_slli_si64(*reg, 3), blue_mask_mmx);
    //*reg = _mm_or_si64(_mm_or_si64(red, green), blue);

    blue = _mm_or_si64(red, blue);
    blue = _mm_or_si64(_mm_and_si64(_mm_srli_si64(blue, 5), blue_red_mask2_mmx), blue);
    green = _mm_or_si64(_mm_and_si64(_mm_srli_si64(green, 6), green_mask2_mmx), green);

    *reg = _mm_or_si64(blue, green);
}

void rgb16to32(byte *src, byte *dest, int width, int height, int offset)
{
    static __v8qi zero_mmx = { 0, 0, 0, 0, 0, 0, 0, 0 };
    __m64 c16, c32_1, c32_2;
    int x, y;

    for (y = 0; y < height; y++, src += offset) {
        for (x = 0; x < width; x += 4) {
            c16 = *((__v4hi *)(&src[x * 2]));

            c32_1 = _mm_unpacklo_pi16(c16, zero_mmx);
            mmx16to32(&c32_1);
            *((__v4hi *)(&dest[(y * width + x) * 4])) = c32_1;

            c32_2 = _mm_unpackhi_pi16(c16, zero_mmx);
            mmx16to32(&c32_2);
            *((__v4hi *)(&dest[(y * width + x) * 4 + 8])) = c32_2;
        }
    }

    // empty the multimedia state
    _mm_empty();
}




void green_balance(byte *src, byte *dest, int width, int height, int offset, int red_green_gain)
{
	static __v4hi mask_lo = {0xFF, 0xFF, 0xFF, 0xFF};
	static __v4hi mask_hi = {0xFF00, 0xFF00, 0xFF00, 0xFF00};
	static __v4hi mmx_gain;
	__m64 mmx_src, r;
	int x, y;

	((short int *)(&mmx_gain))[0] = red_green_gain;
	((short int *)(&mmx_gain))[1] = red_green_gain;
	((short int *)(&mmx_gain))[2] = red_green_gain;
	((short int *)(&mmx_gain))[3] = red_green_gain;

	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x += 8) {
			mmx_src = *((__m64 *)(&src[y * offset + x]));
			r = _mm_and_si64(_mm_mullo_pi16(_mm_and_si64(mmx_src, mask_lo), mmx_gain), mask_hi);
			*((__m64 *)(&dest[y * width + x])) = _mm_adds_pu8(mmx_src, r);
		}
		y++;
		memcpy(&dest[y * width], &src[y * offset], width);
	}

	// empty the multimedia state
	_mm_empty();
}

