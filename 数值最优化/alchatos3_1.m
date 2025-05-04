clear all;
clc;

% 定义符号变量
syms x1 x2 a;

% 定义目标函数
f = (x1 + 2*x2^2)^2;

% 初始化参数
x0 = [1; 1];  % 初始点
eps = 1e-5;   % 收敛阈值
max_iter = 1000;  % 最大迭代次数
k = 0;  % 迭代计数

% 计算偏导数
df1 = diff(f, x1);  % 对 x1 的偏导数
df2 = diff(f, x2);  % 对 x2 的偏导数
df = [df1; df2];  % 梯度

% 迭代过程
while k < max_iter
    % 计算当前点的梯度
    grad = double(subs(df, {x1, x2}, x0));
    
    % 更新方向（负梯度方向）
    d = -grad;
    
    % 线性搜索以找到合适的步长
    % 这里使用简单的固定学习率，你也可以实现更复杂的线性搜索
    learning_rate = 0.01; 
    x_new = x0 + learning_rate * d;  % 更新点
    
    % 检查收敛条件
    if norm(x_new - x0) < eps
        break;  % 如果更新幅度小于阈值，则退出
    end
    
    % 更新 x0 和迭代计数
    x0 = x_new;
    k = k + 1;
end

% 输出结果
fprintf('最小值点: (x1, x2) = (%.4f, %.4f)\n', x0(1), x0(2));
fprintf('迭代次数: %d\n', k);
