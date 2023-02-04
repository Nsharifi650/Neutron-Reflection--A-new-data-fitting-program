function ChiSqu = Chi2(par,data)
global Ng % this is N but just want to use in Chi2 function
N = Ng;

for n=1:N
    SLD(n) = par(n);
end

for n = N+1:(2*(N-1))
    thickness(n-N) = par(n);
end

for n=(2*N-1):(3*(N-1))
    Sigma(n-(2*N-2)) = par(n);
end

% SLD = [par(1),par(2),par(3),par(4)];
% thickness = [par(5),par(6)];
% Sigma = [par(7), par(8), par(9)];


% if isempty(SLD)
%     for n=1:N
%         SLD(n) = par(n);
%     end
%     
%     for n = N+1:(2*(N-1))
%         thickness(n-N) = par(n);
%     end
%     
%     for n=(2*N-1):(3*(N-1))
%     Sigma(n-(2*N-2)) = par(n);
%     end


% N = length(SLD);
% n =0;
% for i = 1:N
%     if SLD(i) == 'v'
%         n = n+1;
%        SLD(i) = par(n);
%     end
% end
% 
% for i = n+1: N+n-2
%     thickness(i-n)= par(i);
% end
% 
% for i = N+n-1: n+(2*N)-3
%     Sigma(i-(N+n-2))= par(i);
% end

%for n=1:length(SLD)-2
%         thickness(n) = par(n);
%     end
%     for n=length(SLD)-1:(length(SLD)-1 + length(SLD)-2)
%         Sigma(n-length(thickness)) = par(n);
%     end


% if isempty(SLD)
%     for n=1:N
%         SLD(n) = par(n);
%     end
%     
%     for n = N+1:(2*(N-1))
%         thickness(n-N) = par(n);
%     end
%     
%     for n=(2*N-1):(3*(N-1))
%     Sigma(n-(2*N-2)) = par(n);
%     end
%     
% else
%     for n=1:length(SLD)-2
%         thickness(n) = par(n);
%     end
%     for n=length(SLD)-1:(length(SLD)-1 + length(SLD)-2)
%         Sigma(n-length(thickness)) = par(n);
%     end
% end


R = zeros(length(data));
ChiSqu = 0;
for n = 1:length(data(:,1))
    m = data(n,1);
    R(n) = parratt(m, SLD, thickness, Sigma);
    ChiSqu = ChiSqu + ((R(n)-data(n,2))/(data(n,3))).^2; %
end
end
