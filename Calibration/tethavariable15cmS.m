clear all
close all
clc

% insert the data measured
theta = linspace(-pi/15, pi/15, 17);
voltage = [2.49 2.49 2.478 2.45 2.402 2.344 2.288 2.242 2.214 2.212 2.24 ...
    2.29 2.348 2.41 2.45 2.478 2.49];

% definisco lo spicchio di interesse
x = [0 -pi/15];
y = [0 3];

z = [0 pi/15];
w = [0 3];

% valori a regime
a = linspace(-pi/15, -pi, 50);
b = 2.49.*1.^(1:50);

c = linspace (pi/15, pi, 50);
d =2.49.*1.^(1:50);

% grafici
figure(1)
PolarGraph = polar(theta,voltage);
PolarGraph.LineStyle ="-";
PolarGraph.Color = [0.9290 0.6940 0.1250];
PolarGraph.Marker = "hexagram";
PolarGraph.LineWidth = 1;
hold on
polar(x,y, 'k-')
polar(z,w, 'k-')
A = polar(a,b)
B = polar(c,d)
A.Color = [0.9290 0.6940 0.1250];
A.LineWidth = 1;
B.Color = [0.9290 0.6940 0.1250];
B.LineWidth = 1;

% caratteristiche titolo 
[t,s] = title ('Rate of change of the voltage with respect to degree, South pole','Distance set at 1.5 cm, \theta variable')
t.FontSize = 16;
s.FontAngle='italic';