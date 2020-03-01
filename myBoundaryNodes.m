function [indNodBd, indElemBd, indLocalEdgBd, edges] = myBoundaryNodes(nodes, elem)
% output:
% indNodBd  -->  list of all nodes on the boundary
% indElemBd -->  list of indices of the Elements on the boundary
% indLocalEdgBd  -->  list of indices of the local element edges on the boundary
% edges     -->  list of all edges defined in the total mesh
% 

[numElem,nd] = size(elem);
indElemBd = [];
indLocalEdgBd = [];
edges = [];
Ones = ones(numElem,nd);
localEdgs = [2:nd;1:nd-1];
localEdgs = [localEdgs';nd,1];

for e = 1:numElem    
    for j = 1:nd
        A = elem(e,localEdgs(j,1))*Ones;
        B = elem(e,localEdgs(j,2))*Ones;
        L = (elem == A) | (elem == B);
        c = sum(L');
        if length(find(c == 2)) == 1
           indElemBd = [indElemBd,e];
           indLocalEdgBd = [indLocalEdgBd,j];
           edges = [edges;elem(e,localEdgs(j,1)),elem(e,localEdgs(j,2))];
        end
    end
end
indElemBd=unique(indElemBd,'sort');
indNodBd = unique([edges(:,1)',edges(:,2)'],'sort');
end

