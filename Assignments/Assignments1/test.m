% % % % f=imread('img\cells.png');                                   % 读入图像
% % % % bw=im2bw(f,graythresh(f));                                 % 转换为黑白二值图像
% % % % bwc=~bw;                                                % 图像反色
% % % % dst=bwdist(bwc);                                          % 图像距离
% % % % ws=watershed(-dst);
% % % % w=ws==0;
% % % % rf=bw&~w;
% % % % figure,imshow(f);                                        % 显示原始图像
% % % % title('Original Image');                                    % 设置图像标题
% % % % figure,imshow(bw);                                      % 显示处理后的图像
% % % % title('Negative Image');                                   % 设置图像标题
% % % % figure,imshow(ws);                                       % 显示处理后的图像
% % % % title('Watershed - Distance Transform');                     % 设置图像标题
% % % % figure,imshow(rf);                                        % 显示处理后的图像
% % % % title('Superimposed - Watershed and original image');         % 设置图像标题
% % % % h=fspecial('sobel');                                       % 设置滤波器
% % % % fd=im2double(f);                                         % 数据类型转换
% % % % sq=sqrt(imfilter(fd,h,'replicate').^2+imfilter(fd,h','replicate').^2);  % 分水岭距离变换
% % % % sqoc=imclose(imopen(sq,ones(3,3)),ones(3,3));               % 图像闭合运算
% % % % wsd=watershed(sqoc);
% % % % wg=wsd==0;
% % % % rfg=f;
% % % % rfg(wg)=255;
% % % % figure,imshow(wsd);                                        % 显示处理后的图像
% % % % title('Watershed - Gradient');                                 % 设置图像标题
% % % % figure,imshow(rf);                                           % 显示处理后的图像
% % % % title('Superimposed - Watershed and original image');           % 设置图像标题
% % % % im=imextendedmin(f,20);
% % % % Lim=watershed(bwdist(im));
% % % % figure,imshow(Lim);                                        % 显示处理后的图像
% % % % title('Watershed - Marker Controlled');                         % 设置图像标题
% % % % em=Lim==0;
% % % % rfmin=imimposemin(sq,im|em);
% % % % wsdmin=watershed(rfmin);
% % % % figure,imshow(rfmin);                                      % 显示处理后的图像
% % % % title('Watershed - Gradient and Marker Controlled');            % 设置图像标题
% % % % rfgm=f;
% % % % rfgm(wsdmin==0)=255;
% % % % figure,imshow(rfgm);                                       % 显示处理后的图像
% % % % title('Superimposed - Watershed (GM) and original image'); % 设置图像标题
% % %
% % %
% % % %%
% % %
% % % clc
% % % clear
% % % warning off
% % % he = imread('img\cells.png');
% % % figure,imshow(he), title('H&E image');
% % % text(size(he,2),size(he,1)+15,...
% % %      'Image courtesy of Alan Partin, Johns Hopkins University', ...
% % %      'FontSize',7,'HorizontalAlignment','right');
% % %  cform = makecform('srgb2lab');
% % % lab_he = applycform(he,cform);
% % % ab = double(lab_he(:,:,2:3));
% % % nrows = size(ab,1);
% % % ncols = size(ab,2);
% % % ab = reshape(ab,nrows*ncols,2);
% % %
% % % nColors = 3;
% % % % repeat the clustering 3 times to avoid local minima
% % % [cluster_idx cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
% % %                                       'Replicates',3);
% % %
% % %                                   pixel_labels = reshape(cluster_idx,nrows,ncols);
% % % figure,imshow(pixel_labels,[]), title('image labeled by cluster index');
% % %
% % % segmented_images = cell(1,3);
% % % rgb_label = repmat(pixel_labels,[1 1 3]);
% % %
% % % for k = 1:nColors
% % %     color = he;
% % %     color(rgb_label ~= k) = 0;
% % %     segmented_images{k} = color;
% % % end
% % % figure,imshow(segmented_images{1}), title('objects in cluster 1');
% % % figure,imshow(segmented_images{2}), title('objects in cluster 2');
% % %
% % % figure,imshow(segmented_images{3}), title('objects in cluster 3');
% % % mean_cluster_val = zeros(3,1);
% % % for k = 1:nColors
% % %     mean_cluster_val(k) = mean(cluster_center(k));
% % % end
% % % [mean_cluster_val,idx] = sort(mean_cluster_val);
% % % blue_cluster_num = idx(2);
% % %
% % % L = lab_he(:,:,1);
% % % blue_idx = find(pixel_labels == blue_cluster_num);
% % % L_blue = L(blue_idx);
% % % is_light_blue = im2bw(L_blue,graythresh(L_blue));
% % %
% % % nuclei_labels = repmat(uint8(0),[nrows ncols]);
% % % nuclei_labels(blue_idx(is_light_blue==false)) = 1;
% % % nuclei_labels = repmat(nuclei_labels,[1 1 3]);
% % % blue_nuclei = he;
% % % blue_nuclei(nuclei_labels ~= 1) = 0;
% % % figure,imshow(blue_nuclei), title('blue nuclei');
% %
% %
% % %%
% % clear; clc;
% % % 读取图片rice.png
% % I=imread('rice.png');
% %
% % % 获取图片的背景
% % BG=imopen(I,strel('disk',15));
% %
% % %得到背景均匀的图片
% % I2=imsubtract(I,BG);
% %
% % %得到二值化的图片
% % level=graythresh(I2);
% % BW=im2bw(I2,level);
% %
% % % labeled是处理后的矩阵，numObjects是米粒的个数；
% % [labeled,numObjects]=bwlabel(BW,8);
% % imshow(labeled);
% % % 取一个空矩阵A，用来存放每个米粒占用的像素点数目；
% % [m,n]=size(labeled);
% % A=zeros(numObjects,1);
% %
% % % 该循环用来统计每个米粒的大小，例如，第 i 个米粒的大小，储存在A(i)中；
% %
% % for x=1:numObjects
% % for i=1:m
% % for j=1:n
% % if labeled(i,j)==x
% % A(x)=A(x)+1;
% % end
% % end
% % end
% % end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
%% 3.1 Final Version

cells_ori = imread('img\cells.png');
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
m_cells_filled=imopen(m_BW_cells,se);

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

%% Best result 1
I_ori = imread('img\cells.png');
I = I_ori(:,:,2);%rgb2gray(I_ori);
K = (1/81)*ones(9);
Zsmooth1 = uint8(conv2(I,K,'same'));
% Zsmooth1 = medfilt2(Zsmooth1,[11,11]);
% Zsmooth1 = imgaussfilt(I,3);
th = graythresh(Zsmooth1);
img = uint8(Zsmooth1 - (th*255));
% th = mean(mean(Zsmooth1));
% Zsmooth1(Zsmooth1>35)=100;

BW2 = edge(img,'canny');
se90 = strel('line',5,90);
se0 = strel('line',5,0);
BWsdil = imdilate(BW2,[se90 se0]);
BWdfill = imfill(BWsdil,'holes');
BWnobord = imclearborder(BWdfill,1);
se1=strel('disk',13);
BWnobord=imopen(BWnobord,se1);
seD = strel('diamond',3);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
% se=strel('disk',3);
% m_cells_filled=imopen(BWfinal,se);
D=-bwdist(~BWfinal);
mask=imextendedmin(D,1);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=BWfinal;
Water_splited(Ld==0)=0;
BWoutline = bwperim(Water_splited);
Segout = I_ori; 
Segout(BWoutline) = 255; 
% imshow(uint8(Zsmooth1));
imshow(Segout);







































%% 
I_ori = imread('img\cells.png');
I = rgb2gray(I_ori);
% Zsmooth1 = imgaussfilt(I,7);
K = (1/121)*ones(13);
Zsmooth1 = conv2(I,K,'same');
% Zsmooth1 = medfilt2(Zsmooth1,[11,11]);
% Zsmooth1 = imgaussfilt(I,3);
% img = uint8(Zsmooth1 - 21);
% th = mean(mean(Zsmooth1));
% Zsmooth1(Zsmooth1>35)=100;
% m_cells=medfilt2(I,[5,5]);
% m_cells_level = graythresh(m_cells);
% m_BW_cells = imbinarize(m_cells,m_cells_level);
% 
% se=strel('disk',5);
% BW_cells=imclose(m_BW_cells,se);
Zsmooth1(Zsmooth1<28)=0; 

BW2 = edge(Zsmooth1,'canny');

se90 = strel('line',4,90);
se0 = strel('line',4,0);
BWsdil = imdilate(BW2,[se0,se90]);
% % % seBW = strel('disk',6);
% % % BWsdil = imdilate(BW2,seBW);
BWdfill = imfill(BWsdil,'holes');
% BWnobord = imclearborder(BWdfill,1);
% seD = strel('square',3);
% BWfinal = imerode(BWnobord,seD);
% BWfinal = imerode(BWfinal,seD);
% D=-bwdist(~BWfinal);
% mask=imextendedmin(D,1);
% D2=imimposemin(D,mask);
% Ld=watershed(D2);
% Water_splited=m_cells_filled;
% Water_splited(Ld==0)=0;
% BWoutline = bwperim(Water_splited);
% Segout = I_ori; 
% Segout(BWoutline) = 255; 
% % imshow(uint8(Zsmooth1));
imshow(BWdfill);
% figure;
% imhist(I);







%%
I_ori = imread('img\cells.png');
I = rgb2gray(I_ori);
I_adjust = imadjust(I);
med = medfilt2(I_adjust,[11,11]);
med(med<110) = 0;
% tmp = [];
% for i = 1:size(med,1)
%     for j = 1:size(med,2)
%         if med(i,j)~=0
% %             disp(med(i,j));
%             tmp = [tmp med(i,j)];
%         end
%     end
% end
% canny_I = edge(I_adjust,'canny');
% m_cells_level = graythresh(I_adjust);
% m_BW_cells = imbinarize(m_cells,m_cells_level);
% K = (1/9)*ones(3);
% med_I = conv2(I,K,'same');
% g_I = imgaussfilt(I_adjust,5);
% med_I = med_I*0.01;
% canny_I = edge(g_I,'canny');
% m_cells_level = graythresh(I_adjust);
% m_BW_cells = imbinarize(I_adjust,m_cells_level);
% D=-bwdist(~m_BW_cells);
% mask=imextendedmin(D,2);
% D2=imimposemin(D,mask);
% Ld=watershed(D2);
% Water_splited=m_BW_cells;
% Water_splited(Ld==0)=0;
imshow(med);



%% 
I_ori = imread('img\cells.png');
I = rgb2gray(I_ori);
I_adjust = imadjust(I);
th = graythresh(I_adjust);
I_adjust = I_adjust/255;
I_adjust(I_adjust<th) = th;
% th1 = graythresh(I_adjust);
% I_adjust(I_adjust<th) = th1;
% % figure;
% % imhist(I_adjust);
% 
% % [height,width] = size(I_adjust);
% % for i = 1:height
% %     for j = 1:width
% %         if I_adjust(i,j)<=110
% %             I_adjust(i,j) = 0;
% %         end
% %     end
% % end
% I_adjust(I_adjust<110)=110;
% % figure;
% % imhist(I_adjust);
% I_adjust(I_adjust<116)=116;
% 
% g_I = imgaussfilt(I_adjust,4);
canny_I = edge(I_adjust,'canny');
se90 = strel('line',6,90);
se0 = strel('line',6,0);
BWsdil = imdilate(canny_I,[se90 se0]);
BWdfill = imfill(BWsdil,'holes');
BWnobord = imclearborder(BWdfill,1);
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
% se=strel('diamond',3);
% m_cells_filled=imopen(BWfinal,se);
D=-bwdist(~BWfinal);
mask=imextendedmin(D,1);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=BWfinal;
Water_splited(Ld==0)=0;
BWoutline = bwperim(Water_splited);
Segout = I_ori; 
Segout(BWoutline) = 255; 
% imshow(uint8(Zsmooth1));
imshow(Segout);



%% Kmeans

RGB = imread('img\cells.png');
RGB = imresize(RGB,0.5);
RGB = imgaussfilt(RGB,4);
L = imsegkmeans(RGB,2);
B = labeloverlay(RGB,L);
% B = rgb2gray(B);
B(B<1) = 0;
imshow(B);
% title('Labeled Image')
% 
% wavelength = 2.^(0:5) * 3;
% orientation = 0:45:135;
% g = gabor(wavelength,orientation);
% 
% I = rgb2gray(im2single(RGB));
% gabormag = imgaborfilt(I,g);
% montage(gabormag,'Size',[4 6])
% 
% for i = 1:length(g)
%     sigma = 0.5*g(i).Wavelength;
%     gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),3*sigma); 
% end
% montage(gabormag,'Size',[4 6])
% 
% nrows = size(RGB,1);
% ncols = size(RGB,2);
% [X,Y] = meshgrid(1:ncols,1:nrows);
% 
% featureSet = cat(3,I,gabormag,X,Y);
% 
% L2 = imsegkmeans(featureSet,2,'NormalizeInput',true);
% C = labeloverlay(RGB,L2);
% imshow(C)
% title('Labeled Image with Additional Pixel Information')

