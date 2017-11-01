#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include "mins.h"

std::string exec(const char* cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::shared_ptr<FILE> pipe(popen(cmd, "r"), pclose);
    if (!pipe) throw std::runtime_error("popen() failed!");
    while (!feof(pipe.get())) {
        if (fgets(buffer.data(), 128, pipe.get()) != nullptr)
            result = buffer.data();                                 //find a better fix
    }
    return result;
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
        std::cout << "  evaluating for perturbation " << x ;
        //prepare freefem input
        auto pert = std::to_string(x);
        std::string cmd = "/usr/bin/FreeFem++ -v 0 -ne /home/andrea/Documents/semester_project_2_code/golden_search_numerical_recipes/test.freefem ";
        cmd = cmd + pert;
        const char* cmd_c = cmd.c_str();

        std::string output = exec(cmd_c);   //run freefem

        Doub spectral_gap = std::stod(output);
        std::cout << " -> " << spectral_gap << std::endl;
        return spectral_gap;
    }
};

int main() {

    // cheating: compute some results to have an idea of there the maximum is
    Funcd f;



    Golden golden;

    golden.bracket(0.36, 0.4, f);
    double xmin = golden.minimize(f);

    std::cout << "main" << std::endl;
    std::cout << golden.ax << " < " << golden.bx << " < " << golden.cx << std::endl;
    std::cout << golden.fa << " , " << golden.fb << " , " << golden.fc << std::endl;
    std::cout << xmin << " " << golden.fmin << std::endl;
    return 0;
}