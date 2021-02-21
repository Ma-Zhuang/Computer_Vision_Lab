function result = myFilter(Img,Filter)
Filter_size = size(Filter);
Img_size = size(Img);
result = uint8(zeros(Img_size(1),Img_size(2),Img_size(3)));
padding_count = (Filter_size(1)-1)/2;
padding_img = zeros(Img_size(1)+(2*padding_count),Img_size(2)+(2*padding_count),Img_size(3));

% 通过赋值的方式对原始图片添加轮廓
for i = 1:Img_size(3)
    for j = 1:Img_size(1)
        for k = 1:Img_size(2)
            %在当前像素点添加所需的轮廓
            padding_img(j+padding_count,k+padding_count,i) = Img(j,k,i);
        end
    end
end

% 对卷积核进行翻转操作，首先以x轴为中心店进行翻转
filter_kernel_flip = flip(Filter);
% 以y的为中心进行翻转
filter_kernel_flip = flip(filter_kernel_flip,2);

% 实现卷积操作
for i = 1:Img_size(3)
    for j = 1:Img_size(1)
        for k = 1:Img_size(2)
            % 创建临时的卷积模板，用以与卷积核相乘的操作
            tmp = zeros(Filter_size(1));
            % 获取到当前像素点位置时，根据增加轮廓的大小，获取到当前卷积模板所对应原图的像素数据
            for l = 0:2*padding_count
                for m = 0:2*padding_count
                    % 将卷积核所对应的原图像素数据，放置到卷积模板当中
                    tmp(l+1,m+1) = padding_img(j+l,k+m,i);
                end
            end
            % 临时记录当前卷积核与原图像素数据，卷积的结果
            tmp_result = 0;
            for p = 1:Filter_size(1)
                for o = 1:Filter_size(1)
                    % 执行卷积操作（卷积核与原图对应像素点的均值求和）
                    tmp_result = tmp_result+(tmp(p,o)*filter_kernel_flip(p,o));
                end
            end
            % 保存卷积平滑后的结果
            result(j,k,i) = tmp_result;
        end
    end
end
end