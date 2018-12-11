
x = -1:0.01:2;
y = -1:0.01:2;
[X,Y] = meshgrid(x,y);
Z = X.*sin(4*pi.*X) - Y.*sin(4*pi*Y + pi) + 1;

surf(X,Y,Z)