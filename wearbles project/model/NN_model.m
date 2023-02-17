% Load the wavelet signals into a matrix, where each column represents a
% wavelet signal
%waveletSignals = {real(reshape(C1, [1, numel(C1)])), real(reshape(C2, [1, numel(C2)])), real(reshape(C3, [1, numel(C3)]))};
waveletSignals = features_obj


% Define the network architecture
numHiddenUnits = 24;
layers = [ ...
    sequenceInputLayer(24)
    fullyConnectedLayer(numHiddenUnits)
    reluLayer
    fullyConnectedLayer(23)
    regressionLayer];

% Set the training options
options = trainingOptions('sgdm', ...
    'MaxEpochs', 1000, ...
    'Shuffle', 'every-epoch', ...
    'Verbose', false, ...
    'Plots', 'training-progress');

% Train the network
trainedNet = trainNetwork(waveletSignals, waveletSignals, layers, options);
%In this example, waveletSignals is a matrix containing the wavelet signals, with each column representing a signal. The sequenceInputLayer function is used to define the input layer of the network, which expects a sequence of six values (one for each wavelet signal). The fullyConnectedLayer function is then used to define a fully connected layer with the specified number of hidden units, followed by a reluLayer activation function. Finally, a regression layer is used as the output layer of the network.

The trainingOptions function is used to define the training options, such as the number

%input_data = {real(reshape(C1, [1, numel(C1)])), real(reshape(C2, [1, numel(C2)])), real(reshape(C3, [1, numel(C3)]))};
%outputs = predict(trainedNet, input_data)

