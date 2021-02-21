% function result = Prewitt_Filter(Img)
% 
% kernel_x = [-1,0,1;-1,0,1;-1,0,1];
% 
% kernel_y = [1,1,1;0,0,0;-1,-1,-1];
% 
% Img_size = size(Img);
% 
% result_x = zeros(Img_size(1),Img_size(2),Img_size(3));
% result_y = zeros(Img_size(1),Img_size(2),Img_size(3));
% 
% for k = 1:Img_size(3)
%     for i = 1:Img_size(1)
%         for j = 1:Img_size(2)
%             if j == Img_size(2)
%                 break;
%             end
%             result_x(i,j,k) = double(Img())
% 
% end
% 
