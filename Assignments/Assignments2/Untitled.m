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
    images{i} = im2gray(I);
%     imshow(images{i});
end

intrinsics = cameraParams.Intrinsics;
I = images{1};
% Detect features. Increasing 'NumOctaves' helps detect large-scale
% features in high-resolution images. Use an ROI to eliminate spurious
% features around the edges of the image.
% border = 50;
roi = [232, 112, 180, 175];
% roi = [200, 120, 190, 185];
% prevPoints = detectMinEigenFeatures(I, 'MinQuality', 0.001,'ROI',roi);,'MetricThreshold',10,'NumScaleLevels',5

prevPoints   = detectMinEigenFeatures(I,'ROI',roi, 'MinQuality', 0.0001);

% Extract features. Using 'Upright' features improves matching, as long as
% the camera motion involves little or no in-plane rotation.
prevFeatures = extractFeatures(I, prevPoints, 'Upright', true);



% imshow(I, 'InitialMagnification', 50);
% title('150 Strongest Corners from the First Image');
% hold on
% plot(selectStrongest(prevPoints, 200));











% Create an empty imageviewset object to manage the data associated with each
% view.
vSet = imageviewset;

% Add the first view. Place the camera associated with the first view
% and the origin, oriented along the Z-axis.
viewId = 1;
vSet = addView(vSet, viewId, rigid3d, 'Points', prevPoints);

%     imshow(I, 'InitialMagnification', 50);
%     title('150 Strongest Corners from the First Image');
%     hold on
%     plot(selectStrongest(currPoints, 200));
for i = 2:numel(images)
    % Undistort the current image.
    I = images{i};
    
    % Detect, extract and match features.
    %     currPoints = detectMinEigenFeatures(I, 'MinQuality', 0.001,'ROI',roi);,'MetricThreshold',10,'NumScaleLevels',5
%     currPoints   = detectSURFFeatures(I, 'NumOctaves', 8,'ROI',roi,'NumScaleLevels',6);
    currPoints = detectMinEigenFeatures(I,'ROI',roi, 'MinQuality', 0.001);

    currFeatures = extractFeatures(I, currPoints, 'Upright', true);
    
    indexPairs   = matchFeatures(prevFeatures, currFeatures, ...
        'MaxRatio', 1, 'Unique',  true,'MatchThreshold',100,'Method','Approximate');
    
    % Select matched points.
    matchedPoints1 = prevPoints(indexPairs(:, 1));
    matchedPoints2 = currPoints(indexPairs(:, 2));
    
    [F, inlierIdx] = estimateEssentialMatrix(matchedPoints1, matchedPoints2,cameraParams);
    inlierPoints1 = matchedPoints1(inlierIdx, :);
    inlierPoints2 = matchedPoints2(inlierIdx, :);
    
    
    
    
    showMatchedFeatures(images{i-1}, images{i}, inlierPoints1, inlierPoints2);
    title('Tracked Features');
    
    [relativeOrient, relativeLoc, validPointFraction] = relativeCameraPose(F, cameraParams, inlierPoints1,...
        inlierPoints2);
    
    prevPose = poses(vSet, i-1).AbsolutePose;
    
    
    relativeLocSize = size(relativeLoc);
    if relativeLocSize(1)==2
        relativeLoc = relativeLoc(1,:);
    end
    
    
    
    relativeOrientSize = size(relativeOrient);
    relativeOrientSizeLength = length(relativeOrientSize);
    if relativeOrientSizeLength==3
        relativeOrient = relativeOrient(:,:,1);
    end
    
    
    
    relPose  = rigid3d(relativeOrient, relativeLoc);
    currPose = rigid3d(relPose.T * prevPose.T);
    vSet = addView(vSet, i, currPose, 'Points', currPoints);
    vSet = addConnection(vSet, i-1, i, relPose, 'Matches', indexPairs(inlierIdx,:));
    tracks = findTracks(vSet);
    camPoses = poses(vSet);
    xyzPoints = triangulateMultiview(tracks, camPoses, intrinsics);
    [xyzPoints, camPoses, reprojectionErrors] = bundleAdjustment(xyzPoints, ...
        tracks, camPoses, intrinsics, 'FixedViewId', 1, ...
        'PointsUndistorted', true);
    vSet = updateView(vSet, camPoses);

    prevFeatures = currFeatures;
    prevPoints   = currPoints;  
end

% Display camera poses.
camPoses = poses(vSet);
figure;
plotCamera(camPoses, 'Size', 0.2);
hold on

% Exclude noisy 3-D points.
goodIdx = (reprojectionErrors < 5);
xyzPoints = xyzPoints(goodIdx, :);

% Display the 3-D points.
pcshow(xyzPoints, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
    'MarkerSize', 45);
grid on
hold off

% Specify the viewing volume.
loc1 = camPoses.AbsolutePose(1).Translation;
xlim([loc1(1)-50, loc1(1)+50]);
ylim([loc1(2)-50, loc1(2)+50]);
zlim([loc1(3)-50, loc1(3)+50]);
camorbit(0, -30);
xlabel("X");
ylabel("Y");
zlabel("Z");
title('Refined Camera Poses');

% 

% Read and undistort the first image
I = im2gray(images{i});

% Detect corners in the first image.
prevPoints = detectMinEigenFeatures(I, 'MinQuality', 0.000001);

% Create the point tracker object to track the points across views.
tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 6);

% Initialize the point tracker.
prevPoints = prevPoints.Location;
initialize(tracker, prevPoints, I);

% Store the dense points in the view set.

vSet = updateConnection(vSet, 1, 2, 'Matches', zeros(0, 2));
vSet = updateView(vSet, 1, 'Points', prevPoints);

% Track the points across all views.
for i = 2:numel(images)
    % Read and undistort the current image.
    I = im2gray(images{i});
    
    % Track the points.
    [currPoints, validIdx] = step(tracker, I);
    
    % Clear the old matches between the points.
    if i < numel(images)
        vSet = updateConnection(vSet, i, i+1, 'Matches', zeros(0, 2));
    end
    vSet = updateView(vSet, i, 'Points', currPoints);
    
    % Store the point matches in the view set.
    matches = repmat((1:size(prevPoints, 1))', [1, 2]);
    matches = matches(validIdx, :);        
    vSet = updateConnection(vSet, i-1, i, 'Matches', matches);
end

% Find point tracks across all views.
tracks = findTracks(vSet);

% Find point tracks across all views.
camPoses = poses(vSet);

% Triangulate initial locations for the 3-D world points.
xyzPoints = triangulateMultiview(tracks, camPoses,...
    intrinsics);

% Refine the 3-D world points and camera poses.
[xyzPoints, camPoses, reprojectionErrors] = bundleAdjustment(...
    xyzPoints, tracks, camPoses, intrinsics, 'FixedViewId', 1, ...
    'PointsUndistorted', true);



% Display the refined camera poses.
figure;
plotCamera(camPoses, 'Size', 0.2);
hold on

% Exclude noisy 3-D world points.
% goodIdx = (reprojectionErrors < 500);

% Display the dense 3-D world points.
pcshow(xyzPoints, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
    'MarkerSize', 45);
grid on
hold off

% Specify the viewing volume.
loc1 = camPoses.AbsolutePose(1).Translation;
% xlim([loc1(1)-10, loc1(1)+10]);
% ylim([loc1(2)-10, loc1(2)+10]);
% zlim([loc1(3)-10, loc1(3)+10]);
camorbit(0, -10);

title('Dense Reconstruction');