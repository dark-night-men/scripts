#/usr/bin/g++-8 -std=c++17 -O2 -Wall -pedantic -pthread
# Put the names of your source files here
#SOURCES=source.cpp
SOURCES=main.cpp

# Set CFLAGS
CFLAGS=-std=c++2b -O2 -Wall -pedantic -pthread -Werror -Wextra

# SET THE SETTINGS
# Windows
ifeq ($(OS),Windows_NT)
    CC=g++
    OUTPUT=a.exe
    DEL=del
else
# nix
    #CC=g++
    CC=/usr/bin/g++-11
    OUTPUT=a.out
    DEL=rm -v
endif

OBJECTS=$(SOURCES:.cpp=.o)

# DO THE WORK
all: $(SOURCES) $(OUTPUT)

$(OUTPUT): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@

.cpp.o:
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	$(DEL) *.o $(OUTPUT)
