I = imread('Test_img\lena.jpg');
lean = rgb2gray(I);
BW2 = edge(lean,'canny');
figure;
imshow(BW2);