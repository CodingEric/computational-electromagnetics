% 左边界是磁壁，右边界是电壁的 1D FDTD
% 这说明第一个 E 被赋值，并且参与 H 的赋值；第一个 H 不被赋值，但是参与 E 的赋值。
% 为了不更改网格结构（赋值的区域必须是连在一块的，中间不可跳过不赋值的点），我们可以认为第一个 E 的编号是 2。
% 这是一种不太好的实现方式，如果写在试卷上应该说明清楚。

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
    
    H1(2:100) = H0(2:100) - coeff1 * (E0(3:101) - E0(2:100));
    E1(2:100) = E0(2:100) - coeff2 * (H1(2:100) - H1(1:99));

    E1(31) = E1(31) + exp(-((n-30)/15)^2);

    % Absorption boundary (Left)
%     E1(1) = c * (E1(2) - E1(1)) / dz * dt + E0(1);
%     H1(1) = c * (H1(2) - H1(1)) / dz * dt + H0(1);
%     E1(1) = E0(2) + (c*dt - dz) / (c*dt + dz) * (E1(2) - E0(1));

    % Absorption boundary (right)
%     E1(101) = E0(100) + (c*dt - dz) / (c*dt + dz) * (E1(100) - E0(101));

    figure(1);
%     plot(H1);
%     axis([1 110 -0.005 0.005])
    
    % 注意这里也是从第二个点开始裁切 E 的。
    plot(E1(2:101));
    
    axis([1 110 -2 2]);
%     getframe;

    E0 = E1;
    H0 = H1;
end