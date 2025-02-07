%%% Initialziation
clear variables ; clc ; close all;

%%% data
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos', 'nndatasets','DigitDataset');
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');

%%% data samples
figure;
rng(1); % set random seed
%% 
%% 
perm = randperm(10000,20);
for i = 1:20
    subplot(4,5,i);
    imshow(imds.Files{perm(i)});
end

%%% label information
labelCount = countEachLabel(imds);
display(labelCount);

%%% check image size
img = readimage(imds,1);
size(img)

%%% training, validation
numTrainFiles = 750;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

%%% design network
layers = [
    imageInputLayer([28 28 1])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer
];

display( layers );


%%% training option
% options = trainingOptions('sgdm', ...
%     'InitialLearnRate',0.01, ...
%     'MaxEpochs',4, ...
%     'Shuffle','every-epoch', ...
%     'ValidationData',imdsValidation, ...
%     'ValidationFrequency',30, ...
%     'Verbose',false, ...
%     'Plots','training-progress');

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false);

%%% training
net = trainNetwork(imdsTrain,layers,options);

YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

accuracy = sum(YPred == YValidation)/numel(YValidation);
display(accuracy);

%% TEST 
%%% 주석 해제 후 실습!!!
% %%% example 1
test_img_idx = 2; % 1 - 10000: NOT in the training data set
test_img  = imread('image0.jpeg');
test_img  =rgb2gray(test_img);
test_img  =imresize(test_img,[28,28]);
%test_img = imrotate(test_img, -90)
%%% TODO
%%% exampl 2: your handwriting
%%% hint: color to gray, resize
%%% rgb2gray, imresize

figure();
imshow(test_img);

test_result = classify(net,test_img);
display(test_result);