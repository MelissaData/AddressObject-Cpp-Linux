# Melissa Address Object Linux C++

CXX = g++
CXXFLAGS = -Wall -Wextra -pedantic -std=c++11 -g
LDLIBS = -lmdAddr
LDFLAGS = -L/mnt/f/TEST/linux/AddressObject-Cpp-Linux/MelissaAddressObjectLinuxCpp/Build
RM = rm -f

OUT_DIR = Build

MelissaAddressObjectLinuxCpp: Main.cpp AddressObject.cpp mdAddr.h mdEnums.h | $(OUT_DIR)
	$(CXX) $(CXXFLAGS) Main.cpp AddressObject.cpp $(LDFLAGS) $(LDLIBS) -o $(OUT_DIR)/$@

clean:
	$(RM) *.o $(OUT_DIR)/MelissaAddressObjectLinuxCpp
