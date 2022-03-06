function plotElements(nodes, elem, numbering)
%
%(c)Numerical Factory 2021
%

[numNod, dim] = size(nodes);
numElem = size(elem,1);
xmax = max(nodes(:,1));
xmin = min(nodes(:,1));
if (dim==1)
    ymax=2;
    ymin=-2;
else
    ymax = max(nodes(:,2));
    ymin = min(nodes(:,2));
end
shift = max(0.01*max(abs([xmin, xmax, ymin,ymax])),0.04);
shiftPoints = shift;

%shift=2*max(0.02*max(abs([xmax, xmin,ymin,ymax])),0.01);
if (size(elem,2) == 2 && dim == 1) %1D bar elements
    shift=0.1;
    yyy=zeros(numNod,1);
    plot(nodes(:,1),yyy,'ro','LineWidth',1.2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5); 
    axis([xmin-shift, xmax+3*shift, ymin-shift, ymax+shift])
    hold on;
%    shiftPoints=shift; %0.01*max(max(abs(nodes)));
  if (numbering==1)
    for n=1:numNod
        labelNode = ['{\boldmath$n_{',num2str(n),'}$}'];
        text(nodes(n,1),-shift,...
            labelNode,'interpreter','LaTeX','fontSize',12)
    end
    hold on;
  end
%    shiftEdges=shift;
    for e=1:numElem
        labelEdge = ['{\boldmath$E_{',num2str(e),'}$}'];
        plot([nodes(elem(e,1),1),nodes(elem(e,2),1)],[0,0],'b-');        
        p=(nodes(elem(e,1),1)+nodes(elem(e,2),1))/2;
      if (numbering==1)
        text(p,shift,...
            labelEdge,'interpreter','LaTeX','fontSize',12);
      end
    end
elseif (size(elem,2) == 3 && dim == 1) %1D bar quadratic elements
    shift=0.1;
    yyy=zeros(numNod,1);
    plot(nodes(:,1),yyy,'ro','LineWidth',1.2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5); 
    axis([xmin-shift, xmax+3*shift, ymin-shift, ymax+shift])
    hold on;
%    shiftPoints=shift; %0.01*max(max(abs(nodes)));
  if (numbering==1)
    for n=1:numNod
        labelNode = ['{\boldmath$n_{',num2str(n),'}$}'];
        text(nodes(n,1),-shift,...
            labelNode,'interpreter','LaTeX','fontSize',12)
    end
    hold on;
  end
%    shiftEdges=shift;
    for e=1:numElem
        labelEdge = ['{\boldmath$E_{',num2str(e),'}$}'];
        plot([nodes(elem(e,1),1),nodes(elem(e,3),1)],[0,0],'b-');        
        p=(nodes(elem(e,1),1)+nodes(elem(e,3),1))/2;
      if (numbering==1)
        text(p,shift,...
            labelEdge,'interpreter','LaTeX','fontSize',12);
      end
    end

        
elseif(size(elem,2) == 2 && dim == 2) % 2D bar elements
    plot(nodes(:,1),nodes(:,2),'ro','LineWidth',1.2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);
    axis([xmin-2*shift, xmax+2*shift, ymin-2*shift, ymax+2*shift])
    hold on;
    %shiftPoints=0.05*max(max(abs(nodes)));
  if (numbering==1)
    for n=1:numNod
        labelNode = ['{\boldmath$n_{',num2str(n),'}$}'];
        text(nodes(n,1),nodes(n,2)-shift,...
            labelNode,'interpreter','LaTeX','fontSize',12)
    end
  end

    %Plot elements
    for e=1:numElem
        labelEdge = ['{\boldmath$E_{',num2str(e),'}$}'];
        plot(nodes(elem(e,:),1),nodes(elem(e,:),2),'b-');
        p=[sum(nodes(elem(e,:),1)),sum(nodes(elem(e,:),2))]/2;
      if (numbering==1)
        text(p(1,1)+shift,p(1,2)+shift,...
            labelEdge,'interpreter','LaTeX','fontSize',12);
      end
    end
    axis equal vis3d
    
