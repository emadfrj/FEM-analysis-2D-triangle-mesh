
fy=@(x,y) (-10*x^2); %Disturbuted force formula
fx=@(x,y) (0);

edge=xlsread('Triangle5.xlsx',8);
t=edge(:,3);%thickness
Node=xlsread('Triangle5.xlsx',1);
Node=sortrows(Node,1);
Ftraction=zeros(2*size(Node,1),1);% Force matrix resulting from traction force
for i=1:size(edge,1)
    node1 = edge(i,1);
    node2 = edge(i,2);
    x1=Node(node1,2);
    y1=Node(node1,3);
    x2=Node(node2,2);
    y2=Node(node2,3);
    L=sqrt( (x1-x2)^2+(y1-y2)^2 );%lenght 
    Fy=L*fy((x1+x2)/2,(y1+y2)/2);
    Fx=L*fx((x1+x2)/2,(y1+y2)/2);
    F=[Fx/2;Fy/2;Fx/2;Fy/2];
    r=[2*node1-1      2*node1         2*node2-1         2*node2];
   Ftraction(r)=Ftraction(r)+F;
end
xlswrite('Triangle5.xlsx',Ftraction,9);