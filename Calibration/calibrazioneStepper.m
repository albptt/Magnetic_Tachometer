clear all
close all
clc

clear all
close all
clc

% sensors = [9 19 29 39 49 59 69 79 89 99 109 118 128 138 148 158 168 178 188 197 ...
    % 207 217 227 237 246 257 266 276 286 296 306 316 325 335 345 355 364 374 384 393 ...
    % 404 413 423 440];

sensors = [0 0 0 0 0 59 69 79 89 99 109 118 128 138 148 158 168 178 188 197 ...
     207 217 227 237 246 257 266 276 286 296 306 316 325 335 345 355 364 374 384 393 ...
     404 413 423];

values = linspace (1,43,43)

stepper = 10 : 10 : 430;
errore = [];
errore_perc = [];
for i = 1 : length(stepper)
    errore(i) = stepper(i) - sensors(i);
    errore_perc(i) = errore(i)/100;
end
average_error = mean(errore_perc);
average_error_perc = average_error * 100;
%% 
figure(1)
p=plot (values, sensors,'-o','LineWidth',1.5, 'Color',[1 0.5 0.8])
hold on
plot (values, stepper, 'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
xlim([1 43])
xticks([1:44])
t = title ('Calibration with a stepper')
x = xlabel('Step considered')
y = ylabel ('RPM')
l = legend ('RPM read with the sensors', 'RPM set with the stepper')
l.Location = 'northwest'
l.FontSize = 15
p.MarkerFaceColor = [1 0.5 0.8];

% p.MarkerSize = 8;
t.FontSize = 20;
x.FontSize = 15;
y.FontSize = 15;