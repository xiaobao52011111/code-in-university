function [x_opt, f_opt, iter] = trust_region_method()
    % 初始化参数
    x0 = [10; 10];          % 初始点
    delta_max = 2.0;        % 最大信赖域半径
    delta = 1.0;            % 初始信赖域半径
    eta = 0.1;              % 减小信赖域的阈值
    epsilon = 1e-6;         % 梯度收敛阈值
    max_iter = 1000;        % 最大迭代次数

    % 初始化迭代变量
    x_current = x0;
    iter = 0;

    while iter < max_iter
        % 计算当前点的函数值、梯度和Hessian
        [f_current, g_current, H_current] = objective_function(x_current);

        % 检查收敛性
        if norm(g_current) < epsilon
            break;
        end

        % 求解信赖域子问题 - 使用二次模型
        [d, ~] = trust_region_subproblem(g_current, H_current, delta);

        % 计算新的候选点
        x_new = x_current + d;

        % 计算实际和预测的函数减小量
        [f_new, g_new, ~] = objective_function(x_new);
        
        predicted_reduction = -( g_current'*d + 0.5*d'*H_current*d );
        actual_reduction = f_current - f_new;

        % 计算减小比率
        rho = actual_reduction / predicted_reduction;

        % 更新策略
        if rho > 0.75
            % 实际减小远超预测，增大信赖域
            x_current = x_new;
            delta = min(2*delta, delta_max);
        elseif rho >= 0.25
            % 减小适中，保持当前信赖域
            x_current = x_new;
        else
            % 减小不理想，缩小信赖域
            delta = delta / 2;
        end

        % 更新迭代计数器
        iter = iter + 1;
    end

    % 输出结果
    x_opt = x_current;
    [f_opt, ~, ~] = objective_function(x_opt);
end

function [f, g, H] = objective_function(x)
    % 目标函数定义
    f = 10*(x(2) - x(1))^2 + (1 - x(1))^2;
    
    % 梯度
    g = [
        20*(x(1) - x(2)) + 2*(x(1) - 1);
        20*(x(2) - x(1))
    ];
    
    % Hessian矩阵
    H = [
        22 -20;
        -20 20
    ];
end

function [d, lambda] = trust_region_subproblem(g, H, delta)
    % 使用拉格朗日乘数法求解信赖域子问题
    % 这是一个简化版本，实际应用中需要更复杂的数值方法
    
    % 先尝试无约束最优解
    d = -H \ g;
    
    % 如果解在信赖域内，直接返回
    if norm(d) <= delta
        lambda = 0;
        return;
    end
    
    % 否则，需要约束求解
    % 这里使用简单的二分法
    lambda_low = 0;
    lambda_high = 1000;  % 一个较大的上界
    
    for iter = 1:20
        lambda = (lambda_low + lambda_high) / 2;
        
        % 求解修正后的线性方程
        d = -(H + lambda*eye(2)) \ g;
        
        % 检查约束条件
        if abs(norm(d) - delta) < 1e-6
            break;
        elseif norm(d) > delta
            lambda_low = lambda;
        else
            lambda_high = lambda;
        end
    end
end