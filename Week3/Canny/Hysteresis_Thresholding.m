% function edge_result=Hysteresis_Thresholding(edge,high,low)
%     [height,width] = size(edge);
%     for i = 1:height
%         for j = 1:width
%             if edge(i,j) > high
%                 edge(i,j) = 255;
%             end
%         end
%     end
% 
%     edge_result = connect(edge,low);
%     
% end


%% 
function edge=Hysteresis_Thresholding(edge,high,low)
    [height,width] = size(edge);
%     edge_result = zeros(height,width);
%     edge_result = edge;
    for i = 2:height-1
        for j = 2:width-1
            if edge(i,j) > high
                edge(i,j) = 255;
%                 continue;
            elseif edge(i,j) < low
                edge(i,j) = 0;
%                 continue;
            else
                tem =[edge(i-1,j-1), edge(i-1,j), edge(i,j+1);
                      edge(i,j-1), edge(i,j), edge(i,j+1);
                      edge(i+1,j-1), edge(i+1,j), edge(i+1,j+1)];
%                 tmp = cell(3,3);
%                 tmp{1,1} = [-1,-1];
%                 tmp{1,2} = [-1,0];
%                 tmp{1,3} = [0,1];
%                 tmp{2,1} = [0,-1];
%                 tmp{2,2} = [0,0];
%                 tmp{2,3} = [0,1];
%                 tmp{3,1} = [1,-1];
%                 tmp{3,2} = [1,0];
%                 tmp{3,3} = [1,1];
                [row,col] = find(tem>=low);
                length = size(row);
                if length>=1
%                     for k = 1:length(1)
%                         x = row(k);
%                         y = col(k);
%                         cood = tmp{x,y};
%                         edge(i+cood(1),j+cood(2)) = 255;
%                     end
                    edge(i,j) = 255;
                end
%                 temMax = max(tem);
%                 disp(temMax);
%                 disp("----------------------------------------------------------")
%                 if temMax > low
%                     edge_result(i,j) = 255;
%                     continue;
%                 else
%                     edge_result(i,j) = 0;
%                     continue;
%                 end
            end
        end
    end
end