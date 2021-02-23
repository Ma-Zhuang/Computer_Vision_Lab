calc = imread('img\calculator2_buttons.jpg');
calc_gary = rgb2gray(calc);
se1=strel('disk',4);
calc_gary_erode = imerode(calc_gary,se1);
calc_c = calc_gary-calc_gary_erode;
figure;
imhist(calc_c);

T = 140;
[height,width] = size(calc_c);
result = uint8(zeros(height,width));
for i = 1:height
    for j = 1:width
        if calc_c(i,j) < T
            result(i,j) = 255;
        end
    end
end
figure;
imshow(result);