close all;clear;clc;
load cameracalib.mat
imageDir = fullfile('1_3_Output','frames');
imds = imageDatastore(imageDir);
imagesList = [1:12];
images = cell(1, numel(imagesList));
for i = 1:numel(imagesList)
    I = readimage(imds, imagesList(i));
    I = imresize(I,[1200,1600]);
    I = undistortImage(I,cameraParams);
    I = imresize(I,[352,640]);
    images{i} = I;
%     imshow(images{i});
end

I = im2gray(images{1});
imagePoints1 = detectMinEigenFeatures(I, 'MinQuality', 0.001);

% figure
% imshow(I, 'InitialMagnification', 50);
% title('150 Strongest Corners from the First Image');
% hold on
% plot(selectStrongest(imagePoints1, 150));

tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);
imagePoints1 = imagePoints1.Location;
initialize(tracker, imagePoints1, I);

cameraSize = 0.2;
RList{1} = eye(3);
tList{1} = [0 0 0];
figure
for i = 2:numel(images)
    
    [imagePoints2, validIdx] = step(tracker, im2gray(images{i}));
    matchedPoints1 = imagePoints1(validIdx, :);
    matchedPoints2 = imagePoints2(validIdx, :);
    
%     figure
%     showMatchedFeatures(im2gray(images{i-1}), im2gray(images{i}), matchedPoints1, matchedPoints2);
%     title('Tracked Features');
    [fMatrix, epipolarInliers] = estimateFundamentalMatrix(...
        matchedPoints1, matchedPoints2, 'Method', 'MSAC', 'NumTrials', 10000);
    inlierPoints1 = matchedPoints1(epipolarInliers, :);
    inlierPoints2 = matchedPoints2(epipolarInliers, :);
    %     figure
    %     showMatchedFeatures(im2gray(images{i-1}), im2gray(images{i}), inlierPoints1, inlierPoints2);
    %     title('Epipolar Inliers');
    [R, t] = cameraPose(fMatrix, cameraParams, inlierPoints1, inlierPoints2);
%     tSize = size(t);
%     if tSize(1)~=1
%         t = t(1,:);
%     end
%     RSize = size(R);
%     RSizeLength = length(RSize);
%     if RSizeLength==3
%         R = R(:,:,1);
%     end
    imagePoints1 = detectMinEigenFeatures(im2gray(images{i-1}), 'MinQuality', 0.001);
    
    tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);
    
    imagePoints1 = imagePoints1.Location;
    initialize(tracker, imagePoints1, im2gray(images{i-1}));
    
    [imagePoints2, validIdx] = step(tracker, im2gray(images{i}));
    matchedPoints1 = imagePoints1(validIdx, :);
    matchedPoints2 = imagePoints2(validIdx, :);
    
    camMatrix1 = cameraMatrix(cameraParams, RList{i-1}', -tList{i-1}*RList{i-1}');
    camMatrix2 = cameraMatrix(cameraParams, R', -t*R');
    RList{i} = R;
    tList{i} = t;
    
    hold on
    grid on
    plotCamera('Location', tList{i}, 'Orientation', RList{i}, 'Size', cameraSize, ...
        'Color', 'b', 'Label', string(i), 'Opacity', 0);
    hold on
    
    points3D = triangulate(matchedPoints1, matchedPoints2, camMatrix1, camMatrix2);
    
    numPixels = size(im2gray(images{i-1}), 1) * size(im2gray(images{i-1}), 2);
    allColors = reshape(images{i-1}, [352*640, 3]);
    colorIdx = sub2ind([size(images{i-1}, 1), size(images{i-1}, 2)], round(matchedPoints1(:,2)), ...
        round(matchedPoints1(:, 1)));
    color = allColors(colorIdx, :);
    
    % Create the point cloud
    ptCloud = pointCloud(points3D, 'Color', color);
    
    
    
%     drawnow;
%     hold on;
    
end
pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
    'MarkerSize', 45);




% Visualize the point cloud


% Rotate and zoom the plot
camorbit(0, -30);
camzoom(1.5);

% Label the axes
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis')

title('Up to Scale Reconstruction of the Scene');