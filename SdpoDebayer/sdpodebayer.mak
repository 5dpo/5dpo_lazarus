
CROSS_COMPILE   = /usr/bin/

CC              = $(CROSS_COMPILE)gcc

#CFLAGS=-W -Wall -g -O3 -pipe -march=pentium-m
CFLAGS=-W -Wall -g -O3 -pipe -march=native -flax-vector-conversions 


libmmxdebayer.a: mmxdebayer.o mmxdebayer.c sdpodebayer.mak
	ar rcs libmmxdebayer.a mmxdebayer.o

mmxdebayer.o: mmxdebayer.c sdpodebayer.mak
	$(CC) -c mmxdebayer.c $(CFLAGS)

#windows: mmxdebayer.c 
#	gcc -c mmxdebayer.c -DBUILD_DLL -W -Wall -g -O3 -march=pentium-m -ffast-math -fno-exceptions -flax-vector-conversions
#	gcc -shared -o mmxdebayer.dll mmxdebayer.o -Wl,--out-implib,libmmxdebayer.a

