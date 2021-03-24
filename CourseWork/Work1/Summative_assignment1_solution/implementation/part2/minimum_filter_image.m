function [ out_img ] = minimum_filter_image( in_img, se )

in_img_dim = int16(size(in_img));
in_img_max = max(in_img(:));

se_dim = int16(size(se));
se_centre = se_dim / 2;

out_img = zeros(in_img_dim);

for i = 1:in_img_dim(1)
    for j = 1:in_img_dim(2)
        cval = in_img_max;
        
        for u = 1:se_dim(1)
            ci = i + (u - se_centre(1));
            if ci <= 0 || ci > in_img_dim(1)
                continue
            end
            
            for v = 1:se_dim(2)
                cj = j + (v - se_centre(2));
                if cj <= 0 || cj > in_img_dim(2);
                    continue
                end
                
                if se(u, v)
                    cval = min(cval, in_img(ci, cj));
                end
            end
        end
        
        out_img(i,j) = cval;
    end
end

out_img = uint8(out_img);

end