elseif(size(elem,2) == 2 && dim == 3) %3D bar elements
    plot3(nodes(:,1),nodes(:,2),nodes(:,3),'ro','LineWidth',1.2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);           
    %axis([xmin-shift, xmax+shift, ymin-shift, ymax+shift, zmin-shift, zmax+shift])
    view(120,20);
    hold on;
    %shiftPoints=0.05*max(max(abs(nodes)));
  if (numbering==1)
    for n=1:numNod
        labelNode = ['{\boldmath$n_{',num2str(n),'}$}'];
        text(nodes(n,1)+shift,nodes(n,2)+shift,nodes(n,3)+shift,...
            labelNode,'interpreter','LaTeX','fontSize',12)
    end
  end
    %Plot elements
    shiftEdges=shift;
    for e=1:numElem
        labelEdge = ['{\boldmath$E_{',num2str(e),'}$}'];
        plot3(nodes(elem(e,:),1),nodes(elem(e,:),2),nodes(elem(e,:),3),'b-');
        p=[sum(nodes(elem(e,:),1)),sum(nodes(elem(e,:),2)),sum(nodes(elem(e,:),3))]/2;
  if (numbering==1)
        text(p(1,1)+shiftEdges,p(1,2)+shiftEdges,p(1,3)+shiftEdges,...
            labelEdge,'interpreter','LaTeX','fontSize',12);
    end    
    end    
 
   axis equal vis3d
    hold off; 
    
elseif (size(elem,2) == 3 && dim == 2) %Case Triangles
    A = sparse([elem(:,1); elem(:,1); elem(:,2); elem(:,2); elem(:,3); elem(:,3)], ...
    [elem(:,2); elem(:,3); elem(:,1); elem(:,3); elem(:,1); elem(:,2)],1.0);
    A = min(A, 1);
    gplot(A,nodes)
    hold on;
    h = title('Triangle Elements Visualizer');
    set(h,'FontSize',11,'FontWeight','bold') 
    plot(nodes(:,1),nodes(:,2),'ro','LineWidth',1.5,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',2);         
    axis([xmin-2*shift, xmax+2*shift, ymin-2*shift, ymax+2*shift]);
    axis equal;
    if (numbering==1)
        for n=1:numNod
            labelNode = ['{\boldmath$n_{',num2str(n),'}$}'];
            text(nodes(n,1),nodes(n,2)-shiftPoints,labelNode,'interpreter','LaTeX','fontSize',12)
        end
        for e=1:numElem   
            xx=sum(nodes(elem(e,:),:),1)/3;
            labelNode = ['{\boldmath$E_{',num2str(e),'}$}'];
            text(xx(1),xx(2),labelNode,'interpreter','LaTeX','fontSize',12)
        end
    end
    hold off;
elseif (size(elem,2) == 4 && dim == 2) % case quadrilaterals
   A = sparse(...
        [elem(:,1); elem(:,1); elem(:,2); elem(:,2); elem(:,3); elem(:,3); elem(:,4); elem(:,4)], ...
        [elem(:,4); elem(:,2); elem(:,1); elem(:,3); elem(:,2); elem(:,4); elem(:,3); elem(:,1)], ...
        1.0);
    A = min(A, 1);
    gplot(A,nodes)
    hold on;
    h = title('Quadrilateral Elements Visualizer');
    set(h,'FontSize',11,'FontWeight','bold') 
    plot(nodes(:,1),nodes(:,2),'ro','LineWidth',1.5,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',2);         
    axis([xmin-2*shift, xmax+2*shift, ymin-2*shift, ymax+2*shift]);
    axis equal;

    if (numbering==1)
        for n=1:numNod
            labelNode = ['{\boldmath$n_{',num2str(n),'}$}'];
            text(nodes(n,1),nodes(n,2)-shiftPoints,labelNode,'interpreter','LaTeX','fontSize',12)
        end
        for e=1:numElem   
            xx=sum(nodes(elem(e,:),:),1)/4;
            labelNode = ['{\boldmath$E_{',num2str(e),'}$}'];
            text(xx(1),xx(2),labelNode,'interpreter','LaTeX','fontSize',12)
        end
    end
    
    hold off;

elseif (size(elem,2) == 4 && dim == 3) % case Tetrahedra
    TRI=[];
    for e=1:numElem   
        TRI=[TRI; elem(e,[1,2,3])]; %face 1
        TRI=[TRI; elem(e,[1,3,4])];
        TRI=[TRI; elem(e,[1,2,4])];
        TRI=[TRI; elem(e,[2,3,4])];
    end
    trimesh(TRI,nodes(:,1),nodes(:,2),nodes(:,3),'EdgeColor', [0.1, 0.8, 0.8]);
    axis equal vis3d


    hold off;
end



