%% Initialization
clear; close all;

%%%%%Load the data
% Create a table from the CSV file
df = readtable('jacobito_fall(v1).csv');


%%%%% Lets look at the data
% Convert the table to an array
myArray = table2array(df);

% Extract the time and acceleration data from the table
time = df.Time;

Xacc = df.Xacc;
Yacc = df.Yacc;
Zacc = df.Zacc;

% Create a line plot of the first set of acceleration data
subplot(3,1,1)
plot(time, Xacc);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Accelerometer Data');

% Tell MATLAB to retain the current plot when creating a new plot
hold on;

% Create a line plot of the second set of acceleration data
plot(time, Yacc);
plot(time, Zacc);

% Add a legend to the plot
legend('Xacc', 'Yacc', 'Zacc');
hold off 


% Extract the time and gyroscope data from the table
time = df.Time;

Xg = df.Xg;
Yg = df.Yg;
Zg = df.Zg;

% Create a line plot of the first set of gyroscope data
subplot(3,1,2)
plot(time, Xg);
xlabel('Time (s)');
ylabel('Gyroscope (m/s^2)');
title('Gyroscope Data');

% Tell MATLAB to retain the current plot when creating a new plot
hold on;

% Create a line plot of the second set of gyroscope data
plot(time, Yg);
plot(time, Zg);

% Add a legend to the plot
legend('Xg', 'Yg', 'Zg');
hold off 


% Create a line plot of the first set of heart ----- heart rate not plotting
hr = df.hr;
hr(isnan(hr)) = NaN;

% Plot the heart rate signal, skipping over any NaN values
subplot(3,1,3)
plot(time, hr, 'o-')
xlabel('Time (s)')
ylabel('Heart Rate (bpm)')

%%%%%%%%
%Processing
%%%%%%%


%How Should I process HR? 
HRidx = 2:50:numel(time);

Xacc_z = zscore(Xacc);
Yacc_z = zscore(Yacc);
Zacc_z = zscore(Zacc);

Xg_z = zscore(Xg);
Yg_z = zscore(Yg);
Zg_z = zscore(Zg);


%
%%%%%%%%
%CWT
%%%%%%%
%

%Acceleration
% Set the sampling frequency and the wavelet function
    % Extract the time and signal data from the table

% Calculate the sampling frequency *1/2 for nyquist freq
Fs = 1/mean(diff(time)); % Hz
Fn = .5*Fs;
wavelet = 'morse'; % good for noisy signals

% Compute the CWT coefficients for each signal
[C1, F] = cwt(Xacc, Fn, wavelet);
[C2, F] = cwt(Yacc, Fn, wavelet);
[C3, F] = cwt(Zacc, Fn, wavelet);

% get number of time steps
ntime = size(C1,2);

% Plot the CWT coefficients for each signal
figure;
subplot(3,1,1);
imagesc(time, F, abs(C1));
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('CWT Coefficients for Acceleration 1');

subplot(3,1,2);
imagesc(time, F, abs(C2));
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('CWT Coefficients for Acceleration 2');

subplot(3,1,3);
imagesc(time, F, abs(C3));
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('CWT Coefficients for Acceleration 3');


%%Acceleration
% Set the sampling frequency and the wavelet function
    % Extract the time and signal data from the table

% Calculate the sampling frequency *1/2 for nyquist freq
Fs = 1/mean(diff(time)); % Hz
Fn = .5*Fs;
wavelet = 'morse'; %good for noisy signals

% Compute the CWT coefficients for each signal
[G1, F] = cwt(Xg, Fn, wavelet);
[G2, F] = cwt(Yg, Fn, wavelet);
[G3, F] = cwt(Zg, Fn, wavelet);

% Plot the CWT coefficients for each signal
figure;
subplot(3,1,1);
imagesc(time, F, abs(G1));
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('CWT Coefficients for Gyroscope 1');

subplot(3,1,2);
imagesc(time, F, abs(G2));
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('CWT Coefficients for Gyroscope 2');

