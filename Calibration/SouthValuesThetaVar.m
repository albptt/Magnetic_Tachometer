clear all
close all
clc

theta = linspace(-pi/(7.5), pi/(7.5), 17);
% theta = linspace (-24, 24, 17);
voltage1 = [2.476 2.476 2.494 2.524 2.582 2.674 2.748 2.818 2.85 2.836 ...
    2.796 2.716 2.624 2.544 2.5 2.482 2.482];
voltage2 = [2.49 2.49 2.5 2.52 2.554 2.6 2.644 2.68 2.706 2.708 2.694 ...
    2.66 2.61 2.568 2.53 2.5 2.49];
voltage3 = [2.49 2.5 2.51 2.52 2.54 2.566 2.588 2.602 2.61 2.608 2.6 2.582 ...
    2.56 2.54 2.52 2.506 2.49];

x = [0 -pi/(7.5)];
y = [0 3];

z = [0 pi/(7.5)];
w = [0 3];

a = linspace(-pi/(7.5), -pi, 50);
b = 2.49.*1.^(1:50);

c = linspace (pi/(7.5), pi, 50);
d =2.49.*1.^(1:50);

figure(1)
PolarGraph1 = polarplot(theta,voltage1);
PolarGraph1.LineStyle ="-";
PolarGraph1.Color = [0.4940 0.1840 0.5560];
PolarGraph1.Marker = "hexagram";
PolarGraph1.LineWidth = 1;
hold on
PolarGraph2 = polarplot(theta,voltage2);
PolarGraph2.LineStyle ="-";
PolarGraph2.Color = [0.3010 0.7450 0.9330]
PolarGraph2.Marker = "hexagram";
PolarGraph2.LineWidth = 1;
PolarGraph3 = polarplot(theta,voltage3);
PolarGraph3.LineStyle ="-";
PolarGraph3.Color = [1 0.5 0.8];
PolarGraph3.Marker = "hexagram";
PolarGraph3.LineWidth = 1;
hold on
polarplot(x,y, 'k-')
polarplot(z,w, 'k-')
A = polarplot(a,b)
B = polarplot(c,d)
A.Color = 'k';
A.LineWidth = 1;
B.Color = 'k';
B.LineWidth = 1;
ax = gca();
legend('1.5cm', '2 cm', '2.5 cm')
thetaticks(0:24:360)
% thetaticks([24 336])
thetaticklabels ({'0','24°',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','','-24°'})
pax = gca;
pax.FontSize = 10
%rticks([2.4 2.5 2.6 2.7 2.8 2.9])
rticks([2.61 2.706 2.85])

%t = title('Rate of change of the voltage with respect to degree, South pole')


%[t,s] = title ('Rate of change of the voltage with respect to degree, South pole','Different distances, \theta variable')
%t.FontSize = 16;
%t.Position = [5.5895e-06 3.7678 0]
% s.FontAngle='italic';
% s.Position = [5.5895e-06 3.4777 0]