function [dydt] = dynamics_fxn2(y,mr1,mr2,mc,L1,L2,k)
M = [mr+mc,        1/2*mr*L*cos(y(3));...
    cos(y(3)),      (1/2)*L^2];
D = [.5*mr*L*(y(4))^2*sin(y(3))-k*y(1);....
    -9.81*sin(y(3))];
dydt = M\D;
end