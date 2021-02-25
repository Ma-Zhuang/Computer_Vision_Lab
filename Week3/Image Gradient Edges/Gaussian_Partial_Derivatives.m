lena = imread('Test_img\lena.jpg');
lena_gary = rgb2gray(lena);
sigma = 1;
[result_x, result_y] = der_Gaussian_filter(lena_gary,sigma,1);
% subplot(1,3,1);
% imshow(result_x);
% hold on;
% 
% subplot(1,3,2);
% imshow(result_y);
% hold on;
result_x = result_x/max(result_x(:));
result_y = result_y/max(result_y(:));
result = sqrt(result_x.^2+result_y.^2);
%subplot(1,3,3);
imshow(result);

