%% 锐化( I *(2e - g) ) I：图像，e：脉冲卷积核，g：平滑滤波
% Einstein = imread('Test_img\lena.jpg');
% n = input('请输入均值滤波器模板大小\n');
% padding_num = (n-1)/2;
% e_kernel = zeros(n);
% g_kernel = ones(n)/(n^2);
% e_kernel(padding_num+1,padding_num+1) = 2;
% tmp_kernel = e_kernel-g_kernel;
% 
% Einstein_size = size(Einstein);
% 
% padding_Einstein = zeros(Einstein_size(1)+(2*padding_num),Einstein_size(2)+(2*padding_num),Einstein_size(3));
% 
% 
% for i = 1:Einstein_size(3)
%     for j = 1:Einstein_size(1)
%         for k = 1:Einstein_size(2)
%             padding_Einstein(j+padding_num,k+padding_num,i) = Einstein(j,k,i);
%         end
%     end
% end
% 
% filter_kernel = tmp_kernel;
% filter_kernel_flip = flip(filter_kernel);
% filter_kernel_flip = flip(filter_kernel_flip,2);
% result = uint8(zeros(Einstein_size(1),Einstein_size(2),Einstein_size(3)));
% 
% for i = 1:Einstein_size(3)
%     for j = 1:Einstein_size(1)
%         for k = 1:Einstein_size(2)
%             tmp = zeros(n);
%             for l = 0:2*padding_num
%                 for m = 0:2*padding_num
%                     tmp(l+1,m+1) = padding_Einstein(j+l,k+m,i);
%                 end
%             end
%             tmp_result = 0;
%             for p = 1:n
%                 for o = 1:n
%                     tmp_result = tmp_result+(tmp(p,o)*filter_kernel_flip(p,o));
%                 end
%             end
%             result(j,k,i) = tmp_result;
%         end
%     end
% end
% 
% subplot(1,2,1);
% imshow(Einstein);
% title({'Origin Image'});
% hold on;
% 
% subplot(1,2,2);
% imshow(result);
% title('Sharpened');

%% 锐化 原始步骤：原图像减去平滑后的图像得出细节图。而将细节图与原图像相加，最终实现锐化的效果。

%% 读取测试图片并输入卷积核大小
lena = imread('Test_img\lena.jpg');
n = input('请输入均值滤波器模板大小\n');


%% 通过自己实现的方法实现平滑处理
%计算需要在图像中增加的轮过大小
padding_num = (n-1)/2;
% 获取当前图片的尺寸
lena_size = size(lena);
% 创建新的模板
padding_lena = zeros(lena_size(1)+(2*padding_num),lena_size(2)+(2*padding_num),lena_size(3));

% 通过赋值的方式对原始图片添加轮廓
for i = 1:lena_size(3)
    for j = 1:lena_size(1)
        for k = 1:lena_size(2)
            %在当前像素点添加所需的轮廓
            padding_lena(j+padding_num,k+padding_num,i) = lena(j,k,i);
        end
    end
end

% 使用平均滤波实现平滑操作
filter_kernel = ones(n)/(n^2);
% 对卷积核进行翻转操作，首先以x轴为中心店进行翻转
filter_kernel_flip = flip(filter_kernel);
% 以y的为中心进行翻转
filter_kernel_flip = flip(filter_kernel_flip,2);
% 创建空模板，以用来显示平滑后的结果。注：需将数据类型转换为uint8
result = uint8(zeros(lena_size(1),lena_size(2),lena_size(3)));

% 实现卷积操作
for i = 1:lena_size(3)
    for j = 1:lena_size(1)
        for k = 1:lena_size(2)
            % 创建临时的卷积模板，用以与卷积核相乘的操作
            tmp = zeros(n);
            % 获取到当前像素点位置时，根据增加轮廓的大小，获取到当前卷积模板所对应原图的像素数据
            for l = 0:2*padding_num
                for m = 0:2*padding_num
                    % 将卷积核所对应的原图像素数据，放置到卷积模板当中
                    tmp(l+1,m+1) = padding_lena(j+l,k+m,i);
                end
            end
            % 临时记录当前卷积核与原图像素数据，卷积的结果
            tmp_result = 0;
            for p = 1:n
                for o = 1:n
                    % 执行卷积操作（卷积核与原图对应像素点的均值求和）
                    tmp_result = tmp_result+(tmp(p,o)*filter_kernel_flip(p,o));
                end
            end
            % 保存卷积平滑后的结果
            result(j,k,i) = tmp_result;
        end
    end
end

% 原图像减去平滑后的图像得出细节图。而将细节图与原图像相加，最终实现锐化的效果。
detail = lena - result;
sharpened = lena + detail;

%% 显示原图与结果
subplot(2,3,1);
imshow(lena);
title('Origin Image');
hold on;

subplot(2,3,2);
imshow(result);
title('Smoothed Image');
hold on;

subplot(2,3,3);
imshow(detail);
title('Detail');
hold on;

subplot(2,3,4);
imshow(lena);
title('Origin Image');
hold on;

subplot(2,3,5);
imshow(detail);
title('Detail');
hold on;

subplot(2,3,6);
imshow(sharpened);
title('Sharpened');
hold on;