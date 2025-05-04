function bfgs_optimization()
    % 第一部分: 优化问题 (i)
    fprintf('优化问题 (i):\n')
    x0_i = [0; 1]; % 初始点
    B0_i = eye(2); % 初始矩阵 B0
    [x_min_i, f_min_i, iter_i] = bfgs(@f1, @grad_f1, x0_i, B0_i);
    fprintf('最小值 x: [%f; %f], 最小值 f(x): %f, 迭代次数: %d\n', x_min_i(1), x_min_i(2), f_min_i, iter_i)
end

function [x_min, f_min, iter] = bfgs(f, grad, x0, B0)
    tol = 1e-4; % 收敛容忍度
    max_iter = 100; % 最大迭代次数
    x = x0; % 当前点
    B = B0; % 当前 Hessian 矩阵近似

    for iter = 1:max_iter
        % 计算梯度
        g = grad(x);
        
        % 检查收敛
        if norm(g) < tol
            x_min = x;
            f_min = f(x);
            break;
        end
        
        % 进行精确线性搜索
        alpha = -g'*
        
        % 更新点
        s = -alpha * g; % 步长方向
        x_new = x + s
        
        % 更新 Hessian 矩阵近似 B
        y = grad(x_new) - g; % 梯度增量
        if s' * y > 1e-5 % 防止除零
            B = B + (y*y')/(y'*s) - (B*s*s'*B)/(s'*B*s); % BFGS 更新公式
        end
        
        % 更新当前点
        x = x_new;
    end

    % 如果达到最大迭代次数，返回当前结果
    x_min = x;
    f_min = f(x);
end

% function alpha = exact_line_search(f, x, g)
%     % 精确线性搜索
%     line_search_func = @(alpha) f(x - alpha * g); % 目标函数
%     alpha = fminunc(line_search_func, 0); % 使用 fminunc 进行优化
% end


% 第一部分: 目标函数及其梯度
function f = f1(x)
    f = 0.5*x(1)^2 + x(2)^2 - x(1)*x(2) - x(1);
end

function g = grad_f1(x)
    g = [x(1) - x(2) - 1; 2*x(2) - x(1)]; % 梯度
end
