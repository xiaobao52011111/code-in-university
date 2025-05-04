  clear all; clc
		% 定义变量
		f = @(x) 3*x^4 - 16*x^3 + 30*x^2 - 24*x + 8;
		g = @(x) 12*x^3 - 48*x^2 + 60*x - 24;
        gg = @(x) 36*x^2 - 96*x +60;
		alpha = 1;
        beta = 0.8;
		
		% if primary step = 1, answer is wrong?
		k = 0; 
        x0 = 1;
		d = -1;
		eps = 1e-5;
		sigma = 0.3;
		gx = g(x0);
        ggx = gg(x0);
        % fx0 = f(x0);
        % fx1 = f(x0-0.1)
        % dif = fx0 - fx1;
		
		while abs(gx) > eps 
		gx = g(x0); % gradient
        ggx = gg(x0);
		x1 = x0 - alpha * gx;
		fa = f(x1);
		f0 = f(x0);
		ff = f0 - fa - sigma * alpha * gx;
		if norm(gx) ==0 && norm(ggx) == 0
            x0 = x0+1;
        end
		if ff < 0 % 不满足条件
		alpha = alpha * beta;
		else
		x0 = x1; 
		gx = g(x0); 
		k = k + 1;
		end
		end
		
		fprintf("Final result x = %f, step alpha = %f, after %d iterations ", x0, alpha, k);