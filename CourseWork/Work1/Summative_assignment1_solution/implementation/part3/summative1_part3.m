%% Cell Question 3
% cells.png and Ecoli.png are both needed
% Please run code one section at a time.
clear all 
close all 
clc
%% ALL CV and RV students. Q 3.1 to 3.3
clear all 
close all 
clc

%3.1 - Segmentation using the default OTSU method
Image = imread('cells.png');

figure()
imshow(Image)
title('Orignal image Cells')

%%%GAUSSIAN SMOOTHING OPTION
%sigma = 2; %sigma value in gaussian filter
%Image = imgaussfilt(Image,sigma); %apply Gaussaing smoothing to image
%%% Uncomment above two lines to perform gaussian smoothing
Image_gray = rgb2gray(Image); %getting the image into grayscale, since graythresh requires images in grayscale.
figure()
imshow(Image_gray)
title('Grayscale image Cells')

OTSU_Threshold = graythresh(Image_gray); %this calculates a threshold, using OTSU's method



Binary_Image_OTSU = imbinarize(Image_gray,OTSU_Threshold); % converts the image to a binary image using the threshold (i.e Above threshold OR below threshold)
figure()
imshow(Binary_Image_OTSU) %displaying the binary image
title('Binary Image of the Cells')


BW = edge(Binary_Image_OTSU) ; %returns a binary image BW containing 1s where the function finds edges in the input image I and 0s elsewhere. By default, edge uses the Sobel edge detection method.
figure()
imshow(BW)
title('Binary Edges of the Cells')


BWdfill = imfill(Binary_Image_OTSU, 'holes'); %filling holes of the binary image
figure, imshow(BWdfill); %displaying image
title('binary image with filled holes');



%% 3.2
%Superimpose labels on orignal image
labelBW = bwlabel(BW); %create labels of edges

figure()
imshow(Image)
hold on
himage = imshow(labelBW);
himage.AlphaData = 0.5;
title('Cell Labels Superimposed Transparently on Original Image')
hold off

% Cell outlines Overlay
figure() 
[B,L] = bwboundaries(BWdfill,'noholes');
imshow(label2rgb(L, @jet, [.5 .5 .5]))
%title('OTSU segementation of cells, two sigma Gaussian filter') 
title('OTSU segementation of cells, no filter') 
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

figure()
[B,L,N,A] = bwboundaries(BWdfill,'noholes');
imshow(BW); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];
title('OTSU segementation of cells')
for k=1:length(B),
  boundary = B{k};
  cidx = mod(k,length(colors))+1;
  plot(boundary(:,2), boundary(:,1),...
       colors(cidx),'LineWidth',2);

  %randomize text position for better visibility
  rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
  col = boundary(rndRow,2); row = boundary(rndRow,1);
  h = text(col+1, row-1, num2str(L(row,col)));
  set(h,'Color',colors(cidx),'FontSize',14,'FontWeight','bold');
end


%% 3.3 Cell analysis 
label = bwlabel(BWdfill); %returns the label matrix L that contains labels for the 8-connected objects found in BW- basically labels each 'cell' with a number
maximum = max(max(label)); %returns the maximum number of label, i.e the number of cells detected
NUMBER_OF_CELLS = maximum;


list1_number_of_cells = zeros(1,maximum); %list of the number of cells, each column represent a new cells, the value of each column is essentially the area of the cell in pixels
dimensions_of_image = size(label); %obtaining the number of rows and columns of the label matrix

nr = dimensions_of_image(1,1); %number of rows of the label matrix
nc = dimensions_of_image(1,2); %number of columns of the label matrix

%This counts the area of each region (cell)
for i=1:nr %number of rows
     for j=1:nc %number of columns
         if (label(i,j)) > 0 %if a region exsists
             list1_number_of_cells(1,(label(i,j)))=list1_number_of_cells(1,(label(i,j)))+1 ; %increment list in position of region number by 1, such to count a pixel belonging to a cell
         end
     end   
end

AREA_OF_EACH_CELL = list1_number_of_cells;
MEAN_AREA_OF_ALL_CELLS = mean(AREA_OF_EACH_CELL);
STD_AREA_OF_ALL_CELLS = std(AREA_OF_EACH_CELL);


% Brightness 
image_green_only = Image(:,:,2); %The intensity of the green plane of the RGB image
mean_intensity_green = regionprops(label,image_green_only,'MeanIntensity') ; %mean green intensity of all 'cells'
 

MEAN_BRIGHTNESS_OF_EACH_CELL = [mean_intensity_green.MeanIntensity]; %Creating a matrix that contains the mean intensity of green pixels of each cell
MEAN_BRIGHTNESS_OF_ALL_CELLS = mean(MEAN_BRIGHTNESS_OF_EACH_CELL);
STD_BRIGHTNESS_OF_ALL_CELLS = std(MEAN_BRIGHTNESS_OF_EACH_CELL);

figure()
plot(1:size(AREA_OF_EACH_CELL,2),AREA_OF_EACH_CELL,'o');
xlabel('Segmented Cell Number');
ylabel('Area / pixels');
title('Area of each cell, using raw OTSU')

figure()
plot(1:size(MEAN_BRIGHTNESS_OF_EACH_CELL,2),MEAN_BRIGHTNESS_OF_EACH_CELL,'o');
xlabel('Segmented Cell Number');
ylabel('Mean green Channel Intensity / Arbitary Units');
title('Mean brightness (green) of each cell, using raw OTSU')


