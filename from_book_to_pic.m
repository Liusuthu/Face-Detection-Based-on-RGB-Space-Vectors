clc;clear;
load('final_vs.mat');
load('newpic1L3_d_book.mat')

picture_raw=imread('newpic1.jpg');
%picture_raw=picture_raw(585:1280,217:400,:);%debug先从小图像开始
raw_pic_size=size(picture_raw);
num_x=floor(raw_pic_size(1)/20);
num_y=floor(raw_pic_size(2)/20);

painting=picture_raw;   %用于处理加上方框的图像



for id_x=1:num_x
   for id_y=1:num_y
       if(d_book(id_x,id_y)<0.4800)
           painting=Circle(painting,  id_x*20-19,  id_y*20-19,  id_x*20,  id_y*20);
       end
   end   
end

%画图
subplot(3,1,1);
imshow(picture_raw);
title('raw')
subplot(3,1,2);
imshow(painting);
title('detected')
subplot(3,1,3);
imshow(d_book);
title('book')