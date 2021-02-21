noise = imread('Test_img\Gaussian_noise.PNG');

kernel = Gaussian_kernel(2);

result = myFilter(noise,kernel);

subplot(1,2,1);
imshow(noise);
title('Original Image');
hold on;

subplot(1,2,2);
imshow(result);
title('Gaussian Filter')