% 两边界为磁壁的1D FDTD
% 思路：电磁互换。但不是简单的互换符号，而是保留原有符号，然后修改取值范围。
% 长度较短的矩阵在迭代过程中整体被赋值，长度较长的矩阵在迭代中掐头去尾被赋值。

E0 = zeros(1,100);
E1 = E0;
H0 = zeros(1,101);
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
    
    H1(2:100) = H0(2:100) - coeff1 * (E0(2:100) - E0(1:99));
    E1(1:100) = E0(1:100) - coeff2 * (H1(2:101) - H1(1:100));

    E1(31) = E1(31) + exp(-((n-30)/15)^2);

    % Absorption boundary (Left)
%     E1(1) = c * (E1(2) - E1(1)) / dz * dt + E0(1);
%     H1(1) = c * (H1(2) - H1(1)) / dz * dt + H0(1);
%     E1(1) = E0(2) + (c*dt - dz) / (c*dt + dz) * (E1(2) - E0(1));

    % Absorption boundary (right)
%     E1(100) = E0(99) + (c*dt - dz) / (c*dt + dz) * (E1(99) - E0(100));

    figure(1);

    % 在真空波阻抗下，磁场的幅度数值是远远小于电场的。
%     plot(H1);
%     axis([1 110 -0.005 0.005])

    plot(E1);
    axis([1 110 -2 2]);

%     getframe;

    E0 = E1;
    H0 = H1;
end