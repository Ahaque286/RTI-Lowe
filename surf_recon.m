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
surf(X,Y,Z_x)

figure
surfnorm(X,Y,Z)