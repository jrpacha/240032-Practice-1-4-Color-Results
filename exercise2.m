clearvars
close all

p=[39.0,7.0];
eval('meshTwoHolesQuad');
numNodes=size(nodes,1);
numElem=size(elem,1);

for e=1:numElem
    n1=elem(e,1);
    n2=elem(e,2);
    n3=elem(e,3);
    n4=elem(e,4);
    v1=nodes(n1,:);
    v2=nodes(n2,:);
    v3=nodes(n3,:);
    v4=nodes(n4,:);
    vertexs=[v1;v2;v3;v4];
    [alphas,isInside]=baryCoordQuad(vertexs,p);
    if isInside >=1
        break;
    end
end

figure()
plotQuadMesh(nodes, elem);
hold on
plot(p(1,1),p(1,2),'or','Marker','o','MarkerFaceColor','red',...
    'MarkerSize',5)
plot(vertexs(:,1),vertexs(:,2),'og','Marker','o','MarkerFaceColor',...
    'green','MarkerSize',4)
hold off


%Intepolate temperature at point p
temp=1:numNodes;%temperatures at the nodes (just an example).
                
                      
%Interpolated temperature at point p                      
interpTemp=temp(n1)*alphas(1)+...
    temp(n2)*alphas(2)+...
    temp(n3)*alphas(3)+...
    temp(n4)*alphas(4)

fprintf('Elem: %d\n',e)
fprintf('Nodes: %d,%d,%d,%d\n',n1,n2,n3,n4)
fprintf('%7s%11s\n','X','Y')      %fancy output: don't try this at exams!
fprintf('%12.5e%12.5e\n',vertexs')%fancy output: don't try this at exams!
fprintf('\nInterpolated Temp.at point p=(%f,%f),\nT=%12.5e\n',...
    p,interpTemp);

%Color map for the temperatures (optioinal for this practice)
titol='Temperature plot';
colorScale='jet';
plotContourSolution(nodes,elem,temp,titol,colorScale)
hold on
plot(p(1,1),p(1,2),'ok','Marker','o','MarkerFaceColor','black',...
    'MarkerSize',4)
plot(vertexs(:,1),vertexs(:,2),'ok','Marker','o','MarkerFaceColor',...
    'black','MarkerSize',4)
hold off