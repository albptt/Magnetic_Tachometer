clear all
close all
clc

values = [4.922 3.996 3.444 2.946 2.796 2.706 2.652 2.612 2.584 2.564 2.55 2.538 ...
    2.53 2.52 2.514 2.51 2.508 2.5 2.5 2.5 2.5];

distances = [0 3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60];

figure(1)
p=plot (distances, values, '-o','LineWidth',3)
grid on
[t,s] = title ('South Pole')
x = xlabel('Distance [mm]')
y = ylabel ('Voltage [V]')
% ylim ([0 3])
a = yline(2.49)
a.LineWidth = 1;
a.LineStyle = '--';
% a.Label = 'Regime value'

p.MarkerFaceColor = [1 0.5 0];
p.MarkerSize = 8;
t.FontSize = 16;
% s.FontAngle='italic';
x.FontSize = 15;
y.FontSize = 15;

