lena = imread('Test_img\lena.jpg');
subplot(2,3,1);
imshow(lena);
title("Original Image");
hold on;

lena_gary = rgb2gray(lena);
subplot(2,3,2);
imshow(lena_gary);
title("Gary Image");
hold on;

sigma = 1;
[lena_x, lena_y, lena_ori] = der_Gaussian_filter(lena_gary,sigma,1);
lena_tmp_x = (lena_x/max(lena_x(:)));
lena_tmp_y = (lena_y/max(lena_y(:)));
lena_der = sqrt(lena_tmp_x.^2+lena_tmp_y.^2);

subplot(2,3,3);
imshow(lena_der);
title("Amplitude image");
hold on;

lena_nonMax = Non_maximum_suppression(lena_der,lena_ori);

subplot(2,3,4);
imshow(lena_nonMax);
title("Non Maximum Suppression");
hold on;

edge_result = Hysteresis_Thresholding(lena_nonMax,0.3,0.1);
subplot(2,3,5);
imshow(edge_result);
title("Edge detection");
hold on;

result_lib = edge(lena_gary,'canny');
subplot(2,3,6);
imshow(result_lib);
title("Edge detection by lib");
hold on;