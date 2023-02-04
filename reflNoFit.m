% Note order: ambient, top layer,...bottom layer, substrate 

% resolution
r = 0.002; % resolution factor - 
% initial guess
% SLD = [0,1.5e-6,1.5e-6,1.5e-6,1.5e-6,1.5e-6,1.5e-6,1.5e-6,1.5e-6,1.5e-6,1.5e-6,1.5e-6,1.5e-6,1.5e-6,6.3e-6]; % e.g. (if 4:) air, first layer, second layer, substrate
% thickness = [60,60,60,60,60,60,60,60,60,60,60,60,60];%[9,10]; %substrate and medium (e.g. air) not included
% Sigma= [2,2,2,2,2,2,2,2,2,2,2,2,2,2];



% x-ray SLD
%Silica: 2.2724e-05, Palmitic acid: 8.1522e-06

% SLD = [0,1e-6,4e-6];
% Sigma =[5,3];
% thickness = [20];

% thickness = [80.6828   24.4557   47.4048   26.3796   39.1055   18.7983];
% Sigma = [1.7254    0.0008    9.2682    7.0274    3.2160    0.0468    5.5782];
% SLD = 1.0e-04 *[0    0.0074    0.0003    0.0208    0.0000    0.0075    0.0669    0.2126];

thickness = [80.6828   40.4557   70.4048   26.3796   39.1055   18.7983];
Sigma = [1.7254    0.0008    9.2682    7.0274    3.2160    0.0468    5.5782];
SLD = 1.0e-04 *[0    0.0074    0.0003    0.0208    0.0000    0.0075    0.0669    0.2126];


data = xlsread('test.xlsx','D2O','A2:C762');


% SLD = [0,7.1275e-07,5.3364e-07,2.6585e-06,1.6517e-06,3.5179e-06,5.5073e-06,2.2783e-05]; % (A/A^3) e.g. (if 4:) air, top layer,..., Bottom layer, substrate
% thickness = [71.5,61,46.4,30.7,39.6,18.7];% %substrate and medium (e.g. air) not included
% Sigma= [9.07,1,6.4,5.94,2.39,6.32,1]; % A

N = length(SLD);

% %%
% Q = linspace(0, 0.3,6000);
% 
% % constant resolution
% Qresol = r*Q;
% 
% % Using experimental data
% % Qresol = data(:,4);
% 
% R=zeros(1, length(Q));
% RB=zeros(1, length(Q));
% 
% for n=1:length(Q)
%     m = Q(n);
%     R(n) = parratt(m, SLD, thickness, Sigma);
%     RB(n) = Born(m,SLD, thickness,Sigma);
%     R2(n) = parrattv2(m, SLD, thickness, Sigma);
%     
% end
% 
% Rsmeared = Qresolution(Q,R,Qresol,3);
% R2smeared = Qresolution(Q,R2,Qresol,3);
% RBsmeared =Qresolution(Q,RB,Qresol,3);
% figure(1)
% plot(Q,RBsmeared)
% hold on
% plot(Q,Rsmeared)
% %plot(data(:,1),data(:,2),'x')
% %errorbar(data(:,1),data(:,2),data(:,3),'x')
% legend('Born approximation','Parratt','Experimental data')
% set(gca, 'YScale', 'log');
% ylim([-Inf 10]);
% xlabel('Q (Å^{-1})');
% ylabel('R(Q)');
% hold off


%% just Paratts
Q = linspace(0, 0.6,6000);

% constant resolution
Qresol = r*Q;

% Using experimental data
% Qresol = data(:,4);

R=zeros(1, length(Q));

% Reflectivity profile
for n=1:length(Q)
    m = Q(n);
    R(n) = parratt(m, SLD, thickness, Sigma);
    RB(n) = Born(m,SLD, thickness,Sigma);
end

% SLD Plot
%z = linspace(-30,sum(thickness)+50,1000);
% for i = 1:length(z);
%     m = z(i);
%     f(i) = SLD_plot(SLD,m,Sigma,thickness);
% end
% figure(1)
%plot(z,f)


Rsmeared = Qresolution(Q,R,Qresol,3);
RBsmeared = Qresolution(Q,RB,Qresol,5);
figure(2)
plot(Q,Rsmeared)
hold on
plot(data(:,1),data(:,2),'x')
set(gca, 'YScale', 'log');
ylim([-Inf 1]);
xlabel('Q (A^{-1)}');
ylabel('R(Q)');
hold off