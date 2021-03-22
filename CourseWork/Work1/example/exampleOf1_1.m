original_img_rgb = imread('domain_spec_model_with_pi_open.png');
original_img = rgb2gray(original_img_rgb);
kernel = [-1,-1,-1;-1,8,-1;-1,-1,-1];
result = conv2(original_img,kernel,'valid');

subplot(1,2,1);
imshow(original_img);
title("Original Image");
hold on;

subplot(1,2,2);
imshow(result);
title("After convolution");
hold on;