%%

cells_ori = imread('img\cells.png');
cells = rgb2gray(cells_ori);
cells_level = graythresh(cells);
BW_cells = imbinarize(cells,cells_level);
se=strel('disk',5);
m_cells_filled=imclose(BW_cells,se);
out = edge(m_cells_filled,'canny');
se90 = strel('line',6,90);
se0 = strel('line',6,0);
BWsdil = imdilate(out,[se90 se0]);
BWdfill = imfill(BWsdil,'holes');
BWnobord = imclearborder(BWdfill,1);
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
% se=strel('diamond',3);
% m_cells_filled=imopen(BWfinal,se);
D=-bwdist(~BWfinal);
mask=imextendedmin(D,1);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=BWfinal;
Water_splited(Ld==0)=0;
imshow(Water_splited);

%% 

I_ori = imread('img\cells.png');
img = rgb2gray(I_ori);
% K = (1/121)*ones(11);
% img = uint8(conv2(I,K,'same'));
% % Zsmooth1 = medfilt2(I,[8,8]);
th = graythresh(img);
img(img >= (th*255)) = (th*255)*20;
% mini = min(min(img));
% img(img >= mini & img <=34) = 255;
img = medfilt2(img,[5,5]);
BW2 = edge(img,'canny');
% BW2 = medfilt2(BW2,[2,2]);
% se90 = strel('line',3,90);
% se0 = strel('line',3,0);
% BWsdil = imdilate(BW2,[se90 se0]);
% BWsdil = medfilt2(BWsdil,[3,3]);
% conn = double(ones(3,3));
% BWdfill = imfill(BWsdil,conn,'holes');
% BWnobord = imclearborder(BWdfill,1);
% se1=strel('disk',5);
% BWnobord=imopen(BWnobord,se1);
% seD = strel('diamond',1);
% BWfinal = imerode(BWnobord,seD);
% BWfinal = imerode(BWfinal,seD);
% se=strel('disk',5);
% m_cells_filled=imerode(BWfinal,se);
% D=-bwdist(~m_cells_filled);
% mask=imextendedmin(D,1);
% D2=imimposemin(D,mask);
% Ld=watershed(D2);
% Water_splited=m_cells_filled;
% Water_splited(Ld==0)=0;
% BWoutline = bwperim(Water_splited);
% Segout = I_ori;
% Segout(BWoutline) = 255; 
imshow(BW2);


