function gaussian = myGaussianFunction(x,y,sigma)
    gaussian = (1/(2*pi*sigma^2))*exp((-(x^2+y^2))/(2*sigma^2));
end