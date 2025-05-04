clear all; clc;

% 定义目标函数
f = @(x) 3*x^4 - 16*x^3 + 30*x^2 - 24*x + 8;   
g = @(x) 12*x^3 - 48*x^2 + 60*x - 24;           
alpha = 1;                                       
beta = 0.8;                                      
k = 0;                                           
x0 = 5;                                        
eps = 1e-5;                                     
c1 = 0.4; % Wolfe条件1
c2 = 0.6; % Wolfe条件2

gx = g(x0);                                   

while (abs(gx) > eps) && (k < 40000)           
    % 计算新的点
    x1 = x0 - alpha * gx;                       
    fa = f(x1);                                
    f0 = f(x0);                                
    g1 = g(x1);                                

    % Wolfe条件检查
    while (fa > f0 + c1 * alpha * gx) || (g1 < c2 * gx)
        alpha = beta * alpha;  % 减小步长
        x1 = x0 - alpha * gx;                   
        fa = f(x1);                             
        g1 = g(x1);                             
    end

    % 更新x0和梯度
    x0 = x1; 
    gx = g(x0); 
    k = k + 1;                                 
end

% 输出结果
fprintf("Final result x = %f, step alpha = %f, after %d iterations\n", x0, alpha, k);
