#include <iostream>
#include <fstream>
#include <string>

int main() {
    std::ifstream file("result.txt");
    std::ofstream copy("copy_result.txt");
    while (!file.eof()) {
        std::string line;
        getline(file,line);
        std::cout << line << std::endl;
        copy << line << '\n';
    }

    file.close();
    copy.close();

    return 0;
}
