function [u,delta]=QP_solve(LV,Lh,V,h,lambda,gamma,f,g,u_ref,u_lim,H)
    %   | -Lgh  0  | | u   |  ≤ | Lfh + lambda*h |
    %   |  LgV  -1 | |delta|    |-LfV - gamma*V  |
    %   可加入u_min ≤ u ≤ u_max
    %   选取K类函数为正比例函数，lambda为cbf的比例系数，gamma为clf的比例系数
    %   u_ref为期望输入，默认输入为0       //从该变量及之后皆为可缺省变量，但该变量不输入后面的也不可输入
    %   u_lim为输入限制，若没有输入限制可以输入umax=umin=0
    %   H为qp权重矩阵       维数为ulim+1 * ulim+1的对角矩阵，最后一个元素为松弛变量的系数，可输入diag([])
    arguments
        LV  
        Lh  
        V
        h
        lambda
        gamma
        f   (:,1)
        g   
        u_ref (:,1) = zeros(size(g,2),1)
        u_lim  (:,2) =[0,0]
        H   = eye(size(g,2)+1)
    end
    u_dim=size(g,2);
    
    Lgh=Lh*g;
    Lfh=Lh*f;
    LgV=LV*g;
    LfV=LV*f;
    
    
    %约束条件Ax<=b的矩阵构造
    A=[-Lgh 0;LgV -1];
    b=[Lfh+lambda*h ; -LfV-gamma*V];
    
    m=[-u_ref;0];
    
    %加入输入限制
    u_min=u_lim(:,1);
    u_max=u_lim(:,2);
    if u_max(1)>u_min(1)        %若无输入限制则直接跳过
        A=[A;eye(u_dim),zeros(u_dim,1);-eye(u_dim),zeros(u_dim,1)];
        b=[b;u_max;-u_min];
    end
    
             
    options=optimset('Display','off');
    r=quadprog(H,m,A,b,[],[],[],[],[],options);
    u=r(1:end-1);
    delta=r(end);
    
end