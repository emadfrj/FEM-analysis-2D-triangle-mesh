%This function adds the boundary conditions to the model by modifying K(global stiffness matrix) and F(force matrix)
function [K,F]=BCTriangle(K,F,BC,angleBC)

n=size(BC,1); %number of prescribed deformations

%angle boundary condition
angleN=size(angleBC,1);%number of angle boundary condition
T=eye(size(K,1));
for i=1:angleN
 t = [cos(angleBC(i,2)) sin(angleBC(i,2));-sin(angleBC(i,2)) cos(angleBC(i,2))];
 T([2*angleBC(i,1),2*angleBC(i,1)-1],[2*angleBC(i,1),2*angleBC(i,1)-1])=t;
end
K=T*K*T';

%Penalty opproach 
BigK= max(K(:));%biggest member of K
B=BigK*1e12;
for i=1:n
       K(BC(i,1),BC(i,1))=K(BC(i,1),BC(i,1))+B;
       F(BC(i,1))=B*BC(i,2);
end



