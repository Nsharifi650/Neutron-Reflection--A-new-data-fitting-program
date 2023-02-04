%% notes
% Note order: ambient, top layer,...bottom layer, substrate 

% Step bounds: 4 columns per parameter[parameter number (1,2,3,4,..), step (0 is keeping it constant, lower limit, upperlimit]

% resolution
r = 0; % resolution factor - note the model currently uses constant resolution
%importing data
%data = xlsread('test.xlsx','D2O','A2:C716');
data = xlsread('test_lipids.xlsx','D2O','A2:D82');

% SLD_IG = [0,1.5e-6,6.3e-6]; % e.g. (if 4:) air, first layer, second layer, substrate
% thickness_IG = [100]; %substrate and medium (e.g. air) not included
% Sigma_IG = [5,2];
% IG = [SLD_IG,thickness_IG,Sigma_IG];  % initial conditions
% StepBounds = [1 1 0 0;2 1 0 0.5;3 1 0 0.5;4 1 0 0.5;5 1 0 10;6 1 0 10]; 

% SLD_IG = [0,7.1275e-07,5.3364e-07,2.6585e-06,1.6517e-06,3.5179e-06,5.5073e-06,2.2783e-05]; % (A/A^3) e.g. (if 4:) air, top layer,..., Bottom layer, substrate
% thickness_IG = [71.5,61,46.4,30.7,39.6,18.7];% %substrate and medium (e.g. air) not included
% Sigma_IG= [9.07,1,6.4,5.94,2.39,6.32,1]; % A


%% 5 layers fitted parameters
% SLD = 1.0e-03 *   0    0.0029    0.1279    0.0045    0.0127    0.0087    0.0212
% thickness =  18.3350    0.0000   41.9650   60.5630   56.9003
% Sigma =  0.0000   11.7718   12.7894    2.2006    1.6517    9.9247

%% fitted parameters for 4 layers - > test.xlsx
% SLD =   1.0e-04 *     0    0.0668    0.1485    0.0621    0.1631    0.2037
% thickness = 43.9633   28.2051   50.4754   35.5267
% Sigma =  6.2690    1.5356    7.4513    6.3894    4.0267

%% 6 layers fitted parameter
% SLD =   1.0e-04 *      0    0.1328    0.1983    0.1464         0    0.0459    0.0588    0.1504
% thickness =  118.7892   11.0147   45.7533   23.0573   34.2312   36.6999
% Sigma =   20.0000    0.0000    5.6470    7.4773    5.3790    0.0000    8.1013






% 4 layers
thickness_IG = [80.6828];
Sigma_IG = [1.7254    0.8];
SLD_IG = 1.0e-04 *[0    0.0074    0.0003];

% 5 layers
% thickness_IG = [80.6828   24.4557   47.4048  39.1055, 45];
% Sigma_IG = [1.7254    4    9.2682    7.0274    3.2160, 5];
% SLD_IG = 1.0e-04 *[0    0.0074    0.0003    0.0208    0.04  0.06   0.2126];

% 6 layers
% SLD_IG = 1.0e-04 *[0    0.074    0.03    0.0208    0.04    0.0075    0.0669    0.2126];
% thickness_IG = [80.6828   24.4557   47.4048   26.3796   39.1055   35.7983];
% Sigma_IG = [1.7254    0.08    9.2682    7.0274    3.2160    4.68    5.5782];

% SLD_IG = 1.0e-04 *[0    0.074    0.03    0.0208    0.04    0.0075    0.0669   0.05  0.2126];
% thickness_IG = [80.6828   24.4557   47.4048   26.3796   39.1055   35.7983, 45];
% Sigma_IG = [1.7254    0.08    9.2682    7.0274    3.2160    4.68    5.5782   8];

% setting up step bounds matrix
SLD_LL = 0;
SLD_UL = 0.1;
Sigma_LL = 0;
Sigma_UU = 12;
thickness_LL = 0;
thickness_UU = 150;
SLD_step = 1e-9;
thickness_step = 0.001;
Sigma_step = 0.001;

%% defining the stepbounds matrix
N = length(SLD_IG);
StepBounds = zeros(3*(N-1),4);
for i = 1: N
    StepBounds(i,:) = [i SLD_step SLD_LL SLD_UL];
end

for i = N+1: 2*(N-1)
    StepBounds(i,:) = [i thickness_step thickness_LL thickness_UU];
end

for i = (2*N)-1: 3*(N-1)
    StepBounds(i,:) = [i Sigma_step Sigma_LL Sigma_UU];
end

%8 layers
%StepBounds = [1 0 0 0;2 1e-9 SLD_LL SLD_UL;3 1e-9 SLD_LL SLD_UL;4 1e-9 SLD_LL SLD_UL;5 1e-9 SLD_LL SLD_UL;6 1e-9 SLD_LL SLD_UL; 7 1e-9 SLD_LL SLD_UL;8 1e-9 SLD_LL SLD_UL; 9 1e-9 SLD_LL SLD_UL; 10 0.001 thickness_LL thickness_UU;11 0.001 thickness_LL thickness_UU;12 0.001 thickness_LL thickness_UU;13 0.001 thickness_LL thickness_UU;14 0.001 thickness_LL thickness_UU;15 0.001 thickness_LL thickness_UU;16 0.001 thickness_LL thickness_UU;17 0.001 Sigma_LL Sigma_UU;18 0.001 Sigma_LL Sigma_UU;19 0.001 Sigma_LL Sigma_UU;20 0.001 Sigma_LL Sigma_UU;21 0.001 Sigma_LL Sigma_UU; 22 0.001 Sigma_LL Sigma_UU;23 0.001 Sigma_LL Sigma_UU;24 0.001 Sigma_LL Sigma_UU]; 

%7 layers
%StepBounds = [1 0 0 0;2 1e-9 SLD_LL SLD_UL;3 1e-9 SLD_LL SLD_UL;4 1e-9 SLD_LL SLD_UL;5 1e-9 SLD_LL SLD_UL;6 1e-9 SLD_LL SLD_UL; 7 1e-9 SLD_LL SLD_UL;8 1e-9 SLD_LL SLD_UL; 9 1e-9 SLD_LL SLD_UL; 10 0.001 thickness_LL thickness_UU;11 0.001 thickness_LL thickness_UU;12 0.001 thickness_LL thickness_UU;13 0.001 thickness_LL thickness_UU;14 0.001 thickness_LL thickness_UU;15 0.001 thickness_LL thickness_UU;16 0.001 thickness_LL thickness_UU;17 0.001 Sigma_LL Sigma_UU;18 0.001 Sigma_LL Sigma_UU;19 0.001 Sigma_LL Sigma_UU;20 0.001 Sigma_LL Sigma_UU;21 0.001 Sigma_LL Sigma_UU; 22 0.001 Sigma_LL Sigma_UU;23 0.001 Sigma_LL Sigma_UU;24 0.001 Sigma_LL Sigma_UU]; 

%6 layers
%StepBounds = [1 0 0 0;2 1e-9 0 0.1;3 1e-9 0 1.1;4 1e-9 0 1.1;5 1e-9 0 1;6 1e-9 0 1; 7 1e-9 0 1;8 1e-9 0 1; 9 0.001 0 150; 10 0.001 0 150;11 0.001 0 150;12 0.001 0 150;13 0.001 0 150;14 0.001 0 150;15 0.001 0 20;16 0.001 0 20;17 0.001 0 20;18 0.001 0 20;19 0.001 0 10;20 0.001 0 20;21 0.001 0 20]; 

% 5 layers
%StepBounds = [1 0 0 0;2 1e-9 0 0.1;3 1e-9 0 1.1;4 1e-9 0 1.1;5 1e-9 0 1;6 1e-9 0 1; 7 1e-9 0 1; 8 0.001 0 150; 9 0.001 0 150;10 0.001 0 150;11 0.001 0 150;12 0.001 0 150;13 0.001 0 20;14 0.001 0 20;15 0.001 0 20;16 0.001 0 20;17 0.001 0 20;18 0.001 0 20]; 

% 4 layers
%StepBounds = [1 0 0 0;2 1e-9 0 0.1;3 1e-9 0 1.1;4 1e-9 0 1.1;5 1e-9 0 1; 6 1e-9 0 1; 7 0.001 0 150; 8 0.001 0 150;9 0.001 0 150;10 0.001 0 150;11 0.001 0 10;12 0.001 0 10;13 0.001 0 10;14 0.001 0 10;15 0.001 0 10];


%StepBounds = [1 0 0 0;2 1e-9 0 0.1;3 1e-9 0 1.1;4 1e-9 0 1.1;5 1e-9 0 1; 6 1e-9 0 1; 7 0.001 0 150; 8 0.001 0 150;9 0.001 0 150;10 0.001 0 150;11 0.001 0 10;12 0.001 0 10;13 0.001 0 10;14 0.001 0 10;15 0.001 0 10];


IG = [SLD_IG,thickness_IG,Sigma_IG];  % initial conditions

global Ng % this is N but just want to use in Chi2 function
Ng = N;

%options; min, exit(return), improve 
[a b c] = fminuit('Chi2','Mplot',IG, [data],'-s',StepBounds);

SLD = a(1:N)
thickness = a(N+1:(2*(N-1)))
Sigma = a((2*N-1):(3*(N-1)))


%%
Q = linspace(0, 0.6,2000);

% constant resolution
Qresol = r*Q;

% Using experimental data
% Qresol = data(:,4);

R=zeros(1, length(Q));
RB=zeros(1, length(Q));

for n=1:length(Q)
    m = Q(n);
    R(n) = parratt(m, SLD, thickness, Sigma);
    RB(n) = Born(m,SLD, thickness,Sigma);
end

% SLD plot
z = linspace(-30,sum(thickness)+50,1000);
for i = 1:length(z)
    m = z(i);
    f(i) = SLD_plot(SLD,m,Sigma,thickness);
end

figure(1)
plot(z,f)


Rsmeared = Qresolution(Q,R,Qresol,3);
RBsmeared =Qresolution(Q,RB,Qresol,3);
figure(2)
plot(Q,Rsmeared)
hold on
%plot(Q,RBsmeared)
plot(data(:,1),data(:,2),'x')
errorbar(data(:,1),data(:,2),data(:,3),'x')
legend('Parratt','Experimental data')
set(gca, 'YScale', 'log');
ylim([-Inf 10]);
xlabel('Q (A^{-1})');
ylabel('R(Q)');
hold off

figure(3)
plot(Q,Rsmeared)
hold on
%plot(Q,RBsmeared)
legend('Simulated profile','Experimental data')
set(gca, 'YScale', 'log');
ylim([-Inf 10]);
xlabel('Q (A^{-1})');
ylabel('R(Q)');
hold off
