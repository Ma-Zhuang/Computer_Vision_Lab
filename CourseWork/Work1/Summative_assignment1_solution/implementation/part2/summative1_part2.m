% Assignment part 2 solution Bsc/Extended/MSc
% to run use: part2("./dom.jpg","./dom_full.jpeg", "./dom_part.jpg")

function part2(img_path, img1_path, img2_path)
close all
clc
% import images
img1 = rgb2gray(imread(img_path));

%% 2.1.1 add noise according to the specifications using imnoise function

img1_gaussian = imnoise(img1, 'gaussian', 0.3, 0.5);
img1_salt_pepper = imnoise(img1,'salt & pepper', 0.075);
img1_speckle = imnoise(img1, 'speckle');

% % visualization 
figure;
subplot(2, 2, 1);
imshow(img1);
title("Original image")
subplot(2, 2, 2);
imshow(img1_gaussian);
title("Gaussian noise")
subplot(2, 2, 3);
imshow(img1_salt_pepper);
title("Salt and pepper noise")
subplot(2, 2, 4);
imshow(img1_speckle);
title("Speckle noise")
sgtitle("Solution of Task 2.1.1.")

%% 2.1.2 noise removal using implemented image filters on the noisy image

img1_g_min = minimum_filter_image(img1_gaussian, ones(5));
img1_g_max = maximum_filter_image(img1_gaussian, ones(5));
img1_g_mean = mean_filter_image(img1_gaussian, ones(5));
img1_g_med = median_filter_image(img1_gaussian, ones(5));

img1_sp_min = minimum_filter_image(img1_salt_pepper, ones(5));
img1_sp_max = maximum_filter_image(img1_salt_pepper, ones(5));
img1_sp_mean = mean_filter_image(img1_salt_pepper, ones(5));
img1_sp_med = median_filter_image(img1_salt_pepper, ones(5));

% visualization 
figure;
subplot(2, 5, 1);
imshow(img1_gaussian);
title("Image with Gaussian noise")
subplot(2, 5, 2);
imshow(img1_g_min);
title("Gaussian noise 5x5 min filter")
subplot(2, 5, 3);
imshow(img1_g_max);
title("Gaussian noise 5x5 max filter")
subplot(2, 5,4);
imshow(img1_g_mean);
title("Gaussian noise 5x5 mean filter")
subplot(2, 5,  5);
imshow(img1_g_med);
title("Gaussian noise 5x5 med filter")

subplot(2, 5, 6);
imshow(img1_salt_pepper);
title("Image with Salt & Pepper noise")
subplot(2, 5, 7);
imshow(img1_sp_min);
title("Salt & Pepper noise 5x5 min filter")
subplot(2, 5, 8);
imshow(img1_sp_max);
title("Salt & Pepper noise 5x5 max filter")
subplot(2, 5, 9);
imshow(img1_sp_mean);
title("Salt & Pepper noise 5x5 mean filter")
subplot(2, 5, 10);
imshow(img1_sp_med);
title("Salt & Pepper noise 5x5 med filter")

sgtitle("Solution of Task 2.1.2.")

%% 2.2. Extract local image features using FAST from the noisy (Task 2.1.1.) and
% denoised images (Task 2.1.2.) - not from the original image

% students who could not complete Task 2.1.2. use:
% [matchedPoints_sp0, matchedPoints_img1, num_pairs0] = matching(img1_salt_pepper, img1);
% figure; ax = axes;
% showMatchedFeatures(img1_salt_pepper,img1,matchedPoints_sp0,matchedPoints_img1,'montage','Parent',ax);
% title(ax, num2str(num_pairs0) + " candidate point matches using the original img");
% legend(ax, 'Matched points 1','Matched points 2');

% continuing Task 2.1.1. and 2.1.2.
 
[matchedPoints_sp1, matchedPoints_sp_min, num_pairs1] = matching(img1_salt_pepper, img1_sp_min);
[matchedPoints_sp2, matchedPoints_sp_max, num_pairs2] = matching(img1_salt_pepper, img1_sp_max);
[matchedPoints_sp3, matchedPoints_sp_mean, num_pairs3] = matching(img1_salt_pepper, img1_sp_mean);
[matchedPoints_sp4, matchedPoints_sp_med, num_pairs4] = matching(img1_salt_pepper, img1_sp_med);

figure; ax = axes;
showMatchedFeatures(img1_salt_pepper,img1_sp_min,matchedPoints_sp1,matchedPoints_sp_min,'montage','Parent',ax);
title("Feature matching: min filter (" + num2str(num_pairs1)+ " matches)")
figure; ax = axes;
showMatchedFeatures(img1_salt_pepper,img1_sp_max,matchedPoints_sp2,matchedPoints_sp_max,'montage','Parent',ax);
title("Feature matching: max filter (" + num2str(num_pairs2)+ " matches)")
figure; ax = axes;
showMatchedFeatures(img1_salt_pepper,img1_sp_mean,matchedPoints_sp3,matchedPoints_sp_mean,'montage','Parent',ax);
title("Feature matching: mean filter (" + num2str(num_pairs3)+ " matches)")
figure; ax = axes;
showMatchedFeatures(img1_salt_pepper,img1_sp_med,matchedPoints_sp4,matchedPoints_sp_med,'montage','Parent',ax);
title("Feature matching: med filter (" + num2str(num_pairs4)+ " matches)")

%% 2.3 Master's and extended only
% read more: https://www.mathworks.com/help/vision/feature-detection-and-extraction.html
% https://www.mathworks.com/help/images/approaches-to-registering-images.html
% https://www.mathworks.com/help/vision/ref/estimategeometrictransform2d.html

img1 = rgb2gray(imread(img1_path));
img2 = rgb2gray(imread(img2_path)); %distorted

[matchedPtsOriginal, matchedPtsDistorted, num_pairs] = matching(img1, img2);
figure; 
showMatchedFeatures(img1,img2,...
    matchedPtsOriginal,matchedPtsDistorted);
title("Feature matching: (" + num2str(num_pairs)+ " matches with outliers)")

[tform,inlierPtsDistorted,inlierPtsOriginal] = ...
    estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,...
    'similarity');
figure; 
showMatchedFeatures(img1,img2,...
    inlierPtsOriginal,inlierPtsDistorted);
title('Matched inlier points');

outputView = imref2d(size(img1));
Ir = imwarp(img2,tform,'OutputView',outputView);

fused_img = imfuse(img1,Ir,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
figure; imshow(fused_img); 
title('Recovered image');
end
function [matchedPoints1, matchedPoints2, num_pairs]=matching(img1, img2)
% select at least one of the following: 
% detectBRISKFeatures	
% detectFASTFeatures - in the solution PDF we used this detector
% detectHarrisFeatures
% detectMinEigenFeatures
% detectMSERFeatures
% detectORBFeatures
% detectSURFFeatures
% detectKAZEFeatures
% see list at https://www.mathworks.com/help/vision/feature-detection-and-extraction.html under Detect features

img1_feat = detectSURFFeatures(img1);
[f1, vpts1] = extractFeatures(img1, img1_feat);

img2_feat = detectSURFFeatures(img2);
[f2, vpts2] = extractFeatures(img2, img2_feat);

indexPairs = matchFeatures(f1, f2) ;
num_pairs = size(indexPairs,1);
dsiplay_every = 1;
matchedPoints1 = vpts1(indexPairs(1:dsiplay_every:num_pairs, 1));
matchedPoints2 = vpts2(indexPairs(1:dsiplay_every:num_pairs, 2));
end

