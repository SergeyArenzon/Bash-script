output: main.o 
	g++ main.o -o output -lpthread 

main.o: main.cpp
	g++ -c main.cpp	-lpthread

clean:
	rm *.o output
