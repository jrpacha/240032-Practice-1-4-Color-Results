clearvars
close all

v1=[0,0];
v2=[5,-1];
v3=[4,5];
v4=[1,4];
vertexs=[v1;v2;v3;v4];

p=[3,2];

plotRectangle(v1, v2, v3, v4);
hold on
plot(p(1,1),p(1,2),'o','Marker','o','MarkerfaceColor','red')
hold off

[alphas,isInside]=baryCoordQuad(vertexs,p);

fprintf('alphas = [%.4e, %.4e, %.4e, %.4e]\n',alphas)
fprintf('isInside = %d\n',isInside)

