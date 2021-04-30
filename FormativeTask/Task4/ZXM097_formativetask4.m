clear; close all; clc;
%%训练集类别
categoriesLable = ["bird","horse","ship","truck"];
%%原始训练集路径
trainDataFolder = 'D:\MATLAB\Project\FormativeTask\Task4\cifar10Train\';
%%将原始训练集存入到imageDatastore（包含全部子文件夹，将子文件夹名称作为标签）
originTrainImds = imageDatastore(trainDataFolder, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

%%从原始训练集中提取需要的类别，存储为训练集 
[trainDatasetTotal,~] = splitEachLabel(originTrainImds,5000,'Include',categoriesLable);
%%设置训练数据的个数
numTrainFiles = int32((5000/3)*2);
%%将数据集分为训练集和验证集，其中训练集占总数据的2/3
[trainDataset,trainDatasetValidation] = splitEachLabel(trainDatasetTotal,numTrainFiles,'randomize');
%%测试集路径
testDataFolder = 'D:\MATLAB\Project\FormativeTask\Task4\cifar10Test\';
%%将原始测试集存入到imageDatastore
origintestImds = imageDatastore(testDataFolder, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
%%从原始测试集中提取需要的类别，存储为测试集 
[testDataset,~] = splitEachLabel(origintestImds,1000,'Include',categoriesLable);

%%输入层 图片大小以及通道数
inputSize = [32 32 3];
%%输出层 输出几个类别
numClasses = numel(categories (trainDataset.Labels));

layers = [
    %%输入层
    imageInputLayer(inputSize)
    %%卷积层（卷积核大小为3，个数为32，padding为4，BiasLearnRateFactor为2）
    convolution2dLayer(3,32,'Padding',4,'BiasLearnRateFactor',2)
    %%池化层 最大池化（大小为3，Stride为2）
    maxPooling2dLayer(3,'Stride',2)
    %%激活函数
    reluLayer
    %%卷积层（卷积核大小为3，个数为32，padding为4，BiasLearnRateFactor为2）
    convolution2dLayer(3,32,'Padding',4,'BiasLearnRateFactor',2)
    %%激活函数
    reluLayer
    %%池化层 均值池化（大小为3，Stride为2）
    averagePooling2dLayer(3,'Stride',2)
    %%卷积层（卷积核大小为3，个数为32，padding为4，BiasLearnRateFactor为2）
    convolution2dLayer(3,32,'Padding',4,'BiasLearnRateFactor',2)
    %%激活函数
    reluLayer
    %%池化层 均值池化（大小为3，Stride为2）
    averagePooling2dLayer(3,'Stride',2)
    %%卷积层（卷积核大小为3，个数为32，padding为4，BiasLearnRateFactor为2）
    convolution2dLayer(3,32,'Padding',4,'BiasLearnRateFactor',2)
    %%激活函数
    reluLayer
    %%全连接层（输出类别为4类，BiasLearnRateFactor为2）
    fullyConnectedLayer(numClasses,'BiasLearnRateFactor',2)
    %%激活函数
    softmaxLayer
    %%输出层
    classificationLayer];

%%使用Adam优化
%%最大纪元为20
%%最小批处理为40
%%初始学习率为0.001
%%降低训练期间的学习率，每隔一定数量的时间更新学习率
%%L2正则化因子为0.004
%%应用于学习率的乘数因子，降低学习率（0.1）
%%全局学习率乘以下降因（8）
%%训练时验证集验证频率为30
%%验证集
%%不在控制台打印训练过程
%%显示训练过程
%%在每次训练之前将训练数集打乱，并在每次验证之前将验证集打乱
%%使用gpu训练网络
options = trainingOptions('adam', ...
    'MaxEpochs',20, ...
    'MiniBatchSize',40, ...
    'InitialLearnRate',0.001, ...
    'LearnRateSchedule','piecewise', ...
    'L2Regularization',0.004, ...
    'LearnRateDropFactor',0.1, ...
    'LearnRateDropPeriod',8, ...
    'ValidationFrequency',30, ...
    'ValidationData',trainDatasetValidation, ...
    'Verbose',false, ...
    'Plots','training-progress', ...
    'Shuffle','every-epoch', ...
    'ExecutionEnvironment','gpu');

%%训练网络
net = trainNetwork(trainDataset,layers,options);

%%使用训练好的网络进行测试
YPred = classify(net,testDataset);
%%获取当前测试集标签
YValidation = testDataset.Labels;
%%计算网络测试集准确度
accuracy = mean(YPred == YValidation);