function U=UmakerTriangle(u,BC,angleBC)
U=u;
for i=1:size(BC,1)
    U(BC(i,1))=BC(i,2);
end

%effect of angle Boundary Condition
for i=1:size(angleBC,1)
    U(2*angleBC(i,1)-1,1)=U(2*angleBC(i,1)-1,1)* cos(angleBC(i,2));
    U(2*angleBC(i,1),1)=U(2*angleBC(i,1)-1,1)* sin(angleBC(i,2));
end





        
    
