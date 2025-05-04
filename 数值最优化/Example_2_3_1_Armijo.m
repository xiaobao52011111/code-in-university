clc;
clear;
sigma_1 = 1/4;
beta = 1;
rho = 0.7;
Ans = [];
err = 1e-5;
x = 1;
[f,df,ddf] = fun(x);
d = -df;
if norm(df) == 0 && norm(ddf) == 0 
      x = x +0.1;
end
[f,df] = fun(x);
while norm(df) > err
    for ii = 1:100
        if ii == 1
            alpha = 1;
        else 
            alpha = beta*rho^(ii-2);
        end
        y = x+alpha*d;
        decrease = sigma_1*alpha*df.'*d;
        f_y = fun(y);
        if f_y <= f+decrease
           ind = [ii,alpha,y]; 
           Ans = [Ans; ind];
           break;
        end
    end
    x = y;
    [f,df] = fun(x);
    d = -df;
end
disp('Ans = ');disp(Ans);
function [f,df,ddf] = fun(h)
f = 3*h^4-16*h^3+30*h^2-24*h+8;
df = 12*h^3-48*h^2+60*h-24;
ddf = 36*h^2-96*h+60;
end

