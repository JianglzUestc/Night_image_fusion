function [img_rgb] = yuv2rgb(img) 
img=mat2gray(img);  %任意区间映射到[0,1];
[m n dim]=size(img);
%%图像的RGB
Y=img(:,:,1);
U=img(:,:,2);
V=img(:,:,3);
%%YUV2RGB
matrix=[0.299 0.587 0.114;
        -0.14713 -0.28886 0.436;
        0.615 -0.51498 -0.10001];
matrix=inv(matrix);
for i=1:m
   for j=1:n 
        tmp=matrix*[Y(i,j) U(i,j) V(i,j)]';
        R(i,j)=tmp(1);
        G(i,j)=tmp(2);
        B(i,j)=tmp(3);
   end
end
R = uint8(R);
G = uint8(G);
B = uint8(B);
img_rgb = cat(3,R,G,B);