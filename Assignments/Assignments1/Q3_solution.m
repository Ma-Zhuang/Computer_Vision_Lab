img_d = imread('img\calculator2_buttons.jpg');
img_e = imread('img\calculator2_buttons.jpg');
thresh_img_d = graythresh(img_d);
thresh_img_e = graythresh(img_e);
img_bw_d = im2bw(img_d,thresh_img_d);
img_bw_e = im2bw(img_e,thresh_img_e);
kernel = [0,1,0;
          1,1,1;
          0,1,0];
result_d = myDilatation(img_bw_d,kernel);
result_e = myErosion(img_bw_e,kernel);

subplot(2,2,1)
imshow(img_d);
title("Original Image");
hold on;

subplot(2,2,2);
imshow(result_d);
title("Dilatetation Image");
hold on;

subplot(2,2,3)
imshow(img_e);
title("Original Image");
hold on;

subplot(2,2,4);
imshow(result_e);
title("Erosion Image");
