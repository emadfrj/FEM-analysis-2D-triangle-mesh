% Call this function for analysing the triangle mesh stuctures.
%ExcelPath is the path to your excel input file
%MagnifyingScale is used in plotting to depict deformations more clearly
%DistributedForces is an optional argument. It has to be a cell array with
%three columns. the first column is the page number of excel file allocated to the
%edge under distributed force. the second and third columns are function handler for distributed force 
%in the direction of x and y. both these functions have to be relative to x and y
%For example DistributedForces ={8,  @(x,y) (0),  @(x,y) (-10*x^2)}
function [F,strain,stress,FonmisStress] = Solve_Triangle(ExcelPath,MagnifyingScale,DistributedForces)
Node=xlsread(ExcelPath,1);
Node=sortrows(Node,1);
Element=xlsread(ExcelPath,2);
AE=xlsread(ExcelPath,3);
t=AE(:,1);
E=AE(:,2);
Nu=AE(:,3);
alpha=AE(:,4);
angleBC=xlsread(ExcelPath,4);
BC=xlsread(ExcelPath,5);
F=xlsread(ExcelPath,6);
Thermal=xlsread(ExcelPath,7);
%traction effect
if exist('DistributedForces','var')
    for i=1:size(DistributedForces,1)
        edge = xlsread(ExcelPath,DistributedForces{i,1});
        fx = DistributedForces{i,2};
        fy = DistributedForces{i,3};
        F=F+tractionmaker(Node,edge,fx,fy);%calculate and add Traction Force vector to main Force vector
    end
end
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
Plottingtriangle(Node,Element,U,FonmisStress,MagnifyingScale)
end


