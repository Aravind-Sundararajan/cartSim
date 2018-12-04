function [dydt] = dynamics_fxn(y,mr,mc,L,k)
%spring-cart-pendulum problem EOM; dydt = m\D
M = [mr+mc,        .5*mr*L*cos(y(3));...
    .5*cos(y(3)),      (1/3)*L];
D = [.5*mr*L*(y(4)^2)*sin(y(3))-k*y(1);....
    -.5*9.81*sin(y(3))];
dydt = M\D;
end