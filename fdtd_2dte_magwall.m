% 四边界为电壁的2D TE FDTD，epsilon是定值

E0y = zeros(100,100);
E0x = zeros(100,100);
E1y = zeros(100,100);
E1x = zeros(100,100);

H0z = zeros(101,101);
H1z = zeros(101,101);

epsilon = 1e-9 / (36 * pi);
mu = 4 * pi * 1e-7;
c = 3e8;

delta = 0.01;
dt = 0.5*delta/c;

n = 0;
while true
    n = n + 1;

    ksai6 = (H0z(2:101,2:101) - H0z(2:101, 1:100)) / delta;
    a2 = dt / epsilon;
    a3 = 1;
    E1x(1:100,1:100) = a3*E0x(1:100,1:100) + a2 * ksai6;

    ksai5 = (H0z(2:101,2:101) - H0z(1:100, 2:101)) / delta;
    b2 = dt / epsilon;
    b3 = 1;
    E1y(1:100,1:100) = b3 * E0y(1:100, 1:100) - b2 * ksai5;
    
    ita5 = (E1x(1:99,2:100) - E1x(1:99, 1:99)) / delta;
    ita6 = (E1y(2:100,1:99) - E1y(1:99, 1:99)) / delta;
    H1z(2:100,2:100) = H0z(2:100,2:100) + dt / mu * (ita5 - ita6);

    H1z(51, 51) = H1z(51, 51) + exp(-((n-30)/15)^2);

    % 吸收边界条件
%     H1z(1,:) = H0z(2,:) + (c*dt - delta) / (c*dt + delta) * (H1z(2,:) - H0z(1,:));

%     imagesc(H1z,[-0.05,0.05]);
%     axis equal;
%     colorbar;

%     imshow(Ez1,[-0.5,0.5]);

    surf(1:101,1:101,H1z);
    zlim([-0.1 0.1]);

    getframe;

    H0z = H1z;
    E0x = E1x;
    E0y = E1y;
end