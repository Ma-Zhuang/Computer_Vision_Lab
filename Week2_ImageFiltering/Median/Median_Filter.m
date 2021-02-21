%% 读取图片，输入卷积核大小，创建卷积核
salt1 = imread('Test_img\salt_and_pepper.PNG');
salt2 = imread('Test_img\salt_and_pepper1.PNG');
impulse = imread('Test_img\Impulse.PNG');
kernel_size = input("请输入卷积核大小\n");
kernel = ones(kernel_size);

%% Example 1
salt1_result = medianKernel(salt1,kernel);
salt1_result_lib = medfilt3(salt1,[kernel_size,kernel_size,kernel_size]);

subplot(3,3,1);
imshow(salt1);
title('Original Image');
hold on;

subplot(3,3,2);
imshow(salt1_result);
title('Median Filter')
hold on;

subplot(3,3,3);
imshow(salt1_result_lib);
title('Median Filter by lib')
hold on;


%% Example 2
salt2_result = medianKernel(salt2,kernel);
salt2_result_lib = medfilt3(salt2,[kernel_size,kernel_size,kernel_size]);

subplot(3,3,4);
imshow(salt2);
title('Original Image');
hold on;

subplot(3,3,5);
imshow(salt2_result);
title('Median Filter')
hold on;

subplot(3,3,6);
imshow(salt2_result_lib);
title('Median Filter by lib')
hold on;


%% Example 3
impulse_result = medianKernel(impulse,kernel);
impulse_result_lib = medfilt3(impulse,[kernel_size,kernel_size,kernel_size]);

subplot(3,3,7);
imshow(impulse);
title('Original Image');
hold on;

subplot(3,3,8);
imshow(impulse_result);
title('Median Filter')
hold on;

subplot(3,3,9);
imshow(impulse_result_lib);
title('Median Filter by lib')
