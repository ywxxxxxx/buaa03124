function [h,Lh] = cal_cbf(x_state)
%需要确定hx和dh/dx即Lh并写在该函数内部
%输入为状态变量
%输出是当前状态下的Lh行向量 h标量
    syms x y real
    X=[10;12];Xr=3;
    q=[x y]';
    cbf_sym=(q(1)-X(1))^2+(q(2)-X(2))^2-Xr^2 ;   %壁垒函数 符号形式

    
    Lh_sym=simplify(jacobian(cbf_sym,q));                 
    Lh_func=matlabFunction(Lh_sym,'vars',q);
    
    Lh=Lh_func(x_state(1),x_state(2));       %Lh 数值 行向量
    
    cbf_func=matlabFunction(cbf_sym,'vars',q);          %cbf 函数
    h=cbf_func(x_state(1),x_state(2));       %h 标量
end