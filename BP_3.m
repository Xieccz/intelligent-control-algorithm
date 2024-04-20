%原理解释
clear;
clc;
NUM = 5;
x = [0 0.1  0.2  0.3 0.4];
y_obj = [4    2   2   2  2];

%产生5组参数
% w1=rand(1,NUM);%
% w2=rand(1,NUM);%
% theta=rand(1,NUM);%
% beta=rand(1,NUM);%

w1 = [-10.7616162337773,-10.0870414900461,-10.7354042454094,-10.2389658154740,-10.8158038553040]
w2 = [4.21231442047992,4.01592971110033,4.50102562807680,4.60817949070844,4.47140936200411]
theta = [-2.23404089534787,-2.01532695578772,-2.01215210704637,-1.98075298312586,-2.02398302670497]
beta = [1.08167860727054,0.345439416587181,0.845786196871718,0.372735071154955,0.255900741958464]

LR1 = 0.002; %learing rate
LR2 = 0.004;
LR3 = 0.002;
LR4 = 0.002;

for times = 1:1:200000
    
    for i = 1:1:NUM
      y_cur(i) = 0; %输出层的值
    end
    
    for i = 1:1:NUM
    z(i) = w1(i) * x(i) - theta(i); %隐藏层的输入
    fz(i) = 1 / (1 + exp(-1 * beta(i) * z(i))); %隐藏层的输出
    y_cur(i) = w2(i) * fz(i); %输出层的值 
    end
    
    %计算误差
    for i = 1:1:NUM
        error(i) = 0;
    end
     for i = 1:1:NUM
         error(i) =  y_obj(i) - y_cur(i);%样本-实际
     end
    
    %计算目标函数J
    J = 0;      
    for i = 1:1:NUM
        J = J + error(i)^2 / 2;
    end    
    if(J < 0.01) 
       break;
    end
    %%%%%%%%%%%%求导%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %J对W(2)求导------------------------
    for i = 1:1:NUM
        J_W2(i) = -error(i)*fz(i);
    end
    
    J_W2_sum = 0; %计算需要用的
     for i = 1:1:NUM
        J_W2_sum = J_W2_sum + J_W2(i);
     end
     
    %J对W(1)求导------------------------
    for i = 1:1:NUM
        J_W1(i) = -error(i) * w2(i) * beta(i) * exp(-beta(i)*z(i)) * fz(i)^2 * x(i);
    end
    
    J_W1_sum = 0; %计算需要用的
     for i = 1:1:NUM
        J_W1_sum = J_W1_sum + J_W1(i);
     end
     
    %J对beta求导------------------------
     for i = 1:1:NUM
        J_beta(i) = -error(i) * w2(i) * z(i) * exp(-beta(i)*z(i)) * fz(i)^2;
     end
    
     J_beta_sum = 0; %计算需要用的
     for i = 1:1:NUM
        J_beta_sum = J_beta_sum + J_beta(i);
     end
     
     %J对theta求导------------------------
     for i = 1:1:NUM
        J_theta(i) = error(i) * w2(i) * beta(i) * exp(-beta(i)*z(i)) * fz(i)^2;
     end
    
     J_theta_sum = 0; %计算需要用的
     for i = 1:1:NUM
        J_theta_sum = J_theta_sum + J_theta(i);
     end
   %%%%%%%%%%%%%更新数据%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:1:NUM
        w1(i) = w1(i) - LR1 * J_W1_sum;
        w2(i) = w2(i) - LR2 * J_W2_sum;        
        beta(i) = beta(i) - LR3 * J_beta_sum;        
        theta(i) = theta(i) - LR4 * J_theta_sum; 
    end    
end
times;
figure;
hold on;
plot(x, y_obj, 'b');
plot(x, y_cur, 'r');
