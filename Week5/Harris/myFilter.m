function result = myFilter(Img,Filter)
    [height_filter,width_filter] = size(Filter);
    [height_img,width_img] = size(Img);
    result = zeros(height_img,width_img);
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
            tmp_result = 0;
            for k = 1:height_filter
                for l = 1:width_filter
                    tmp_result = tmp_result+(tmp(k,l)*Filter(k,l));
                end
            end
            result(i,j) = tmp_result;
            
        end
    end
    
end

