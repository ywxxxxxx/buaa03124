function [V,LV] = cal_clf(x_state)
%需要确定Vx并写在该函数内部
%输入为状态变量
%输出是当前状态下的LV行向量 V标量
    syms x y real
    D=[20;20];
    q=[x y]';
    clf_sym=(q(1)-D(1))^2+(q(2)-D(2))^2;
    
    LV_sym=simplify(jacobian(clf_sym,q));
    LV_func=matlabFunction(LV_sym,'vars',q);
    
    LV=LV_func(x_state(1),x_state(2));
    
    clf_func=matlabFunction(clf_sym,'vars',q);
    V=clf_func(x_state(1),x_state(2));
end