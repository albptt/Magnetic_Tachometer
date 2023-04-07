clear all
close all
clc

%% riporto i valori
theta = linspace(-pi/15, pi/15, 17); % i plot dei grafici polari richiedono i valori in radianti
voltage = [2.49 2.5 2.51 2.52 2.54 2.566 2.588 2.602 2.61 2.608 2.6 2.582 ...
    2.56 2.54 2.52 2.506 2.49];

%% assi di riferimento per individuare lo spicchio di nostro interesse
x = [0 -pi/15];
y = [0 3];

z = [0 pi/15];
w = [0 3];

%% plotto i valori a regime
a = linspace(-pi/15, -pi, 12);
b = 2.49.*1.^(1:12);

c = linspace (pi/15, pi, 12);
d =2.49.*1.^(1:12);

%% grafici
figure(1)
PolarGraph = polar(theta,voltage);
PolarGraph.LineStyle ="-";
PolarGraph.Color = [0.6350 0.0780 0.1840];
PolarGraph.Marker = "hexagram";
PolarGraph.LineWidth = 1;
hold on
polar(x,y, 'k-')
polar(z,w, 'k-')
A = polar(a,b)
B = polar(c,d)
A.Color = [0.6350 0.0780 0.1840]; 
A.LineWidth = 1;
B.Color = [0.6350 0.0780 0.1840];
B.LineWidth = 1;

%% caratteristiche del titolo
[t,s] = title ('Rate of change of the voltage with respect to degree, North pole','Distance set at 2,5 cm, \theta variable')
t.FontSize = 16;
s.FontAngle='italic';
