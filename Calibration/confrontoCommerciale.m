clear all
close all
clc

clear all
close all
clc

% sensors = [9 19 29 39 49 59 69 79 89 99 109 118 128 138 148 158 168 178 188 197 ...
    % 207 217 227 237 246 257 266 276 286 296 306 316 325 335 345 355 364 374 384 393 ...
    % 404 413 423 440];
% %%
%     nostro = [ 0
%     6.5
% 10.4
% 13.3
% 16.4
% 18.91
% 21.15
% 23
% 26.25
% 30.7
% 34.7
% 33.22
% 31.85
% 30.6
% 29.73
% 28.49
% 27.12
% 25.5
% 24.4
% 22.5
% 21
% 19.5
% 17.9
% 16.5
% 14.2
% 12.2
% 9.7
% 6.47
% 9.33
% 15.5
% 19.7
% 23.4
% 27.9
% 35.2
% 39.6
% 40.1
% 38.9
% 37.4
% 35.8
% 17
% 15.3
% 12.8
% 10.6
% 8.7
% 5.3
% 8.2
% 13.9
% 21.1
% 28.2
% 32.9
% 34.8
% 38.3
% 39.2
% 37.6
% 35.2
% 33.71
% 31.7
% 30.5
% 29.1
% 27.7
% 26.2
% 25.1
% 24.1
% 21.9
% 21.1
% 18.7
% 16.8
% 14.9
% 13.8
% 9.7
% 6.3
% 8.5
% 11.8
% 17.7
% 21.7
% 24.8
% 27.5
% 30.4
% 32.7
% 32.0
% 30.6
% 29.2
% 28.2
% 26.8
% 25.1
% 24.1
% 22.3
% 20.8
% 19.2
% 17.7
% 15.9
% 14.1
% 12.2
% 9.7
% 6.8
% 10.0
% 15.7
% 23.3
% 25.4
% 22.9
% 22.5
% 21.5
% 19.7
% 17.7
% 15.9
% 13.7
% 12.2
% 9.8
% 6.8
% 6.1
% 13.4
% 24.5
% 33.6
% 43.4
% 42.4
% 41.6
% 39.8
% 39.2
% 37.5
% 36.1
% 35.2
% 33.2
% 32.6
% 31.4
% 30.0
% 28.6
% 27.4
% 25.8
% 24.4
% 23.1
% 22.0
% 20.7
% 19.0
% 0]';
% 
% % sensors = [0 0 0 0 0 59 69 79 89 99 109 118 128 138 148 158 168 178 188 197 ...
% %      207 217 227 237 246 257 266 276 286 296 306 316 325 335 345 355 364 374 384 393 ...
% %      404 413 423];
% 
 values = linspace (0,133,134)
% 
% commercial = [ 0
%     7.5
% 9
% 12.9
% 15.9
% 18.1
% 20.4
% 22.8
% 26.1
% 30.2
% 33.4
% 34.2
% 32.9
% 31.5
% 30.2
% 28.8
% 27.5
% 26.1
% 24.7
% 23.2
% 21.7
% 20.1
% 18.5
% 16.7
% 14.8
% 12.7
% 10.2
% 6.8
% 9.5
% 12.1
% 18.7
% 23.8
% 28.9
% 33.6
% 37.7
% 39.9
% 39.2
% 37.8
% 35.5
% 17.6
% 15.9
% 13.9
% 11.7
% 9.2
% 5.4
% 8.4
% 11.1
% 19.5
% 26.2
% 31.3
% 35.3
% 39
% 38.9
% 37.7
% 36.4
% 33.8
% 32.4
% 31.1
% 29.8
% 28.3
% 27
% 25.5
% 24
% 22.5
% 20.9
% 19.2
% 17.5
% 15.5
% 13.4
% 10.9
% 7.8
% 8.7
% 10.7
% 15.8
% 20.2
% 24.1
% 28.1
% 31.5
% 33
% 32.4
% 31.1
% 29.9
% 28.5
% 27.2
% 25.7
% 24.4
% 22.9
% 21.4
% 19.8
% 18.2
% 16.5
% 14.7
% 12.7
% 10.3
% 7.2
% 12
% 14.3
% 20.5
% 24.6
% 24.2
% 22.8
% 21.4
% 19.8
% 18.3
% 16.6
% 14.8
% 12.7
% 10.4
% 7.3
% 6.7
% 10.3
% 25.8
% 35.2
% 41.2
% 43
% 41.6
% 40.3
% 39.1
% 37.8
% 36.6
% 35.4
% 34.2
% 32.9
% 31.6
% 30.3
% 29
% 27.7
% 26.4
% 25.1
% 23.7
% 22.3
% 20.8
% 19.3
% 0]';
%%
% errore = [];
% errore_perc = [];
% for i = 1 : length(stepper)
%     errore(i) = stepper(i) - sensors(i);
%     errore_perc(i) = errore(i)/100;
% end
% average_error = mean(errore_perc);
% average_error_perc = average_error * 100;

