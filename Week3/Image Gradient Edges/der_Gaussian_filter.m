function [result_x, result_y, result_ori]= der_Gaussian_filter(Img,sigma,der)
    [height,width] = size(Img);
    kernel_size = (6*sigma)+1;
    kernel_center = (kernel_size+1)/2;
    kernel_x = zeros(kernel_size);
    kernel_y = zeros(kernel_size);
    result_x = zeros(height,width);
    result_y = zeros(height,width);
    result_ori = zeros(height,width);
    if der == 1
        for i = 1:kernel_size
            for j = 1: kernel_size
                [kernel_x(i,j),kernel_y(i,j)] = gaussian_1d(i-kernel_center,j-kernel_center,sigma);
            end
        end
    elseif der == 2
        for i = 1:kernel_size
            for j = 1: kernel_size
                [kernel_x(i,j),kernel_y(i,j)] = gaussian_2d(i-kernel_center,j-kernel_center,sigma);
            end
        end
    end
%     disp(sum(kernel_x(:)));
%     disp(sum(kernel_y(:)));
%     kernel_x = kernel_x/sum(kernel_x(:));
%     kernel_y = kernel_y/sum(kernel_y(:));
%     disp("--------------------------------------------");
% %     disp(kernel_x);
% %     disp(kernel_y);
    
    padding_num = (kernel_size-1)/2;
    padding = zeros(height+(padding_num*2),width+(padding_num*2));
    for i = 1:height
        for j = 1:width
            padding(i+padding_num,j+padding_num) = Img(i,j);
        end
    end
    
    for i = 1:height
        for j = 1:width
            tmp_x = zeros(kernel_size);
            tmp_y = zeros(kernel_size);
            
            for k = 0:2*padding_num
                for l = 0:2*padding_num
                    tmp_x(k+1,l+1) = padding(i+k,j+l);
                    tmp_y(k+1,l+1) = padding(i+k,j+l);
                end
            end
            tmp_result_x = 0;
            tmp_result_y = 0;
            for k = 1:kernel_size
                for l = 1:kernel_size
                    tmp_result_x = tmp_result_x + (tmp_x(k,l)*kernel_x(k,l));
                    tmp_result_y = tmp_result_y + (tmp_y(k,l)*kernel_y(k,l));
                end
            end
            result_x(i,j) = tmp_result_x;
            result_y(i,j) = tmp_result_y;
            result_ori(i,j) = (atan(tmp_result_y/tmp_result_x)*180)/pi;
        end
    end
end

