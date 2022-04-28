global libstring;
close all

%% Option to start Setup Procedure (just once is enough)
% tracker_setup

%% Initialize structure
for kk = 0:(4 - 1)
   sm.(['x' num2str(kk)]) = 0;
   sm.(['y' num2str(kk)]) = 0;
   sm.(['z' num2str(kk)]) = 0;
   sm.(['a' num2str(kk)]) = 0;
   sm.(['e' num2str(kk)]) = 0;
   sm.(['r' num2str(kk)]) = 0;
   sm.(['time' num2str(kk)]) = 0;
   sm.(['quality' num2str(kk)]) = 0;  
end

pRecord = libpointer('tagDOUBLE_POSITION_ANGLES_TIME_Q_RECORD_AllSensors_Four', sm);
Counter = 0;

%% Building the cube (10x10x10inches)
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

xc = coord(:,1);
yc = coord(:,2);
zc = coord(:,3);

%% Real-time Graph
h = figure(1);
grid on
view(3)
hold on
% plot3()
sens1 = plot3(0,0,0,'o','LineWidth',10,'MarkerSize',15);
sens2 = plot3(0,0,0,'o','LineWidth',10,'MarkerSize',15);
patch(xc(idx), yc(idx), zc(idx), 'r', 'facealpha', 0.1);
hold off
axis([-36 36 -36 36 -36 36]);
xlabel('X in inches')
ylabel('Y in inches')
zlabel('Z in inches')

disp('Please hit any key to quit')
while 1
    % kbhit to quit the program
    isKeyPressed = ~isempty(get(h,'CurrentCharacter'));
    if isKeyPressed
        break
    end
    
    % Get Synchronous Record
    Error   = calllib(libstring, 'GetSynchronousRecord',  hex2dec('ffff'), pRecord, 4*64);
    errorHandler(Error);
    Counter = Counter + 1; % consider removing counter
    Record = get(pRecord, 'Value');
    for count = 1:2 % number of sensors
        Pos(Counter, 1, count) = Record.(['x' num2str(count - 1)]);
        Pos(Counter, 2, count) = Record.(['y' num2str(count - 1)]);
        Pos(Counter, 3, count) = -Record.(['z' num2str(count - 1)]); % flip z axis
        % Ang(Counter, 1, count) = Record.(['a' num2str(count - 1)]);
        % Ang(Counter, 2, count) = Record.(['e' num2str(count - 1)]);
        % Ang(Counter, 3, count) = Record.(['r' num2str(count - 1)]);
        % time(Counter, 1, count) = Record.(['time' num2str(count - 1)]);        
        % Quality(Counter, 1, count) = Record.(['quality' num2str(count - 1)]);    
    end
    % Update graphs
    set(sens1, 'XData', Pos(Counter, 1, 1), 'YData', Pos(Counter, 2, 1), 'ZData', Pos(Counter, 3, 1));
    set(sens2, 'XData', Pos(Counter, 1, 2), 'YData', Pos(Counter, 2, 2), 'ZData', Pos(Counter, 3, 2));
    % sprintf('x = %f, y = %f, z = %f', Pos(Counter, 1, 1)', Pos(Counter, 2, 1), Pos(Counter, 3, 1))
    pause(0.00000001)
    % drawnow limitrate  % forces Matlab to evaluate Callback in figure
    
    % Check object collision
    if (Pos(Counter,1,1)>20 && (Pos(Counter,1,1)<30)) && (Pos(Counter,2,1)>0 && (Pos(Counter,2,1)<10)) && (Pos(Counter,3,1)>0 && (Pos(Counter,3,1)<10))
        disp('Object is Colliding!')
    else
        disp('Not Colliding!')
    end
end
