clear;
clc;
%模糊查询表

%假设E、EC和U的论域：{-6,-5,…,-1,0,1,…,5,6}；
% E,EC, U的语言值： NB，NM，NS，Z，PS，PM，PB
Input1_Terms=[1,2,3,4,5,6,7];
Input2_Terms=[1,2,3,4,5,6,7];
output_Terms=[1,2,3,4,5,6,7];

%各个语言值的隶属函数采用三角函数
Input1_Terms_Membership=[1,0.5,0,0,0,0,0,0,0,0,0,0,0;%语言值NB
				0,0.5,1,0.5,0,0,0,0,0,0,0,0,0;%语言值NM
				0,0,0,0.5,1,0.5,0,0,0,0,0,0,0;%语言值NS
				0,0,0,0,0,0.5,1,0.5,0,0,0,0,0;%语言值Z
				0,0,0,0,0,0,0,0.5,1,0.5,0,0,0;%语言值PS
				0,0,0,0,0,0,0,0,0,0.5,1,0.5,0;%语言值PM
				0,0,0,0,0,0,0,0,0,0,0,0.5,1];%语言值PB
Input2_Terms_Membership=Input1_Terms_Membership;
Output_Terms_Membership=Input1_Terms_Membership;

%将语言值按顺序编号，NB、NM、NS、Z、PS、PM、PB分别对应1、2、3、4、5、6、7号。
%假设控制规则表总结如下 
Rule=   [1,1,1,1,2,4,4;
     	1,1,1,1,2,4,4;
      	 2,2,2,2,4,5,5;
         2,2,3,4,5,6,6;
         3,3,4,6,6,6,6;
    	 4,4,6,7,7,7,7;
         4,4,6,7,7,7,7];
     
%所有规则蕴涵的模糊关系：
for i=1:169
    for j=1:13
        R(i,j)=0;
    end
end

for Input1_Terms_Index=1:7  %E: NB，NM，NS，Z，PS，PM，PB
     for Input2_Terms_Index=1:7 %EC: NB，NM，NS，Z，PS，PM，PB
    %程序段1
	Output_Terms_Index=Rule(Input1_Terms_Index,Input2_Terms_Index );%NB&NB=>NB
    A=Input1_Terms_Membership(Input1_Terms_Index,:);%语言变量E的语言值(NB->PB)的隶属度,13列数
    B=Input2_Terms_Membership(Input2_Terms_Index,:);%语言变量EC的语言值(NB->PB)的隶属度
    C=Output_Terms_Membership(Output_Terms_Index,:);%语言变量U的语言值(NB->PB)的隶属度          

    %注：R1＝A×B
	for i=1:13
      for j=1:13
            R1(i,j)=min(A(i),B(j));
      end
    end
    
    %注：R2＝R1'
    R2=[ ];
    for k=1:13
          R2=[R2;R1(k,:)'];
    end
    
    %注：R3＝R2×C
    for i=1:169
        for j=1:13
            R3(i,j)=min(R2(i),C(j));
        end
    end
    
    %各条(49条)运算规则并运算，值取大
	 R=max(R,R3);          
     end
end

%模糊输入A, 隶属度最大
Input1_value_index = 12;
Input1_value_membership=Input1_Terms_Membership(:,Input1_value_index);
[Max_Input1_value,Max_Input1_index]=max(Input1_value_membership);
Ad=Input1_Terms_Membership(Max_Input1_index,:);

%模糊输入B
Input2_value_index = 12;
Input2_value_membership=Input2_Terms_Membership(:,Input2_value_index);
[Max_Input2_value,Max_Input2_index]=max(Input2_value_membership);
Bd=Input2_Terms_Membership(Max_Input2_index,:);

%推理
%Rd1＝Ad×Bd
 for i=1:13
    for j=1:13
     Rd1(i,j)=min(Ad(i),Bd(j));
    end
 end

 %Rd2＝Rd1'
Rd2=[ ];
for k=1:13
      Rd2=[Rd2,Rd1(k,:)];
end

%Cd＝Rd2 o R, Cd为推理后得到的模糊输出
for j=1:13
      Cd(j)=max(min(Rd2',R(:,j)));%两者取小，再取大   169 o (169x13)
end


%加权平均法
sum1=0;
sum2=0;
Output = -6:1:6; 
 for i=1:13
       sum1=sum1+Cd(i);
       sum2=sum2+Cd(i)*Output(i);
  end
  OUT=round(sum2/sum1)
  
