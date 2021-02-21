%% 通过卷积计算图像的导数
% 读取图像并生成卷积核
tigger_gray = imread('Test_img\lena.jpg');
%tigger_gray = tigger;%rgb2gray(tigger);
kernel_x = [-1,1];
kernel_y = [-1;1];

% 将RGB图像转换成灰度图像
tigger_size = size(tigger_gray);

% 分别存储x和y方向的导数
result_x = zeros(tigger_size(1),tigger_size(2),tigger_size(3));
result_y = zeros(tigger_size(1),tigger_size(2),tigger_size(3));

% 计算x方向的导数
for k = 1:tigger_size(3)
for i = 1:tigger_size(1)
    for j = 1:tigger_size(2)
        if j == tigger_size(2)
            break;
        end
%         tmp = single([tigger_gray(i,j),tigger_gray(i,j+1)]);
%         result_x(i,j) = dot(tmp,kernel_x);
        tmp_point = tigger_gray(i,j,k);
        tmp_kx =double(double(tigger_gray(i,j,k))*kernel_x(1));
        tmp_kx1 = double(tigger_gray(i,j+1,k))*kernel_x(2);
        tmp = tmp_kx+tmp_kx1;
%         tmp = single((tigger_gray(i,j)*kernel_x(1))+(tigger_gray(i,j+1)*kernel_x(2)));
        result_x(i,j,k) = tmp;
    end
end
end

% 计算y方向的导数
for k = 1:tigger_size(3)
for i = 1:tigger_size(2)
    for j = 1:tigger_size(1)
        if j == tigger_size(1)
            break;
        end
%         tmp = single([tigger_gray(j,i),tigger_gray(j+1,i)]);
%         result_y(j,i) = dot(tmp,kernel_y);
        result_y(j,i,k) = double(tigger_gray(j,i,k))*kernel_y(1)+(double(tigger_gray(j+1,i,k))*kernel_y(2));
    end
end
end

% 将结果矩阵归一化
result_x = result_x/max(result_x(:));
result_y = result_y/max(result_y(:));

subplot(3,3,2);
imshow(tigger_gray);
title("Original Image");
hold on;

subplot(3,3,4);
imshow(result_x);
title("X方向导数");
hold on;

subplot(3,3,6);
imshow(result_y);
title("Y方向导数");
hold on;

subplot(3,3,8);
t = result_x.^2+result_y.^2;
st = sqrt(t);
imshow(st);
title("Result")