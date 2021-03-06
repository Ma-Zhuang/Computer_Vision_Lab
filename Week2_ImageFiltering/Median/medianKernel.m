%% 中值滤波核
function result = medianKernel(Img,Filter)
% 获取图像大小
img_size = size(Img);
% 创建空模板，用于返回结果
result = uint8(zeros(img_size(1),img_size(2),img_size(3)));
% 获取过滤器大小
filter_size = size(Filter);
% 计算中值
filter_center = ((filter_size(1)^2)+1)/2;
% 计算图像每条边的padding个数
padding_num = (filter_size(1)-1)/2;
% 创建padding后的空模板，用于卷积操作
padding_img = zeros(img_size(1)+(2*padding_num),img_size(2)+(2*padding_num),img_size(3));

% 向padding后的模板中替换元素，用于实现padding操作
for i = 1:img_size(3)
    for j = 1:img_size(1)
        for k = 1:img_size(2)
            padding_img(j+padding_num,k+padding_num,i) = Img(j,k,i);
        end
    end
end


% 实施卷积操作
for i = 1:img_size(3)
    for j = 1:img_size(1)
        for k = 1:img_size(2)
            % 创建临时的矩阵，用于存放当前卷积模板中各个元素所对应的图像像素值
            tmp = zeros(filter_size);
            for l = 0:(2*padding_num)
                for m = 0:(2*padding_num)
                    % 提取当前卷积模板中各个元素，所对应的像素图像值
                    tmp(l+1,m+1) = padding_img(j+l,k+m,i);
                end
            end
            % 将矩阵转换成为数组
            tmp_array = tmp(:);
            % 对数组进行升序排序
            sort_array = sort(tmp_array);
            % 将数组的中值作为卷积操作后，新的像素值并放置在返回结果矩阵中
            result(j,k,i) = sort_array(filter_center);
        end
    end
end
end

