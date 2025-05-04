clc;
clear;
a = 0;
b = 3;
lambda = 0.618;
Ans = [];
err = 1e-5;
while b-a > err
    Ans = [Ans;a,b]; 
    u = b-lambda*(b-a);
    v = a+lambda*(b-a);
    f_u = fun(u);
    f_v = fun(v);
    if b-a < err
        disp('ii=');disp(ii);
        break;
    end
    if f_u < f_v
       b = v;
    elseif f_u > f_v
       a = u;
    else
       a = u;
       b = v;
    end
end
disp('Ans = ');disp(Ans);
function f = fun(h)
f = 3*h^4-16*h^3+30*h^2-24*h+8;
end
