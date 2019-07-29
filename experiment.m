clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 16;                                                                    %�ڵ�ĸ���
tryTimes = 50;                                                             %�ظ�����Ĵ���
AllFrame = zeros(1, n);                                                    %����֡������
SuccessFrame = zeros(1, n);                                                %���ͳɹ���֡������
SER_Nodes_try = zeros(4, n, tryTimes);
SER_Nodes = zeros(4, 1, n);                                                  %������
BackoffTime_try = zeros(4, n, tryTimes);
BackoffTime = zeros(4, 1, n);                                                %�˱�ʱ���ܺ�
ConWindow = 1;
BEIndex = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������ڵ������ϵͳ���ܵ�Ӱ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for minBE = 2:5
    for t = 1:50
        for i = 1:n
            [AllFrame(i), SuccessFrame(i), BackoffTime_try(BEIndex,i,t)] = Csmaca(i,ConWindow, minBE, 5);
             SER_Nodes_try(BEIndex,i,t) = (AllFrame(i)-SuccessFrame(i))/AllFrame(i);
        end
    end
    SER_Nodes(BEIndex) = mean(SER_Nodes_try(BEIndex), 2)';
    BackoffTime(BEIndex) = mean(BackoffTime_try(BEIndex), 2)';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ͼչʾ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
plot(1:n, SER_Nodes(1,:), '-*');
box on;
grid on;
xlabel('Nodes');
ylabel('SER');
% xlim([1, 15]);                                  % ֻ�趨x��Ļ��Ʒ�Χ
set(gca,'XTick',0:1:n);                          % �ı�x����������ʾ ������Ϊ1
title('CSMA\_CA: Nodes-SER');

figure(2);
plot(1:n, BackoffTime(1,:), '-*');
box on;
grid on;
xlabel('Nodes');
ylabel('Backoff');
% xlim([1, 15]);                                  % ֻ�趨x��Ļ��Ʒ�Χ
set(gca,'XTick',0:1:n);                          % �ı�x����������ʾ ������Ϊ1
title('CSMA\_CA: BackoffTime');