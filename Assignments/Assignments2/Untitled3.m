close all; clear; clc;
load cameracalib.mat
videoReader = VideoReader('1_3\oranges.mp4');
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);

objectFrame = readFrame(videoReader);
% objectRegion = [232, 112, 180, 175];
objectRegion = [1, 1, 640, 352];

objectImage = insertShape(objectFrame,'Rectangle',objectRegion,'Color','red');
figure;
imshow(objectImage);
title('Red box shows object region');

prevPoints = detectMinEigenFeatures(im2gray(objectFrame),'ROI',objectRegion, 'MinQuality', 0.0001);
pointImage = insertMarker(objectFrame,prevPoints.Location,'+','Color','white');
figure;
imshow(pointImage);
title('Detected interest points');

tracker = vision.PointTracker('MaxBidirectionalError',1);

initialize(tracker,prevPoints.Location,objectFrame);

images = {};
i = 1;
while hasFrame(videoReader)
      frame = readFrame(videoReader);
      [currPoints,validity] = tracker(frame);
      out = insertMarker(frame,currPoints(validity, :),'s','Color','red');
      images{i} = out;
      videoPlayer(out);
      i = i+1;
end

release(videoPlayer);

for i = 1:numel(images)

    imwrite(images{i},'D:\MATLAB\Project\Assignments\Assignments2\Computer Vision and Imaging (extended) [06-30241] Summative_2\Part 1\1_3_Output\featureImages\'+string(i)+'.png');
    

end


% % Display camera poses.
% camPoses = poses(vSet);
% figure;
% plotCamera(camPoses, 'Size', 0.2);
% hold on
% 
% % Exclude noisy 3-D points.
% % goodIdx = (reprojectionErrors < 5);
% % xyzPoints = xyzPoints(goodIdx, :);
% 
% % Display the 3-D points.
% pcshow(xyzPoints, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
%     'MarkerSize', 45);
% grid on
% hold off
% 
% % Specify the viewing volume.
% loc1 = camPoses.AbsolutePose(1).Translation;
% xlim([loc1(1)-5, loc1(1)+4]);
% ylim([loc1(2)-5, loc1(2)+4]);
% zlim([loc1(3)-1, loc1(3)+20]);
% camorbit(0, -30);
% 
% title('Refined Camera Poses');
% 
% 
% 
% 
% trackers = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 6);
% prevPoints2 = detectMinEigenFeatures(im2gray(objectFrame),'ROI',objectRegion, 'MinQuality', 0.0001);
% initialize(trackers, prevPoints2.Location, objectFrame);
% 
% vSet = updateConnection(vSet, 1, 2, 'Matches', zeros(0, 2));
% vSet = updateView(vSet, 1, 'Points', prevPoints2);
% 
% while hasFrame(videoReader)
%     
%     if i==150
%         break;
%     end
%     frame = readFrame(videoReader);
%     [currPoints, validIdx] = step(trackers, frame);
%     
%     if i < 150
%         vSet = updateConnection(vSet, i, i+1, 'Matches', zeros(0, 2));
%     end
%     vSet = updateView(vSet, i, 'Points', currPoints);
%     matches = repmat((1:size(prevPoints, 1))', [1, 2]);
%     matches = matches(validIdx, :);        
%     vSet = updateConnection(vSet, i-1, i, 'Matches', matches);
%     i=i+1;
% end
% 
% tracks = findTracks(vSet);
% camPoses = poses(vSet);
% xyzPoints = triangulateMultiview(tracks, camPoses,...
%     cameraParams.Intrinsics);
% figure;
% plotCamera(camPoses, 'Size', 0.2);
% hold on
% 
% % Exclude noisy 3-D world points.
% % goodIdx = (reprojectionErrors < 5);
% 
% % Display the dense 3-D world points.
% pcshow(xyzPoints, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
%     'MarkerSize', 45);
% grid on
% hold off
% 
% % Specify the viewing volume.
% % loc1 = camPoses.AbsolutePose(1).Translation;
% % xlim([loc1(1)-5, loc1(1)+4]);
% % ylim([loc1(2)-5, loc1(2)+4]);
% % zlim([loc1(3)-1, loc1(3)+20]);
% camorbit(0, -30);
% 
% title('Dense Reconstruction');








































































% close all; clear; clc;
% load cameracalib.mat
% videoReader = VideoReader('1_3_Output\o1.avi');
% videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
% 
% objectFrame = readFrame(videoReader);
% % objectRegion = [200, 90, 230, 210];
% % objectRegion = [232, 112, 180, 175];
% % objectRegion = [1, 1, 640, 352];
% objectRegion = [221, 10, 400, 300];
% 
% 
% objectImage = insertShape(objectFrame,'Rectangle',objectRegion,'Color','red');
% figure;
% imshow(objectImage);
% title('Red box shows object region');
% 
% prevPoints = detectMinEigenFeatures(im2gray(objectFrame),'ROI',objectRegion, 'MinQuality', 0.0001);
% prevFeatures = extractFeatures(im2gray(objectFrame), prevPoints.Location, 'Upright', true);
% pointImage = insertMarker(objectFrame,prevPoints.Location,'+','Color','white');
% figure;
% imshow(pointImage);
% title('Detected interest points');
% 
% tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 8);
% 
% initialize(tracker,prevPoints.Location,objectFrame);
% 
% 
% prevPoints = prevPoints.Location;
% 
% 
% vSet = imageviewset;
% 
% % Add the first view. Place the camera associated with the first view
% % and the origin, oriented along the Z-axis.
% viewId = 1;
% vSet = addView(vSet, viewId, rigid3d, 'Points', prevPoints);
% i = 1;
% LastFrame = objectFrame;
% while hasFrame(videoReader)    
%     frame = readFrame(videoReader);
%     if i~=1
%         [currPoints,validity] = step(tracker,frame);
%         
%         
%         currFeatures = extractFeatures(im2gray(frame), currPoints, 'Upright', true);
%         indexPairs   = matchFeatures(prevFeatures, currFeatures, ...
%             'MaxRatio', 1, 'Unique',  true);
%         
%         
%         matchedPoints1 = prevPoints(indexPairs(:,1),:);
%         matchedPoints2 = currPoints(indexPairs(:,2),:);
%     
%         
%         
%         
%         [fMatrix, epipolarInliers] = estimateFundamentalMatrix(...
%             matchedPoints1, matchedPoints2, 'Method', 'MSAC', 'NumTrials', 2500);
%         inlierPoints1 = matchedPoints1(epipolarInliers, :);
%         inlierPoints2 = matchedPoints2(epipolarInliers, :);
%         showMatchedFeatures(LastFrame, frame, inlierPoints1, inlierPoints2);
%         title('Epipolar Inliers');
%         [R,t] = relativeCameraPose(fMatrix,cameraParams,inlierPoints1,inlierPoints2);
%           
%          
%         RSize = size(R);
%         RSizeLength = length(RSize);
%         if RSizeLength~=2
%             R = R(:,:,1);
%         end
%         
%         tSize = size(t);
%         if tSize(1)~=1
%             t = t(1,:);
%         end
%         
%         
%         
%         
%         
%         prevPose = poses(vSet, i-1).AbsolutePose;
%         relPose  = rigid3d(R, t);
%         
%         currPose = rigid3d(relPose.T * prevPose.T);
%         vSet = addView(vSet, i, currPose, 'Points', currPoints);
%         vSet = addConnection(vSet, i-1, i, relPose, 'Matches', indexPairs(epipolarInliers,:));
%         tracks = findTracks(vSet);
%         camPoses = poses(vSet);
%         xyzPoints = triangulateMultiview(tracks, camPoses, cameraParams.Intrinsics);
%         [xyzPoints, camPoses, reprojectionErrors] = bundleAdjustment(xyzPoints, ...
%             tracks, camPoses, cameraParams.Intrinsics, 'FixedViewId', 1, ...
%             'PointsUndistorted', true);
%         vSet = updateView(vSet, camPoses);
%         prevPoints   = currPoints;
%         prevFeatures = currFeatures;
% 
%         
%         LastFrame = frame;
%         out = insertMarker(frame,matchedPoints2,'+');
%         videoPlayer(out);
%     end
%     i=i+1;
% end
% 
% release(videoPlayer);
% 
% 
% % Display camera poses.
% camPoses = poses(vSet);
% figure;
% plotCamera(camPoses, 'Size', 0.2);
% hold on
% 
% % Exclude noisy 3-D points.
% goodIdx = (reprojectionErrors < 50);
% xyzPoints = xyzPoints(goodIdx, :);
% 
% % Display the 3-D points.
% pcshow(xyzPoints, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
%     'MarkerSize', 45);
% grid on
% hold off
% 
% % Specify the viewing volume.
% loc1 = camPoses.AbsolutePose(1).Translation;
% xlim([loc1(1)-20, loc1(1)+20]);
% ylim([loc1(2)-20, loc1(2)+20]);
% zlim([loc1(3)-20, loc1(3)+20]);
% camorbit(0, -20);
% 
% title('Refined Camera Poses');
% 
% 
% prevPoints = detectMinEigenFeatures(im2gray(objectFrame),'ROI',objectRegion, 'MinQuality', 0.000001);
% tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 6);
% prevPoints = prevPoints.Location;
% initialize(tracker, prevPoints, objectFrame);
% vSet = updateConnection(vSet, 1, 2, 'Matches', zeros(0, 2));
% vSet = updateView(vSet, 1, 'Points', prevPoints);
% i=2;
% while hasFrame(videoReader)
%     if i~=1
%         [currPoints, validIdx] = step(tracker, I);
%         if i < i
%             vSet = updateConnection(vSet, i, i+1, 'Matches', zeros(0, 2));
%         end
%         vSet = updateView(vSet, i, 'Points', currPoints);
%         matches = repmat((1:size(prevPoints, 1))', [1, 2]);
%         matches = matches(validIdx, :);
%         vSet = updateConnection(vSet, i-1, i, 'Matches', matches);
%     end
%     i=i+1;
% end
% 
% 
% 
% 
% 
% 
% 
% tracks = findTracks(vSet);
% 
% % Find point tracks across all views.
% camPoses = poses(vSet);
% 
% % Triangulate initial locations for the 3-D world points.
% xyzPoints = triangulateMultiview(tracks, camPoses,...
%     cameraParams.Intrinsics);
% 
% % Refine the 3-D world points and camera poses.
% [xyzPoints, camPoses, reprojectionErrors] = bundleAdjustment(...
%     xyzPoints, tracks, camPoses, cameraParams.Intrinsics, 'FixedViewId', 1, ...
%     'PointsUndistorted', true);
% 
% 
% % Display the refined camera poses.
% figure;
% plotCamera(camPoses, 'Size', 0.2);
% hold on
% 
% % Exclude noisy 3-D world points.
% goodIdx = (reprojectionErrors < 5);
% 
% % Display the dense 3-D world points.
% pcshow(xyzPoints(goodIdx, :), 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
%     'MarkerSize', 45);
% grid on
% hold off
% 
% % Specify the viewing volume.
% loc1 = camPoses.AbsolutePose(1).Translation;
% xlim([loc1(1)-10, loc1(1)+10]);
% ylim([loc1(2)-10, loc1(2)+10]);
% zlim([loc1(3)-10, loc1(3)+10]);
% camorbit(0, -10);
% 
% title('Dense Reconstruction');