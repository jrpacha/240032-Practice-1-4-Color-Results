clearvars
close all

eval('meshHole')

numNodes = size(nodes, 1);
numElem = size(elem, 2);

Temp = 1:numNodes;
titol = 'Temperature Plot';
colormap = 'jet';
plotContourSolution(nodes, elem, Temp, titol, colormap);
hold on

%Find the nodes at the boundary
idxNodesL = find(nodes(:,1) < 0.01);
idxNodesR = find(nodes(:,1) > 0.99);
idxNodesB = find(nodes(:,2) < -0.99);
idxNodesT = find(nodes(:,2) > 0.99);
idxNodesC = find(sqrt(nodes(:,1).^2 + nodes(:,2).^2) < 0.401);

%Plot the nodes
plot(nodes(idxNodesL,1), nodes(idxNodesL,2), 'o', 'markerFaceColor', 'green')
plot(nodes(idxNodesR,1), nodes(idxNodesR,2), 'o', 'markerFaceColor', 'green')
plot(nodes(idxNodesB,1), nodes(idxNodesB,2), 'o', 'markerFaceColor', 'green')
plot(nodes(idxNodesT,1), nodes(idxNodesT,2), 'o', 'markerFaceColor', 'green')
plot(nodes(idxNodesC,1), nodes(idxNodesC,2), 'o', 'markerFaceColor', 'green')

hold off

idxNodesAtBoundary = unique([idxNodesL; idxNodesR; idxNodesB; idxNodesT; idxNodesC]');
size(idxNodesAtBoundary, 2)

[indNodBd, indElemBd, indLocalEdgBd, edges] = boundaryNodes(nodes, elem);
size(indNodBd, 2)

figure()
numbering = 0;
plotElementsOld(nodes, elem, numbering)
hold on
plot(nodes(indNodBd,1), nodes(indNodBd,2), 'o', 'markerFaceColor', 'green')

for e = indElemBd'
    fill(nodes(elem(e,:),1), nodes(elem(e,:),2), 'y')
end
hold off

newNodesBd = setdiff(indNodBd, idxNodesL);
figure()
plotElementsOld(nodes, elem, numbering)
hold on
plot(nodes(newNodesBd,1), nodes(newNodesBd,2), 'o', 'markerFaceColor', 'green')
hold off


