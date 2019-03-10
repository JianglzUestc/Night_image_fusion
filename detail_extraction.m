function [ya_detail,ua_detail,va_detail,yf_detail,uf_detail,vf_detail] = ...
    detail_extraction(yaf,uaf,vaf,yff,uff,vff,ya,ua,va,yf,uf,vf)
omiga = 0.02;
ya_detail = ya./(yaf+omiga);
ua_detail = ua./(uaf+omiga);
va_detail = va./(vaf+omiga);
yf_detail = yf./(yff+omiga);
uf_detail = uf./(uff+omiga);
vf_detail = vf./(vff+omiga);