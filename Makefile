UNAME := $(shell uname)
LIBDIR := $(shell racket -e "(require setup/dirs) (display (find-lib-dir))")



ifeq ($(UNAME), Darwin)
	EXTENSION := dylib
else
	EXTENSION := so
endif

all: MurmurHash3.${EXTENSION}

MurmurHash3.${EXTENSION}: MurmurHash3.c
	gcc -std=c99 -shared -o MurmurHash3.${EXTENSION} MurmurHash3.c

clean:
	rm -f MurmurHash3.${EXTENSION}

install: all
	cp MurmurHash3.${EXTENSION} ${LIBDIR}/MurmurHash3.${EXTENSION}


