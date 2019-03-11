function [alphas,isInside] = baryCoordQuad(vertices,point)
%BARYCOORDQUAD 
%Compute the quadrilateral barycentric coordinates of the a point
%INPUT
% vertices (array 3x2): array holding the coordinates of the vertexs 
%                       of the quadrilateral V=[x1,y1;x2,y2;x3,y3;x4,y4].
%    point (array 1x2): array holding the coordinates of the point.
%
%OUTPUT
%   alphas (array 1x3): array holding the barycentric coordinates of the 
%                       point.
%   isInside (integer): if isInside=1, then the point belongs to the
%                       quadrilateral, if isInside=0, the point lies 
%                       outside.
% 

isInside=1;

%Vertices of the quadrilateral
v1=vertices(1,:);
v2=vertices(2,:);
v3=vertices(3,:);
v4=vertices(4,:);

% define the previous notation
a=(v1-point);
b=v2-v1;
c=v4-v1;
d=v1-v2-v4+v3;

% compute 2on order equation A mu^2 + B mu + C=0
% as the vertices are 2D, we add a zero third component
% to compute cross products.
A=cross([c,0],[d,0]); %must be 3D vectors
B=cross([c,0],[b,0])+cross([a,0],[d,0]);
C=cross([a,0],[b,0]);
% Only third component is needed (the other two are zero)
 A=A(3);
 B=B(3);
 C=C(3);
%
% Check for unique solutions
%
if (abs(A)<1.e-14)
    u1= -C/B;
    u2=u1;
else
    %
    % Check for non complex solutions
    %
    if (B^2-4*A*C >0)
        u1=(-B+sqrt(B^2-4*A*C))/(2*A);
        u2=(-B-sqrt(B^2-4*A*C))/(2*A);
    else %complex solution
        u1=-1000;
        u2=u1;
    end
end
%
mu=-10000; %stupid value small enough
if(u1>=0 && u1<=1)
    mu=u1;
end
if(u2>=0 && u2<=1)
    mu=u2;
end

% compute 2on order equation A lambda^2 + B lambda + C=0
A=cross([b,0],[d,0]); %must be 3D vectors
B=cross([b,0],[c,0])+cross([a,0],[d,0]);
C=cross([a,0],[c,0]);
% Only third component is needed (the other two are zero)
A=A(3);
B=B(3);
C=C(3);
%
% Check for unique solutions
%
if (abs(A)<1.e-14)
    w1= -C/B;
    w2=w1;
else
    %
    % Check for non complex solutions
    %
    if (B^2-4*A*C >0)
        w1=(-B+sqrt(B^2-4*A*C))/(2*A);
        w2=(-B-sqrt(B^2-4*A*C))/(2*A);
    else %complex solution
        w1=-1000;
        w2=w1;
    end
end
%
lambda=-10000; %stupid value
if(w1>=0 && w1<=1)
    lambda=w1;
end
if(w2>=0 && w2<=1)
    lambda=w2;
end
%[mu,lambda] %parameters
% Barycentric coordinates
alpha1=(1-mu)*(1-lambda);
alpha2=lambda*(1-mu);
alpha3=mu*lambda;
alpha4=(1-lambda)*mu;
alphas=[alpha1,alpha2,alpha3,alpha4];

if (min(alphas) < 0)
    isInside=0;
end

end

