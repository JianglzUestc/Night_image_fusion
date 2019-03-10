function [Y_base] = Y_reconstitution(yaf,yff)
[H,W] = size(yaf); 
num = sum(sum(yff>yaf));
alpha = num/(H*W);
Y_base = zeros(H,W);
if alpha<0.9
    Y_base = yff;
    index = find(yaf>yff);
    Y_base(index) = yaf(index);
else
    Y_base = yaf;
end