tigger_gray = imread('Test_img\tigger.PNG');

kernel_x = [-1,0,1;-2,0,2;-1,0,1];

kernel_y = [1,2,1;0,0,0;-1,-2,-1];

[result_x,result_y] = myFilter(tigger_gray,kernel_x,kernel_y);

result_x = result_x/max(result_x(:));
result_y = result_y/max(result_y(:));

result = sqrt(result_x.^2+result_y.^2);

subplot(2,3,2);
imshow(tigger_gray);
title("Original Image");
hold on;

subplot(2,3,4);
imshow(result_x);
title("X方向导数");
hold on;

subplot(2,3,5);
imshow(result_y);
title("Y方向导数");
hold on;

subplot(2,3,6);
imshow(result);
title("Result");