function golden_section_search()
    % 初始点 x 和下降方向 p
    x = [1; 0]; 
    p = [-1; 1];

    % 目标函数
    f = @(alpha) objective_function(x + alpha * p);

    % 黄金分割法的参数设置
    tol = 1e-5; % 容忍度
    a = 0; % 搜索区间左端点
    b = 1; % 搜索区间右端点

    % 黄金分割比例
    phi = (sqrt(5) - 1) / 2;

    % 计算初始点
    h = b - a;
    if h <= tol
        return;
    end

    % 黄金分割搜索
    x1 = a + (1 - phi) * h;
    x2 = a + phi * h;
    f1 = f(x1);
    f2 = f(x2);

    while h > tol
        if f1 < f2
            b = x2;
            x2 = x1;
            f2 = f1;
            x1 = a + (1 - phi) * (b - a);
            f1 = f(x1);
        else
            a = x1;
            x1 = x2;
            f1 = f2;
            x2 = a + phi * (b - a);
            f2 = f(x2);
        end
        h = b - a;
    end

    % 结果
    alpha_optimal = (a + b) / 2;
    fprintf('最优步长 alpha: %f\n', alpha_optimal);
    fprintf('f(x + alpha * p): %f\n', f(alpha_optimal));
end

function f = objective_function(x)
    f = (x(1) + x(2)^2)^2; % 目标函数
end