clear all;
clc;
f = @(x) (x(1) + 2*x(2)^2)^2;
x0 = [1,1];
k = 0;
eps = 1e-5;
df1 = 2*x(1) + 4*x(2)^2;
df2 = 8*x2*(x(1) + 2*x(2)^2);
df = [df1 df2];
d = -df;
% fa = @(a,x1,x2) ((x1+a) + (a+2*x2^2))^2;
% dfa1 = diff(fa(a,x1,x2),a);
% fprintf('dfa1 = %s\n', char(dfa1));
% dfa1 = 8*a + 4*x1 + 8*x2^2;
aa = -(4*x1 + 8*x2^2)/8;
x1 = 1;x2 = 1;
while abs(df)>eps 
    x0 = [x1 x2];
    x = x0 + aa*d;
end
print ("x1 = %f,x2 = %f",x1,x2)
