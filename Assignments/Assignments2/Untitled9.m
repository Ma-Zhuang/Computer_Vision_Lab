% close all;clear;clc;
% load cameracalib.mat
% imageDir = fullfile('1_3_Output','images');
% imds = imageDatastore(imageDir);
% imagesList = [1:11:220];
% images = cell(1, numel(imagesList));
% for i = 1:numel(imagesList)
%     I = readimage(imds, imagesList(i));
%     I = imresize(I,[1200,1600]);
%     I = undistortImage(I,cameraParams);
%     images{i} = imresize(I,[352,640]);
% end
% 
% 
% roi = [200, 112, 180, 170];
% I1 = images{1};
% % Detect feature points
% prePoints = detectMinEigenFeatures(im2gray(I1), 'MinQuality', 0.000001,'ROI',roi);
% 
% % Visualize detected points
% % figure
% % imshow(I1, 'InitialMagnification', 50);
% % title('150 Strongest Corners from the First Image');
% % hold on
% % plot(selectStrongest(prePoints, 150));
% 
% 
% 
% % Create the point tracker
% tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 6);
% 
% % Initialize the point tracker
% prePoints = prePoints.Location;
% initialize(tracker, prePoints, I1);
% 
% vSet = imageviewset;
% viewId = 1;
% % vSet = addView(vSet, viewId, rigid3d, 'Points', prevPoints);
% 
% 
% RList{1} = eye(3);
% tList{1} = [0 0 0];
% points3DList = [];
% colorList = [];
% 
% 
% 
% cameraSize = 0.2;
% figure
% for i = 2:numel(imagesList)
%     % Track the points
%     [currPoints, validIdx] = step(tracker, images{i});
%     matchedPoints1 = prePoints(validIdx, :);
%     matchedPoints2 = currPoints(validIdx, :);
%     
%     % Visualize correspondences
%     
% %     showMatchedFeatures(images{i-1}, images{i}, matchedPoints1, matchedPoints2);
% %     title('Tracked Features');
%     
%     
%     % Estimate the fundamental matrix
%     [fMatrix, epipolarInliers] = estimateFundamentalMatrix(...
%         matchedPoints1, matchedPoints2, 'Method', 'MSAC', 'NumTrials', 10000);
%     
%     % Find epipolar inliers
%     inlierPoints1 = matchedPoints1(epipolarInliers, :);
%     inlierPoints2 = matchedPoints2(epipolarInliers, :);
%     
%     % Display inlier matches
%     
% %     showMatchedFeatures(images{i-1}, images{i}, inlierPoints1, inlierPoints2);
% %     title('Epipolar Inliers');
%     
%     
%     
%     
%     [R, t] = cameraPose(fMatrix, cameraParams, inlierPoints1, inlierPoints2);
%     RList{i} = R;
%     tList{i} = t;
%     
%     % Detect dense feature points
%     prePoints = detectMinEigenFeatures(im2gray(images{i-1}), 'MinQuality', 0.000001,'ROI',roi);
%     
%     % Create the point tracker
%     tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 6);
%     
%     % Initialize the point tracker
%     prePoints = prePoints.Location;
%     initialize(tracker, prePoints, images{i-1});
%     
%     % Track the points
%     [currPoints, validIdx] = step(tracker, images{i});
%     matchedPoints1 = prePoints(validIdx, :);
%     matchedPoints2 = currPoints(validIdx, :);
%     
%     % Compute the camera matrices for each position of the camera
%     % The first camera is at the origin looking along the X-axis. Thus, its
%     % rotation matrix is identity, and its translation vector is 0.
%     camPreMatrix = cameraMatrix(cameraParams, RList{i-1}', -tList{i-1}*RList{i-1}');
%     camCurrMatrix = cameraMatrix(cameraParams, RList{i}', -tList{i}*RList{i}');
%     
%     % Compute the 3-D points
%     points3D = triangulate(matchedPoints1, matchedPoints2, camPreMatrix, camCurrMatrix);
%     
%     points3DList = [points3DList ;points3D];
%     
%     % Get the color of each reconstructed point
%     numPixels = size(images{i-1}, 1) * size(images{i-1}, 2);
%     allColors = reshape(images{i-1}, [numPixels, 3]);
%     colorIdx = sub2ind([size(images{i-1}, 1), size(images{i-1}, 2)], round(matchedPoints1(:,2)), ...
%         round(matchedPoints1(:, 1)));
%     color = allColors(colorIdx, :);
%     colorList = [colorList ;color];
%     
%  
%     plotCamera('Location', tList{i-1}, 'Orientation', RList{i-1}, 'Size', cameraSize, ...
%         'Color', 'r', 'Label', string(i), 'Opacity', 0);
%     hold on
%     grid on
% end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % Create the point cloud
% ptCloud = pointCloud(points3DList, 'Color', colorList);
% 
% 
% % Visualize the point cloud
% pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
%     'MarkerSize', 45);
% 
% % Rotate and zoom the plot
% camorbit(0, -30);
% camzoom(1.5);
% 
% 
% xlim([1-10, 1+10]);
% ylim([1-10, 1+10]);
% zlim([1-10, 1+10]);
% 
% % Label the axes
% xlabel('x-axis');
% ylabel('y-axis');
% zlabel('z-axis')
% 
% title('Up to Scale Reconstruction of the Scene');
% 
% 
% 
% 
% 





























































































