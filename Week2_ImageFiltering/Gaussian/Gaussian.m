%% 高斯函数
function G = Gaussian(sigma,x,y)

G = (exp((-(x^2+y^2)/(2*sigma^2))))/(2*pi*sigma^2);
end