subplot(3,1,3);
imagesc(time, F, abs(G3));
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('CWT Coefficients for Gyroscope 3');


%%%%%Merge CWT to table - what should be the dimension argument?
coeffs = {F, time, C1, C2, C3, G1, G2, G3};


% 
%Find the peaks of each signal at each time
% findpeaks only works on vectors, so we need to do a loop!

for i=1:ntime

    [C1p,C1l] = findpeaks(abs(C1(:,i)),'SortStr','descend');
    [C2p,C2l] = findpeaks(abs(C2(:,i)),'SortStr','descend');
    [C3p,C3l] = findpeaks(abs(C3(:,i)),'SortStr','descend');

    [G1p,G1l] = findpeaks(abs(G1(:,i)),'SortStr','descend');

    [G2p,G2l] = findpeaks(abs(G2(:,i)),'SortStr','descend');
    [G3p,G3l] = findpeaks(abs(G3(:,i)),'SortStr','descend');

    [Hrp,Hrl] = findpeaks(hr,'SortStr','descend');
    
    features_obj(:,i) = [C1p(1:2);F(C1l(1:2));C2p(1:2);F(C2l(1:2)); C3p(1:2); F(C3l(1:2)); ...
        G1p(1:2); F(G1l(1:2)); G2p(1:2); F(G2l(1:2)); G3p(1:2); F(G3l(1:2))]; % ...
%         hr(i)];
%         features_obj(:,i) = [C1p(1:2);F(C1l(1:2));G2p(1:2);F(G2l(1:2))];

end

% so this has 2 pieces of information now
% 1.  amplitude of the peaks C1p, etc.; 2. frequency of peaks C1l


t_temp = (C1p - 1) / Fs;

% Plot the top two peaks as a function of time
figure; scatter(time, features_obj(1,:),'r', 'filled');hold on;
scatter(time, features_obj(3,:),'r', 'filled');hold on;

hold off;
%%%something odd with how I am either plotting or constructing the
%%%find_pe




%%%%%%%%%%%%%%%%%%%%
% Cluster Analysis  %
%%%%%%%%%%%%%%%%%%%%
% Run t-SNE on the data
%  Nota: first argument is dimensions reduction, perplexity argument
%  controls the number of neighbors to consider, and last argument is how
%  many times to run the algorithm


for i=1:ntime
    C1tsne(i,:) = tsne(features_obj(:,i)', 'NumDimensions', 3,'Standardize',1);
% C1tsne = tsne(C1, 'NumDimensions', 3, 'Perplexity', 30, 'NumIterations', 1000);
end

figure;
scatter3(C1tsne(:,1),C1tsne(:,2), C1tsne(:,3));

Plot the result
 scatter3(C1tsne(:,1), C1tsne(:,2), C1tsne(:,3)), C1tsne;
options = struct('MaxIterations', 1000);

%[Yembed,loss2] = tsne(C2p,'Algorithm','exact','NumDimensions',3, options);



%peaks = [C1p; C2p; C3p; G1p; G2p; G3p];


%rng default % for fair comparison
%Y100 = tsne(peaks,'Algorithm','barneshut','NumPCAComponents',50,'Perplexity',1);

%Y = tsne(peaks,'Algorithm','barneshut','NumPCAComponents',50);

%figure
%numGroups = length(unique(L));
%clr = hsv(numGroups);
%gscatter(Y(:,1),Y(:,2),L,clr)
%title('Default Figure')


%%%%%%%%%%%%%%
% DB - Scan  %
%%%%%%%%%%%%%%


% Perform DBSCAN clustering on the transformed data
[idx] = dbscan(features_obj,30,3); % The default distance metric is Euclidean distance
gscatter(features_obj(:,1),features_obj(:,2),idx);
title('DBSCAN Using Euclidean Distance Metric')

s = silhouette(features_obj, idx);
% Calculate the mean silhouette score
mean_s = mean(s);


% Use the evalclusters function to calculate the Calinski-Harabasz index
[CH,~] = evalclusters(features_obj,idx,'CalinskiHarabasz');



