%% USED

I_ori = imread('img\cells.png');
img = rgb2gray(I_ori);
% img = imgaussfilt(img,2);
img = medfilt2(img,[3,3]);
th = graythresh(img);
img(img<=(th*255)) = uint8(th*255);
th1 = graythresh(img);
img(img<=(th1*255)) = uint8(th1*255);
% img = medfilt2(img,[3,3]);
% img(img>(th1*255)) = 255;
% se_img = strel('disk',3);
% img = imdilate(img,se_img);
% img = medfilt2(img,[3,3]);
BW2 = edge(img,'canny');

se90 = strel('line',6,90);
se0 = strel('line',6,0);
BWsdil = imdilate(BW2,[se90 se0]);
conn = double(ones(3,3));
BWdfill = imfill(BWsdil,conn,'holes');
BWnobord = imclearborder(BWdfill,1);

% % 
seD = strel('diamond',3);
BWfinal = imdilate(BWnobord,seD);
BWfinal = imdilate(BWfinal,seD);
% % 
D=-bwdist(~BWfinal);
mask=imextendedmin(D,2);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=BWfinal;
Water_splited(Ld==0)=0;
BWoutline = bwperim(Water_splited);
Segout = I_ori;
Segout(BWoutline) = 255; 

imshow(Segout);


