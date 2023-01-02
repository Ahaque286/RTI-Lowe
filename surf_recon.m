% This example shows how to rebuild a CONTINOUS surface from normal vectors
%
% The technique will not work if the surface is something like a staircase
% with infinite slope in certain points. The RTI does not have information
% about such points.
%  
% I initially created a surface Z = (X,Y) and generated its normal vectors.
% Then used those normal vectors to regenerate the surface. 
% Figure 1 shows the original surface with normal vectors and figure 2
% shows the surface reconstrcuted from the normal vectos via integration.
%
m = 50;
n = 50;
x = single(linspace(-8,8,m));
y = single(linspace(-8,8,n));
[X,Y] = meshgrid(x,y);
%Z = (4-abs(X)) + (4-abs(Y));
Z = X.^3-3.*X.*Y.^2;
%Z(Z < 0) = 0;

% normal vectors
[Nx, Ny, Nz] = surfnorm(X,Y,Z);

% Gradient generation
dx = Nx./Nz; % returns the partial derivative of z with respect to x
dy = Ny./Nz; % returns the partial derivative of z with respect to y
dz = Nz./Nz;

% boundary condition
Z_x = zeros(50);
for i =2:50
        Z_x (i,1) = -dy(i-1,1)*16/n+Z_x(i-1,1);
end

% integration
for i = 1:50
    for j =2:50
        Z_x (i,j) = -dx(i,j-1)*16/m+Z_x(i,j-1);
    end
end

figure
surfnorm(X,Y,Z)

figure
surf(X,Y,Z_x)