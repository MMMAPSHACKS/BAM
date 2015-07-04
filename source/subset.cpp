// pick a subset of a csv file
//
// Martin Leadbeater, 2015

#include <iostream>
#include <fstream>

const int subset_percent = 5;

int main(int argc, char *argv[]) {
	for (int i=1; i<argc; ++i) {
		std::ifstream in(argv[i]);
		char buf[10240];
		int lineno = 0;
		while (in.getline(buf, 10240, '\n')) {
			if (lineno++ == 0 || random() % 100 < subset_percent)
				std::cout << buf << "\n";
		}
	}

	return EXIT_SUCCESS;
}
