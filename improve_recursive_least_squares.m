k=1:1:500;
y=zeros(1,500);
delta=normrnd(0,0.1,1,500);
u=normrnd(0,0.1,1,500);
hdelta=zeros(1,500);
theta=zeros(6,500);
% d_theta=zeros(4,500);
% e=zeros(1,500);
fai=zeros(6,500);
K=zeros(6,500);
P=eye(6);
P0=10^6*eye(6);
% R=0.1*eye(4);
for i=1:1:500
    if i==1         
        fai(:,i)=[0 0 0 0 0 0]';
        y(1,i)=delta(i);
    elseif i==2        
        hdelta(i-1)=y(1,i-1)- fai(:,i-1)'*theta(:,i-1);
        fai(:,i)=[y(1,i-1) 0 0 0 hdelta(i-1) 0]';
        y(1,i)=1.6*y(1,i-1) +delta(i)-delta(i-1);
    elseif i==3
       hdelta(i-1)=y(1,i-1)- fai(:,i-1)'*theta(:,i-1);
       y(1,i)=1.6*y(1,i-1)-0.7*y(1,i-2)+1.1*u(1,i-2) +delta(i)-delta(i-1)+0.2*delta(i-2);
       fai(:,i)=[y(1,i-1) y(1,i-2) u(1,i-2) 0 hdelta(i-1) hdelta(i-2)]';
    elseif i>3
        hdelta(i-1)=y(1,i-1)- fai(:,i-1)'*theta(:,i-1);
       y(i)=1.6*y(i-1)-0.7*y(i-2)+1.1*u(i-2)+0.5*u(i-3)+delta(i)-delta(i-1)+0.2*delta(i-2);
       fai(:,i)=[y(1,i-1) y(1,i-2) u(1,i-2) u(1,i-3) hdelta(i-1) hdelta(i-2)]';
    end
    if i>1
%         P=P0-((P0*fai(:,i)*fai(:,i)'*P0)/(1+fai(:,i)'*P0*fai(:,i)));
%         e(i)=y(i)-fai(:,i)'*theta(:,i-1)-fai(:,i)'*d_theta(:,i-1);
%         d_theta(:,i)= d_theta(:,i-1)+P0*fai(:,i)*e(i);
%         theta(:,i)=theta(:,i-1)+d_theta(:,i);
%         P0=P;
        K(:,i)=(P0*fai(:,i))/(1+fai(:,i)'*P0*fai(:,i));
        theta(:,i)=theta(:,i-1)+K(:,i)*(y(i)-fai(:,i)'*theta(:,i-1));
        P=(eye(6)-K(:,i)*fai(:,i)')*P0;
        P0=P;
    end
    
end
plot(k,theta);
