%% original image,gray image,sigma, number of harris,K
function result = myHarris(img,img_gary,sigma,Harris_Number,K)
    [height_img,width_img] = size(img_gary);
    [img_x, img_y, img_ori]= der_Gaussian_filter(img_gary,1);
    gaussian_kernel = Gaussian_kernel(sigma);
    I_x2 = img_x.^2;
    I_y2 = img_y.^2;
    I_xy = img_x.*img_y;

    I_x2 = myFilter(I_x2,gaussian_kernel);
    I_y2 = myFilter(I_y2,gaussian_kernel);
    I_xy = myFilter(I_xy,gaussian_kernel);
    
    R = zeros(height_img,width_img);
    
    for i = 1:height_img
        for j = 1:width_img
            M = [I_x2(i,j),I_xy(i,j);I_xy(i,j),I_y2(i,j)];
            R(i,j) = det(M)-(K*trace(M)^2);
        end
    end
    
    array_R = reshape(R,(height_img*width_img),1);
    
    sort_R = sort(array_R,'descend');
    
    for i = 1:height_img
        for j = 1:width_img
            if Harris_Number>(height_img*width_img)
                Harris_Number = height_img*width_img;
            end
            if R(i,j) <= sort_R(Harris_Number)
                R(i,j) = 0;
            end
        end
    end
    
    R = Non_maximum_suppression(R,img_ori);
    
    for i = 1:height_img
        for j = 1:width_img
            if R(i,j)~=0
                img(i,j,1)= 255;
                img(i,j,2)=0;
                img(i,j,3)=0;
            end
        end
    end
    result = img;
end

