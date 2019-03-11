clearvars
close all

p=[39.0,7.0];
eval('meshTwoHolesQuad');
numNodes=size(nodes,1);
numElem=size(elem,1);

for e=1:numElem
    v1=nodes(elem(e,1),:);
    v2=nodes(elem(e,2),:);
    v3=nodes(elem(e,3),:);
    v4=nodes(elem(e,4),:);
    vertexs=[v1;v2;v3;v4];
    [alphas,isInside]=baryCoordQuad(vertexs,p);
    if isInside >=1
        break;
    end
end

plotQuadMesh(nodes, elem);
hold on
plot(p(1,1),p(1,2),'o','Marker','o','MarkerFaceColor','red',...
    'MarkerSize',5)
plot(vertexs(:,1),vertexs(:,2),'o','Marker','o','MarkerFaceColor',...
    'green','MarkerSize',4)
hold off

fprintf('Elem: %d\n',e)
fprintf('%7s%11s\n','X','Y')
fprintf('%12.5e%12.5e\n',vertexs');