clc;
clear;
Ans = [];
err = 1e-10;
x = [0;1];
[f,df] = func(x);
beta = 0;
theta = 0;
d = [0;0];
y = [0;0];
eta = 1000;
%model = 'HS';
% model = 'FR';
% model = 'MFR';
% model = 'PRP';
% model = 'MPRP';
% model = 'CD';
% model = 'DY';
model = 'CG_Descent';
while norm(df) > err
    switch model 
        case {'HS','FR','PRP','CD','DY','CG_Descent'}
             d = -df+beta*d;
        case {'MFR'}
             d = -(1+theta)*df+beta*d;
        case {'MPRP'}
             d = -df+beta*d-theta*y;
    end
    alpha = -(x(1)*d(1)+2*x(2)*d(2)-x(1)*d(2)-x(2)*d(1)-d(1))/((d(1)-d(2))^2+d(2)^2);
    x_1 = x+alpha*d;
    [f_1,df_1] = func(x_1);
    switch model
        case 'HS'
              beta = df_1.'*(df_1-df)/(d.'*(df_1-df));
        case 'FR'
              beta = norm(df_1).^2/norm(df).^2;
        case 'MFR'
              beta = norm(df_1).^2/norm(df).^2; 
              theta = (df_1.'*d)/norm(df).^2;
        case 'PRP'
              beta = df_1.'*(df_1-df)/norm(df).^2;
        case 'MPRP'
              beta = df_1.'*(df_1-df)/norm(df).^2;
              theta = (df_1.'*d)/norm(df).^2;
              y = df_1-df;
        case 'CD'
              beta = -norm(df_1).^2/(d.'*df);
        case 'DY'
              beta = norm(df_1).^2/(d.'*(df_1-df));
        case 'CG_Descent'
              eta_k = -1/(norm(d)*min(eta,norm(df)));
              y = df_1-df;
              s = x_1-x;
              beta_k = 1/(d.'*y)*(y-2*(norm(y)^2/(s.'*y))*s).'*df_1;
              beta = max(beta_k,eta_k);
    end             
    x = x_1;
    [f,df] = func(x);
    Ans = [Ans;x.',alpha];
end
disp('Ans = '); disp(Ans);
function [f,df] = func(x)
f = 1/2*x(1)^2+x(2)^2-x(1)*x(2)-x(1);
df = [x(1)-x(2)-1;2*x(2)-x(1)];
end