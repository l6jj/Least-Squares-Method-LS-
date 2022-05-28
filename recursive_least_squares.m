% [1]Zilong, Tan, Huaguang, et al. Research on Identification Process 
%of Nonlinear System Based on An Improved Recursive Least Squares Algorithm[C]
k=1:1:500;
y=zeros(1,500);
delta=normrnd(0,0.1,1,500);
u=normrnd(0,0.1,1,500);
theta=zeros(4,500);
d_theta=zeros(4,500);
e=zeros(1,500);
fai=zeros(4,500);
K=zeros(4,500);
P=eye(4);
P0=10^6*eye(4);
R=0.1*eye(4);
for i=1:1:500
%     y(1:i)=1.6*y(1:i-1)-0.7*y(1:i-2)+1.1*u(1:i-2)+0.5*u(1:i-3)+delta(i);
    if i==1
        y(1,i)=delta(i); 
        fai(:,i)=[0 0 0 0]';
    elseif i==2 
        y(1,i)=1.6*y(1,i-1) +delta(i);
        fai(:,i)=[y(1,i-1) 0 0 0]';
    elseif i==3
       y(1,i)=1.6*y(1,i-1)-0.7*y(1,i-2)+1.1*u(1,i-2) +delta(i);
       fai(:,i)=[y(1,i-1) y(1,i-2) u(1,i-2) 0]';
    elseif i>3
       y(i)=1.6*y(i-1)-0.7*y(i-2)+1.1*u(i-2)+0.5*u(i-3)+delta(i);
       fai(:,i)=[y(1,i-1) y(1,i-2) u(1,i-2) u(1,i-3)]';
    end
    if i>1
%         P=P0-((P0*fai(:,i)*fai(:,i)'*P0)/(1+fai(:,i)'*P0*fai(:,i)));
%         e(i)=y(i)-fai(:,i)'*theta(:,i-1)-fai(:,i)'*d_theta(:,i-1);
%         d_theta(:,i)= d_theta(:,i-1)+P0*fai(:,i)*e(i);
%         theta(:,i)=theta(:,i-1)+d_theta(:,i);
%         P0=P;
        K(:,i)=(P0*fai(:,i))/(1+fai(:,i)'*P0*fai(:,i));
        theta(:,i)=theta(:,i-1)+K(:,i)*(y(i)-fai(:,i)'*theta(:,i-1));
        P=(eye(4)-K(:,i)*fai(:,i)')*P0;
        P0=P;
    end
    
end
plot(k,theta);
