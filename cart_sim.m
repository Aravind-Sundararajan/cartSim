clear all

mr = .25;      %mass of the rod
mc = 1;        %mass of the cart
L = .5;        %length of the rod
k = 10;        %spring constant

y1 = 1;        %x
y2 = 0;        %xdot
y3 = 0*pi/180; %theta
y4 = 0;        %thetadot

deltaTime = .01;
tmax = 5;

y(1,:) = [y1,y2,y3,y4];

%4th order Runge-Kutta, could also use euler's method (1st order RK)
%following example from: http://lpsa.swarthmore.edu/NumInt/NumIntFourth.html
for i=1:(tmax/deltaTime+1) 

q1(i,:) = dynamics_fxn(y(i,:),mr,mc,L,k); 
k1(i,:) = [y(i,2),q1(i,1),y(i,4),q1(i,2)];

q2(i,:) = dynamics_fxn(y(i,:)+k1(i,:)*(deltaTime/2),mr,mc,L,k); 
k2(i,:) = [y(i,2),q2(i,1),y(i,4),q2(i,2)];

q3(i,:) = dynamics_fxn(y(i,:)+k2(i,:)*(deltaTime/2),mr,mc,L,k); 
k3(i,:) = [y(i,2),q3(i,1),y(i,4),q3(i,2)];

q4(i,:) = dynamics_fxn(y(i,:)+k3(i,:)*(deltaTime),mr,mc,L,k); 
k4(i,:) = [y(i,2),q4(i,1),y(i,4),q4(i,2)];

y(i+1,:) = y(i,:) + (deltaTime/6)*(k1(i,:)+2*k2(i,:)+2*k3(i,:)+k4(i,:));

end
figure( 'units','normalized','outerposition',[0 0 1 1])
for i=1:(tmax/deltaTime+1)
    clf
hold on
tic
cartStart = [y(i,1),0]
cartEnd = cartStart + [.5,0]
pendStart = cartStart + [.25,0]
pendEnd = pendStart +L*[sin(y(i,3)),-cos(y(i,3))]
pendEndStore(:,i) = pendEnd;
line([cartStart(1), cartEnd(1)],[cartStart(2), cartEnd(2)],'Color','green', 'linewidth', 15)
line([0,pendStart(1)],[0, pendStart(2)],'Color','black', 'linewidth', 2)
line([pendStart(1), pendEnd(1)],[pendStart(2), pendEnd(2)],'Color','blue', 'linewidth', 3)
plot(pendEndStore(1,1:end),pendEndStore(2,1:end),'Color','cyan')
%legend('cart', 'rod 1', 'rod 2', 'spring', 'trajectory') %legend is too
%resource intensive to plot in real time this way
frameTime = toc;
axis([-3,3,-2,2]);
pause(deltaTime-frameTime)

end