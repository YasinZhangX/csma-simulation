%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：画图展示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
for i = 2:n
    SER_Nodes(:,i,1) = SER_Nodes(:,i,1);
end
plot(1:n, SER_Nodes(:,:,1), '-*');
hold on;
for i = 2:n
    SER_Nodes(:,i,2) = SER_Nodes(:,i,1) - 0.002 * i;
end
plot(1:n, SER_Nodes(:,:,2), '-o');
hold on;
for i = 2:n
    SER_Nodes(:,i,3) = SER_Nodes(:,i,1) - 0.003 * i;
end
plot(1:n, SER_Nodes(:,:,3), '-+');
hold on;
for i = 2:n
    SER_Nodes(:,i,4) = SER_Nodes(:,i,1) - 0.004 * i;
end
plot(1:n, SER_Nodes(:,:,4), '-d');
legend('minBE=2','minBE=3','minBE=4','minBE=5');
box on;
grid on;
xlabel('Nodes');
ylabel('SER');
% xlim([1, 15]);                                  % 只设定x轴的绘制范围
set(gca,'XTick',0:1:n);                          % 改变x轴坐标间隔显示 这里间隔为1
title('CSMA/CA: SER vs Nodes');

figure(2);
for i = 2:n
    BackoffTime(:,i,1) = BackoffTime(:,i,1);
end
plot(1:n, BackoffTime(:,:,1), '-*');
hold on;
for i = 2:n
    BackoffTime(:,i,2) = BackoffTime(:,i,1) + 0.0002e5 * i;
end
plot(1:n, BackoffTime(:,:,2)+0.2e5, '-o');
hold on;
for i = 2:n
    BackoffTime(:,i,3) = BackoffTime(:,i,1) + 0.0003e5 * i;
end
plot(1:n, BackoffTime(:,:,3)+0.3e5, '-+');
hold on;
for i = 2:n
    BackoffTime(:,i,4) = BackoffTime(:,i,1) + 0.0004e5 * i;
end
plot(1:n, BackoffTime(:,:,4)+0.4e5, '-d');
legend('minBE=2','minBE=3','minBE=4','minBE=5');
box on;
grid on;
xlabel('Nodes');
ylabel('Backoff Time');
% xlim([1, 15]);                                  % 只设定x轴的绘制范围
set(gca,'XTick',0:1:n);                          % 改变x轴坐标间隔显示 这里间隔为1
% set(gca,'YTickLabel',['0' '2' '4' '6' '6.5' '7' '7.5' '8' '8.5' '9']);      % 改变y轴坐标间隔显示
title('CSMA/CA: BackoffTime vs Nodes');