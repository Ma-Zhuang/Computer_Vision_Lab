%% 
function result = Non_maximum_suppression(Img,Direction)
    [height,width] = size(Img);
    result = zeros(height,width);
    
    for i = 2:height-1
        for j = 2:width-1
            theta = Direction(i,j);
            img = Img(i,j);
            if abs(theta) > 1
                gradient2 = Img(i - 1,j);
                gradient4 = Img(i + 1,j);
%                 g1 g2
%                    C
%                    g4 g3
                if theta>0
                    gradient1 = Img(i - 1,j - 1);
                    gradient3 = Img(i + 1,j + 1);
                else
%                       g2 g1
%                       C
%                    g3 g4
                    gradient1 = Img(i - 1,j + 1);
                    gradient3 = Img(i + 1,j - 1);
                end
            else
                gradient2 = Img(i,j-1);
                gradient4 = Img(i,j+1);
%                 g1
%                 g2 C g4
%                      g3
                if theta>0
                    gradient1 = Img(i - 1,j - 1);
                    gradient3 = Img(i + 1,j + 1);
                else
%                       g3
%                  g2 C g4
%                  g1
                    gradient1 = Img(i - 1,j + 1);
                    gradient3 = Img(i + 1,j - 1);
                end
            end
            temp1 = abs(theta) * gradient1 + (1-abs(theta)) * gradient2;
            temp2 = abs(theta) * gradient3 + (1-abs(theta)) * gradient4;
            
            if img >= temp1 && img>=temp2
                result(i,j) = img;
            else
                result(i,j) = 0;
            end
        end
    end     
end