fruits = imread('fruits.jpg');
figure;
subplot(2,3,1);
imshow(fruits);
title("(a) Original image of part 1.");
hold on;


fruits_blue = fruits(:,:,3);
fruits_blue_edge = edge(fruits_blue,'Sobel',0.2);
subplot(2,3,2);
imshow(fruits_blue_edge);
title("(b) Binary edge image of question 1.1");
hold on;


[height,width] = size(fruits_blue_edge);
fruits_segment = zeros(height,width);%fruits_blue_edge;
for i = 1:height
    for j = 1:width
        value_diff = abs(fruits(i,j,2)-fruits(i,j,3));
        if value_diff > 30
            fruits_segment(i,j) = 1;
        end
    end
end
subplot(2,3,3);
imshow(fruits_segment);
title("(c) Segmented image of part 1.2");
hold on;

se90 = strel('line',11,90);
se0 = strel('line',11,0);

fruits_segment_correct = imdilate(fruits_segment,[se90,se0]);
fruits_segment_correct = imfill(fruits_segment_correct,'holes');
fruits_segment_correct = imerode(fruits_segment_correct,[se90,se0]);
subplot(2,3,4);
imshow(fruits_segment_correct);
title("(d) Segmented image of part 1.3");
hold on;

fruits_BoundingBox = regionprops(logical(fruits_segment_correct), 'BoundingBox');
subplot(2,3,5);
imshow(fruits);
title("(e) Bounding boxes of part 1.4");
hold on;
for i = 1:size(fruits_BoundingBox,1)
    rectangle('Position', fruits_BoundingBox(i).BoundingBox,'EdgeColor','black', 'LineWidth', 1);
end

box = fruits_BoundingBox(11).BoundingBox;
grapefruit = uint8(zeros(box(4),box(3),3));
for i = 1:3
    for j = 0:box(4)-1
        for k = 0:box(3)-1
            grapefruit(j+1,k+1,i) = fruits(j+uint16(box(2)),k+uint16(box(1)),i);
        end
    end
end
subplot(2,3,6);
imshow(grapefruit);
title("(f) Expected result of part 1.");
hold on;