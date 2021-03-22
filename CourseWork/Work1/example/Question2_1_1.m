original_img_rgb = imread('lena.jpg');
original_img = rgb2gray(original_img_rgb);

% subplot(2,2,1);
% imshow(original_img);
% title("Original Image");
% hold on;
% 
% gaussian_noise = imnoise(original_img,'gaussian',0.3,0.5);
% subplot(2,2,2);
% imshow(gaussian_noise);
% title("Gaussian Noise");
% hold on;
% 
% salt_and_pepper_noise = imnoise(original_img,'salt & pepper',0.75);
% subplot(2,2,3);
% imshow(salt_and_pepper_noise);
% title("Salt and pepper Noise");
% hold on;
% 
% speckle_noise = imnoise(original_img,'speckle');
% subplot(2,2,4);
% imshow(speckle_noise);
% title("Speckle Noise");
% hold on;


% A = [-1,-1,-1;-1,8,-1;-1,-1,-1];
% A_1 = [0 -1 -1 -1 -1 0;
%     -1 -2 -3 -3 -2 -1;
%     -1 -3 12 12 -3 -1;
%     -1 -3 12 12 -3 -1;
%     -1 -2 -3 -3 -2 -1;
%     0 -1 -1 -1 -1 0;];
% A = [1 1 1 1 1 1;
%     -1 -2 -3 -3 -2 -1;
%     -1 -3 -4 -4 -3 -1;
%     1 3 4 4 3 1;
%     1 2 3 3 2 1;
%     -1 -1 -1 -1 -1 -1;];
% C_1 = conv2(original_img,A_1,'valid');
% C = conv2(original_img,A,'valid');
% subplot(2,1,1);
% imshow(C_1);
% title("Original Image");
% hold on;
% subplot(2,1,2);
% imshow(C);
% title("After convolution");
% hold on;
