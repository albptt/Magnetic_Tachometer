clear all
close all
clc

% insert the data measured
theta = linspace(-pi/(7.5), pi/(7.5), 17);
voltage1 = [2.49 2.49 2.478 2.45 2.402 2.344 2.288 2.242 2.214 2.212 2.24 ...
    2.29 2.348 2.41 2.45 2.478 2.49];
voltage2 = [2.49 2.472 2.46 2.43 2.4 2.36 2.326 2.3 2.292 2.298 2.324 2.356 ...
    2.398 2.43 2.456 2.47 2.49];
voltage3 = [2.49 2.468 2.456 2.436 2.416 2.396 2.378 2.366 2.36 2.366 2.376 ...
    2.39 2.414 2.434 2.45 2.468 2.49];

% definisco lo spicchio di interesse
x = [0 -pi/(7.5)];
y = [0 3];

z = [0 pi/(7.5)];
w = [0 3];

% valori a regime
a = linspace(-pi/(7.5), -pi, 50);
b = 2.49.*1.^(1:50);

c = linspace (pi/(7.5), pi, 50);
d =2.49.*1.^(1:50);

% grafici
figure(1)
PolarGraph1 = polarplot(theta,voltage1);
PolarGraph1.LineStyle ="-";
PolarGraph1.Color = [0.9290 0.6940 0.1250];
PolarGraph1.Marker = "hexagram";
PolarGraph1.LineWidth = 1;
hold on
PolarGraph2 = polarplot(theta,voltage2);
PolarGraph2.LineStyle ="-";
PolarGraph2.Color = [0.8500 0.3250 0.0980]
PolarGraph2.Marker = "hexagram";
PolarGraph2.LineWidth = 1;
PolarGraph3 = polarplot(theta,voltage3);
PolarGraph3.LineStyle ="-";
PolarGraph3.Color = [0.6350 0.0780 0.1840]
PolarGraph3.Marker = "hexagram";
PolarGraph3.LineWidth = 1;
polarplot(x,y, 'k-')
polarplot(z,w, 'k-')
A = polarplot(a,b)
B = polarplot(c,d)
A.Color = 'k';
A.LineWidth = 1;
B.Color = 'k';
B.LineWidth = 1;
legend('1.5cm', '2 cm', '2.5 cm')
legend('1.5cm', '2 cm', '2.5 cm')
thetaticks(0:24:360)
rticks([2.2 2.3 2.4 2.5])

t = title('Rate of change of the voltage with respect to degree, North pole')


% caratteristiche titolo 
%[t,s] = title ('Rate of change of the voltage with respect to degree, North pole','Different distances, \theta variable')
t.FontSize = 16;
%s.FontAngle='italic';