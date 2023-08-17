function [A,b] = cal_cbf(x_state)
%需要确定hx和dh/dx中元素即Lh并写在该函数内部
%输入为状态变量
%输出是当前状态下的h,Lfh,Lf2h,LgLfh
    x=x_state(1);
    y=x_state(2);
    v=x_state(3);
    theta=x_state(4);
    
    X=[20;1];Xr=4;
    h=(x-X(1))^2+(y-X(2))^2-Xr^2;
    
    Lfh=2*(x-X(1))*v*cos(theta)+2*(y-X(2))*v*sin(theta);
    Lf2h=2*v^2;
    LgLfh=[2*(x-X(1))*cos(theta)+2*(y-X(2))*sin(theta),2*(y-X(2))*v*cos(theta)-2*(x-X(1))*v*sin(theta)];
    
    H=@(x)atan(x)+1.6;
    dHdx=@(x)1/(x^2+1);
    A=-dHdx(Lfh)*LgLfh;
    b=0.4*H(Lfh)*h+Lfh*H(Lfh)+dHdx(Lfh)*Lf2h;
end