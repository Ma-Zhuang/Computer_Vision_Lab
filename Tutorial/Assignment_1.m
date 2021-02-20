%% Question 1.1
% load image
desk_img = imread('Writing_desk.jpg');
figure;
%display image
imshow(desk_img);
%setting the title
title({'Color image of a desk','Question 1.1'});
pause(0.5);

%%Question 1.2
% extract rectangular image regions - all color channels
painting_img = desk_img(19:364,99:439,1:3);
figure;
imshow(painting_img);
title({'Color image of a painting','Question 1.2'});
pause(0.5);

vase_img = desk_img(271:487,508:632,1:3);
figure;
imshow(vase_img);
title({'Color image of a vase','Question 1.2'});
pause(0.5);

statuettes_img = desk_img(390:483,110:236,1:3);
figure;
imshow(statuettes_img);
title({'Color image of statuettes','Question 1.2'});


%% Question 1.3
%spearate color channels

statuettes_red_img = statuettes_img(:,:,1);
figure;
imshow(statuettes_red_img);
title({'Red channel of color imahe of statuettes','Question 1.3'});
pause(0.5);

statuettes_green_img = statuettes_img(:,:,2);
figure;
imshow(statuettes_red_img);
title({'Green channel of color imahe of statuettes','Question 1.3'});
pause(0.5);

statuettes_blue_img = statuettes_img(:,:,3);
figure;
imshow(statuettes_blue_img);
title({'Blue channel of color imahe of statuettes','Question 1.3'});
pause(0.5);

%% Question 1.4
% Combine the red, green and blue image channels
% display the greyscal image without and with a color map
statuettes_greyscale_img = uint8((uint16(statuettes_red_img) + uint16(statuettes_green_img) + uint16(statuettes_blue_img)) / 3);
figure;
imshow(statuettes_greyscale_img);
title({'Greyscale image of statuettes','Question 1.4'});
pause(0.5);

figure;
imshow(statuettes_greyscale_img);
colormap('jet');
title({'Greyscale image of statuettes with jet colourmap', '(Question 2.4)'});
pause(0.5);

figure;
imshow(statuettes_greyscale_img);
colormap('hsv');
title({'Greyscale image of statuettes with hsv colourmap', '(Question 2.4)'});
pause(0.5);

%% Question 2.5
% remap the colour channels
desk_remapped_img = uint8(zeros(1023,720,3));
desk_remapped_img(:,:,1) = desk_img(:,:,2);
desk_remapped_img(:,:,2) = desk_img(:,:,3);
desk_remapped_img(:,:,3) = desk_img(:,:,1);
figure;
imshow(desk_remapped_img);
title({'Colour image of a desk with remapped colour channels', '(Question 2.5)'});
pause(0.5);