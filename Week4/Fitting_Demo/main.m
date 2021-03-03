coin = imread('Test_img\coin2.PNG');
[img_edge,Derivative_direction] = canny(coin,1,1.35,0.45);
x = Hough_transform(img_edge,Derivative_direction,6,27);
imshow(img_edge);