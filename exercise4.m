%exercise4.m
%Compute the number of nodes in the boundary of the meshTwoHolesQuad.m 
%example. using the boundaryNodes function.

clearvars
close all

eval('meshTwoHolesQuad');

[indNodBd, indElemBd, indLocalEdgBd, edges] = boundaryNodes(nodes, elem)

fprintf(' number of Boundary nodes = %d \n',length(indNodBd));

figure()
plotElements(nodes,elem,0);
hold on

for e = 1:length(indElemBd)
    fill(nodes(elem(indElemBd(e),:),1),nodes(elem(indElemBd(e),:),2),'y')
end
plot(nodes(indNodBd,1),nodes(indNodBd,2),'ob','Marker','o',...
    'MarkerFaceColor','blue','MarkerSize',4)
hold off