%% 

I_ori = imread('img\cells.png');
img = rgb2gray(I_ori);
img = medfilt2(img,[3,3]);
img = img * 5;
th = graythresh(img);
img(img<=(th*255)) = uint8(th*255);
th1 = graythresh(img);
img(img<=(th1*255)) = uint8(th1*255);
img = imadjust(img);
img(img~=0) = 255;
BW2 = edge(img,'canny');
se90 = strel('line',8,90);
se0 = strel('line',8,0);
BWsdil = imdilate(BW2,[se90 se0]);
conn = double(ones(3,3));
BWdfill = imfill(BWsdil,conn,'holes');
BWnobord = imclearborder(BWdfill,1);
seD = strel('disk',5);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
D=-bwdist(~BWfinal);
mask=imextendedmin(D,2);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=BWfinal;
Water_splited(Ld==0)=0;
BWoutline = bwperim(Water_splited);
Segout = I_ori;
Segout(BWoutline) = 255; 
imshow(Segout);


%% Final Final Version 2
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

% % 
seD = strel('diamond',3);
BWfinal = imdilate(BWnobord,seD);
BWfinal = imdilate(BWfinal,seD);
% % 
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






%% Best result 
I_ori = imread('img\cells.png');
I = I_ori(:,:,2);%rgb2gray(I_ori);
K = (1/9)*ones(3);
img = uint8(conv2(I,K,'same'));
% Zsmooth1 = medfilt2(Zsmooth1,[11,11]);
% Zsmooth1 = imgaussfilt(I,3);
th = graythresh(img);
img(img<=floor(th*255)) = floor(th*255);

