figure(3);
plot(1:n, Throughout(:,:,1), '-*', 'LineWidth',1);
hold on;
plot(1:n, Throughout(:,:,2), '-o', 'LineWidth',1);
hold on;
plot(1:n, Throughout(:,:,3), '-+', 'LineWidth',1);
hold on;
plot(1:n, Throughout(:,:,4), '-d', 'LineWidth',1);
legend('maxBE=4','maxBE=5','maxBE=6','maxBE=7');
box on;
grid on;
xlabel('Nodes');
ylabel('Throughout/Number of packets');
% xlim([1, 15]);                                  % ֻ�趨x��Ļ��Ʒ�Χ
set(gca,'XTick',0:1:n);                          % �ı�x����������ʾ ������Ϊ1
title('CSMA/CA: Throughout vs Nodes');