#include <iostream>
#include <vector>
#include <cstdio>

// solve differential equation:
// dN/dt = rate - 0.693N/t_half

// define dN/dt
double f(double r, double k, double N) {
    return r - k*N;
}

// solve dN/dt with Runge-Kutta
std::vector<double> RK(double rate,double t_half,
                          double N0,double dt,int num_steps) {
    double k = 0.693/t_half;
    
    std::vector<double> res;
    res.push_back(N0);

    double k1,k2,k3,k4;
    for (auto i = 0; i < num_steps; ++i) {
        k1 = f(rate,k,res[i]);
        k2 = f(rate,k,res[i]+dt*k1/2.0);
        k3 = f(rate,k,res[i]+dt*k2/2.0);
        k4 = f(rate,k,res[i]+dt*k3);

        res.push_back(res[i] + dt*(k1+k2+k3+k4)/6.0);
    }

    return res;
}

int main() {
     
    double rate = 1500.0;
    double factor = 60.0*60.0*24.0;
    double t_half = 5.0;
    double N0 = 0.0;

    double dt = 1.0/24.0/60.0*5.0;
    int num_steps = 3*(24*12 + 1); 
    
    std::vector<double> RK_res1 = RK(1500*factor,t_half,N0,dt,num_steps);
    std::vector<double> RK_res2 = RK(500*factor,t_half,N0,dt,num_steps);
    std::vector<double> RK_res3 = RK(100*factor,t_half,N0,dt,num_steps);
    
    FILE *fp;
    fp = fopen("ODE_data.dat","w");
    for (auto i = 0; i < num_steps; ++i) {
        fprintf(fp,"%.5f    %.5e    %.5e    %.5e\n",i*dt,RK_res1[i],RK_res2[i],RK_res3[i]); 
    }
    fclose(fp);

    return 0;
}
