function [Smear]=Qresolution(Q,I,Qresol,N)
%[Smear]=Qresolution(Q,I,Qresol,N)
%
%   Q is the experimental wavevectors array
%   I is the experimental non-smeared scattered intensity
%   Qresol is the Q-dependent absolute resolution
%   N (default 2) is the minimum number of points to be contained in a six standard
%   deviation range. Lower N could leads to errors in the numerical
%   integration for low Q values.

if nargin < 4, N = 2; end;


sigmaQ=Qresol./(2*sqrt(log(2))); %Computates the std. dev. vector for each investigated Q; sigmaQ is an array!!
Smear=zeros(length(Q),1)';
Ncont=zeros(length(Q),1);
dQ=Q-circshift(Q,[1,-1]);
dQ(1)=[]; %dQ has one element less than Q, Qresol, etc...

% Smearj=zeros(length(Q));
% Rq_res=zeros(length(Q));
% for j=1:length(Q)
%     Rq_res(:,j)=1./(sqrt(2*pi)*sigmaQ(j)).*exp(-0.5.*(Q(:)-Q(j)).^2/sigmaQ(j)^2);
%     Smearj(:,j)=Rq_res(:,j).*I./sum(Rq_res(:,j),1);
% end;
% Smear=sum(Smearj,2)';

Qintmin=Q-3*sigmaQ;  %Definition of integration range for resolution evaluation; usually three std. dev.s
Qintmax=Q+3*sigmaQ;
for j=1:length(Q)
    %Smear(j)=0;
    %Qintmin=Q(j)-3*sigmaQ(j);  %Definition of integration range for resolution evaluation; usually three std. dev.s
    %Qintmax=Q(j)+3*sigmaQ(j);
    % Controllo che l'intervallo +-3sigma contenga almeno N punti.
    % Se così non fosse lascio invariata l'intensità e passo al Q successivo.
    Ncont(j)=length(find(Qintmin(j)<=Q& Q<=Qintmax(j)));
    if(Ncont(j)>=N)
        Area=0;
        for i=1:length(Q)-2
            if(Qintmin(j)<=Q(i)&& Q(i)<=Qintmax(j))
                Rq_res=1./(sqrt(2*pi)*sigmaQ(j)).*exp(-0.5.*(Q(i)-Q(j)).^2/sigmaQ(j)^2);
                Smear(j)=dQ(i)*Rq_res*I(i)+Smear(j);
                Area=dQ(i)*Rq_res+Area;
            end;
        end;
        Smear(j)=Smear(j)/Area;
    else
        Smear(j)=I(j);
    end;
end;
%loglog(Q,Smear,'-b');
