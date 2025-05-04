clear all;clc
f = @(x) 0.5*x(1)^2 + x(2)^2 - x(1)*x(2) - x(1);
grad_f = @(x) [x(1) - x(2) - 1; 2*x(2) - x(1)];

x0 = [0; 1];
tol = 1e-6; 
max_iter = 1000; 
% 八种算法
methods = {@modified_prp, @cg, @modified_fr, @fr, @hs, @prp, @cd, @dy};

% 循环测试各方法
for i = 1:length(methods)
    fprintf(' %s\n', func2str(methods{i}));
    [x, fval, iter] = methods{i}(f, grad_f, x0, tol, max_iter);
    fprintf(' x = [%f, %f], fval = %f, iter = %d\n\n', x(1), x(2), fval, iter);
end

% 修正PRP算法
function [x, fval, iter] = modified_prp(f, grad_f, x0, tol, max_iter)
    [x, fval, iter] = cg_method(f, grad_f, x0, tol, max_iter, 'modified_prp');
end

% CG算法
function [x, fval, iter] = cg(f, grad_f, x0, tol, max_iter)
    [x, fval, iter] = cg_method(f, grad_f, x0, tol, max_iter, 'basic');
end

% 修正FR算法
function [x, fval, iter] = modified_fr(f, grad_f, x0, tol, max_iter)
    [x, fval, iter] = cg_method(f, grad_f, x0, tol, max_iter, 'modified_fr');
end

% FR算法
function [x, fval, iter] = fr(f, grad_f, x0, tol, max_iter)
    [x, fval, iter] = cg_method(f, grad_f, x0, tol, max_iter, 'fr');
end

% HS算法
function [x, fval, iter] = hs(f, grad_f, x0, tol, max_iter)
    [x, fval, iter] = cg_method(f, grad_f, x0, tol, max_iter, 'hs');
end

% PRP算法
function [x, fval, iter] = prp(f, grad_f, x0, tol, max_iter)
    [x, fval, iter] = cg_method(f, grad_f, x0, tol, max_iter, 'prp');
end

% CD算法
function [x, fval, iter] = cd(f, grad_f, x0, tol, max_iter)
    [x, fval, iter] = cg_method(f, grad_f, x0, tol, max_iter, 'cd');
end

% DY算法
function [x, fval, iter] = dy(f, grad_f, x0, tol, max_iter)
    [x, fval, iter] = cg_method(f, grad_f, x0, tol, max_iter, 'dy');
end

% 共轭梯度算法通用实现
function [x, fval, iter] = cg_method(f, grad_f, x0, tol, max_iter, method)
    x = x0;
    g = grad_f(x);
    d = -g;
    iter = 0;
    
    while norm(g) > tol && iter < max_iter
        % 精确线性搜索
        alpha = exact_line_search(f, grad_f, x, d);
        % 更新
        x = x + alpha * d;
        g_new = grad_f(x);

        % 选择不同的beta公式
        switch method
            case 'basic'
                beta = 0; % 梯度下降
            case 'fr'
                beta = (g_new' * g_new) / (g' * g);
            case 'prp'
                beta = max(0, (g_new' * (g_new - g)) / (g' * g));
            case 'hs'
                beta = (g_new' * (g_new - g)) / (d' * (g_new - g));
            case 'cd'
                beta = (g_new' * g_new) / (d' * g);
            case 'dy'
                beta = (g_new' * g_new) / (d' * (g_new - g));
            case 'modified_prp'
                beta = max(0, (g_new' * g_new) / (d' * g));
            case 'modified_fr'
                beta = max(0, (g_new' * g_new) / (g' * g));
            otherwise
                error('Unknown method');
        end
        
        % 更新方向
        d = -g_new + beta * d;
        g = g_new;
        iter = iter + 1;
    end
    
    fval = f(x);
end

% 精确线性搜索
function alpha = exact_line_search(f, grad_f, x, d)
    % 精确线性搜索，找到使 f(x + alpha * d) 最小化的 alpha
    syms alpha_sym;
    x_new = x + alpha_sym * d; % 更新方向
    f_alpha = f(x_new); % 目标函数关于 alpha 的表达式
    df_alpha = diff(f_alpha, alpha_sym); % 求导
    alpha = double(solve(df_alpha == 0, alpha_sym)); % 求解最优 alpha
end
