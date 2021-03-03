function Circles = Select_Circle(height,width,radius,vote_matrix,step,threshold)
    tmpCircles = [];
    for i =1:ceil(height/step)
        for j=1:ceil(width/step)
            for r = 1:ceil(radius/step)
                if vote_matrix(i,j,r) >=threshold
                    y = i * step + step / 2;
                    x = j * step + step / 2;
                    r = r * step + step / 2;
                    tmpCircles = [tmpCircles, [ceil(x) ceil(y) ceil(r)]];
                end
            end
        end
    end
    tmpW = length(tmpCircles);
    tmpH = tmpW/3;
    tmpCirclesM = reshape(tmpCircles,tmpH,3);
    Circles = tmpCirclesM;
    disp(Circles);
end