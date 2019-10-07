clearvars
close all

%Exercise3: Selection of a set of points: Boundaries

eval('meshHole');
numNodes=size(nodes,1);
numelem=size(elem,1);

temp=1:numNodes;
colorMap='jet';
title='Temperature Plot';
plotContourSolution(nodes,elem,temp,title,colorMap)
hold on

plotTriangMesh(nodes,elem)
hold on

%Indexs of the ones on each edge and on the half-circle
indNodLeft=find(nodes(:,1) < 0.01);
indNodRight=find(nodes(:,1) > 0.99);
indNodTop=find(nodes(:,2) > 0.99);
indNodBottom=find(nodes(:,2) < -0.99);
indNodCirc=find(sqrt(nodes(:,1).^2 + nodes(:,2).^2) < 0.41);

indNodBoundary = unique([indNodLeft',indNodRight',indNodTop',...
    indNodBottom',indNodCirc']);

fprintf('# nodes left: %d\n',length(indNodLeft))    
fprintf('# nodes right: %d\n',length(indNodRight))   
fprintf('# nodes top: %d\n',length(indNodTop))       
fprintf('# nodes bottom: %d\n',length(indNodBottom))
fprintf('# nodes circle: %d\n',length(indNodCirc))   
fprintf('# nodes circle: %d\n',length(indNodCirc))   

fprintf('# nodes on the boundary %d\n',length(indNodBoundary))  

% plot(nodes(indNodLeft,1),nodes(indNodLeft,2),'o','Marker','o',...
%     'MarkerFaceColor','red')
plot(nodes(indNodBoundary,1),nodes(indNodBoundary,2),'o','Marker','o',...
     'MarkerFaceColor','red')
hold off






