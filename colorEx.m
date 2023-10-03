clearvars
close all

% triangle
nodes=[1,1;  %define the nodes of a triangle
    3,2;
    2,4];


f = [0; 14; 27];
X = nodes(:,1); Y = nodes(:,2);
fill(X,Y,f)
%axis equal
colormap('jet')
colorbar %shows the bar with the color scale
hold on;
p = [2,3];
plot(p(1), p(2),'ko')
hold off;

eval('meshHole');
numNodes = size(nodes,1);
numElem = size(elem,1);

temp = 1:numNodes;
titleName = 'TemperaturePlot';
colorScale = 'jet';

plotContourSolution(nodes,elem,temp, titleName,colorScale)

eval('meshTwoHolesQuad')
numNodes = size(nodes,1);
[numElem,numNodesElem] = size(elem);

temp = 1:numNodes';
titleName = 'TemperaturePlot (1)';
colorScale = 'jet';
plotContourSolution(nodes,elem,temp, titleName,colorScale)

figure
X = nodes(elem(1:numElem,:)',1); X = reshape(X,numNodesElem,numElem);
Y = nodes(elem(1:numElem,:)',2); Y = reshape(Y,numNodesElem,numElem);
temp = temp(elem(1:numElem,:)'); temp = reshape(temp,numNodesElem,numElem);
fill(X,Y,temp);
colormap('jet');
axis equal
colorbar
title('Temperature color (2)')