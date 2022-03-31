#include <iostream>
#include <vector>
#include <fstream>
#include <cstdio>

// solve differential equation:
// dN/dt = rate - 0.693N/t_half
std::vector<double> Euler(double rate,double t_half,
                          double N0,double dt,int num_steps) {
    std::vector<double> res;
    res.push_back(N0);
    for (auto i = 0; i < num_steps; ++i) {
        res.push_back(res[i] + (rate-0.693/t_half)*dt);
    }

    return res;
}

int main() {
    
    double rate = 1.296e8;
    double t_half = 5;
    double N0 = 0.0;

    double dt = 0.1;
    int num_steps = 10; 
    
    std::vector<double> euler_res = Euler(rate,t_half,N0,dt,num_steps);
    
    //std::ofstream out;
    //out.open("ODE_data.dat");
    
    FILE *fp;
    fp = fopen("ODE_data.dat","w");
    for (auto i = 0; i < num_steps; ++i) {
        fprintf(fp,"%.1f    %.4e\n",i*dt,euler_res[i]); 
//        out << i*dt << "    " << euler_res[i] << std::endl;
    }
    fclose(fp);
//    out.close();

    return 0;
}
