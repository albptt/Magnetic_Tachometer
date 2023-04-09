clear all
close all
clc

%% valori misurati
theta = linspace(-pi/15, pi/15, 17); % i plot dei grafici polari richiedono i valori in radianti
voltage = [2.49 2.49 2.5 2.52 2.554 2.6 2.644 2.68 2.706 2.708 2.694 ...
    2.66 2.61 2.568 2.53 2.5 2.49]
    
%% assi di riferimento per lo spicchio di nostro interesse
x = [0 -pi/15];
y = [0 3];

z = [0 pi/15];
w = [0 3];

%% curve per individuare i valori a regime
a = linspace(-pi/15, -pi, 50);
b = 2.49.*1.^(1:50);

c = linspace (pi/15, pi, 50);
d =2.49.*1.^(1:50);

%% grafici
figure(1)
PolarGraph = polar(theta,voltage);
PolarGraph.LineStyle ="-";
PolarGraph.Color = [0.3010 0.7450 0.9330];
PolarGraph.Marker = "hexagram";
PolarGraph.LineWidth = 1;
hold on
polar(x,y, 'k-')
polar(z,w, 'k-')
A = polar(a,b)
B = polar(c,d)
A.Color = [0.3010 0.7450 0.9330];
A.LineWidth = 1;
B.Color = [0.3010 0.7450 0.9330];
B.LineWidth = 1;

%% caratteristiche titolo
[t,s] = title ('Rate of change of the voltage with respect to degree, North pole','Distance set at 2 cm, \theta variable')
t.FontSize = 16;
s.FontAngle='italic';
