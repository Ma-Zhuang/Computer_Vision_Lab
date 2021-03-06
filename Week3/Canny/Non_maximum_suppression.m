%% 
% function result = Non_maximum_suppression(Img,Direction)
%     [height,width] = size(Img);
%     result = zeros(height,width);
%     
%     for i = 2:height-1
%         for j = 2:width-1
%             theta = Direction(i,j);
%             img = Img(i,j);
%             weight = tan(theta);
%             if theta == 0 || theta == -180
%                 if img < Img(i,j+1) || img < Img(i,j-1)
%                     result(i,j) = 0;
%                 else
%                     result(i,j) = img;
%                 end 
%             elseif theta == 45 || theta == -45
%                 if img < Img(i+1,j+1) || img < Img(i-1,j-1)
%                     result(i,j) = 0;
%                 else
%                     result(i,j) = img;
%                 end 
%             elseif theta == 90 || theta == -90
%                 if img < Img(i+1,j) || img < Img(i-1,j)
%                     result(i,j) = 0;
%                 else
%                     result(i,j) = img;
%                 end 
%             elseif (theta > 0 && theta <90)
%                 if theta > 45
%                     g1 = Img(i-1,j+1);
%                     g2 = Img(i-1,j);
%                     g3 = Img(i+1,j-1);
%                     g4 = Img(i+1,j);
%                 else
%                     g1 = Img(i-1,j-1);
%                     g2 = Img(i,j-1);
%                     g3 = Img(i+1,j+1);
%                     g4 = Img(i,j+1);
%                 end
%                 d1 = weight*g1+(1-weight)*g2;
%                 d2 = weight*g3+(1-weight)*g4;
%                 if img < d1 || img < d2
%                     result(i,j) = 0;
%                 else
%                     result(i,j) = img;
%                 end
%             elseif (theta < 0 && theta >-90)
%                 if theta > -45
%                     g1 = Img(i-1,j-1);
%                     g2 = Img(i-1,j);
%                     g3 = Img(i+1,j+1);
%                     g4 = Img(i-1,j);
%                 else
%                     g1 = Img(i-1,j-1);
%                     g2 = Img(i,j-1);
%                     g3 = Img(i+1,j+1);
%                     g4 = Img(i,j+1);
%                 end
%                 d1 = weight*g1+(1-weight)*g2;
%                 d2 = weight*g3+(1-weight)*g4;
%                 if img < d1 || img < d2
%                     result(i,j) = 0;
%                 else
%                     result(i,j) = img;
%                 end
%             end
%         end
%     end     
% end




%% 
% function result = Non_maximum_suppression(Img,Direction)
%     [height,width] = size(Img);
%     result = zeros(height,width);
%     
%     for i = 2:height-1
%         for j = 2:width-1
%             theta = Direction(i,j);
%             img = Img(i,j);
%             if theta >=0
%                 if theta<=45
%                     weight = tan(theta);
%                     q1 = Img(i-1,j+1);
%                     q2 = Img(i,j+1);
%                     q3 = Img(i+1,j-1);
%                     q4 = Img(i,j-1);
%                     d1 = weight * q1 + (1-weight)*q2;
%                     d2 = weight * q3 + (1-weight)*q4;
%                     if img >=d1 && img>=d2
%                         result(i,j) = img;
%                     end
%                 else
%                     weight = 1/tan(theta);
%                     q1 = Img(i-1,j);
%                     q2 = Img(i-1,j+1);
%                     q3 = Img(i+1,j-1);
%                     q4 = Img(i+1,j);
%                     d1 = weight * q2 + (1-weight)*q1;
%                     d2 = weight * q3 + (1-weight)*q4;
%                     if img >=d1 && img>=d2
%                         result(i,j) = img;
%                     end
%                 end
%             else
%                 if theta>=-45
%                     weight = abs(tan(theta));
%                     q1 = Img(i,j+1);
%                     q2 = Img(i+1,j+1);
%                     q3 = Img(i-1,j-1);
%                     q4 = Img(i,j-1);
%                     d1 = weight * q2 + (1-weight)*q1;
%                     d2 = weight * q3 + (1-weight)*q4;
%                     if img >=d1 && img>=d2
%                         result(i,j) = img;
%                     end
%                 else
%                     weight = abs(1/tan(theta));
%                     q1 = Img(i+1,j+1);
%                     q2 = Img(i+1,j);
%                     q3 = Img(i-1,j);
%                     q4 = Img(i-1,j-1);
%                     d1 = weight * q1 + (1-weight)*q2;
%                     d2 = weight * q4 + (1-weight)*q3;
%                     if img >=d1 && img>=d2
%                         result(i,j) = img;
%                     end
%                 end
%             end
%         end
%     end     
% end




%% 
% function result = Non_maximum_suppression(result_tmp_x,result_tmp_y,Img)
%     [height,width] = size(Img);
%     result = zeros(height,width);
%     
%     for i = 2:height-1
%         for j = 2:width-1
%             if Img(i,j) == 0
%                 result(i,j) = 0;
%             else
%                 gradX = result_tmp_x(i,j);
%                 gradY = result_tmp_y(i,j);
%                 gradTmp = Img(i,j);
%                 if abs(gradY)>abs(gradX)
%                     weight = abs(gradX)/abs(gradY);
%                     grad2 = Img(i-1,j);
%                     grad4 = Img(i+1,j);
%                     if gradX*gradY>0
%                         grad1 = Img(i-1,j-1);
%                         grad3 = Img(i+1,j+1);
%                     else
%                         grad1 = Img(i-1,j+1);
%                         grad3 = Img(i+1,j-1);
%                     end
%                 else
%                     weight = abs(gradY)/abs(gradX);
%                     grad2 = Img(i,j-1);
%                     grad4 = Img(i,j+1);
%                     if gradX*gradY>0
%                         grad1 = Img(i+1, j-1);
%                         grad3 = Img(i-1, j+1);
%                     else
%                         grad1 = Img(i-1, j-1);
%                         grad3 = Img(i+1,j+1);
%                     end
%                 end
%                 gradTmp1 = weight*grad1 + (1-weight)*grad2;
%                 gradTmp2 = weight*grad3 + (1-weight)*grad4;
%                 if gradTmp >=gradTmp1 && gradTmp >= gradTmp2
%                     result(i,j) = gradTmp;
%                 else
%                     result(i,j) = 0;
%                 end
%             end
%         end
%     end     
% end



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