figure()
plot(AREA_OF_EACH_CELL,MEAN_BRIGHTNESS_OF_EACH_CELL,'+')
xlabel('Area / pixels');
ylabel('Mean green Channel Intensity / Arbitary Units');


disp('For cells.png, using the default OTSU method yeilds the following about the GFPs:')
NUMBER_OF_CELLS
MEAN_AREA_OF_ALL_CELLS 
disp(' pixels and ')
MEAN_BRIGHTNESS_OF_ALL_CELLS 
disp(' units. ')

%bwarea(Binary_Image_OTSU); %calculates entire area of objects in a window
%% Masters CV and RV Students only. Q 3.4 - Ecoli
clear all
close all 
clc

% Segment the cells. 
% Read Image
Image = imread('Ecoli.png');

Image_RGB = imread('Ecoli.png');

figure()
imshow(Image)
title('Orignal image E Coli cells')

%Set Red and Blue components to zero. 
Image_G = Image(:,:,2);
Image(:,:,1) = 0;
Image(:,:,2) = Image_G;
Image(:,:,3) = 0;


figure()
imshow(Image)
title('Orignal image E Coli cells - Green Channel Only')

%%%GAUSSIAN SMOOTHING OPTION
%sigma = 2; %sigma value in gaussian filter
%Image = imgaussfilt(Image,sigma); %apply Gaussaing smoothing to image
%%% Uncomment above two lines to perform gaussian smoothing

Image_gray = rgb2gray(Image); 
figure()
imshow(Image_gray)
title('Grayscale image Ecoli Cells')

OTSU_Threshold = graythresh(Image_gray); %this calculates a threshold, using OTSU's method


Binary_Image_OTSU = imbinarize(Image_gray,OTSU_Threshold); % converts the image to a binary image using the threshold (i.e Above threshold OR below threshold)
figure()
imshow(Binary_Image_OTSU) %displaying the binary image
title('Binary Image Ecoli Cells')


BW = edge(Binary_Image_OTSU) ; %returns a binary image BW containing 1s where the function finds edges in the input image I and 0s elsewhere. By default, edge uses the Sobel edge detection method.
figure()
imshow(BW)
title('Binary Edges Ecoli Cells')

BWdfill = imfill(Binary_Image_OTSU, 'holes'); %filling holes of the binary image
figure, imshow(BWdfill); %displaying image
title('Binary image with filled holes');

%% Superimposing Image
labelBW = bwlabel(BW); %creating labels, which are the outlines of the segmentation

figure()
imshow(Image_RGB)
hold on
himage = imshow(labelBW);
himage.AlphaData = 0.5; %line thickness
title('Colored Labels Superimposed Transparently on Original Image')
hold off

%% Cell analysis Q 3.3

label = bwlabel(BWdfill); %returns the label matrix L that contains labels for the 8-connected objects found in BW- basically labels each 'cell' with a number
maximum = max(max(label)); %returns the maximum number of label, i.e the number of cells detected
NUMBER_OF_CELLS = maximum;

list1_number_of_cells = zeros(1,maximum); %list of the number of cells, each column represent a new cells, the value of each column is essentially the area of the cell in pixels
dimensions_of_image = size(label); %obtaining the number of rows and columns of the label matrix

nr = dimensions_of_image(1,1); %number of rows of the label matrix
nc = dimensions_of_image(1,2); %number of columns of the label matrix

%This counts the area of each region (cell)
for i=1:nr %number of rows
     for j=1:nc %number of columns
         if (label(i,j)) > 0 %if a region exsists
             list1_number_of_cells(1,(label(i,j)))=list1_number_of_cells(1,(label(i,j)))+1 ; %increment list in position of region number by 1, such to count a pixel belonging to a cell
         end
     end   
end

%cell stats
AREA_OF_EACH_CELL = list1_number_of_cells;
MEAN_AREA_OF_ALL_CELLS = mean(AREA_OF_EACH_CELL);
STD_AREA_OF_ALL_CELLS = std(AREA_OF_EACH_CELL);


% Brightness 
image_green_only = Image(:,:,2); %The intensity of the green plane of the RGB image
mean_intensity_green = regionprops(label,image_green_only,'MeanIntensity') ; %mean green intensity of all 220 'cells'
 

MEAN_BRIGHTNESS_OF_EACH_CELL = [mean_intensity_green.MeanIntensity]; %Creating a matrix that contains the mean intensity of green pixels of each cell
MEAN_BRIGHTNESS_OF_ALL_CELLS = mean(MEAN_BRIGHTNESS_OF_EACH_CELL);
STD_BRIGHTNESS_OF_ALL_CELLS = std(MEAN_BRIGHTNESS_OF_EACH_CELL);


figure()
plot(1:size(AREA_OF_EACH_CELL,2),AREA_OF_EACH_CELL,'o');
xlabel('Segmented Cell Number');
ylabel('Area / pixels');
title('Area of each cell, using raw OTSU')

figure()
plot(1:size(MEAN_BRIGHTNESS_OF_EACH_CELL,2),MEAN_BRIGHTNESS_OF_EACH_CELL,'o');
xlabel('Segmented Cell Number');
ylabel('Mean green Channel Intensity / Arbitary Units');
title('Mean brightness (green) of each cell, using raw OTSU')

disp('For Ecoli.png, using the default OTSU method yeilds the following about the GFPs:')
NUMBER_OF_CELLS
MEAN_AREA_OF_ALL_CELLS 
disp(' pixels and ')
MEAN_BRIGHTNESS_OF_ALL_CELLS 
disp(' units. ')

%bwarea(Binary_Image_OTSU); %calculates entire area of objects in a window
%% end. 

