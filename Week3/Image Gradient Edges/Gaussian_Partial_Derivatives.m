lena = imread('Test_img\lena.jpg');
lena_gary = rgb2gray(lena);
sigma = 1;

[result_x, result_y, result_ori] = der_Gaussian_filter(lena_gary,sigma,1);
% subplot(1,3,1);
% imshow(result_x);
% hold on;
% 
% subplot(1,3,2);
% imshow(result_y);
% hold on;
result_tmp_x = (result_x/max(result_x(:)));
result_tmp_y = (result_y/max(result_y(:)));
result = sqrt(result_tmp_x.^2+result_tmp_y.^2);
%subplot(1,3,3);


%imshow(result_ori);

% x = atan(result_tmp_y/result_tmp_x);
%imshow(x);

%ori = Non_maximum_suppression(result_tmp_x,result_tmp_y,result);
ori = Non_maximum_suppression(result,result_ori);

subplot(1,3,1);
imshow(result);
hold on;

subplot(1,3,2);
imshow(ori);
hold on;

% figure;
% imhist(ori);
edge_result = Hysteresis_Thresholding(ori,0.15,0.09);

subplot(1,3,3);
imshow(edge_result);
hold on;


% b=[1 2 3;4 5 6;7 8 9];
% 
% [row,cell]=find(b>=3);
% disp(row(1));
% disp(cell(1));
% disp(size(row));