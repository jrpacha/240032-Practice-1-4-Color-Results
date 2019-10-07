function [indNodBd, indElemBd, indLocalEdgBd, edges] = boundaryNodes(nodes, elem)
% output:
% indNodBd  -->  list of all nodes on the boundary
% indElemBd -->  list of indices of the Elements on the boundary
% indLocalEdgBd  -->  list of indices of the local element edges on the boundary
% edges     -->  list of all edges defined in the total mesh
% 
    numNod  = size(nodes,1);
    [numElem, ndim] = size(elem);
    if (ndim == 3) %triangle edges
        edges = unique(sort([elem(:,[1,2]);elem(:,[2,3]);elem(:,[3,1])],2),'rows');
    elseif (ndim == 4) %quadrilateral edges
        edges = unique(sort([elem(:,[1,2]);elem(:,[2,3]);elem(:,[3,4]);elem(:,[4,1])],2),'rows');
    end    
    indNodBd=[];
    indLocalEdgBd=[];
    indElemBd=[];
    % look for the edges belonging only to one element
    for i=1:size(edges,1)
        n1=edges(i,1);
        n2=edges(i,2);
        [indRow,indCol]=find(elem == n1); %find elements owning the first node
        [indElem,col]=find(elem(indRow,:) == n2); % owing also the second one
        if (length(indElem) == 1) %boundary edges
            indNodBd=[indNodBd, n1,n2];
            indElemBd=[indElemBd;indRow(indElem)];
            lloc1=find(elem(indRow(indElem),:)==n1);
            lloc2=find(elem(indRow(indElem),:)==n2);
            if (ndim == 3) %triangle edges
                aux=[0,0,0];
                aux(lloc1)=1;
                aux(lloc2)=1;
                number = aux(1)+2*aux(2)+4*aux(3); 
                switch (number) %identify the appropriate element edge
                    case 3
                        edgeBd=1; 
                    case 5
                        edgeBd=3; 
                    case 6
                        edgeBd=2; 
                    otherwise, error('edge not allowed');
                end
            elseif (ndim == 4) %quadrilateral edges
                aux=[0,0,0,0];
                aux(lloc1)=1;
                aux(lloc2)=1;
                number = aux(1)+2*aux(2)+4*aux(3)+8*aux(4); 
                switch (number) %identify the appropriate element edge
                    case 3
                        edgeBd=1; 
                    case 6
                        edgeBd=2; 
                    case 9
                        edgeBd=4; 
                    case 12
                        edgeBd=3; 
                    otherwise, error('edge not allowed');
                end
            end
            indLocalEdgBd=[indLocalEdgBd, edgeBd];
        end
    end
indNodBd=unique(indNodBd);