close all;clear;clc;
load cameracalib.mat
imageDir = fullfile('1_3_Output','images');
imds = imageDatastore(imageDir);
imagesList = [1:11:220];
images = cell(1, numel(imagesList));
for i = 1:numel(imagesList)
    I = readimage(imds, imagesList(i));
    I = imresize(I,[1200,1600]);
    I = undistortImage(I,cameraParams);
    images{i} = imresize(I,[352,640]);
end


roi = [232, 112, 180, 175];
I1 = images{1};
% Detect feature points
prevPoints = detectMinEigenFeatures(im2gray(I1), 'MinQuality', 0.000001,'ROI',roi);

% Visualize detected points
figure
imshow(I1, 'InitialMagnification', 50);
title('150 Strongest Corners from the First Image');
hold on
plot(selectStrongest(prevPoints, 150));


% vSet = imageviewset;
% viewId = 1;
% vSet = addView(vSet, viewId, rigid3d, 'Points', prevPoints);
% tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 6);
% initialize(tracker, prevPoints, I1);
% % 
% for i = 2:numel(imagesList)
% 
%     [currPoints, validIdx] = step(tracker, images{i});
%     matchedPoints1 = prevPoints(indexPairs(:, 1));
%     matchedPoints2 = currPoints(indexPairs(:, 2));
%     
% end
% 
% 






% Create the point tracker
% tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 6);
% 
% % Initialize the point tracker
% prePoints = prePoints.Location;
% initialize(tracker, prePoints, I1);
% 
% vSet = imageviewset;
% viewId = 1;
% % vSet = addView(vSet, viewId, rigid3d, 'Points', prevPoints);
% 
% 
% RList{1} = eye(3);
% tList{1} = [0 0 0];
% points3DList = [];
% colorList = [];
% 
% 
% 
% cameraSize = 0.2;
% figure
% for i = 2:numel(imagesList)
%     % Track the points
%     [currPoints, validIdx] = step(tracker, images{i});
%     matchedPoints1 = prePoints(validIdx, :);
%     matchedPoints2 = currPoints(validIdx, :);
%     
%     % Visualize correspondences
%     
% %     showMatchedFeatures(images{i-1}, images{i}, matchedPoints1, matchedPoints2);
% %     title('Tracked Features');
%     
%     
%     % Estimate the fundamental matrix
%     [fMatrix, epipolarInliers] = estimateFundamentalMatrix(...
%         matchedPoints1, matchedPoints2, 'Method', 'MSAC', 'NumTrials', 10000);
%     
%     % Find epipolar inliers
%     inlierPoints1 = matchedPoints1(epipolarInliers, :);
%     inlierPoints2 = matchedPoints2(epipolarInliers, :);
%     
%     % Display inlier matches
%     
% %     showMatchedFeatures(images{i-1}, images{i}, inlierPoints1, inlierPoints2);
% %     title('Epipolar Inliers');
%     
%     
%     
%     
%     [R, t] = cameraPose(fMatrix, cameraParams, inlierPoints1, inlierPoints2);
%     RList{i} = R;
%     tList{i} = t;
%     
%     % Detect dense feature points
%     prePoints = detectMinEigenFeatures(im2gray(images{i-1}), 'MinQuality', 0.000001,'ROI',roi);
%     
%     % Create the point tracker
%     tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 6);
%     
%     % Initialize the point tracker
%     prePoints = prePoints.Location;
%     initialize(tracker, prePoints, images{i-1});
%     
%     % Track the points
%     [currPoints, validIdx] = step(tracker, images{i});
%     matchedPoints1 = prePoints(validIdx, :);
%     matchedPoints2 = currPoints(validIdx, :);
%     
%     % Compute the camera matrices for each position of the camera
%     % The first camera is at the origin looking along the X-axis. Thus, its
%     % rotation matrix is identity, and its translation vector is 0.
%     camPreMatrix = cameraMatrix(cameraParams, RList{i-1}', -tList{i-1}*RList{i-1}');
%     camCurrMatrix = cameraMatrix(cameraParams, RList{i}', -tList{i}*RList{i}');
%     
%     % Compute the 3-D points
%     points3D = triangulate(matchedPoints1, matchedPoints2, camPreMatrix, camCurrMatrix);
%     
%     points3DList = [points3DList ;points3D];
%     
%     % Get the color of each reconstructed point
%     numPixels = size(images{i-1}, 1) * size(images{i-1}, 2);
%     allColors = reshape(images{i-1}, [numPixels, 3]);
%     colorIdx = sub2ind([size(images{i-1}, 1), size(images{i-1}, 2)], round(matchedPoints1(:,2)), ...
%         round(matchedPoints1(:, 1)));
%     color = allColors(colorIdx, :);
%     colorList = [colorList ;color];
%     
%  
%     plotCamera('Location', tList{i-1}, 'Orientation', RList{i-1}, 'Size', cameraSize, ...
%         'Color', 'r', 'Label', string(i), 'Opacity', 0);
%     hold on
%     grid on
% end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % Create the point cloud
% ptCloud = pointCloud(points3DList, 'Color', colorList);
% 
% 
% % Visualize the point cloud
% pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
%     'MarkerSize', 45);
% 
% % Rotate and zoom the plot
% camorbit(0, -30);
% camzoom(1.5);
% 
% 
% xlim([1-10, 1+10]);
% ylim([1-10, 1+10]);
% zlim([1-10, 1+10]);
% 
% % Label the axes
% xlabel('x-axis');
% ylabel('y-axis');
% zlabel('z-axis')
% 
% title('Up to Scale Reconstruction of the Scene');