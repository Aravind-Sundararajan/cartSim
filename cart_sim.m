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
for t=1:(tmax/deltaTime+1)
    
    q1(t,:) = dynamics_fxn(y(t,:),mr,mc,L,k);
    k1(t,:) = [y(t,2),q1(t,1),y(t,4),q1(t,2)];
    
    q2(t,:) = dynamics_fxn(y(t,:)+k1(t,:)*(deltaTime/2),mr,mc,L,k);
    k2(t,:) = [y(t,2),q2(t,1),y(t,4),q2(t,2)];
    
    q3(t,:) = dynamics_fxn(y(t,:)+k2(t,:)*(deltaTime/2),mr,mc,L,k);
    k3(t,:) = [y(t,2),q3(t,1),y(t,4),q3(t,2)];
    
    q4(t,:) = dynamics_fxn(y(t,:)+k3(t,:)*(deltaTime),mr,mc,L,k);
    k4(t,:) = [y(t,2),q4(t,1),y(t,4),q4(t,2)];
    
    y(t+1,:) = y(t,:) + (deltaTime/6)*(k1(t,:)+2*k2(t,:)+2*k3(t,:)+k4(t,:));
    
end
figure( 'units','normalized','outerposition',[0 0 1 1])
for t=1:(tmax/deltaTime+1)
    clf
    hold on
    tic
    cartStart = [y(t,1),0];
    cartEnd = cartStart + [.5,0];
    pendStart = cartStart + [.25,0];
    pendEnd = pendStart +L*[sin(y(t,3)),-cos(y(t,3))];
    pendEndStore(:,t) = pendEnd;
    line([cartStart(1), cartEnd(1)],[cartStart(2), cartEnd(2)],'Color','green', 'linewidth', 15);
    line([0,pendStart(1)],[0, pendStart(2)],'Color','black', 'linewidth', 2);
    line([pendStart(1), pendEnd(1)],[pendStart(2), pendEnd(2)],'Color','blue', 'linewidth', 3);
    plot(pendEndStore(1,1:end),pendEndStore(2,1:end),'Color','cyan');
    %legend('cart', 'rod 1', 'rod 2', 'spring', 'trajectory') %legend is too
    %resource intensive to plot in real time this way
    frameTime = toc;
    axis([-3,3,-2,2]);
    if (deltaTime-frameTime)>0
        pause((deltaTime-frameTime)) %pause so the sim plays back in real time
    else
        pause(10^-10)%in case the deltaTime is too small to play back in real time just print to screen anyway
    end
    
end