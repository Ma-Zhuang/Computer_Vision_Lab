function result = myDilatation(Img,Kernel)
[img_height,img_width] = size(Img);
result = zeros(img_height,img_width);
[kernel_hight,kernel_width] = size(Kernel);
padding_num = (kernel_hight-1)/2;
padding_img = zeros(img_height+(2*padding_num),img_width+(2*padding_num));
for i = 1:img_height
    for j = 1:img_width
        padding_img(i+padding_num,j+padding_num) = Img(i,j);
    end
end

for i = 1:img_height
    for j = 1:img_width
        tmp = zeros(kernel_width);
        for l = 0:(2*padding_num)
            for m = 0:(2*padding_num)
                tmp(l+1,m+1) = padding_img(i+l,j+m);
            end
        end
        tmp_matrix = zeros(kernel_hight,kernel_width);
        for l = 1:kernel_hight
            for m = 1:kernel_width
                tmp_matrix(l,m) = tmp(l,m) * Kernel(l,m);
            end
        end
        tmp_array = tmp_matrix(:);
        tmp_max = max(tmp_array);
        result(i,j) = tmp_max;
    end
end
        
end