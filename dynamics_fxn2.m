function [dydt] = dynamics_fxn2(y,mr1,mr2,mc,L1,L2,k)
%spring-cart-pendulum problem EOM; dydt = m\D
%here our M has to be a 3x3 matrix
M = [mc+mr1+mr2                                  , .5*cos(y(3))*L1*(mr1+mr2)      , .5*cos(y(5))*L2*mr2;...
    (1/12)*L1*(6*cos(y(3))*mr1 + 6*cos(y(3))*mr2), (1/12)*L1*(4*L1*mr1 + 3*L1*mr2), .25*cos(y(3)-y(5))*L1*L2*mr2;...
    .5*cos(y(5))*L2*mr2                          ,.25*cos(y(3)-y(5))*L1*L2*mr2    , (1/3)*(L2^2)*mr2];
D = -[k*y(1) - .5*sin(y(3))*L1*(mr1+mr2)*(y(4)^2) - .5*sin(y(5)) * L2 *mr2 * (y(6)^2);...
     (1/12)*L1*(6*9.81*sin(y(3))*mr1 + 3*sin(y(3) - y(5))*L2*mr2*(y(6)^2));...
      (1/12)*L2*mr2*(6*9.81*sin(y(5)) - 3*sin(y(3) - y(5))*L1*(y(4)^2))   ];
dydt = M\D;
end