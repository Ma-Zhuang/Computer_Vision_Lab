original_img_rgb = imread('lena.jpg');
original_img = rgb2gray(original_img_rgb);

A = [0 -1 -1 -1 -1 0;
    -1 -2 -3 -3 -2 -1;
    -1 -3 12 12 -3 -1;
    -1 -3 12 12 -3 -1;
    -1 -2 -3 -3 -2 -1;
    0 -1 -1 -1 -1 0;];
B = [1 1 1 1 1 1;
    -1 -2 -3 -3 -2 -1;
    -1 -3 -4 -4 -3 -1;
    1 3 4 4 3 1;
    1 2 3 3 2 1;
    -1 -1 -1 -1 -1 -1;];
result_A = conv2(original_img,A,'valid');
result_B = conv2(original_img,B,'valid');
subplot(1,2,1);
imshow(result_A);
title("Kernel A");
hold on;
subplot(1,2,2);
imshow(result_B);
title("Kernel B");
hold on;

av_r=sum(original_img(:))/length(original_img(:));
av_A=sum(result_A(:))/length(result_A(:));
av_B=sum(result_B(:))/length(result_B(:));
disp(av_r);
disp(av_A);
disp(av_B);