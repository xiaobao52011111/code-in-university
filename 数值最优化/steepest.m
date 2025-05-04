function [x, fval] = steepest_descent(f, grad_f, x0)
    % 初始化参数
    maxIter = 100;
    tol = 1e-6;
    iter = 0;
    x = x0;
    
    while true
        g = grad_f(x);
        
        if norm(g) < tol
            break;
        end
        
        alpha = line_search(f, x, -g); % 精确线性搜索
        x = x + alpha * (-g);
        iter = iter + 1;
        
        if iter >= maxIter
            error('Maximum number of iterations exceeded.');
        end
    end
    
    fval = f(x);
end






