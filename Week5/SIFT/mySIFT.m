function result = mySIFT(img_gary,number_scale,sigma)
    K = 2^(1/number_scale);
    K_sigma = zeros(1,(number_scale+3));
    for i = 0:size(K_sigma,2)
        K_sigma(1,i+1) = K^i*sigma;
    end
    sigma = zeros(1,(number_scale+3));
    for i = 1:size(K_sigma,2)
        if i-1==0
            sigma(1,i) = K_sigma(1,i);
        else
            sigma(1,i) = round(sqrt((K_sigma(1,i))^2-(K_sigma(1,i-1))^2));
        end
    end
    
    for i = 1:size(sigma,2)-3
        kernel = Gaussian_kernel(sigma(i));
        
    result = sigma;
end

