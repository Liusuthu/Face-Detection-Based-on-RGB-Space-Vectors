function groupup(i_x,i_y)
global num_x num_y sign;
%上
if(  (i_x-1>=1)  &&  (sign(i_x-1,i_y)==1)  )
	sign(i_x-1,i_y)=sign(i_x,i_y);
    groupup(i_x-1,i_y);
end
%下
if(  (i_x+1<=num_x)  &&  (sign(i_x+1,i_y)==1)  )
    sign(i_x+1,i_y)=sign(i_x,i_y);
    groupup(i_x+1,i_y);
end
%左
if(  (i_y-1>=1)  &&  (sign(i_x,i_y-1)==1)  )
    sign(i_x,i_y-1)=sign(i_x,i_y);
    groupup(i_x,i_y-1);
end
%右
if(  (i_y+1<=num_y)  &&  (sign(i_x,i_y+1)==1)  )
    sign(i_x,i_y+1)=sign(i_x,i_y);
    groupup(i_x,i_y+1);
end