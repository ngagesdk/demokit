LDFLAGS := -lSDL2
CFLAGS := -O3 -Werror -Wall -Wextra -pedantic -std=c90 -g
#CFLAGS := -O3 -Werror -Wall -Wextra -pedantic -std=c90

#CFLAGS += $(shell pkg-config SDL_image --cflags)
#CFLAGS += $(shell sdl-config --cflags)
#LIBS += $(shell pkg-config SDL_image --libs)
#LIBS += $(shell sdl-config --libs)

#CFLAGS += $(LIBS)

# CFLAGS += -Wno-switch
CFLAGS += -Wno-overlength-strings

all: fire

run: fire
	./fire

OBJS := fire.c firepal.c
INC := firepal.h

fire: $(OBJS) $(INC)
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $@

.PHONY: clean
clean:
	-rm -f fire *.o
