function [V,LV] = cal_clf(x_state)
%需要确定Vx并写在该函数内部
%输入为状态变量
%输出是当前状态下的LV行向量 V标量
    D=[20;20];
    V_func=@(x,y)(x-D(1))^2+(y-D(2))^2;
    V=V_func(x_state(1),x_state(2));

    LV1=@(x,y)2*(x-D(1));
    LV2=@(x,y)2*(y-D(2));
    LV3=0;
    
    LV=[LV1(x_state(1),x_state(2)),LV2(x_state(1),x_state(2)),0];
    
end