% % demo_ASIFT.m is a MATLAB interface for the ASIFT software. This
% % script provides an example of using demo_ASIFT.m. The input/output of
% % demo_ASIFT.m follow those of the ASIFT software and a description can
% % found in README.txt. (Note that the ASIFT software support only the PNG format, 
% % the Matlab interface reads most standard image formats.)
% % Copyright, Jean-Michel Morel, Guoshen Yu, 2008. 
file_img1 = 'flash.png'; %pic1
file_img2 = 'noflash.png'; %pic2
imgOutVert = 'imgOutVert.png'; %output1
imgOutHori = 'imgOutHori.png';  %output2
matchings = 'matchings.txt';
keys1 = 'keys1.txt'; %format
keys2 = 'keys2.txt'; %format
flag_resize = 0;
%gray
% imgIn1_color = imread(file_img1);
% imgIn2_color = imread(file_img2);
imgIn1_gray = rgb2gray(imgIn1_color);
imgIn2_gray = rgb2gray(imgIn2_color);
%Histogram Equalization
[img1_histo,img2_histo] = Histogram_Equalization(imgIn1_gray,imgIn2_gray);
%ASIFT image matching
png1 = 'process1.png';
imwrite(img1_histo, png1, 'png');
png2 = 'process2.png';
imwrite(img2_histo, png2, 'png');
demo_ASIFT(png1, png2, imgOutVert, imgOutHori, matchings, keys1, keys2, flag_resize);
%Ransac

%over-fitting test
imgIn1_color = imread('flash.png');
imgIn2_color = imread('noflash.png');
%image fusion
%color space conversion RGB-->YUV
imgIn1_yuv = double(rgb2ycbcr(imgIn1_color));
imgIn2_yuv = double(rgb2ycbcr(imgIn2_color));
%filter
[yaf,uaf,vaf,yff,uff,vff,ya,ua,va,yf,uf,vf] = yuvFilter(imgIn1_yuv,imgIn2_yuv);
%reconstitution
y_base = Y_reconstitution(yaf,yff);
%Detail information extraction
[ya_detail,ua_detail,va_detail,yf_detail,uf_detail,vf_detail] ...
    = detail_extraction(yaf,uaf,vaf,yff,uff,vff,ya,ua,va,yf,uf,vf);
%texture reconstitution
[y_finald,u_finald,v_finald] = texture_reconstitution...
    (ya_detail,ua_detail,va_detail,yf_detail,uf_detail,vf_detail);
y_final = uint8(y_base.*y_finald);
u_final = uint8(uaf.*u_finald);
v_final = uint8(vaf.*v_finald);
img = cat(3,y_final,u_final,v_final);
%YUV-->RGB
img_rgb = ycbcr2rgb(img);
% imshow(img_rgb);