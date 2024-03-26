clc;clear;
load('final_vs.mat');
load('20pic3L3_d_book.mat');

global num_x num_y;

picture_raw=imread('pic3.jpg');
raw_pic_size=size(picture_raw);
num_x=floor(raw_pic_size(1)/20);
num_y=floor(raw_pic_size(2)/20);

painting=picture_raw;   %用于处理加上方框的图像

global sign;
sign=double(d_book<0.4500);

figure();imshow(sign);

group=1;

for i_x=1:num_x
    for i_y=1:num_y
        if(sign(i_x,i_y)==1)
            group=group+1;
            sign(i_x,i_y)=group;
            groupup(i_x,i_y);
        end
    end    
end

%imshow(uint8(sign*8));

%接下来给每个人头加上大长方形
for label=2:group
    up=num_x;down=1;left=num_y;right=1;    
    for i_x=1:num_x
       for i_y=1:num_y
           if(sign(i_x,i_y)==label)
               %上
               if(i_x<up)
                   up=i_x;
               end
               %下
               if(i_x>down)
                   down=i_x;
               end
               %左
               if(i_y<left)
                   left=i_y;
               end
               %右
               if(i_y>right)
                   right=i_y;
               end
           end
       end
    end
    %若是尺寸大小满足需求则表上框
    if(right-left>=1 && down-up>=1)
        painting=Circle(painting,  (up-1)*20+1,  (left-1)*20+1,  down*20,  right*20);
    end
end

imshow(painting);
title('detected')





%%%%%%这种做法行不通，而是要一旦找到一个1就递归找到所有的同组
% for i_x=1:num_x
%    for i_y=1:num_y
%        if(sign(i_x,i_y)==0)
%            %0跳过操作                  
%        elseif(sign(i_x,i_y)==1)
%            %1则编号并传递四周
%            if( (i_y+1<=num_y)  &&  (sign(i_x,i_y+1)~=0)  &&(sign(i_x,i_y+1)~=1) )
%                sign(i_x,i_y)=sign(i_x,i_y+1);%继承右方编号
%            else%新编号
%                group=group+1;
%                sign(i_x,i_y)=group;
%            end           
%            %传递四周
%            if(  (i_x-1>=1)  &&  (sign(i_x-1,i_y)==1)  )
%                sign(i_x-1,i_y)=sign(i_x,i_y);
%            end%上
%            if(  (i_x+1<=num_x)  &&  (sign(i_x+1,i_y)==1)  )
%                sign(i_x+1,i_y)=sign(i_x,i_y);
%            end%下
%            if(  (i_y-1>=1)  &&  (sign(i_x,i_y-1)==1)  )
%                sign(i_x,i_y-1)=sign(i_x,i_y);
%            end%左
%            if(  (i_y+1<=num_y)  &&  (sign(i_x,i_y+1)==1)  )
%                sign(i_x,i_y+1)=sign(i_x,i_y);
%            end%右
%        else
%            %已有编号则传递四周
%            if(  (i_x-1>=1)  &&  (sign(i_x-1,i_y)==1)  )
%                sign(i_x-1,i_y)=sign(i_x,i_y);
%            end%上
%            if(  (i_x+1<=num_x)  &&  (sign(i_x+1,i_y)==1)  )
%                sign(i_x+1,i_y)=sign(i_x,i_y);
%            end%下
%            if(  (i_y-1>=1)  &&  (sign(i_x,i_y-1)==1)  )
%                sign(i_x,i_y-1)=sign(i_x,i_y);
%            end%左
%            if(  (i_y+1<=num_y)  &&  (sign(i_x,i_y+1)==1)  )
%                sign(i_x,i_y+1)=sign(i_x,i_y);
%            end%右
%        end
%    end
% end

