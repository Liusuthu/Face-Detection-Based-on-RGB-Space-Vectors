clc;clear;

L=5;                %指定的颜色种类系数L
dim=2^L;            %每种颜色维度有多少种可能
ratio=2^(8-L);      %和8bit颜色空间做替换时的比率

v=zeros(1,dim^3);   %最终训练出的向量

for name=6:33
    
filename=string(name)+'.bmp'; 
%%%%%%%%%%%%%%%%%%%%
picture=imread(filename);
pic_size=size(picture);
x=pic_size(1);
y=pic_size(2);


f=zeros(1,dim^3);   %u(R)

%计算u(R)中每个分量f_n的大小
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
%%%%%%%%%%%%%%%%%%%%
v=v+f;
end


