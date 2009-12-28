LDFLAGS = -L/Library/Fink/sl64/lib -llzma -Wall
CFLAGS = -I/Library/Fink/sl64/include -g -O0 -std=c99 -Wall

pixz: pixz.o encode.o block.o
	gcc $(LDFLAGS) -o $@ $^

%.o: %.c pixz.h
	gcc $(CFLAGS) -c -o $@ $<

run: pixz
	time ./$< < test.in > test.out
	@md5sum test.in
	@xz -d < test.out | md5sum

clean:
	rm -f *.o pixz test.out

.PHONY: run clean