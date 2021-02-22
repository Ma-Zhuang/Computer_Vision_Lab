%src为rgb图像，Contrast为调节的对比度值，调节范围为【-100，100】
function img = ContrastAdjust(src,Contrast)

Image=double(src);

R=Image(:,:,1);
G=Image(:,:,2);
B=Image(:,:,3);

Average=mean(src(:));
%调整参数[-100,100]


Contrast=Contrast/100*255;
Percent=Contrast/255;
if(Contrast>0)
    R = Average + (R - Average) * 1 / (1 - Percent) ;
    G = Average + (G - Average) * 1 / (1 - Percent) ;
    B = Average + (B - Average) * 1 / (1 - Percent) ;
else
    R= Average + (R - Average) * (1 + Percent);
    G= Average + (G - Average) * (1 + Percent);
    B= Average + (B - Average) * (1 + Percent);
    
end

img(:,:,1)=R;
img(:,:,2)=G;
img(:,:,3)=B;
end