nostro= [0
52
84
107
132
152
170
185
211
247
279
267
256
246
239
229
218
205
196
181
169
157
144
133
114
98
78
52
75
125
158
188
224
283
318
322
313
301
288
137
123
103
85
70
43
66
112
170
227
264
280
308
315
302
283
271
255
245
234
223
211
202
194
176
170
150
135
120
111
78
51
68
95
142
174
199
221
244
263
257
246
235
227
215
202
194
179
167
154
142
128
113
98
78
55
80
126
187
204
184
181
173
158
142
128
110
98
79
55
49
108
197
270
349
341
334
320
315
301
290
283
267
262
252
241
230
220
207
196
186
177
166
153
0];

commercial=[0
60
72
104
128
145
164
183
210
243
268
275
264
253
243
231
221
210
199
186
174
162
149
134
119
102
82
55
76
97
150
191
232
270
303
321
315
304
285
141
128
112
94
74
43
68
89
157
211
252
284
313
313
303
293
272
260
250
240
227
217
205
193
181
168
154
141
125
108
88
63
70
86
127
162
194
226
253
265
260
250
240
229
219
207
196
184
172
159
146
133
118
102
83
58
96
115
165
198
195
183
172
159
147
133
119
102
84
59
54
83
207
283
331
346
334
324
314
304
294
285
275
264
254
244
233
223
212
202
191
179
167
155
0];
%% 
figure(1)
p=plot (values, nostro,'-o','LineWidth',1.5, 'Color',[0.5 0 0.5])
% viola: [0.5 0 0.5]
% azzurro: [0.84 0.93 0.95]
hold on
q = plot (values, commercial,'-o', 'LineWidth',1.5,'Color',[1,0.5,0])
xlim([0 134])
ylim([0 400])
xticks([0:10:134])
% t = title ('Calibration with a stepper')
x = xlabel('number of samples')
y = ylabel ('reading RPM')
l = legend ('GLAM Tachometer', 'Commercial Tachometer')
l.Location = 'northwest'
l.FontSize = 20
p.MarkerFaceColor = [0.5 0 0.5];
q.MarkerFaceColor = [1,0.5,0];

% p.MarkerSize = 8;
%t.FontSize = 20;
x.FontSize = 20;
y.FontSize = 20;

%%
y=zeros(size(values));
error= nostro - commercial;
Q = quantile(error, [0.25, 0.5, 0.75]);

figure(2)
% scatter(values, error, '-', 'LineWidth', 1.5, 'Color', [1, 0, 1, 0.3])
b = boxplot(error', 'Colors', [1, 0, 1]);
set(b,{'linew'},{2})

hold on
p = plot([0.75, 1.25], [Q(1), Q(1)], 'r-', 'LineWidth', 2); % Linea Q1
q = plot([0.75, 1.25], [Q(3), Q(3)], 'r-', 'LineWidth', 2); % Linea Q3
p.Color = [0.5, 0, 0.5]
q.Color = [0.5, 0, 0.5]

text(1.35, Q(1), num2str(Q(1)), 'VerticalAlignment', 'middle');
text(1.35, Q(3), num2str(Q(3)), 'VerticalAlignment', 'middle');

set(gca,'XTick',[])
%plot(values, y, '-', 'LineWidth', 1.5, 'Color', 'black')
x = xlabel('number of samples')
y = ylabel ('differnce [km/h]')
%le.Location = 'northwest'
%le.FontSize = 15;
x.FontSize = 15;
y.FontSize = 15;
%xlim ([0 max(values)])


% Aggiungi linee per i quartili


hold off;



%%

max(error)

mean(error)

%%
x = min(nostro) : 0.01 : max(nostro)
y = @(x) x
figure(3)
s = scatter(nostro, commercial);
hold on
plot(x,y(x),'k','linewidth', 2)
s.MarkerFaceColor = [1, 0, 1];
x=xlabel('GLAM sensor')
y=ylabel ('Commercial sensor')

x.FontSize = 15;
y.FontSize = 15;
xlim ([min(nostro) max(nostro)])

% basta lo scatter
x.FontSize = 20;
y.FontSize = 20;