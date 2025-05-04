function steepest_descent()
    % 初始化参数
    x0 = [1; 1]; % 初始点
    tol = 1e-6; % 收敛容忍度
    max_iter = 100; % 最大迭代次数
    x = x0; % 当前点

    % 迭代过程
    for iter = 1:max_iter
        % 计算梯度
        grad = gradient(x);
        
        % 检查收敛
        if norm(grad) < tol % 检查梯度的范数
            fprintf('最速下降法收敛于迭代 %d，解为 x = [%f; %f]\n', iter, x(1), x(2));
            return;
        end
        
        % 进行精确线性搜索计算步长 alpha
        alpha = exact_line_search(x, grad);
        
        % 更新点
        x = x - alpha * grad; % 按最速下降法公式更新点
    end

    disp('达到最大迭代次数，未收敛。');
end

function grad = gradient(x)
    % 计算目标函数的梯度
    grad = [2*x(1); 4*x(2)]; % 对应于 f(x) = x1^2 + 2*x2^2
end

function alpha = exact_line_search(x, grad)
    % 精确线性搜索，最小化 f(x - alpha * grad)
    f = @(alpha) (x(1) - alpha * grad(1))^2 + 2 * (x(2) - alpha * grad(2))^2;
    alpha_opt = fminunc(f, 1); % 使用未约束优化工具找到最优步长
    alpha = alpha_opt; 
end