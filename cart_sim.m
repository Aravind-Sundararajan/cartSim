clear all
close all

% system properties
mr = .25;
mc = 1;
L = .5;
k = 10;

%n = 16;

% initial conditions
y1 = 0;
y2 = 0;
y3 = 45*pi/180;
y4 = 0;

dt = .01;
tmax = 5;

y(1,:) = [y1,y2,y3,y4];


%RK4

for i=1:(tmax/dt+1) 

q1(i,:) = dynamics_fxn(y(i,:),mr,mc,L,k); 
k1(i,:) = [y(i,2),q1(i,1),y(i,4),q1(i,2)];

q2(i,:) = dynamics_fxn(y(i,:)+k1(i,:)*(dt/2),mr,mc,L,k); 
k2(i,:) = [y(i,2),q2(i,1),y(i,4),q2(i,2)];

q3(i,:) = dynamics_fxn(y(i,:)+k2(i,:)*(dt/2),mr,mc,L,k); 
k3(i,:) = [y(i,2),q3(i,1),y(i,4),q3(i,2)];

q4(i,:) = dynamics_fxn(y(i,:)+k3(i,:)*(dt),mr,mc,L,k); 
k4(i,:) = [y(i,2),q4(i,1),y(i,4),q4(i,2)];

y(i+1,:) = y(i,:) + (dt/6)*(k1(i,:)+2*k2(i,:)+2*k3(i,:)+k4(i,:));

end

for i=1:(tmax/dt+1)
    clf
hold on
tic
cartStart = [y(i,1),0]
cartEnd = cartStart + [.5,0]
pendStart = cartStart + [.25,0]
pendEnd = pendStart +L*[sin(y(i,3)),-cos(y(i,3))]
line([cartStart(1), cartEnd(1)],[cartStart(2), cartEnd(2)],'Color','green', 'linewidth', 10)
line([pendStart(1), pendEnd(1)],[pendStart(2), pendEnd(2)],'Color','blue', 'linewidth', 3)
% xs = zeros(1,n);
% xs(1:2) = [-2.5,-2.25];
% xs(n-1:n) = [y(i,1)-.5,(y(i,1)-.25)];
% ys = zeros(1,n);
% ys(1:2) = [0,0];
% ys(n-1:n) = [0,0];
% for p = 3:n-2
%     xs(p) = -2.5+p*(y(i,1)+2.25)/(n+1);
%     ys(p) = (-1)^(p-1)*(.125-(y(i,1)*.125/2));
% end

frameTime = toc;
axis([-5,5,-5,5],'square');
hold off
pause(dt-frameTime)

end