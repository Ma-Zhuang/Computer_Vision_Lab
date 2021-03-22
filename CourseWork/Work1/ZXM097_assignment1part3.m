%% Question 3.1
clear; clc; close all;
cells_ori = imread('img\cells.PNG');
cells = cells_ori(:,:,2);%rgb2gray(cells_ori);
[m,n]=size(cells);
subplot(2,2,1);
imshow(cells_ori);
title("Original Image");
hold on;

cells_level = graythresh(cells);
BW_cells = imbinarize(cells,cells_level);
subplot(2,2,2);
imshow(BW_cells);
title("OTSU");
hold on;

m_cells=medfilt2(cells,[5,5]);
m_cells_level = graythresh(m_cells);
m_BW_cells = imbinarize(m_cells,m_cells_level);

se=strel('disk',5);
m_cells_filled=imclose(m_BW_cells,se);

subplot(2,2,3);
imshow(m_cells_filled);
title("OTSU(Median Filter and Open operating)");
hold on;

tmpImg = zeros(m,n,5);
for i = [3,5]
    segmentation_m_cells=medfilt2(cells,[i,i]);
    segmentation_m_cells_level = graythresh(segmentation_m_cells);
    segmentation_m_BW_cells = imbinarize(segmentation_m_cells,segmentation_m_cells_level);
    se=strel('disk',9);
    segmentation_m_cells_filled=imopen(segmentation_m_BW_cells,se);
    
    D=-bwdist(~segmentation_m_cells_filled);
    mask=imextendedmin(D,2);
    D2=imimposemin(D,mask);
    Ld=watershed(D2);
    Water_splited=segmentation_m_cells_filled;
    Water_splited(Ld==0)=0;
    tmpImg(:,:,i) = Water_splited;
end

segmentation_cells = zeros(size(cells,1),size(cells,2));
for i = 1:m
    for j = 1:n
        if tmpImg(i,j,3) == tmpImg(i,j,5) && tmpImg(i,j,5)==1
            segmentation_cells(i,j) = 1;
        end
    end
end
subplot(2,2,4);
imshow(segmentation_cells);
title("OTSU(Median Filter & Open operating & Segmentation cells)");

% figure;
% subplot(1,2,1);
% imshow(BW_cells);
% title("Default OTSU");
% subplot(1,2,2);
% imshow(segmentation_cells);
% title("Improve OTSU");

%% Question 3.2 Version 1
clear; clc; close all;
I_ori = imread('img\cells.png');
I = I_ori(:,:,2);

img = medfilt2(I,[3,3]);
th = graythresh(img);
img(img<=floor(th*255)) = floor(th*255);
th1 = graythresh(img);
img(img<=floor(th1*255)) = floor(th1*255);
img = imadjust(img);

BW2 = edge(img,'canny');

se90 = strel('line',9,90);
se0 = strel('line',9,0);
BWsdil = imdilate(BW2,[se90 se0]);
conn = double(ones(3,3));
BWdfill = imfill(BWsdil,conn,'holes');
BWnobord = imclearborder(BWdfill,1);

seD = strel('diamond',3);
BWfinal = imdilate(BWnobord,seD);
BWfinal = imdilate(BWfinal,seD);

D=-bwdist(~BWfinal);
mask=imextendedmin(D,2);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=BWfinal;
Water_splited(Ld==0)=0;
BWoutline = bwperim(Water_splited);
se = strel('disk',1);
BWoutline = imdilate(BWoutline,se);
Segout = I_ori;
Segout(BWoutline) = 255; 

imshow(Segout);


%% Question 3.2 Version 2
clear; clc; close all;
I_ori = imread('img\cells.png');
I = I_ori(:,:,2);
K = (1/81)*ones(9);
Zsmooth1 = uint8(conv2(I,K,'same'));

th = graythresh(Zsmooth1);
img = uint8(Zsmooth1 - (th*255));

BW2 = edge(img,'canny');

se90 = strel('line',4,90);
se0 = strel('line',4,0);
BWsdil = imdilate(BW2,[se90 se0]);

BWdfill = imfill(BWsdil,'holes');

BWnobord = imclearborder(BWdfill,1);

se1=strel('disk',5);
BWnobord=imopen(BWnobord,se1);

seD = strel('disk',3);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);

D=-bwdist(~BWfinal);
mask=imextendedmin(D,4);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=BWfinal;
Water_splited(Ld==0)=0;



BWoutline = bwperim(Water_splited);
se = strel('disk',2);
BWoutline = imdilate(BWoutline,se);
Segout = I_ori; 
Segout(BWoutline) = 255; 

imshow(Segout);


