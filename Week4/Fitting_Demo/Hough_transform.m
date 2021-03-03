%% 
function vote_matrix = Hough_transform(img,angle,step,threshold)
    [height,width] = size(img);
    radius = ceil(sqrt(height^2+width^2));
    vote_matrix = zeros(ceil(height/step),ceil(width/step),ceil(radius/step));
    
    for i = 2:height-1
        for j = 2:width-1
            if img(i,j)>0
                y = i;
                x = j;
                r = 1;
                while y < height && x < width && y>=1 && x>=1
                    vote_matrix(ceil(y/step),ceil(x/step),ceil(r/step)) = vote_matrix(ceil(y/step),ceil(x/step),ceil(r/step)) + 1;
                    y = y + step*angle(i,j);
                    x = x + step;
                    r = r + sqrt((step * angle(i,j))^2+step^2);
                end
                y = i - step * angle(i,j);
                x = j - step;
                r = sqrt((step * angle(i,j))^2+step^2);
                while y < height && x < width && y>=1 && x>=1
                    vote_matrix(ceil(y/step),ceil(x/step),ceil(r/step)) = vote_matrix(ceil(y/step),ceil(x/step),ceil(r/step)) + 1;
                    y = y - step*angle(i,j);
                    x = x - step;
                    r = r + sqrt((step * angle(i,j))^2+step^2);
                end
            end
        end
    end
    Select_Circle(height,width,radius,vote_matrix,step,threshold);
end




%%
% function vote_matrix = Hough_transform(img,angles,step)
%     [height,width] = size(img);
%     radius = ceil(sqrt(height^2+width^2));
%     vote_matrix = zeros(ceil(height/step),ceil(width/step),ceil(radius/step));
%     r = 0;
%     for i = 1:height
%         for j = 1:width
%             if img(i,j)~=0
%                 angle = angles(i,j);
%                 while r <=radius
%                     i_1 = floor(cos(angle)*r);
%                     j_1 = floor(sin(angle)*r);
%                     if i+i_1 <=height && j+j_1<= width && i-i_1 >0 && j-j_1>0 && r+1<=radius
%                         vote_matrix(i+i_1,j+j_1,r+1) = vote_matrix(i+i_1,j+j_1,r+1)+1;
%                         vote_matrix(i-i_1,j-j_1,r+1) = vote_matrix(i-i_1,j-j_1,r+1)+1;
%                     end
%                     r = r+step;
%                 end
%             end
%         end
%     end
% end
%%
%% 
% function vote_matrix = Hough_transform(img,angle,step)
%     [height,width] = size(img);
%     radius = ceil(sqrt(height^2+width^2));
%     vote_matrix = zeros(ceil(height/step),ceil(width/step),ceil(radius/step));
%     
%     for i = 1:height-1
%         for j = 1:width-1
%             if img(i,j)>0
%                 y = i;
%                 x = j;
%                 r = 1;
%                 while y < height && x < width && y>=1 && x>=1
%                     vote_matrix(ceil(y),ceil(x),ceil(r)) = vote_matrix(ceil(y),ceil(x),ceil(r)) + 1;
%                     y = y + step*angle(i,j);
%                     x = x + step;
%                     r = r + sqrt((step * angle(i,j))^2+step^2);
%                 end
%                 y = i - step * angle(i,j);
%                 x = j - step;
%                 r = sqrt((step * angle(i,j))^2+step^2);
%                 while y < height && x < width && y>=1 && x>=1
%                     vote_matrix(ceil(y),ceil(x),ceil(r)) = vote_matrix(ceil(y),ceil(x),ceil(r)) + 1;
%                     y = y - step*angle(i,j);
%                     x = x - step;
%                     r = r + sqrt((step * angle(i,j))^2+step^2);
%                 end
%             end
%         end
%     end
% end