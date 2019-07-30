clear all; clc
x = [1E-03,1E+00,1E+03,1E+06,1E+09,1E+12,1E+15,1E+18];
y = [1E-03,1E+00,1E+03,1E+06,1E+09,1E+12,1E+15,1E+18];
loglog(x,y);
ylabel('Final Cumulative Wealth');
set(gca,'Ytick',[1E-03,1E+00,1E+03,1E+06,1E+09,1E+12,1E+15,1E+18]);
set(gca,'Yticklabel',{'1E-03','1E+00','1E+03','1E+06','1E+09','1E+12', '1E+15','1E+18'});