close all

%% Plotting
figure(1)
x = linspace(10,30,50);
y = 60*cos((x)/3.2)+60;
hold on
plot(x,y)

%% Obtain Data
data = readtable('Magnetic Tracking System Control.txt');
[timediff, norm] = Magnetic_Test(data);
norm = norm*25.4;
plot(timediff, norm)

data = readtable('Magnetic Tracking System Experiment.txt');
[timediff, norm] = Magnetic_Test(data);
norm = norm*25.4;
plot(timediff, norm)

hold off
grid on
xlabel('Time/s'); ylabel('Displacement/mm');
title('Plot of Displacement against Time')
legend('zaber','without Coil','with Coil')
