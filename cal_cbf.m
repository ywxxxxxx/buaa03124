function [h,Lh] = cal_cbf(x_state)
%需要确定hx和dh/dx中元素即Lh并写在该函数内部
%输入为状态变量
%输出是当前状态下的Lh行向量 h标量
    X=[10;12];Xr=3;
    h_func=@(x,y)(x-X(1))^2+(y-X(2))^2-Xr^2;
    h=h_func(x_state(1),x_state(2));
    Lh1=@(x,y) 2*(x-X(1));
    Lh2=@(x,y) 2*(y-X(2));
    Lh3=0;
    Lh=[Lh1(x_state(1),x_state(2)),Lh2(x_state(1),x_state(2)),0];
end