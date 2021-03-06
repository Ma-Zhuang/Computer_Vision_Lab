function G = myGaussian(sigma,x,y)
    G = (exp((-(x^2+y^2)/(2*sigma^2))))/(2*pi*sigma^2);
end