%% Question 3.3.1
% clear; clc; close all;
% cells_ori = imread('img\cells.png');
% cells_green = rgb2gray(cells_ori);%cells_ori(:,:,2);
% cells_green_level = graythresh(cells_green);
% BW_green_cells = imbinarize(cells_green,cells_green_level);
% allArea_noFilter = regionprops(BW_green_cells, 'Area');
% [number_cells,~] = size(allArea_noFilter);
% allArea_filter = [];
% for i = 1:number_cells
%     if allArea_noFilter(i).Area >=200
%         allArea_filter = [allArea_filter allArea_noFilter(i).Area];
%     end
% end
% save('output\each_cells_area.mat','allArea_filter');

clear; clc; close all;
cells_ori = imread('img\cells.png');
cells_green = rgb2gray(cells_ori);%cells_ori(:,:,2);
cells_green_level = graythresh(cells_green);
BW_green_cells = imbinarize(cells_green,cells_green_level);
allArea_noFilter = regionprops(BW_green_cells, 'Area');
[number_cells,~] = size(allArea_noFilter);
allArea_filter = [];
for i = 1:number_cells
    allArea_filter = [allArea_filter allArea_noFilter(i).Area];
end
save('output\each_cells_area.mat','allArea_filter');

%% Question 3.3.2 
clear; clc; close all;
cells_ori = imread('img\cells.png');
cells_green_channel = cells_ori(:,:,2);
cells_green = rgb2gray(cells_ori);
cells_green_level = graythresh(cells_green);
BW_green_cells = imbinarize(cells_green,cells_green_level);
cells_BoundingBox = regionprops(BW_green_cells, 'PixelList');

[number_cells,~] = size(cells_BoundingBox);
each_brightness_mean = [];
for i = 1:number_cells
    tmpCood = cells_BoundingBox(i).PixelList;
    tmp_green_value = [];
    for j = 1:size(tmpCood,1)
        x = tmpCood(j,1);
        y = tmpCood(j,2);
        tmp_green_value = [tmp_green_value cells_green_channel(y,x)];
    end
    each_brightness_mean = [each_brightness_mean mean(tmp_green_value)];
end
save('output\each_brightness_mean.mat','each_brightness_mean');

% clear; clc; close all;
% cells_ori = imread('img\cells.png');
% cells_green = cells_ori(:,:,2);%rgb2gray(cells_ori); %cells_ori(:,:,2);
% cells_green_level = graythresh(cells_green);
% BW_green_cells = imbinarize(cells_green,cells_green_level);
% cells_BoundingBox = regionprops(BW_green_cells, 'BoundingBox');
% noise_index = [];
% allArea_noFilter = regionprops(BW_green_cells, 'Area');
% [number_cells,~] = size(allArea_noFilter);
% for i = 1:number_cells
%     if allArea_noFilter(i).Area >=200
%         noise_index = [noise_index i];
%     end
% end
% % [height,width] = size(cells_green_channel);
% each_brightness_mean = [];
% imshow(cells_green);
% hold on;
% for i = noise_index
%     ox = uint16(cells_BoundingBox(i).BoundingBox(1));
%     oy = uint16(cells_BoundingBox(i).BoundingBox(2));
%     x = uint16(cells_BoundingBox(i).BoundingBox(3));
%     y = uint16(cells_BoundingBox(i).BoundingBox(4));
%     
%     rectangle('Position', cells_BoundingBox(i).BoundingBox,...
% 	'EdgeColor','r', 'LineWidth', 3)
%     tmp_green_value = [];
%     for j = 0:y-1
%         for k = 0:x-1
%             if cells_green(oy+j,ox+k)~=0
%                 tmp_green_value = [tmp_green_value cells_green(oy+j,ox+k)];
%             end
%         end
%     end
%     each_brightness_mean = [each_brightness_mean mean(tmp_green_value)];
% end
% save('output\each_brightness_mean.mat','each_brightness_mean');


% imshow(cells_ori);
% [height,width] = size(cells_green_channel);
% each_brightness_mean = [];
% imshow(cells_green);
% hold on;
% for i = noise_index
%     ox = uint16(cells_BoundingBox(i).BoundingBox(1));
%     oy = uint16(cells_BoundingBox(i).BoundingBox(2));
%     x = uint16(cells_BoundingBox(i).BoundingBox(3));
%     y = uint16(cells_BoundingBox(i).BoundingBox(4));
%     
%     rectangle('Position', cells_BoundingBox(i).BoundingBox,...
% 	'EdgeColor','r', 'LineWidth', 3)
%     tmp_green_value = [];
%     for j = 0:y-1
%         for k = 0:x-1
%             if cells_green(oy+j,ox+k)~=0
%                 tmp_green_value = [tmp_green_value cells_green(oy+j,ox+k)];
%             end
%         end
%     end
%     each_brightness_mean = [each_brightness_mean mean(tmp_green_value)];
% end
% save('output\each_brightness_mean.mat','each_brightness_mean');


