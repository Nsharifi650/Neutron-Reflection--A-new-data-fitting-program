% SLD = [0,3,8,4];
% thickness=[100,200];
% Sig = [8,6,5];
% z = linspace(-40,340,1000);
% f = SLD_plot(SLD,z,Sig,thickness);
% plot(z,f)


% SLD = [0,4];
% thickness=[];
% Sig = [8];
% z = linspace(-30,30,1000);
% % f = SLD_plot(SLD,z,Sig,thickness);
% plot(z,f)

% SLD = [0,4,1];
% thickness=[100];
% Sigma = [8,8];

% SLD = [0,4,1,8];
% thickness=[100,100];
% Sigma = [8,8,3];

% SLD = [0,2,5,4,2,1,5];
% thickness=[10,20,20,20,20];
% Sigma = [10,10,10,10,8,10];
% 

SLD = 1.0e-04 *[-0.1039   -0.0016    0.0602]
thickness =  106.9914
Sigma = [88.1860   -4.1967]

z = linspace(-50,sum(thickness)+50,1000);
for i = 1:length(z)
    m = z(i);
    f(i) = SLD_plot(SLD,m,Sigma,thickness);
end
plot(z,f)




% function f = SLD_plot(x, mu, s)
% p1 = -.5 * ((x - mu)/s) .^ 2;
% p2 = (s * sqrt(2*pi));
% f = exp(p1) ./ p2; 
% end
% 
% x = linspace(-10, 10,1000);
% f = SLD_plot(x,0,3);
% plot(x,f)
% 
