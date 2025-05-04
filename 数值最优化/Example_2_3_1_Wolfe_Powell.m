clc;
clear;
sigma_1 = 1/4;%sigma_1 should be in the intervel (0,1/2)
sigma_2 = 2*sigma_1;%sigma_2 should be in the intervel (sigma_1,1)
beta = 1;
rho = 0.7;
number = 50;
n = 1:number;
A_1 = beta*rho.^n;
A_2 = beta*rho.^(-n);
A = [A_1;A_2];
A = reshape(A,1,2*number);
A = [1,beta,A];
rho_1 = 0.8;
Ans = [];
err = 1e-5;
x = -300;
[f,df] = fun(x);
d = -df;
indicator = 1;
Ans_in = [];
while norm(df) > err
     for ii = 1:length(A)
         if indicator == 1 
            alpha = A(ii);
         else
            alpha = B(ii);
         end
         y = x+alpha*d;
         decrease = sigma_1*alpha*df.'*d;
         [f_y,df_y] = fun(y);
         if f_y <= f+decrease && df_y.'*d>=sigma_2*df.'*d
            indicator = 1;
            index = [ii,alpha,y]; 
            Ans = [Ans; index];
            Ans_in = [Ans_in; indicator];
            break;
         elseif f_y <= f+decrease && df_y.'*d<sigma_2*df.'*d
            indicator = 0;
            beta_i = rho^(-1)*alpha;
            B = alpha+(beta_i-alpha)*rho_1.^n;
            B = [zeros(1,ii),B];
            Ans_in = [Ans_in; indicator];
         end
     end
    x = y;
    [f,df] = fun(x);
    d = -df;
end
disp('Ans = ');disp(Ans);
disp('Ans_in = ');disp(Ans_in);
function [f,df] = fun(h)
f = 3*h^4-16*h^3+30*h^2-24*h+8;
df = 12*h^3-48*h^2+60*h-24;
end
