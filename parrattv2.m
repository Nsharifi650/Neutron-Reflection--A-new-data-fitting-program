function output = parratt(Q, Nb, d, sigma)

% Calculate distorted wavevector projections in each layer
k0 = Q / 2;
k = sqrt(k0^2 - 4 * pi * Nb);

% Phase shift upon traversing each layer
phi = zeros(1,length(Nb) - 1);
phi(2:end) = k(2:end-1) .* d(1:end);

% Fresnel reflection coefficient

r = zeros(1,length(Nb) - 1);
r = (k(1:end-1) - k(2:end))./(k(1:end-1) + k(2:end));
b = -2*k(1:end-1).*k(2:end).*(sigma(1:end).^2);
rbar = r.*exp(b);

% Reflectivity, travel through layers from bottom to top
X = zeros(1,length(Nb));
X(length(Nb)) = 0;
for j = length(sigma):-1:1
    X(j) = exp(-2i * phi(j)) * (rbar(j) + X(j+1).*exp(2i *k(j+1))) / (1 + rbar(j) * X(j+1).*exp(2i *k(j+1)));
end
output = abs(X(1))^2;
end