function result = myFilter(Img,Filter,kernel_type)
    [height_filter,width_filter] = size(Filter);
    [height_img,width_img] = size(Img);
    result = uint8(zeros(height_img,width_img));
    padding_count = (height_filter-1)/2;
    padding_img = zeros(height_img+(2*padding_count),width_img+(2*padding_count));
    
    
    for i=1:height_img
        for j = 1:width_img
            padding_img(i+padding_count,j+padding_count) = Img(i,j);
        end
    end
    
    for i = 1:height_img
        for j = 1:width_img
            tmp = zeros(width_filter);
            
            for k = 0:2*padding_count
                for l = 0:2*padding_count
                    tmp(k+1,l+1) = padding_img(i+k,j+l);
                end
            end
            if kernel_type == "min"
                result(i,j) = min(min(tmp));
            elseif kernel_type == "max"
                result(i,j) = max(max(tmp));
            elseif kernel_type == "mean"
                result(i,j) = mean(mean(tmp));
            elseif kernel_type=="med"
                result(i,j) = median(median(tmp));
            end
        end
    end
end
