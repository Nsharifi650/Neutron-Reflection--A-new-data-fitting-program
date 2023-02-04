% This is plots for the report
data1 = xlsread('NRPlotForReport','Sheet1','B9:D1680'); % air-substrate, roughness vs no roughness
data2 = xlsread('NRPlotForReport','Sheet1','G9:L2008'); % layers of thickness 100A,20A,60A respectively


figure(1) %figure of roughness
plot(data1(:,1),data1(:,2)) % no roughness
hold on
plot(data1(:,1),data1(:,3)) % roughness of 5 A
legend('Flat interface','Rough interface')
set(gca, 'YScale', 'log');
ylim([-Inf 10]);
xlim([0 0.5]);
xlabel('Q (Å^{-1})');
ylabel('R(Q)');
hold off

figure(2) %figure of roughness
plot(data2(:,5),data2(:,6),'--k') % no layer
hold on
plot(data2(:,1),data2(:,3),'-b') % layer of 20 A
%plot(data2(:,1),data2(:,4)) % layer of 60 A
plot(data2(:,1),data2(:,2),'-r') % layer of 100 A
legend('No layer','20 Å','100 Å')
set(gca, 'YScale', 'log');
ylim([-Inf 10]);
xlim([0 0.5]);
xlabel('Q (Å^{-1})');
ylabel('R(Q)');
hold off
