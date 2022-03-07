%exercise4.m
%Compute the number of nodes in the boundary of the meshTwoHolesQuad.m 
%example. using the boundaryNodes function.
 
clearvars
close all

eval('meshTwoHolesQuad');

t = cputime;
[indNodBd, indElemBd, indLocalEdgBd, edges] = boundaryNodes(nodes, elem);
t = cputime - t

fprintf(' number of nodes in the boundary of meshTwoholesQuad.m = %d \n',...
    length(indNodBd));

figure()
plotElementsOld(nodes,elem,0);
hold on

for e = indElemBd'
    fill(nodes(elem(e,:),1),nodes(elem(e,:),2),'y')
end
plot(nodes(indNodBd,1),nodes(indNodBd,2),'ob','Marker','o',...
    'MarkerFaceColor','blue','MarkerSize',4)
hold off