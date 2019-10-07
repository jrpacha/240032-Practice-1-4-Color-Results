clearvars
close all

eval('meshHole');

[indNodBd, indElemBd, indLocalEdgBd, edges] = boundaryNodes(nodes, elem)
fprintf(' number of Boundary nodes = %d \n',length(indNodBd));
fprintf(' number of Boundary elements = %d \n',length(indElemBd));

figure()
plotElements(nodes,elem,0);
hold on

for e = 1:length(indElemBd)
    fill(nodes(elem(indElemBd(e),:),1),nodes(elem(indElemBd(e),:),2),'y')
end
plot(nodes(indNodBd,1),nodes(indNodBd,2),'o','Marker','o',...
    'MarkerFaceColor','red')
hold off

%
% We can substract some of the boundary node sets
% using the *setdiff* Matlab function
%

indNodLeft = find(nodes(:,1) < 0.01);
newBdNodList=setdiff(indNodBd,indNodLeft);

figure()
plotElements(nodes,elem,0)
hold on
plot(nodes(newBdNodList,1),nodes(newBdNodList,2),'ob','Marker','s',...
    'MarkerFaceColor','b')
hold off

