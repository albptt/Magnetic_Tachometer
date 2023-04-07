clear all
close all
clc

%% riporto i valori
theta = linspace(-pi/15, pi/15, 17);
voltage = [2.476 2.476 2.494 2.524 2.582 2.674 2.748 2.818 2.85 2.836 ...
    2.796 2.716 2.624 2.544 2.5 2.482 2.482];

%% assi che individuano lo spicchio di nostro interesse
x = [0 -pi/15];
y = [0 3];

z = [0 pi/15];
w = [0 3];

%% curve per i valori a regime
a = linspace(-pi/15, -pi, 12);
b = 2.49.*1.^(1:12);

c = linspace (pi/15, pi, 12);
d =2.49.*1.^(1:12);

%% grafici
figure(1)
PolarGraph = polar(theta,voltage);
PolarGraph.LineStyle ="-";
PolarGraph.Color = [0.4940 0.1840 0.5560];
PolarGraph.Marker = "hexagram";
PolarGraph.LineWidth = 1;
hold on
polar(x,y, 'k-')
polar(z,w, 'k-')
A = polar(a,b)
B = polar(c,d)
A.Color = [0.4940 0.1840 0.5560];
A.LineWidth = 1;
A.Color = [0.4940 0.1840 0.5560];
B.Color = [0.4940 0.1840 0.5560];
B.LineWidth = 1;

%% caratteristiche titolo
[t,s] = title ('Rate of change of the voltage with respect to degree, North pole','Distance set at 1.5 cm, \theta variable')
t.FontSize = 16;
s.FontAngle='italic';
