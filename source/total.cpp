#include <iostream>
#include <string>
#include <map>
#include <stdlib.h>
#include <math.h>

void usage(const char *prog) {
	std::cout << "usage: " << prog << " year\n";
	exit(1);
}

int main(int argc, char *argv[]) {

	if (argc<2) usage(argv[0]);

	int year_param = 0;
	bool openings = false;
	bool closings = false;
	bool totals = false;
	for (int i = 1; i<argc; i++) {
		if (argv[i][0] == '-') {
			if (strcmp(argv[i], "-o") == 0) openings = true;
			if (strcmp(argv[i], "-c") == 0) closings= true;
			if (strcmp(argv[i], "-a") == 0) totals = true;
		}
		else { // year
			year_param=i;
		}
	}
	if (!year_param) usage(argv[0]);
	
	long year = strtol(argv[year_param], 0, 10);
	if (errno != 0) {
		perror("year");
		exit(1);
	}
	std::string pcode,abn;
	float start,finish;
	int total = 0;

	std::map<std::string, int>postcodes;
	char buf[1000];
	std::cin.getline(buf, 100);
	while (!std::cin.eof()) {
		std::cin >> pcode >> abn >> start >> finish;
		if (year>0) {
			if (totals && start<=year) { postcodes[pcode]++; total++; }
			if (totals && finish<=year) { postcodes[pcode]--; total--; }
			if (openings&& floor(start)==year) { postcodes[pcode]++; total++; }
			if (closings&& floor(finish)==year) { postcodes[pcode]++; total++; }
		}
	}

	std::map<std::string, int>::iterator iter = postcodes.begin();
	while (iter != postcodes.end()) {
		std::cout << (*iter).first << "," << year << "," << (*iter).second << "\n";
		iter++;
	}
	std::cout << "Total," << year << "," << total<<"\n";

	return EXIT_SUCCESS;
}
