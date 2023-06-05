clear all
close all
clc

values_new = [0.132 0.64 1.532 1.926 2.116 2.228 2.292 2.336 2.368 2.396 2.41 ...
    2.42 2.436 2.44 2.45 2.452 2.46 2.46 2.466 2.47 2.47];
values_old = [0.11 1.388 1.9 2.136 2.24 2.278 2.314 2.324 2.34 2.348 2.354 ...
    2.356 2.358 2.364 2.374 2.376 2.376 2.374 2.368 2.37 2.37];

distances = [0 3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60];

figure(1)
p=plot (distances, values_new, '-o','LineWidth',2)
hold on
q = plot (distances, values_old, '-s', 'LineWidth',2)
% grid on
%[t,s] = title ('North Pole')
x = xlabel('Distance [mm]')
y = ylabel ('Voltage [V]')
ylim ([0 3])
xlim([0 60])
xticks([0:60])
a = yline(2.49)
a.LineWidth = 1;
a.LineStyle = '--';
% a.Label = 'Regime value'
l=legend ('Hole magnet', 'Cylinder magnet')
l.Location = 'northwest'
l.FontSize = 30

%p.MarkerFaceColor = [1 0.5 0];
%p.MarkerSize = 8;
p.Color = [0.8500 0.3250 0.0980];
q.Color = [0.3010 0.7450 0.9330];
%q.MarkerSize = 8;

%t.FontSize = 16;
% s.FontAngle='italic';
x.FontSize = 30;
y.FontSize = 30;