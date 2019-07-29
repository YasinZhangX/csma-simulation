clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllFrame = zeros(1,15);                                                    %����֡������
SuccessFrame = zeros(1,15);                                                %���ͳɹ���֡������
SER_Nodes = zeros(1,15);                                                   %������
ConWindow = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������ڵ������ϵͳ���ܵ�Ӱ��
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
AllFrame1 = zeros(1,15);                                                   %�����ܵ�֡��
SuccessFrame1 = zeros(1,15);                                               %���ͳɹ���֡��
SER_Window = zeros(1,15);                                                  %������
NumberNodes1 = 4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�����������ڳ��̶�ϵͳ���ܵ�Ӱ��
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
%����ͼչʾ
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