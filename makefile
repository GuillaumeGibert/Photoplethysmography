all: FFT ImageProcessing SignalProcessing main
	g++ -o bin/ppg lib/main.o lib/FFT.o lib/ImageProcessing.o lib/SignalProcessing.o -L/usr/lib/x86_64-linux-gnu `pkg-config --libs opencv4`
	
FFT: src/FFT.cpp
	g++ -c src/FFT.cpp -o lib/FFT.o -I./include -I/usr/include/opencv4
	
main: src/main.cpp
	g++ -c src/main.cpp -o lib/main.o -I./include -I/usr/include/opencv4
	
ImageProcessing: src/ImageProcessing.cpp
	g++ -c src/ImageProcessing.cpp -o lib/ImageProcessing.o -I./include -I/usr/include/opencv4
	
SignalProcessing: src/SignalProcessing.cpp
	g++ -c src/SignalProcessing.cpp -o lib/SignalProcessing.o -I./include -I/usr/include/opencv4
	
clean:
	rm lib/*.o
	rm bin/*