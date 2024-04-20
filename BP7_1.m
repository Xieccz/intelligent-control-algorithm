%BP 逼近
clear all;
close all;

yita=0.50; 
alfa=0.05;

w2=rands(6,1);
w2_1=w2;w2_2=w2_1;

w1=rands(2,6);
w1_1=w1;w1_2=w1;

dw1=0*w1;

x=[0,0]';

u_1=0;
y_1=0;

I=[0,0,0,0,0,0]';
Iout=[0,0,0,0,0,0]';
FI=[0,0,0,0,0,0]';

ts=0.001;
for  k=1:1:1000
   
time(k)=k*ts;
u(k)=(0.50*sin(3*2*pi*k*ts));
y(k)=u_1^3+y_1/(1+y_1^2); %y_1上次的y值

for  j=1:1:6
     I(j)=x'*w1(:,j);  %输入*权值                 [x1,x2]*[w11 w21 ...w61
                                                %         w12  w22....w62]
     Iout(j)=1/(1+exp(-I(j))); %f(输入*w1权值)
end   

yn(k)=w2'*Iout;     %输出层的输入值(隐藏层输出*w2权值)

e(k)=y(k)-yn(k);    % 误差

w2=w2_1+(yita*e(k))*Iout+alfa*(w2_1-w2_2); %迭代输出层权值w2

for j=1:1:6
   FI(j)=exp(-I(j))/(1+exp(-I(j)))^2;%求导f(隐藏层)
end

for i=1:1:2
   for j=1:1:6
      dw1(i,j)=e(k)*yita*FI(j)*w2(j)*x(i);%求delta_w1
    end
end
w1=w1_1+dw1+alfa*(w1_1-w1_2);%迭代输入层权值w1

%%%%%%%%%%%%%%Jacobian%%%%%%%%%%%%%%%%
yu=0;
for j=1:1:6
   yu=yu+w2(j)*w1(1,j)*FI(j);%求导（输出对输入),输出对输入敏感度
end
dyu(k)=yu;

x(1)=u(k);
x(2)=y(k);

w1_2=w1_1;w1_1=w1;
w2_2=w2_1;w2_1=w2;
u_1=u(k);
y_1=y(k);
end
figure(1);
plot(time,y,'r',time,yn,'b');
xlabel('times');ylabel('y and yn');
figure(2);
plot(time,y-yn,'r');
xlabel('times');ylabel('error');
figure(3);
plot(time,dyu);
xlabel('times');ylabel('dyu');