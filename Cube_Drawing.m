close all

% Coordinates
coord = [...
    20  0   0;
    30  0   0;
    30  10  0;
    20  10  0;
    20  0   10;
    30  0   10;
    30  10  10;
    20  10  10;];
idx = [4 8 5 1 4; 1 5 6 2 1; 2 6 7 3 2; 3 7 8 4 3; 5 8 7 6 5; 1 4 3 2 1]';

% Building the cube
xc = coord(:,1);
yc = coord(:,2);
zc = coord(:,3);
figure;
grid on
hold on
patch(xc(idx), yc(idx), zc(idx), 'r', 'facealpha', 0.1);
% patch([0 .5 1], [0 1 0], [1 0 0])
axis([10 36 -36 36 -36 36]);
view(3);