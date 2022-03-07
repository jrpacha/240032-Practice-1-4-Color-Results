clearvars
close all

%% ColorMapExample
% Consider only one element. A triangle defined by its nodes and we assing 
% a temperature to each node

nodes=[1,1;  %define the nodes of a triangle
       3,2;
       2,4];

elem=[1,2,3]; % The triangle is thought of as one only element.

values=[0;128;255]; %can be temperature, stress, etc.
X=nodes(:,1);
Y=nodes(:,2);
figure()
fill(X,Y,values);
map=colormap('jet') %one of the standar color maps for FEM
colorbar %it is optional, shows the bar with the color scale
hold on;
p=[2,3]; %consider a point
plot(p(1,1),p(1,2),'ko'); %plot the point using a black 'o'
hold off;

% Compute the interpolated temperature and the assigned color
[alphas,isInside] = baryCoord(nodes,p);
interpTemp = alphas*values;
numColors=size(jet,1);
tMin = min(values);
tMax = max(values);
colorP = fix(numColors*(interpTemp-tMin)/(tMax-tMin)) + 1;
fprintf('Interpolated temperature = %f\n',interpTemp)
fprintf('Assigned Color %d RGB: %f,%f,%f\n',colorP,map(colorP,:))

%% A color triangle mesh. Function plotCountourSolution
% Using the approach of the previous exemple and given the values at the 
% nodes of a mesh, we can draw the color interpolation on each element.

eval('meshHole')

numNodes=size(nodes,1);
numElem=size(elem,1);

temp=1:numNodes;

colorMap='jet';
title='Temperature Plot';

plotContourSolution(nodes,elem,temp,title,colorMap); %Can plot both triang.
                                                     %and quad. meshes!