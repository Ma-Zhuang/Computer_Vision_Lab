img_1 = imread('Test_img\1.PNG');
img_1_gary = rgb2gray(img_1);
img_1 = myHarris(img_1,img_1_gary,2,2500,0.06);

img_2 = imread('Test_img\2.PNG');
img_2_gary = rgb2gray(img_2);
img_2 = myHarris(img_2,img_2_gary,2,2500,0.06);
subplot(1,2,1);
imshow(img_1);
hold on;

subplot(1,2,2);
imshow(img_2);