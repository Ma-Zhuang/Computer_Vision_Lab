%% 
function edge=Hysteresis_Thresholding(edge,high,low)
    [height,width] = size(edge);
    for i = 2:height-1
        for j = 2:width-1
            if edge(i,j) > high
                edge(i,j) = 255;
            elseif edge(i,j) < low
                edge(i,j) = 0;
            else
                tem =[edge(i-1,j-1), edge(i-1,j), edge(i,j+1);
                      edge(i,j-1), edge(i,j), edge(i,j+1);
                      edge(i+1,j-1), edge(i+1,j), edge(i+1,j+1)];
                [row,~] = find(tem>=low);
                length = size(row);
                if length>=1
                    edge(i,j) = 255;
                end
            end
        end
    end
end