function  output = Born(Q, Nb, thickness,sigma)
% this method splits the integral into the sum of many integrals for each
% layer
%Sig = 0;
b = 10^5;
for n = 1:length(Nb)
    if n ==1 % air
        A = (Nb(n)*1i/Q)*(exp(0)-exp(1i*Q*b));
    elseif n ==length(Nb)
        A = A+(Nb(n)*1i/Q)*(exp(-1*Q*b)-exp(-1i*Q*sum(thickness(1:n-2))))*exp(-1*((sigma(n-1)*Q)^2)/2);
    else        
        A = A+(Nb(n)*1i/Q)*(exp(-1i*Q*sum(thickness(1:n-1)))-exp(-1i*Q*sum(thickness(1:n-2))))*exp(-1*((sigma(n-1)*Q)^2)/2);
       
    end
end
output = ((4*pi/Q)^2)*((abs(A))^2);
end