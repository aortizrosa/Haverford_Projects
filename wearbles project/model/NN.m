% Define the neural network structure
layers = [
    sequenceInputLayer(numFeatures)
    fullyConnectedLayer(numHiddenUnits)
    reluLayer
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer
];

% Train the neural network using the training data
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',valData, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(df,trainLabels,layers,options);

% Use the trained network to make predictions on the test data
predictions = predict(net,testData);