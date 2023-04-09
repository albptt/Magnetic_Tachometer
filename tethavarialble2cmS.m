clear all
close all
clc

% insert the data measured
theta = linspace(-pi/15, pi/15, 17);
voltage = [2.49 2.472 2.46 2.43 2.4 2.36 2.326 2.3 2.292 2.298 2.324 2.356 ...
    2.398 2.43 2.456 2.47 2.49];

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
PolarGraph.Color = [0.8500 0.3250 0.0980];
PolarGraph.Marker = "hexagram";
PolarGraph.LineWidth = 1;
hold on
polar(x,y, 'k-')
polar(z,w, 'k-')
A = polar(a,b)
B = polar(c,d)
A.Color = [0.8500 0.3250 0.0980];
A.LineWidth = 1;
B.Color = [0.8500 0.3250 0.0980];
B.LineWidth = 1;

% caratteristiche titolo
[t,s] = title ('Rate of change of the voltage with respect to degree, South pole','Distance set at 2 cm, \theta variable')
t.FontSize = 16;
s.FontAngle='italic';