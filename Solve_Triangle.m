clc;clear all;close all
% tractionmaker;%making Force Traction vector in Excel file

Node=xlsread('Triangle5.xlsx',1);
Node=sortrows(Node,1);
Element=xlsread('Triangle5.xlsx',2);
AE=xlsread('Triangle5.xlsx',3);
t=AE(:,1);
E=AE(:,2);
Nu=AE(:,3);
alpha=AE(:,4);
angleBC=xlsread('Triangle5.xlsx',4);
BC=xlsread('Triangle5.xlsx',5);
F=xlsread('Triangle5.xlsx',6);
Thermal=xlsread('Triangle5.xlsx',7);
Ftraction=xlsread('Triangle5.xlsx',9);
%traction effect
F=F+Ftraction;
%making k matrixes
[k,A,Element,B,D]=K_Triangle(Node,Element,E,t,Nu);
%thermal effect
[Fth,e0]=ThermalTriangle(Element,size(Node,1),Thermal,alpha,t,A,B,D);
F=F+Fth;
%assemble K
K=assemble(Node,Element,k);
%Boundary condition effects
[Kr,Fr]=BCTriangle(K,F,BC,angleBC);
%solving equgation
u=Kr\Fr;
%making completed U
U=UmakerTriangle(u,BC,angleBC);
%post processing
F=K*U;
n=size(Element,1);
strain=zeros(3,n);
stress=zeros(3,n);
FonmisStress=zeros(n,1);
for i=1:n
    Ue=[u(2*Element(i,1)-1) ;u(2*Element(i,1)) ;u(2*Element(i,2)-1) ;u(2*Element(i,2)) ;u(2*Element(i,3)-1) ;u(2*Element(i,3)) ];
    strain(:,i)=B(:,:,i)*Ue;
    stress(:,i)=D(:,:,i)*(strain(:,i)-e0(i,:)');
    FonmisStress(i)=sqrt( stress(1,i)^2-stress(1,i)*stress(2,i)+stress(2,i)^2+3*stress(3,i)^2 );
end
Plottingtriangle(Node,Element,U,FonmisStress,1000)
%UAx=U(83)
%UAy=U(84)


