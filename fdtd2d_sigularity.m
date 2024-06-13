% 左边界为电壁，右边界为磁壁的1D FDTD
% 也就是说最后一个 H 不被赋值，但是参与到 E 的确定中。而最后一个 E 被赋值，且参与到 H 的确定中。

E0 = zeros(1,100);
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
    
    H1(1:99) = H0(1:99) - coeff1 * (E0(2:100) - E0(1:99));
    E1(2:100) = E0(2:100) - coeff2 * (H1(2:100) - H1(1:99));

    E1(31) = E1(31) + exp(-((n-30)/15)^2);
    
    figure(1);
    plot(H1);
    axis([1 110 -0.005 0.005])

    E0 = E1;
    H0 = H1;
end