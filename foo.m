clearvars 
close all

nodes = [1,1;
    3,2;
    2,4]; %define the nodes of the tringle

elem = [1,2,3]; %define the triangle itseft as an element
X = nodes(:,1);
Y = nodes(:,2);
values = [0;128;255]; %can be temperature, stress, etc.
fill(X,Y,values);
colormap('jet'); %one of the standard color maps for FEM
colorbar %it is optional, shows the bar with the color scale
hold on;
p=[2,3]; %consider a point
plot(p(1,1),p(1,2),'o','Marker','o',...
    'MarkerFaceColor','black'); %plot the point using a black o
hold off

eval('meshHole');
%eval('meshTwoHolesQuad');
numNodes = size(nodes,1);
numElem = size(elem,1);

%Just as an example, we gave a temperature for each node
Temp=1:numNodes; %temperature for node i is assigned as T(i) = i;

titol='Temperature plot';
colorScale='jet';
%We will use our opwn function for plotting a colored mesh
%it can plot both triangular and quadrilateral meshes.
plotContourSolution(nodes,elem,Temp,titol,colorScale);

%Selectkon of a set of points: Boundaries
hold on
indexLeft=find(nodes(:,1) < 0.001);
plot(nodes(indexLeft,1),nodes(indexLeft,2),'o','Marker','o',...
    'MarkerFaceColor','red')
indexTop=find(nodes(:,2)>0.99);
plot(nodes(indexTop,1),nodes(indexTop,2),'o','Marker','o',...
    'MarkerFaceColor','green')
indexBottom=find(nodes(:,2) < -0.99);
plot(nodes(indexBottom,1),nodes(indexBottom,2),'o','Marker','o',...
    'MarkerFaceColor','blue')
indexRight=find(nodes(:,1) > 0.99);
plot(nodes(indexRight,1),nodes(indexRight,2),'o','Marker','o',...
    'MarkerFaceColor','magenta')
indexCircle=find(sqrt(nodes(:,1).^2 + nodes(:,2).^2) < 0.401);
plot(nodes(indexCircle,1),nodes(indexCircle,2),'o','Marker','o',...
    'MarkerFaceColor','cyan')

fprintf('#Nodes on the left: %d\n',length(indexLeft))
fprintf('#Nodes on the right: %d\n',length(indexRight))
fprintf('#Nodes on the top: %d\n',length(indexTop))
fprintf('#Nodes on the bottom: %d\n',length(indexBottom))
fprintf('#Nodes on the circle: %d\n',length(indexCircle))

indexBoundary = [indexLeft;indexRight;indexTop;indexBottom;indexCircle];
fprintf('#Number of boundary nodes (before unique): %d\n',...
    length(indexBoundary))

indexBoundary = unique(indexBoundary);
fprintf('#Number of boundary nodes (after unique): %d\n',...
    length(indexBoundary))

[indNodBd, indElemBd, indLocalEdgBd, edges] = boundaryNodes(nodes, elem);
fprintf('Number of Boundary nodes: %d\n',length(indNodBd));

fprintf('\nAfter calling boundaryNodes...\n')
indElemBd=unique(indElemBd); %To delete repeated elements
fprintf('Number of boundary elements: %d\n',length(indElemBd))

%Show the elements and nodes at the boundary...
figure()
plotElements(nodes,elem,0);
hold on
X = [nodes(elem(indElemBd,1),1),nodes(elem(indElemBd,2),1),...
    nodes(elem(indElemBd,3),1)]';
Y = [nodes(elem(indElemBd,1),2),nodes(elem(indElemBd,2),2),...
    nodes(elem(indElemBd,3),2)]';
fill(X,Y,'y');
plot(nodes(indNodBd,1),nodes(indNodBd,2),'o','Marker','o',...
    'MarkerFaceColor','red')
hold off

%We can substract some nodes of the booundary using setdiff.
%For Example:
newNodesBd=setdiff(indexBoundary,indexLeft);
figure()
plotElements(nodes,elem,0);
hold on 
plot(nodes(newNodesBd,1),nodes(newNodesBd,2),'o','Marker','o',...
    'MarkerFaceColor','red')
hold off





