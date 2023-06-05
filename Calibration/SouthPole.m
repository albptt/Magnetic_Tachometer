clear all
close all
clc

values_new = [4.922 3.996 3.444 2.946 2.796 2.706 2.652 2.612 2.584 2.564 2.55 2.538 ...
    2.53 2.52 2.514 2.51 2.508 2.5 2.5 2.5 2.5];
values_old = [4.986 3.474 2.96 2.74 2.63 2.574 2.542 2.524 2.512 2.504 2.502 ...
    2.492 2.468 2.472 2.468 2.466 2.466 2.466 2.462 2.46 2.46]

distances = [0 3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60];

figure(1)
p=plot (distances, values_new, '-o','LineWidth',2)
hold on
q = plot (distances, values_old, '-s', 'LineWidth',2)
% grid on
%[t,s] = title ('North Pole')
x = xlabel('Distance [mm]')
y = ylabel ('Voltage [V]')
ylim ([2 5])
xlim([0 60])
xticks([0:60])
a = yline(2.49)
a.LineWidth = 1;
a.LineStyle = '--';
% a.Label = 'Regime value'
l=legend ('Hole magnet', 'Cylinder magnet')
l.Location = 'northeast'
l.FontSize = 30

%p.MarkerFaceColor = [1 0.5 0];
%p.MarkerSize = 8;
p.Color = [0.9290 0.6940 0.1250];
q.Color = [0.4660 0.6740 0.1880]
%q.MarkerSize = 8;

%t.FontSize = 16;
% s.FontAngle='italic';
x.FontSize = 30;
y.FontSize = 30;