clear all
%this sim is the same as cart_sim.m, but now there is a double pendulum
%attached to the cart.

mr1 = .25; %mass rod 1
mr2 = .1; %mass rod 2
mc = 1;    %mass cart
L1 = .5;   %length rod 1
L2 = .25;   %length rod 2
k = 10;    %spring constant

y1 = 1; %x
y2 = 0; %xdot
y3 = 0*pi/180; %theta 1
y4 = 0; %thetadot
y5 = 0*pi/180; %theta 2
y6 = 0; %thetadot

deltaTime = .006; %delta time
tEnd = 15;

y(1,:) = [y1,y2,y3,y4,y5,y6];


%4th order Runge-Kutta, could also use euler's method (1st order RK)
%following example from: http://lpsa.swarthmore.edu/NumInt/NumIntFourth.html
for t=1:(tEnd/deltaTime+1)
    
    YDD1(t,:) = dynamics_fxn2(y(t,:),mr1,mr2,mc,L1,L2,k);
    k1(t,:) = [y(t,2),YDD1(t,1),y(t,4),YDD1(t,2), y(t,6), YDD1(t,3)];
    
    YDD2(t,:) = dynamics_fxn2(y(t,:)+k1(t,:)*(deltaTime/2),mr1,mr2,mc,L1,L2,k);
    k2(t,:) = [y(t,2),YDD2(t,1),y(t,4),YDD2(t,2), y(t,6), YDD2(t,3)];
    
    YDD3(t,:) = dynamics_fxn2(y(t,:)+k2(t,:)*(deltaTime/2),mr1,mr2,mc,L1,L2,k);
    k3(t,:) = [y(t,2),YDD3(t,1),y(t,4),YDD3(t,2), y(t,6), YDD3(t,3)];
    
    YDD4(t,:) = dynamics_fxn2(y(t,:)+k3(t,:)*(deltaTime),mr1,mr2,mc,L1,L2,k);
    k4(t,:) = [y(t,2),YDD4(t,1),y(t,4),YDD4(t,2), y(t,6), YDD4(t,3)];
    
    y(t+1,:) = y(t,:) + (deltaTime/6)*(k1(t,:)+2*k2(t,:)+2*k3(t,:)+k4(t,:));
    
end
figure('units','normalized','outerposition',[0 0 1 1])
for t=1:(tEnd/deltaTime+1)
    clf
    hold on
    tic
    %construct the position vectors
    cartStart = [y(t,1),0];
    cartEnd = cartStart + [.5,0];
    pend1Start = cartStart + [.25,0];
    pend1End = pend1Start +L1*[sin(y(t,3)),-cos(y(t,3))];
    pend2Start = pend1End;
    pend2End = pend2Start +L2*[sin(y(t,5)),-cos(y(t,5))];
    pend2EndStore(:,t) = pend2End;
    
    %plot the objects
    line([cartStart(1), cartEnd(1)],[cartStart(2), cartEnd(2)],'Color','green', 'linewidth', 15);
    line([0,pend1Start(1)],[0, pend1Start(2)],'Color','black', 'linewidth', 2);
    line([pend1Start(1), pend1End(1)],[pend1Start(2), pend1End(2)],'Color','blue', 'linewidth', 3);
    line([pend2Start(1), pend2End(1)],[pend2Start(2), pend2End(2)],'Color','red', 'linewidth', 3);
    plot(pend2EndStore(1,1:end),pend2EndStore(2,1:end),'Color','cyan');
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