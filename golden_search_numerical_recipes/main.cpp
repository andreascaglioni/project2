#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
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
double extract_value_from_String(std::string str){
    //std::cout << "  freefem output: " << str << std::endl;
    std::string tag = "###BEGIN_RESULT###";
    int tag_length = tag.size();
    std::size_t tag_position = str.find(tag);
    std::string substring = str.substr(tag_position+tag_length);
    std::stringstream ss(substring);
    std::string str_value;
    std::getline(ss, str_value, '\n');
/*    std::cout << tag << " found at position " << tag_position << std::endl;
    std::cout << "tag length " << tag_length << std::endl;
    std::cout << "substring " << substring << std::endl;
    std::cout << "value " << str_value << std::endl;*/
    return std::stod(str_value);
}
struct Funcd {
    /*Doub operator() (const Doub x) {
        if(x < 5. && x > -5.)
            return -(sin(x)+cos(2.*x)+ 1./x*sin(3.*x));
        else if(x>=5.)
            return -(sin(5.)+cos(2.*5.)+ 1./x*sin(3.*5.));
        else
            return -(sin(-5.)+cos(2.*-5.)+ 1./x*sin(3.*-5.));
    }*/
    Doub operator() (const Doub x) {
        //std::cout << "  evaluating for perturbation " << x  << "..." << std::endl;
        if(abs(x)>1)
            return 0.;
        //prepare freefem input arguments
        auto perturbation = std::to_string(x);
        std::string freefem_path = "/usr/bin/FreeFem++";
        std::string flags = "-v 0 -ne";                     //DONT CHANGE THIS, OR ALSO CHANGE THE FREEFEM SCRIPT
        std::string script_address = "/home/andrea/Documents/semester_project_2_code/golden_search_numerical_recipes/test2.freefem";
        std::string cmd = freefem_path + " " + flags + " " + script_address + " " + perturbation;
        const char* cmd_c = cmd.c_str();

        std::string output_string = exec(cmd_c);   //run freefem
        Doub spectral_gap = extract_value_from_String(output_string);
        //Doub spectral_gap = std::stod(output);
        //std::cout << " -> " << spectral_gap << std::endl;
        return spectral_gap;
    }
};

int main() {

    // cheating: compute some results to have an idea of there the maximum is
    Funcd f;
    Doub a = -1.;
    while(a <= 1.){
     std::cout << f(a) << " ";// << std::endl;
        a = a + 0.05;
    }
/*
    Golden golden;

    golden.bracket(-0.35, 0.35, f);
    double xmin = golden.minimize(f);

    std::cout << "main" << std::endl;
    std::cout << golden.ax << " < " << golden.bx << " < " << golden.cx << std::endl;
    std::cout << golden.fa << " , " << golden.fb << " , " << golden.fc << std::endl;
    std::cout << xmin << " " << golden.fmin << std::endl;*/
    return 0;
}