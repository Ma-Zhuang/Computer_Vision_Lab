function [gaussian_2d_x,gaussian_2d_y] = gaussian_2d(x,y,sigma)
    gaussian_2d_x = (-1/(2*pi*sigma^4))*(1-((x^2)/(sigma^2)))*exp((-(x^2+y^2))/(2*sigma^2));
    gaussian_2d_y = (-1/(2*pi*sigma^4))*(1-((y^2)/(sigma^2)))*exp((-(x^2+y^2))/(2*sigma^2));
end

