clearvars
close all

%Exercise2
%Use the function plotContourSolution to draw the interpolated color map
%in a quadrengular mesh

eval('meshTwoHolesQuad');
numNodes=size(nodes,1);
numElem=size(elem,1);

temp=1:numNodes; %jaust as an example

colorMap='jet'
title='Temperature Plot'

plotContourSolution(nodes,elem,temp,title,colorMap); %Can plot both triang.
                                                     %and quad. meshes!