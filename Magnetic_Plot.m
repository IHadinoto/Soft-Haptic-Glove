close all 

%% Plotting
figure(1)
hold on

%% Obtain Data
data = readtable('Magnetic Test.txt');
[timediff, norm] = Magnetic_Test(data);
norm = norm*25.4;
plot(timediff, norm)

data = readtable('Magnetic Test 2.txt');
[timediff, norm] = Magnetic_Test(data);
plot(timediff, norm)

hold off
grid on
xlabel('Time/s'); ylabel('Displacement/mm');
title('Plot of Displacement against Time')
legend('inches to mm','mm')
