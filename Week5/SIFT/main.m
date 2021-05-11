% img_1 = imread('Test_img\print.PNG');
% img_1_gary = rgb2gray(img_1);
% [height,width] = size(img_1_gary);
% output = zeros(round(height/2),round(width/2));
% for i =1:2:height
%     for j = 1:2:width
%         output(i,j) = img_1_gary(i,j);
%     end
% end
img_1 = imread('Test_img\print.PNG');
sigma = 500;
noise = randn(size(img_1)).*sigma;
output = double(img_1)+noise;
imshow(output);