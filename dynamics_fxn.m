function [dydt] = dynamics_fxn(y,mr,mc,L,k)
M = [mr+mc,        1/2*mr*L*cos(y(3));...
    cos(y(3)),      (7/6)*L];
D = [.5*mr*L*(y(4))^2*sin(y(3))-k*y(1);....
    -9.81*sin(y(3))];
dydt = M\D;
end