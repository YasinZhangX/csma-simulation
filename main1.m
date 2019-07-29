clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllFrame = zeros(1,15);                                                    %发的帧的总数
SuccessFrame = zeros(1,15);                                                %发送成功的帧的数量
SER_Nodes = zeros(1,15);                                                   %误码率
ConWindow = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：计算节点个数对系统性能的影响
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:15
    [AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
     temp1=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
    [AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
     temp2=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
    [AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
     temp3=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
     SER_Nodes(i)=(temp1+temp2+temp3)/3;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllFrame1 = zeros(1,15);                                                   %发送总的帧数
SuccessFrame1 = zeros(1,15);                                               %发送成功的帧数
SER_Window = zeros(1,15);                                                  %误码率
NumberNodes1 = 4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：计算争用期长短对系统性能的影响
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:15
    [AllFrame1(i), SuccessFrame1(i)] = Csmaca(NumberNodes1,i);
     temp1=(AllFrame1(i)-SuccessFrame1(i))/AllFrame1(i);
    [AllFrame1(i), SuccessFrame1(i)] = Csmaca(NumberNodes1,i);
     temp2=(AllFrame1(i)-SuccessFrame1(i))/AllFrame1(i);
    [AllFrame1(i), SuccessFrame1(i)] = Csmaca(NumberNodes1,i);
     temp3=(AllFrame1(i)-SuccessFrame1(i))/AllFrame1(i);
     SER_Window(i)=(temp1+temp2+temp3)/3;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：画图展示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
subplot(2,1,1);
plot(1:15,SER_Nodes(:));
box on;
grid on;
xlabel('Nodes');
ylabel('SER');
title('CSMA_CA: Nodes-SER');
subplot(2,1,2);
plot(1:15,SER_Window(:));
box on;
grid on;
xlabel('ConWindow');
ylabel('SER');
title('CAMA_CA: ConWindow-SER');