function [img_edge_result,Derivative_direction] = canny(img,sigma,high,low) % h:0.27 l:0.09
    img_size = size(img);
    if length(img_size) == 3
        img_gary = rgb2gray(img);
    else
        img_gary = img;
    end
    
    [img_gary_x, img_gary_y, img_gary_ori] = der_Gaussian_filter(img_gary,sigma);
    img_gary_tmp_x = (img_gary_x/max(img_gary_x(:)));
    img_gary_tmp_y = (img_gary_y/max(img_gary_y(:)));
    img_gary_der = sqrt(img_gary_tmp_x.^2+img_gary_tmp_y.^2);
    
    [img_gary_nonMax,Direction] = Non_maximum_suppression(img_gary_der,img_gary_ori);
    
    img_edge_result = Hysteresis_Thresholding(img_gary_nonMax,high,low);
    
    Derivative_direction = zeros(img_size(1),img_size(2));
    
    for i = 1:img_size(1)
        for j = 1:img_size(2)
            if img_edge_result(i,j)~=0
                Derivative_direction(i,j) = Direction(i,j);
            end
        end
    end
    
end