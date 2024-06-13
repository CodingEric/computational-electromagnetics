% 四边界为电壁的2D TE FDTD，epsilon是矩阵

E0y = zeros(101,101);
E0x = zeros(101,101);
E1y = zeros(101,101);
E1x = zeros(101,101);

H0z = zeros(100,100);
H1z = zeros(100,100);

epsilon = ones(101,101);
epsilon(1:40,:) = 5;
epsilon = epsilon .* 1e-9 / (36 * pi);
mu = 4 * pi * 1e-7;
c = 3e8;
c_eps5 = 3e8 / sqrt(5);

delta = 0.01;
dt = 0.5*delta/c;

n = 0;
while true
    n = n + 1;
    
    % 以下符号规则都按书上的实现来写了。
    ksai6 = (H0z(2:100,2:100) - H0z(2:100, 1:99)) / delta;
    a2 = dt ./ epsilon(2:100,2:100);
    a3 = 1;
    E1x(2:100,2:100) = a3*E0x(2:100,2:100) + a2 .* ksai6;

    ksai5 = (H0z(2:100,2:100) - H0z(1:99, 2:100)) / delta;
    b2 = dt ./ epsilon(2:100,2:100);
    b3 = 1;
    E1y(2:100,2:100) = b3 * E0y(2:100, 2:100) - b2 .* ksai5;
    
    ita5 = (E1x(1:100,2:101) - E1x(1:100, 1:100)) / delta;
    ita6 = (E1y(2:101,1:100) - E1y(1:100, 1:100)) / delta;
    H1z(1:100,1:100) = H0z(1:100,1:100) + dt / mu * (ita5 - ita6);

    H1z(51, 51) = H1z(51, 51) + exp(-((n-30)/15)^2);
    
    % 四个吸收边界条件
    H1z(1,:) = H0z(2,:) + (c_eps5*dt - delta) / (c_eps5*dt + delta) * (H1z(2,:) - H0z(1,:));
    H1z(100,:) = H0z(99,:) + (c*dt - delta) / (c*dt + delta) * (H1z(99,:) - H0z(100,:));
    H1z(:,1) = H0z(:,2) + (c*dt - delta) / (c*dt + delta) * (H1z(:,2) - H0z(:,1));
    H1z(:,100) = H0z(:,99) + (c*dt - delta) / (c*dt + delta) * (H1z(:,99) - H0z(:,100));

%     imagesc(H1z,[-0.05,0.05]);
%     axis equal;
%     colorbar;

%     imshow(Ez1,[-0.5,0.5]);

    surf(1:100,1:100,H1z);
    zlim([-0.1 0.1]);

    getframe;

    H0z = H1z;
    E0x = E1x;
    E0y = E1y;
end