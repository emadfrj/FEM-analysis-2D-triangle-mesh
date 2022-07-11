function [k,A,Element,B,D]=K_Triangle(Node,Element,E,t,Nu)
n=size(Element,1);%number of Elements
k=zeros(6,6,n);
A=zeros(n,1);
D=zeros(3,3,n);
B=zeros(3,6,n);
for i=1:n
    Ai=[1 Node(Element(i,1),2) Node(Element(i,1),3);
           1 Node(Element(i,2),2) Node(Element(i,2),3);
           1 Node(Element(i,3),2) Node(Element(i,3),3)];
    
    A(i)=0.5*det(Ai);  %Area of each element
   
    if (A(i) <0) %Sorting nodes in counterclockwise mode
        A(i)=-A(i);
        temp=Element(i,2);
        Element(i,2)=Element(i,3);
        Element(i,3)=temp;
    end
   
    D(:,:,i)=(E(i)/(1-Nu(i)^2))*[1 Nu(i) 0;Nu(i) 1 0;0 0 (1-Nu(i))/2]; %plane stress
    
    %Calculating B matrix
    x1=Node(Element(i,1),2);   y1=Node(Element(i,1),3);
    x2=Node(Element(i,2),2);   y2=Node(Element(i,2),3);
    x3=Node(Element(i,3),2);   y3=Node(Element(i,3),3); 
    B(:,:,i)=(1/(2*A(i))) * [y2-y3 0 y3-y1 0 y1-y2 0;
                  0 x3-x2 0 x1-x3 0 x2-x1;
                  x3-x2 y2-y3 x1-x3 y3-y1 x2-x1 y1-y2];
              
     k(:,:,i)=t(i)*A(i)*B(:,:,i)'*D(:,:,i)*B(:,:,i);%Calculating k for each element
end