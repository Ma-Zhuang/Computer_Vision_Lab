pizza = imread('img\pizza.jpg');
circle = imread('img\circle.jpg');
pizza_c = ContrastAdjust(pizza,90);

[m,n] = size(circle);
[X,Y] = meshgrid(1:n,1:m);
R_tmp = sqrt((X-307).^2+(Y-215).^2);
R_tmp1 = R_tmp<=400;
IMG_out = R_tmp1.*im2double(circle);
for i = 1:m
    for j = 1:n
        if IMG_out(i,j) > 0
            IMG_out(i,j) = 255;
        else
            IMG_out(i,j) = 0;
        end
    end
end
out_circle = uint8(IMG_out) - circle;
circle_r = imresize(out_circle,[950,1200]);
imshow(out_circle);
% [m,n,~] = size(pizza_c);
% [X,Y] = meshgrid(1:n,1:m);
% R_tmp = sqrt((X-600).^2+(Y-441).^2);
% R_tmp1 = R_tmp<=175;
% R_out = R_tmp1.*im2double(pizza_c(:,:,1));
% G_out = R_tmp1.*im2double(pizza_c(:,:,2));
% B_out = R_tmp1.*im2double(pizza_c(:,:,3));
% IMG_p_out(:,:,1) = R_out;
% IMG_p_out(:,:,2) = G_out;
% IMG_p_out(:,:,3) = B_out;
% imshow(IMG_p_out+im2double(circle_r));