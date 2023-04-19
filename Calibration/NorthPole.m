clear all
close all
clc

values = [0.132 0.64 1.532 1.926 2.116 2.228 2.292 2.336 2.368 2.396 2.41 ...
    2.42 2.436 2.44 2.45 2.452 2.46 2.46 2.466 2.47 2.47];

distances = [0 3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60];

figure(1)
p=plot (distances, values, '-o','LineWidth',2)
grid on
[t,s] = title ('North Pole')
x = xlabel('Distance [mm]')
y = ylabel ('Voltage [V]')
ylim ([0 3])
a = yline(2.49)
a.LineWidth = 1;
a.LineStyle = '--';
% a.Label = 'Regime value'

p.MarkerFaceColor = [1 0.5 0];
p.MarkerSize = 8;
t.FontSize = 16;
% s.FontAngle='italic';
x.FontSize = 15;