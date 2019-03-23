#/usr/bin/g++-8 -std=c++17 -O2 -Wall -pedantic -pthread
# Put the names of your source files here
#SOURCES=source.cpp
SOURCES=main.cpp

# Set CFLAGS
#CFLAGS=-Wall -std=c++11
CFLAGS=-std=c++17 -O2 -Wall -pedantic -pthread

# SET THE SETTINGS
# Windows
ifeq ($(OS),Windows_NT)
    CC=g++
    OUTPUT=a.exe
    DEL=del
else
# nix
    #CC=g++
    CC=/usr/bin/g++-8
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