% img = uint8(Zsmooth1 - 21);
% th = mean(mean(Zsmooth1));
% Zsmooth1(Zsmooth1>35)=100;

BW2 = edge(img,'canny');
se90 = strel('line',6,90);
se0 = strel('line',6,0);
BWsdil = imdilate(BW2,[se90 se0]);
BWdfill = imfill(BWsdil,'holes');
BWnobord = imclearborder(BWdfill,1);
se1=strel('disk',13);
BWnobord=imopen(BWnobord,se1);
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
se=strel('disk',9);
m_cells_filled=imopen(BWfinal,se);
D=-bwdist(~m_cells_filled);
mask=imextendedmin(D,1);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=m_cells_filled;
Water_splited(Ld==0)=0;
BWoutline = bwperim(Water_splited);
Segout = I_ori; 
Segout(BWoutline) = 255; 
% % imshow(uint8(Zsmooth1));
imshow(Segout);




%% Final Final Version 1

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
se = strel('disk',1);
BWoutline = imdilate(BWoutline,se);
Segout = I_ori; 
Segout(BWoutline) = 255; 

imshow(Segout);















































%%
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




%% 

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



%% 
clear; clc; close all;
I_ori = imread('img\Ecoli.png');
I = I_ori(:,:,2)*5;
K = (1/9)*ones(3);
Zsmooth1 = uint8(conv2(I,K,'same'));

th = graythresh(Zsmooth1);
img = uint8(Zsmooth1 - (th*255));

BW2 = edge(img,'canny');
% 
se90 = strel('line',2,90);
se0 = strel('line',2,0);
BWsdil = imdilate(BW2,[se90 se0]);
% 
BWdfill = imfill(BWsdil,'holes');
% 
BWnobord = imclearborder(BWdfill,1);
% 
se1=strel('disk',3);
BWnobord=imopen(BWnobord,se1);
% 
seD = strel('disk',3);
BWfinal = imerode(BWnobord,seD);
% BWfinal = imerode(BWfinal,seD);
% 
D=-bwdist(~BWfinal);
mask=imextendedmin(D,1);
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
