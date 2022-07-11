%This function is for post-processing and calculating the forces in
%bearings and elements. To Solve the KU=F equation we had to omit
%the displacements that are constrained in boundary conditions.
% By this function we again add these constrained displacements to the U vectore
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





        
    
