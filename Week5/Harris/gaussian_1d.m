function [gaussian_1d_x,gaussian_1d_y] = gaussian_1d(x,y,sigma)
    gaussian_1d_x = (-1/(2*pi*sigma^4))*x*exp((-(x^2+y^2))/(2*sigma^2));
    gaussian_1d_y = (-1/(2*pi*sigma^4))*y*exp((-(x^2+y^2))/(2*sigma^2));
end