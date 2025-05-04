function newton_method()
    % 初始化参数
    x0 = [1; 1]; % 初始点
    tol = 1e-6; % 收敛容忍度
    max_iter = 100; % 最大迭代次数
    x = x0; % 当前点

    % 迭代过程
    for iter = 1:max_iter
        % 计算梯度和海森矩阵
        grad = gradient(x);
        H = hessian(x);
        
        % 检查收敛
        if norm(grad) < tol
            fprintf('Newton法收敛于迭代 %d，解为 x = [%f; %f]\n', iter, x(1), x(2));
            return;
        end
        
        % 更新点
        x = x - inv(H) * grad; % 更新公式
    end

    disp('达到最大迭代次数，未收敛。');
end

function grad = gradient(x)
    % 计算目标函数的梯度
    grad = [2*x(1); 4*x(2)]; % f(x) = x1^2 + 2*x2^2
end

function H = hessian(x)
    % 计算目标函数的海森矩阵
    H = [2, 0; 0, 4]; % f(x) = x1^2 + 2*x2^2
end