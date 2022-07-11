% use this function for illustration
function Plottingtriangle(Node,Element,U,FonmisStress,Scale)
n=size(Node,1);
X=zeros(n,1);
Y=zeros(n,1);
Z=zeros(n,1);
for i=1:n
X(i) = Node(i,2)+U(2*i-1)*Scale;
Y(i) = Node(i,3)+U(2*i)*Scale;
end

trisurf(Element,X,Y,Z,FonmisStress)
title(['Displacement Scale: ',num2str(Scale)])
view(2)
axis equal
grid off
colorbar