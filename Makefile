# general c++ makefile made by Raoul Kalkman on 10/2/2021
# this is a makefile which should compile most basic c++ projects, 
# which don't require the use of a library.
# automatically finds all headers, cpp files. 
# extra functions don't work when cli input is expected!

TARGET := main # change this to how you want to name exec
SOURCES := $(wildcard *.cpp)
HEADERS := $(wildcard *.h)
OBJECTS := $(SOURCES:.cpp=.o)
DEPS := $(SOURCES:.cpp=.d)
CXX := g++
FLAGSWARNING := -Wall -Wextra -pedantic -std=c++17
FLAGSDEPLOY := -Wall -std=c++17 -O2
FLAGSCLANG := -Wall -Wextra -pedantic

# from here we will define different ways to actually make

.PHONY: all clean make deploy valgrind debug clang

all: $(TARGET)

clean:
	rm -f $(OBJECTS) $(DEPS) $(TARGET)

# fixme: doesn't properly work on linux
clang:  
	clang++ $(FLAGSCLANG) $(HEADERS) $(SOURCES) -o $(TARGET)

deploy: clean
	$(CXX) $(FLAGSDEPLOY) $(HEADERS) $(SOURCES) -o $(TARGET)

valgrind: clean all
	valgrind --tool=memcheck ./$(TARGET)

debug: clean
	$(CXX) -g -std=c++17 $(HEADERS) $(SOURCES) -o $(TARGET)
	gdb ./$(TARGET)

$(TARGET): $(OBJECTS) $(HEADERS)
	$(CXX) $(FLAGSWARNING) $(HEADERS) $(SOURCES) -o $(TARGET)

