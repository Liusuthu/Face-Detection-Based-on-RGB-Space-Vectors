clc;clear;
load('final_vs.mat');

picture_raw=imread('pic3.jpg');
%picture_raw=picture_raw(585:1280,217:400,:);%debug先从小图像开始
raw_pic_size=size(picture_raw);
num_x=floor(raw_pic_size(1)/20);
num_y=floor(raw_pic_size(2)/20);

painting=picture_raw;   %用于处理加上方框的图像

%定义参量
L=3;                %指定的颜色种类系数L
dim=2^L;            %每种颜色维度有多少种可能
ratio=2^(8-L);      %和8bit颜色空间做替换时的比率

d_book=zeros(num_x,num_y);

%以20×20的格子移动 作为检测的单元
for id_x=1:num_x
   for id_y=1:num_y
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %取出每一次检测的单元
       picture=picture_raw(id_x*20-19:id_x*20,id_y*20-19:id_y*20,:);
       %套用之前的代码，计算各个单元的f，并计算他和v的距离，来判定是不是人脸
       pic_size=size(picture);
       x=pic_size(1);      %竖向
       y=pic_size(2);      %横向
       
       %提取颜色向量，结果存在f里面
        f=zeros(1,dim^3);   %u(R)：提取出区域的颜色向量
        for i=0:dim-1
            for j=0:dim-1
                for k=0:dim-1
                    %%%%%
                    n=i*dim*dim+j*dim+k+1;    %确认颜色的种类数n
                    count=0;
                    for i_x=1:x
                        for i_y=1:y
                            P=picture(i_x,i_y,:);
                            P1=double(P);
                            if(  (floor(P1(1)/ratio)==i) && (floor(P1(2)/ratio)==j) && (floor(P1(3)/ratio)==k)  ) 
                                count=count+1;
                            end
                        end
                    end
                    f(n)=count/(x*y);
                    %%%%%
                end        
            end    
        end
        %计算和标准人脸向量的距离(f和v)
        sqrtf=sqrt(f);sqrtv=sqrt(v3);
        tmp=sqrtf.*sqrtv;
        d=1-sum(tmp);
        d_book(id_x,id_y)=d;
        %判定，如果是人脸单元的话，就在图中标出
        if(d<=0.4500)
            painting=Circle(painting,  id_x*20-19,  id_y*20-19,  id_x*20,  id_y*20);
        end
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   end
end

%画图
subplot(1,2,1);
imshow(picture_raw);
title('raw')
subplot(1,2,2);
imshow(painting);
title('detected')