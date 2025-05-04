clc;
clear;
sigma_1 = 1/4;
beta = 1;
rho = 0.7;
Ans = [];
err = 1e-5;
x = 20;
[f,df] = fun(x);
d = -df;
while norm(df) >err
    for ii = 1:100
        if ii ==1
            alpha = 1;
        else
            alpha = beta *rho^(ii-2);
        end
        y = x +alpha*d;
        decrease = sigma_1 *alpha*df.'*d;
        f_y = fun(y);
        if f_y <= f+decrease
            ind = [ii,alpha,y];
            Ans = [Ans;ind];
            break;
        end
    end
    x = y;
    [f,df] = fun(x);
    d = -df;
end
disp('Ans= ');disp(Ans);
function [f,df] = fun(x)
f =  3*x^4 - 16*x^3 + 30*x^2 - 24*x + 8;
df =  12*x^3 - 48*x^2 + 60*x - 24;
end