function plotQuadMesh(coord, elem)
%(c)Numerical Factory 2016
    h = title('Mesh Visualizer Quad');
    set(h,'FontSize',15,'FontWeight','bold')
    axis equal;
   A = sparse(...
        [elem(:,1); elem(:,1); elem(:,2); elem(:,2); elem(:,3); elem(:,3); elem(:,4); elem(:,4)], ...
        [elem(:,4); elem(:,2); elem(:,1); elem(:,3); elem(:,2); elem(:,4); elem(:,3); elem(:,1)], ...
        1.0);
    A = min(A, 1);
    gplot(A,coord)
    axis equal;
