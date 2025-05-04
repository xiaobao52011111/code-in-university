clear all;clc
%定义变量
a0=0;b0=3;
f = @(x) (1 - x + x^2)^2;
lamda = 0.618;
k = 0;
eps = 1e-5;%最小距离为eps
while (k < 100) && (b0 - a0 > eps)%限制循环条件
    u0 = b0 - lamda*(b0-a0);
    v0 = a0 + lamda*(b0-a0);
    fu0 = f(u0);%再次赋值便于后续比较大小
    fv0 = f(v0);
     fprintf("k = %d, [a_k, b_k] = [%f, %f], u_k = %f, v_k = %f, f(u_k) = %f, f(v_k) = %f\n", ...
            k, a0, b0, u0, v0, fu0, fv0);
        if fu0 < fv0
            a0 = a0;b0 = v0;v0 = u0;
            u0 =b0 - lamda*(b0-a0);
        else
            a0 = u0;b0 = b0;u0 = v0;
            v0 =a0 + lamda*(b0-a0);
        end
        k = k+1;
end
%输出最终结果
fprintf("Final result a = %f, b = %f,  after %d iterations\n", a0, b0, k);
