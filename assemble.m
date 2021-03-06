% This function calculate the global stiffness matrix (K) for all elements
% K is a 2 dimentional matrix. By solving the equation of KU=F the displacements of 
% each nodes(U) can be calculated
function K=assemble(Node,Element,k)
nodenumber=size(Node,1); %number of nodes
d=size(Node,2)-1; %degree of freedom
n=size(Element,1);%number of elements
ne =size(Element,2);% number of nodes in element
K=zeros(d*nodenumber,d*nodenumber); %K assembled

nod=zeros(ne,1);
for i=1:n
    for j=1:ne
        nod(j)=(d*Element(i,j));%Places of displacements in Global U according to this Element's Nodes
    end
    r=zeros(d*(ne),1);
    for z=1:ne
        r(d*(z-1)+1:d*z) = nod(z)-d+1:1:nod(z);
    end
    r=r';
   
    K(r,r)=K(r,r)+k(:,:,i);
   
end

