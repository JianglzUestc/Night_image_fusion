function [y_finald,u_finald,v_finald] = texture_reconstitution...
    (ya_detail,ua_detail,va_detail,yf_detail,uf_detail,vf_detail)
M = 10;
%matrix cat 0
[row,col] = size(ya_detail);
ya_d = [zeros(row,M) ya_detail zeros(row,M)];
ya_d = [zeros(M,col+2*M);ya_d;zeros(M,col+2*M)];
yf_d = [zeros(row,M) yf_detail zeros(row,M)];
yf_d = [zeros(M,col+2*M);yf_d;zeros(M,col+2*M)];
asum = zeros(row,col);
fsum = zeros(row,col);
for i = M+1:(row+M)
    for j = M+1:(col+M)
        asum(i-M,j-M) = sum(sum(ya_d(i-M:i+M,j-M:j+M)));
        fsum(i-M,j-M) = sum(sum(yf_d(i-M:i+M,j-M:j+M)));
    end
end
index = find(asum>fsum);
y_finald = yf_detail;
u_finald = uf_detail;
v_finald = vf_detail;
y_finald(index) = ya_detail(index);
u_finald(index) = ua_detail(index);
v_finald(index) = va_detail(index);

