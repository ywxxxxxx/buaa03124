function [u,delta]=QP_solve(x_state,lambda,gamma,u_ref,u_lim,H)
    %   安全性约束：-LgLfh*u ≤ Lf2h + 2hLfh + (Lfh)^2 + 2h^2*Lfh + h^4
    %   稳定性约束：LgV1*u - delta1 ≤ -lambda*V1 -LfV1
    %              LgV2*u - delta2 ≤ -gamma*V2 -LfV2
    %   可加入u_min ≤ u ≤ u_max
    %   选取K类函数为正比例函数，lambda为clf1的比例系数，gamma为clf2的比例系数
    %   u_ref为期望输入，默认输入为0       //从该变量及之后皆为可缺省变量，但该变量不输入后面的也不可输入
    %   u_lim为输入限制，若没有输入限制可以输入umax=umin=0
    %   H为qp权重矩阵       维数为ulim+1 * ulim+1的对角矩阵，最后一个元素为松弛变量的系数，可输入diag([])
    arguments
        x_state
        lambda
        gamma
        u_ref (:,1) = zeros(2,1)
        u_lim  (:,2) =[0,0]
        H   = eye(4)
    end
    u_dim=2;
    n_clf=2; %  CLF约束方程个数，也就是松弛变量的个数
    
    [a1,b1]=cal_cbf(x_state);
    [V1,V2,LfV1,LgV1,LfV2,LgV2] = cal_clf(x_state);
    
    
    %约束条件Ax<=b的矩阵构造
    A=[a1 0 0;
       LgV1   1 0;
       LgV2   0 1];
    b=[b1;
       -lambda*V1-LfV1;
       -gamma*V2-LfV2];
   
   
    
    m=[-u_ref;0;0];
    
    %加入输入限制
    u_min=u_lim(:,1);
    u_max=u_lim(:,2);
    if u_max(1)>u_min(1)        %若无输入限制则直接跳过
        A=[A;eye(u_dim),zeros(u_dim,n_clf);-eye(u_dim),zeros(u_dim,n_clf)];
        b=[b;u_max;-u_min];
    end
    
             
    options=optimset('Display','off');
    r=quadprog(H,m,A,b,[],[],[],[],[],options);
 
    u=r(1:end-n_clf);
    delta=r(end-n_clf+1:end);
    
end