clc;clear;
load('final_vs.mat');

%图像预处理与显示
picture_raw=imread('pic1.jpg');
araw_pic_size=size(picture_raw);
a1=740; b1=1100;
a2=760; b2=1120;
picture=picture_raw(a1:a2,b1:b2,:);
picture_show=Circle(picture_raw,a1,b1,a2,b2);
subplot(1,2,1);
imshow(picture_show);
subplot(1,2,2);
imshow(picture);

%定义参量
L=3;                %指定的颜色种类系数L
dim=2^L;            %每种颜色维度有多少种可能
ratio=2^(8-L);      %和8bit颜色空间做替换时的比率


%这里决定提取范围
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


