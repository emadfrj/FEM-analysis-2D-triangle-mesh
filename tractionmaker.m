%This function gets Node and edge matrix and the distributed force formula
%in x and y direction. fx(x,y) and fy(x,y) are both functions of x and y.  
%The output is traction force vector with same size of concentrated force vector
%This vector can easily be added to Force vector 
function Ftraction=tractionmaker(Node,edge,fx,fy)
    Node=sortrows(Node,1);
    Ftraction=zeros(2*size(Node,1),1);% Force matrix resulting from traction force
    for i=1:size(edge,1)
        t=edge(i,3);%thickness
        node1 = edge(i,1);
        node2 = edge(i,2);
        x1=Node(node1,2);
        y1=Node(node1,3);
        x2=Node(node2,2);
        y2=Node(node2,3);
        L=sqrt( (x1-x2)^2+(y1-y2)^2 );%lenght 
        Fy=t*L*fy((x1+x2)/2,(y1+y2)/2);
        Fx=t*L*fx((x1+x2)/2,(y1+y2)/2);
        F=[Fx/2;Fy/2;Fx/2;Fy/2];
        r=[2*node1-1      2*node1         2*node2-1         2*node2];
        Ftraction(r)=Ftraction(r)+F;
    end
end