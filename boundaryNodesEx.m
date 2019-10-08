%boundaryNodesEx
%Example to show the output of function boundaryNodes.m

clearvars
close all

[X,Y]=meshgrid(0:3);
[n,m]=size(X);
nodes=[reshape(Y,n*m,1),reshape(X,n*m,1)];
elem=[1,2,6,5;2,3,7,6;3,4,8,7;
      5,6,10,9;6,7,11,10;7,8,12,11;
      9,10,14,13;10,11,15,14;11,12,16,15];
  
plotElements(nodes,elem,1)

[indNodBd, indElemBd, indLocalEdgeBd, edges] = boundaryNodes(nodes, elem);

%Output results
fprintf('Edges (matrix edges):\n')
numEdge=1:size(edges,1);
edges=[numEdge',edges];
fprintf('Edge %2d-->  %2d %2d\n',edges.')

fmt=repmat('%2d, ',1,size(indNodBd(:),1)-1);
fmt=['Nodes on the boundary (vector indNodBd):\n',fmt,'%2d\n'];
fprintf(fmt,indNodBd)

fmt=repmat('%2d, ',1,size(indElemBd(:),1)-1);
fmt=['Elements on the boundary (vector indElemBd):\n',fmt,'%2d\n'];
fprintf(fmt,indElemBd)

fmt=repmat('%2d, ',1,size(indLocalEdgeBd(:),1)-1);
fmt=['Elements on the boundary (vector indLocalEdgBd):\n',fmt,'%2d\n'];
fprintf(fmt,indLocalEdgeBd)
  