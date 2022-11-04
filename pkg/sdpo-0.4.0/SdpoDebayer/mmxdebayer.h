#ifndef MMXDEBAYER_H
#define MMXDEBAYER_H

typedef unsigned char byte;
typedef unsigned short word;
typedef unsigned int dword;

void debayer32(byte *src, byte *dest, int width, int height, int offset);
void debayer16(byte *src, byte *dest, int width, int height, int offset);
void debayer16_gbrg(byte *src, byte *dest, int width, int height, int offset);

void yuv_rgb16(byte *src, byte *dest, int width, int height, int offset);
void yuv_rgb32(byte *src, byte *dest, int width, int height, int offset);

void debayer32_lum(byte *src, byte *dest, byte *dest_lum, int width, int height, int offset);

// multiply the red values of a bayer pattern by a constant and add to the green values on the same line
//void green_balance(byte *src, byte *dest, int width, int height, int offset, double red_green_gain);

#endif
