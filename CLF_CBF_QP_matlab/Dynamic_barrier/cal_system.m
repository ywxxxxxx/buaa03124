function [f,g] = cal_system(x_state)
    %dx = f + g*u
    x=x_state(1);
    y=x_state(2);
    v=x_state(3);
    theta=x_state(4);
    
    f=[v*cos(theta);v*sin(theta);0;0];
    g=[0 0;0 0;1 0;0 1];
   
end