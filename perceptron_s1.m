clear;
clc;
%si,表示训练数据
yita = 0.5;
theta = 1;
s1 = [[1,2], theta];
s2 = [[2,1], theta];
s3 = [[3,3], theta];
s4 = [[4,2], theta];
obj = [1, 1, -1, -1];
sample = [s1; s2; s3; s4];

%w1, w2, theta的权重
W = [1, 1, -1];
num = 0;
for j = 1:2000
    num = num + 1;
     for i = 1:1:4
        val = sample(i,:) * W'; %每次计算一个样本Y(t)
        if(val  >= 0) %sgn(val)
            sgn(i) = 1;
        else
            sgn(i) = -1; %Y(t)
        end
        W = W + yita * (obj(i) - sgn(i)) * sample(i,:);
     end
     if(obj == sgn)
         disp( 'ok');
         %disp('num=');
         num
         break;
     end
end


