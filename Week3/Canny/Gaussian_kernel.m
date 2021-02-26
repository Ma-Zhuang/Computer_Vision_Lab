%% 高斯核
function kernel = Gaussian_kernel(sigma)

kernel_size = (6*sigma) + 1;

kernel = zeros(kernel_size);
kernel_center = (kernel_size+1)/2;
kernel_totle = 0;
for i = 1:kernel_size
    for j = 1:kernel_size
        kernel(i,j) = myGaussianFunction(i-kernel_center,j-kernel_center,sigma);
        kernel_totle = kernel_totle + kernel(i,j);
    end
end
for i = 1:kernel_size
    for j = 1:kernel_size
        kernel(i,j) = kernel(i,j)/kernel_totle;
    end
end
end