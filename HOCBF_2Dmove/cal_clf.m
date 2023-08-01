function [V1,V2,LfV1,LgV1,LfV2,LgV2] = cal_clf(x_state)
%需要确定Vx并写在该函数内部
%输入为状态变量
%输出是当前状态下的LV行向量 V标量
    D=[20;20];  %目标位置
    vd=1;       %期望速度
    x=x_state(1);
    y=x_state(2);
    v=x_state(3);
    theta=x_state(4);
    
    
    V1=(theta-atan((D(2)-y)/(D(1)-x)))^2;
    LfV1=2*(atan((D(2)-y)/(D(1)-x))-theta)*(D(2)-y)/((D(1)-x)^2*(((D(2)-y)/(D(1)-x))^2+1))* v*cos(theta)+...
        2*(atan((D(2)-y)/(D(1)-x))-theta)*(D(2)-y)/((x-X(1))*(((D(2)-y)/(D(1)-x))^2+1))*v*sin(theta);
    LgV1=[0,2*(theta-atan((D(2)-y)/(D(1)-x)))];
    
    V2=(v-vd)^2;
    LfV2=0;
    LgV2=[2*(v-vd),0];
end