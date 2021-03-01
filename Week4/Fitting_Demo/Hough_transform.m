% %% 
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
%                     vote_matrix(floor(y/step),ceil(x/step),floor(r/step)) = vote_matrix(floor(y/step),floor(x/step),floor(r/step)) + 1;
%                     y = y + step*angle(i,j);
%                     x = x + step;
%                     r = r + sqrt((step * angle(i,j))^2+step^2);
%                 end
%                 y = i - step * angle(i,j);
%                 x = j - step;
%                 r = sqrt((step * angle(i,j))^2+step^2);
%                 while y < height && x < width && y>=1 && x>=1
%                     vote_matrix(floor(y/step),floor(x/step),floor(r/step)) = vote_matrix(floor(y/step),floor(x/step),floor(r/step)) + 1;
%                     y = y - step*angle(i,j);
%                     x = x - step;
%                     r = r + sqrt((step * angle(i,j))^2+step^2);
%                 end
%             end
%         end
%     end
% end




%%
function result = Hough_transform(img,angle,step)
    [height,width] = size(img);
    radius = ceil(sqrt(height^2+width^2));
    vote_matrix = zeros(ceil(height/step),ceil(width/step),ceil(radius/step));
    r = 1;
    for i = 1:height
        for j = 1:width
            if img(i,j)~=0
                while r <=radius
                    b = i - j*angle(i,j);
                    
                end
            end
        end
    end
    result = vote_matrix;
end
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