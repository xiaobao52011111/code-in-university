clear all;
clc;
fun = [-0.9;-1.4;-1.9;-0.45;-0.95;-1.45;0.05;-0.45;-0.95];

% 定义约束矩阵 A 和 b
A = [ -0.4 0.6 0.6 0 0 0 0 0 0;
     -0.2 -0.2 0.8 0 0 0 0 0 0;
     0 0 0 -0.85 0.15 0.15 0 0 0;
     0 0 0 -0.6 -0.6 0.4 0 0 0;
     0 0 0 0 0 0 -0.5 -0.5 0.5;
     1 0 0 1 0 0 1 0 0;
     0 1 0 0 1 0 0 1 0;
     0 0 1 0 0 1 0 0 1
     ];
b = [0;
     0;
     0;
     0;
     0;
     2000;
     2500;
     1200];
Aeq = [];
beq = [];
lb = [0,0,0,0,0,0,0,0,0];
ub = [];
% 调用 linprog 函数求解
[x,fval] = linprog(fun,A,b,Aeq,beq,lb,ub)

% 输出结果
disp(x);
disp(-fval);