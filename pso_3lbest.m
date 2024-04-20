function f =pso_3lbest(x1,x2,x3)%求解粒子环形邻域中的局部最优个体
K0=[x1;x2;x3];
K1=[pso_3func(x1),pso_3func(x2),pso_3func(x3)];
[~, index]=max(K1);
plocalbest=K0(index,:);
f=plocalbest;