%This function calculate thermal forces vector
%This vector can easily be added to Force vector 
function [Fth,e0]=ThermalTriangle(Element,n,Thermal,alpha,t,A,B,D)
ne=size(Element,1);%number of elements
e0 = zeros(ne,3);%thermal strain 
Fth = zeros(2*n,1);%thermal force
for i = 1:size(Thermal,1)
    n=Thermal(i,1);%element index
    e0(n,:) = [alpha(n)*Thermal(i,2),alpha(n)*Thermal(i,2),0];
    %thermal forces of this element
    f=t(n)*A(n)*B(:,:,n)'*D(:,:,n)*e0(n,:)';
    %location of thermal forces of this element in global coordinate
    r=[2*Element(n,1)-1,2*Element(n,1),2*Element(n,2)-1,2*Element(n,2),2*Element(n,3)-1,2*Element(n,3)];
    %global thermal force
    Fth(r)=Fth(r)+f;
end