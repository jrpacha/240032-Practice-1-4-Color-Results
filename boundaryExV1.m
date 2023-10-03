clearvars
close all

eval('meshHole');

numNodes = size(nodes,1);
[numElem, numNodsElem] = size(elem);

plotElementsOld(nodes, elem, 0);
%grid on
hold on

%-------------
X = nodes(:,1); Y = nodes(:,2);
indUpperNods = find(Y > 0.99);                  %nodes at the top edge
indLowerNods = find(Y < -0.99);                 %nodes at the bottom edge
indRightNods = find(X > 0.99);                  %nodes at the right edge
indLeftNods = find(X < 0.01);                   %nodes on the left edge
indCircNods = find(sqrt(X.^2 + Y.^ 2) < 0.401); %nodes on the circle

plot(nodes(indUpperNods,1), nodes(indUpperNods,2), ...
    'o', ...
    'MarkerFaceColor','red', ...
    'MarkerSize', 6)

plot(nodes(indLowerNods,1), nodes(indLowerNods,2), ...
    'o', ...
    'MarkerFaceColor','green', ...
    'MarkerSize', 6)

plot(nodes(indRightNods,1), nodes(indRightNods,2), ...
    'o', ...
    'MarkerFaceColor','yellow', ...
    'MarkerSize', 6)

plot(nodes(indLeftNods,1), nodes(indLeftNods,2), ...
    'o', ...
    'MarkerFaceColor','blue', ...
    'MarkerSize', 6)

plot(nodes(indCircNods,1), nodes(indCircNods,2), ...
    'o', ...
    'MarkerFaceColor','magenta', ...
    'MarkerSize', 6)
hold off

fprintf('Example: compute all the nodes at the boundary with find\n')

indNodsAtBd = [indUpperNods', ...
    indLowerNods', ...
    indRightNods', ...
    indLeftNods', ...
    indCircNods'];

fprintf('-- Number of nodes at the boundary (before unique): %d\n', ...
    length(indNodsAtBd));

indNodsAtBd = unique(indNodsAtBd);

fprintf('-- Number of nodes at the boundary (after unique): %d\n', ...
    length(indNodsAtBd));

% Exercise-3
%
% All nodes and elements at the boundary
%

fprintf('Exercise-3: find the nodes and the elements at the boundary\n') 
fprintf('            using the function boundaryNodes\n ')

clear X Y;
[indNodBd, indElemBd] = boundaryNodes(nodes, elem); 
indElemBd = unique(indElemBd); numElemBd = length(indElemBd);

figure();
plotElementsOld(nodes, elem, 0);
hold on

plot(nodes(indNodBd,1), nodes(indNodBd,2), ...
    'o', ...
    'MarkerFaceColor','red', ...
    'MarkerSize', 6)

X = nodes(elem(indElemBd,:)',1); X = reshape(X,numNodsElem,numElemBd);
Y = nodes(elem(indElemBd,:)',2); Y = reshape(Y,numNodsElem,numElemBd); 

fill(X,Y,'yellow')
hold off

%
% Nodes not on the circle: setdiff
%

indNodsBdNotOnCirc = setdiff(indNodBd,indCircNods);

figure();
plotElementsOld(nodes, elem, 0);
hold on

plot(nodes(indNodsBdNotOnCirc,1), nodes(indNodsBdNotOnCirc,2), ...
    'o', ...
    'MarkerFaceColor','red', ...
    'MarkerSize', 6)
hold off

% Exercise 4
clear X Y;
eval('meshTwoHolesQuad');

numNodes = size(nodes,1);
[numElem,numNodsElem] = size(elem);

[indNodBd,indElemBd] = boundaryNodes(nodes, elem);
indElemBd = unique(indElemBd); numElemBd = length(indElemBd);

figure();
plotElementsOld(nodes, elem, 0);
hold on

plot(nodes(indNodBd,1), nodes(indNodBd,2), ...
    'o', ...
    'MarkerFaceColor','red', ...
    'MarkerSize', 6)

X = nodes(elem(indElemBd,:)',1); X = reshape(X,numNodsElem,numElemBd);
Y = nodes(elem(indElemBd,:)',2); Y = reshape(Y,numNodsElem,numElemBd);   

fill(X,Y,'yellow');
hold off

fprintf('Exercise-4\n')
fprintf('Number of nodes at the boundary: %d\n', length(indNodBd))