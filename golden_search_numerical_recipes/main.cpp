#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <cassert>
#include <complex>
#include "mins.h"

std::string exec(const char* cmd) {
    //std::cout << "  executing freefem ..." << std::endl;
    std::array<char, 128> buffer;
    std::string result;
    std::shared_ptr<FILE> pipe(popen(cmd, "r"), pclose);
    if (!pipe) throw std::runtime_error("popen() failed!");
    while (!feof(pipe.get())) {
        if (fgets(buffer.data(), 128, pipe.get()) != nullptr)
            result += buffer.data();                                 //find a better fix
    }
    return result;
}
std::complex<double> extract_value_from_String(std::string str){

    std::string tag = "###BEGIN_RESULT###";
    if (str.find(tag)==-1){
        std::cerr << "error: " << str << std::endl;
        return 0.;
    }
    std::string tagI = "#i#";
    std::string final = str.substr(str.find(tag)+tag.size());
    std::stringstream ss(final);
    std::string line; std::getline(ss, line, '\n');
    std::string str_real = line.substr(0, line.find(tagI));
    std::string str_imaginary = line.substr(line.find(tagI)+tagI.size());
    Doub real_part = std::stod(str_real);
    Doub imaginary_part = std::stod(str_imaginary);
    return std::complex<double> (real_part, imaginary_part);
}
struct Funcd {
    std::complex<double> operator() (const Doub x) {
        //prepare freefem input arguments
        std::string perturbation = std::to_string(x);
        std::string freefem_path = "/usr/bin/FreeFem++";
        std::string flags = "-v 0 -ne";                     //DONT CHANGE THIS, OR ALSO CHANGE THE FREEFEM SCRIPT
        std::string script_address = "/home/andrea/Documents/semester_project_2_code/golden_search_numerical_recipes/test_3.freefem";
        std::string cmd = freefem_path + " " + flags + " " + script_address + " " + perturbation;
        const char* cmd_c = cmd.c_str();
        std::string output_string = exec(cmd_c);   //run freefem
        std::complex<double> spectral_gap = extract_value_from_String(output_string);
        return spectral_gap;
    }
};

int main() {

    // cheating: compute some results to have an idea of there the maximum is
    Funcd f;

    std::ofstream writeToFile("../test_bistable.out");
    assert(writeToFile.is_open());

    Doub a = 0.;
    while(a< 0.2) {
        std::complex<double> val = f(a);
        std::cout << a << " " << real(val) << " " << imag(val) << std::endl;
        writeToFile << a << " " << real(val) << " " << imag(val) << std::endl;
        a += 0.001;
    }

    a = 0.2;
    while(a< 11.) {
        std::complex<double> val = f(a);
        std::cout << a << " " << real(val) << " " << imag(val) << std::endl;
        writeToFile << a << " " << real(val) << " " << imag(val) << std::endl;
        a += 0.1;
    }

    a = 11.;
    while(a< 11.2) {
        std::complex<double> val = f(a);
        std::cout << a << " " << real(val) << " " << imag(val) << std::endl;
        writeToFile << a << " " << real(val) << " " << imag(val) << std::endl;
        a += 0.001;
    }
    a = 11.2;
    while(a< 12.) {
        std::complex<double> val = f(a);
        std::cout << a << " " << real(val) << " " << imag(val) << std::endl;
        writeToFile << a << " " << real(val) << " " << imag(val) << std::endl;
        a += 0.1;
    }
    a = 12.;
    while(a< 20.) {
        std::complex<double> val = f(a);
        std::cout << a << " " << real(val) << " " << imag(val) << std::endl;
        writeToFile << a << " " << real(val) << " " << imag(val) << std::endl;
        writeToFile.flush();
        a += 1.;
    }

    writeToFile.close();

/*  Golden golden;
    golden.bracket(-0.35, 0.35, f);
    double xmin = golden.minimize(f);
    std::cout << "main" << std::endl;
    std::cout << golden.ax << " < " << golden.bx << " < " << golden.cx << std::endl;
    std::cout << golden.fa << " , " << golden.fb << " , " << golden.fc << std::endl;
    std::cout << xmin << " " << golden.fmin << std::endl;*/
    return 0;
}