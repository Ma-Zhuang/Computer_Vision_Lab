%% Question 2.1.1
clear; clc; close all;
original_img_rgb = imread('img\dom.jpg');
original_img = rgb2gray(original_img_rgb);

subplot(2,2,1);
imshow(original_img);
title("Original Image");
hold on;

gaussian_noise = imnoise(original_img,'gaussian',0.3,0.5);
subplot(2,2,2);
imshow(gaussian_noise);
title("Gaussian Noise");
hold on;

salt_and_pepper_noise = imnoise(original_img,'salt & pepper',0.075);
subplot(2,2,3);
imshow(salt_and_pepper_noise);
title("Salt and pepper Noise");
hold on;

speckle_noise = imnoise(original_img,'speckle');
subplot(2,2,4);
imshow(speckle_noise);
title("Speckle Noise");
hold on;

%% Question 2.1.2
clear; clc; close all;
kernel = ones(5);
figure;
subplot(2,5,1);
imshow(gaussian_noise);
title("Image with Gaussian noise")
hold on;

gasussian_minFilter = myFilter(gaussian_noise,kernel,"min");
subplot(2,5,2);
imshow(gasussian_minFilter);
title("Gaussian noise 5\times5 min filter");
hold on;

gasussian_maxFilter = myFilter(gaussian_noise,kernel,"max");
subplot(2,5,3);
imshow(gasussian_maxFilter);
title("Gaussian noise 5\times5 max filter");
hold on;

gasussian_meanFilter = myFilter(gaussian_noise,kernel,"mean");
subplot(2,5,4);
imshow(gasussian_meanFilter);
title("Gaussian noise 5\times5 mean filter");
hold on;

gasussian_medFilter = myFilter(gaussian_noise,kernel,"med");
subplot(2,5,5);
imshow(gasussian_medFilter);
title("Gaussian noise 5\times5 med filter");
hold on;

subplot(2,5,6);
imshow(salt_and_pepper_noise);
title("Image with Salt & Pepper noise")
hold on;

sp_minFilter = myFilter(salt_and_pepper_noise,kernel,"min");
subplot(2,5,7);
imshow(sp_minFilter);
title("Salt & Pepper noise 5\times5 min filter");
hold on;

sp_maxFilter = myFilter(salt_and_pepper_noise,kernel,"max");
subplot(2,5,8);
imshow(sp_maxFilter);
title("Salt & Pepper noise 5\times5 max filter");
hold on;

sp_meanFilter = myFilter(salt_and_pepper_noise,kernel,"mean");
subplot(2,5,9);
imshow(sp_meanFilter);
title("Salt & Pepper noise 5\times5 mean filter");
hold on;

sp_medFilter = myFilter(salt_and_pepper_noise,kernel,"med");
subplot(2,5,10);
imshow(sp_medFilter);
title("Salt & Pepper noise 5\times5 med filter");
hold on;


%% Question 2.2
clear; clc; close all;
boxPoints = detectSURFFeatures(salt_and_pepper_noise);
scenePoints = detectSURFFeatures(sp_medFilter);
[boxFeatures, boxPoints] = extractFeatures(salt_and_pepper_noise, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(sp_medFilter, scenePoints);
boxPairs = matchFeatures(boxFeatures, sceneFeatures);
matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
[~,inlierIdx] = estimateGeometricTransform2D(matchedBoxPoints, matchedScenePoints, 'affine');
inlierBoxPoints   = matchedBoxPoints(inlierIdx, :);
inlierScenePoints = matchedScenePoints(inlierIdx, :);
figure;
showMatchedFeatures(salt_and_pepper_noise, sp_medFilter, inlierBoxPoints,inlierScenePoints, 'montage');
title('Feture matching: med filter');
%% Question 2.3
clear; clc; close all;
% dom_f = imread('img\dom_full.jpeg');
% dom_p = imread('img\dom_part.jpg');
% dom_full = rgb2gray(dom_f);
% dom_part = rgb2gray(dom_p);
% ptsOriginal  = detectSURFFeatures(dom_full);
% ptsDistorted = detectSURFFeatures(dom_part);
% [featuresOriginal,validPtsOriginal] = extractFeatures(dom_full,ptsOriginal);
% [featuresDistorted,validPtsDistorted] = extractFeatures(dom_part,ptsDistorted);
%
% index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
% matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
% matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
% figure
% showMatchedFeatures(dom_full,dom_part,matchedPtsOriginal,matchedPtsDistorted)
% title('Matched SURF Points With Outliers');
%
% [tform,inlierIdx] = estimateGeometricTransform2D(matchedPtsDistorted,matchedPtsOriginal,'similarity');
% inlierPtsDistorted = matchedPtsDistorted(inlierIdx,:);
% inlierPtsOriginal  = matchedPtsOriginal(inlierIdx,:);
%
% figure
% showMatchedFeatures(dom_full,dom_part,inlierPtsOriginal,inlierPtsDistorted)
% title('Matched Inlier Points')
%
% outputView = imref2d(size(dom_full));
% Ir = imwarp(dom_part,tform,'OutputView',outputView);
% figure
% imshow(Ir);
% title('Recovered Image');

domFull = rgb2gray(imread('img\dom_full.jpeg'));
domPart = rgb2gray(imread('img\dom_part.jpg'));

pointsDomFull = detectSURFFeatures(domFull);
pointsDomPart = detectSURFFeatures(domPart);

[featuresDomFull, pointsDomFull] = extractFeatures(domFull, pointsDomFull);
[featuresDomPart, pointsDomPart] = extractFeatures(domPart, pointsDomPart);

indexPairs = matchFeatures(featuresDomFull, featuresDomPart);
matchedDomFull = pointsDomFull(indexPairs(:, 1), :);
matchedDomPart = pointsDomPart(indexPairs(:, 2), :);

figure;
showMatchedFeatures(domFull, domPart, matchedDomFull,matchedDomPart);
title('Feature matching');
hold on;

[tform,inlierIdx] = estimateGeometricTransform2D(matchedDomPart,matchedDomFull,'similarity');
inlierDomPart = matchedDomPart(inlierIdx,:);
inlierDomFull = matchedDomFull(inlierIdx,:);

figure;
showMatchedFeatures(domFull,domPart,inlierDomFull,inlierDomPart);
title('Matched inlier points');
hold on;

domFull_coord = imref2d(size(domFull));
Ir = imwarp(domPart,tform,'OutputView',domFull_coord);
figure;
imshowpair(Ir, domFull,'falsecolor');
title('Recovered Image')