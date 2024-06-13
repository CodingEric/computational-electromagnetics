% 两边界为电壁的1D FDTD

E0 = zeros(1,101);
E1 = E0;
H0 = zeros(1,100);
H1 = H0;

c = 3E8;
dz = 0.3;
dt = 0.5*dz/c;
eps = 1E-9/(36*pi);
mu = 4*pi*1E-7;
coeff1 = dt / (mu * dz);
coeff2 = dt / (eps * dz);

n = 0;

while true
    n = n + 1;
    
    H1(1:100) = H0(1:100) - coeff1 * (E0(2:101) - E0(1:100));
    E1(2:100) = E0(2:100) - coeff2 * (H1(2:100) - H1(1:99));

    E1(31) = E1(31) + exp(-((n-30)/15)^2);

    % Absorption boundary (Left)
%     E1(1) = c * (E1(2) - E1(1)) / dz * dt + E0(1);
%     H1(1) = c * (H1(2) - H1(1)) / dz * dt + H0(1);
%     E1(1) = E0(2) + (c*dt - dz) / (c*dt + dz) * (E1(2) - E0(1));

    % Absorption boundary (right)
%     E1(101) = E0(100) + (c*dt - dz) / (c*dt + dz) * (E1(100) - E0(101));

    figure(1);
    plot(H1);

    axis([1 110 -0.005 0.005])
%     axis([1 110 -2 2]);
%     getframe;

    E0 = E1;
    H0 = H1;
end