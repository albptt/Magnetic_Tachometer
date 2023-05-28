clear all
close all
clc

clear all
close all
clc

% sensors = [9 19 29 39 49 59 69 79 89 99 109 118 128 138 148 158 168 178 188 197 ...
    % 207 217 227 237 246 257 266 276 286 296 306 316 325 335 345 355 364 374 384 393 ...
    % 404 413 423 440];
sensors = [0 9 19 29 39 49 59 69 79 89 99 109 118 128 138 148 158 168 178 ...
    187 197 207 217 227 236 246 257 266 276 286 295 305 316 325 335 345 ...
    355 364 374 384 393 404 413 423 433 443 453 462 472 482 492 502 512]
% sensors = [0 0 0 0 0 59 69 79 89 99 109 118 128 138 148 158 168 178 188 197 ...
%      207 217 227 237 246 257 266 276 286 296 306 316 325 335 345 355 364 374 384 393 ...
%      404 413 423];

values = linspace (0,52,53)

stepper = 0 : 10 : 520;
% errore = [];
% errore_perc = [];
% for i = 1 : length(stepper)
%     errore(i) = stepper(i) - sensors(i);
%     errore_perc(i) = errore(i)/100;
% end
% average_error = mean(errore_perc);
% average_error_perc = average_error * 100;
%% 
figure(1)
p=plot (values, sensors,'-o','LineWidth',1.5, 'Color',[1 0.5 0.8])
% viola: [0.5 0 0.5]
% azzurro: [0.84 0.93 0.95]
hold on
plot (values, stepper, 'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
xlim([0 52])
xticks([0:52])
% t = title ('Calibration with a stepper')
x = xlabel('Step considered')
y = ylabel ('RPM')
l = legend ('RPM read by the sensor', 'RPM set with the stepper')
l.Location = 'northwest'
l.FontSize = 20
p.MarkerFaceColor = [1 0.5 0.8];

% p.MarkerSize = 8;
%t.FontSize = 20;
x.FontSize = 15;
y.FontSize = 15;