%% Question 3.3.3
clear; clc; close all;
allArea = load('output\each_cells_area.mat');
allBrightness = load('output\each_brightness_mean.mat');


allArea = allArea.allArea_filter;
allBrightness = allBrightness.each_brightness_mean;


mean_allArea = mean(allArea);
mean_allBrightness = mean(allBrightness);
save('output\mean_area_brightness.mat','mean_allArea','mean_allBrightness');
std_allArea = std(allArea);
std_allBrightness = std(allBrightness);%sqrt(var(allBrightness)*size(allBrightness,2));
save('output\std_area_brightness.mat','std_allArea','std_allBrightness');

%%


%% Question 3.4.1
clear; clc; close all;
cells_ori = imread('img\Ecoli.png');
cells = cells_ori(:,:,2)*2;
subplot(2,2,1);
imshow(cells_ori);
title("Original Image");
hold on;

cells_level = graythresh(cells);
BW_cells = imbinarize(cells,cells_level);

subplot(2,2,2);
imshow(BW_cells);
title("OTSU");
hold on;

m_cells=medfilt2(cells,[3,3]);

m_cells_level = graythresh(m_cells);
m_BW_cells = imbinarize(m_cells,m_cells_level);

se=strel('disk',3);
m_cells_filled=imclose(m_BW_cells,se);
subplot(2,2,3);
imshow(m_cells_filled);
title("OTSU(Median Filter and Open operating)");
hold on;

D=-bwdist(~m_cells_filled);
mask=imextendedmin(D,2);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=m_cells_filled;
Water_splited(Ld==0)=0;

subplot(2,2,4);
imshow(Water_splited);
title("OTSU(Median Filter & Open operating & Segmentation cells)");

%% Question 3.4.2
clear; clc; close all;
I_ori = imread('img\Ecoli.png');
img = I_ori(:,:,2)*5;

th = graythresh(img);
img(img<=floor(th*255)) = floor(th*255);
th1 = graythresh(img);
img(img<=floor(th1*255)) = floor(th1*255);

BW2 = edge(img,'canny');

se90 = strel('line',1,90);
se0 = strel('line',1,0);
BWsdil = imdilate(BW2,[se90 se0]);
% conn = double(ones(3,3));
BWdfill = imfill(BWsdil,'holes');
BWnobord = imclearborder(BWdfill,1);
% 
D=-bwdist(~BWnobord);
mask=imextendedmin(D,1);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=BWnobord;
Water_splited(Ld==0)=0;
BWoutline = bwperim(Water_splited);
Segout = I_ori;
Segout(BWoutline) = 255; 

imshow(Segout);

%% Question 4.3.3.1
clear; clc; close all;
cells_ori = imread('img\Ecoli.png');
cells_green = cells_ori(:,:,2);
cells_green_level = graythresh(cells_green);
BW_green_cells = imbinarize(cells_green,cells_green_level);
allArea_noFilter = regionprops(BW_green_cells, 'Area');
[number_cells,~] = size(allArea_noFilter);
allArea_filter = [];
for i = 1:number_cells
        allArea_filter = [allArea_filter allArea_noFilter(i).Area];
end
save('output\Ecoli_each_cells_area.mat','allArea_filter');

%% Question 4.3.3.2 

clear; clc; close all;
cells_ori = imread('img\Ecoli.png');
cells_green = cells_ori(:,:,2);
cells_green_level = graythresh(cells_green);
BW_green_cells = imbinarize(cells_green,cells_green_level);
cells_BoundingBox = regionprops(BW_green_cells, 'PixelList');

allArea_noFilter = regionprops(BW_green_cells, 'Area');
[number_cells,~] = size(allArea_noFilter);
each_brightness_mean = [];
for i = 1:number_cells
    tmpCood = cells_BoundingBox(i).PixelList;
    tmp_green_value = [];
    for j = 1:size(tmpCood,1)
        x = tmpCood(j,1);
        y = tmpCood(j,2);
        tmp_green_value = [tmp_green_value cells_green(y,x)];
    end
    each_brightness_mean = [each_brightness_mean mean(tmp_green_value)];
end
save('output\each_brightness_mean.mat','each_brightness_mean');


%% Question 4.3.3.3
clear; clc; close all;
allArea = load('output\Ecoli_each_cells_area.mat');
allBrightness = load('output\Ecoli_each_brightness_mean.mat');


allArea = allArea.allArea_filter;
allBrightness = allBrightness.each_brightness_mean;


mean_allArea = mean(allArea);
mean_allBrightness = mean(allBrightness);
save('output\Ecoli_mean_area_brightness.mat','mean_allArea','mean_allBrightness');
std_allArea = std(allArea);
std_allBrightness = std(allBrightness);
save('output\Ecoli_std_area_brightness.mat','std_allArea','std_allBrightness');