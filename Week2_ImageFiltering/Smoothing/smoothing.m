%% 读取测试图片并输入卷积核大小
lena = imread('Test_img\lena.jpg');
n = input('请输入均值滤波器模板大小\n');


%% 使用系统内置函数对图片进行平滑操作
% 创建卷积核模板
A = fspecial('average',n);
% 进行卷积操作
Y = imfilter(lena,A,'conv');


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


%% 显示原图与结果
subplot(1,3,1);
imshow(lena);
title('Origin Image');
hold on;

subplot(1,3,2);
imshow(result);
title('Smoothing Image by myself');
hold on;

subplot(1,3,3);
imshow(Y);
title('Smoothing Image by lib');