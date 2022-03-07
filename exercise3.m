clearvars
close all

%%Exercise3: Selection of a set of points: Boundaries

eval('meshHole');
numNodes=size(nodes,1);
numelem=size(elem,1);

plotElementsOld(nodes,elem,0);

temp=1:numNodes;
colorMap = 'jet';
title = 'Temperature Plot';
plotContourSolution(nodes,elem,temp,title,colorMap)
hold on

%plotElements(nodes,elem,0)
%hold on

%Indexs of the ones on each edge and on the half-circle
[indNodLeft,indCol] = find(nodes(:,1) < 0.01);
[indNodRight,indCol] = find(nodes(:,1) > 0.99);
[indNodTop,indCol] = find(nodes(:,2) > 0.99);
[indNodBottom,indCol] = find(nodes(:,2) < -0.99);
[indNodCirc,indCol] = find(sqrt(nodes(:,1).^2 + nodes(:,2).^2) < 0.41);

indNodBoundary = unique([indNodLeft',indNodRight',indNodTop',...
    indNodBottom',indNodCirc']);


fprintf('# nodes left: %d\n',length(indNodLeft))    
fprintf('# nodes right: %d\n',length(indNodRight))   
fprintf('# nodes top: %d\n',length(indNodTop))       
fprintf('# nodes bottom: %d\n',length(indNodBottom))
fprintf('# nodes circle: %d\n',length(indNodCirc))   
fprintf('# nodes circle: %d\n',length(indNodCirc))  

fprintf('# nodes on the boundary %d\n',length(indNodBoundary))  
fprintf('list of nodes on the edges:')
fprintf('%4d', indNodBoundary')
fprintf('\n')

% plot(nodes(indNodLeft,1),nodes(indNodLeft,2),'o','Marker','o',...
%     'MarkerFaceColor','red')
plot(nodes(indNodBoundary,1),nodes(indNodBoundary,2),'o','Marker','o',...
     'MarkerFaceColor','red')
hold off






