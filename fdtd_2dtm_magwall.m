% 四边界为磁壁的2D TM FDTD，epsilon是常值

Ez0 = zeros(100, 100);
Ez1 = zeros(100, 100);

H0x = zeros(101, 101);
H1x = zeros(101, 101);
H0y = zeros(101, 101);
H1y = zeros(101, 101);

c = 3E8;
delta = 0.01;
dt = 0.5*delta/c;
eps = 1E-9/(36*pi);
mu = 4*pi*1E-7;

n = 0;

while true
    n = n + 1;
    
    c2 = dt / eps;
    c3 = 1;

    H1y(2:100,2:100)=H0y(2:100,2:100)+(dt/(delta*mu))*(Ez0(2:100,1:99)-Ez0(1:99,1:99));
    H1x(2:100,2:100)=H0x(2:100,2:100)-(dt/(delta*mu))*(Ez0(1:99,2:100)-Ez0(1:99,1:99));
    Ez1(1:100,1:100)=Ez0(1:100,1:100)+(dt/(delta*eps))*(H1y(2:101,2:101)-H1y(1:100,2:101)-H1x(2:101,2:101)+H1x(2:101,1:100));

    Ez1(51, 51) = Ez1(51, 51) + 5 * exp(-((n-30)/15)^2);

    % 四个吸收边界条件
    Ez1(1,:) = Ez0(2,:) + (c*dt - delta) / (c*dt + delta) * (Ez1(2,:) - Ez0(1,:));
    Ez1(100,:) = Ez0(99,:) + (c*dt - delta) / (c*dt + delta) * (Ez1(99,:) - Ez0(100,:));
    Ez1(:,1) = Ez0(:,2) + (c*dt - delta) / (c*dt + delta) * (Ez1(:,2) - Ez0(:,1));
%     Ez1(:,101) = Ez0(:,100) + (c*dt - delta) / (c*dt + delta) * (Ez1(:,100) - Ez0(:,101));

    imagesc(Ez1,[-0.25,0.25]);
%     imshow(Ez1,[-0.5,0.5]);
    axis equal;
    colorbar;

%     surf(1:100,1:100,Ez1);
%     zlim([-0.5 0.5]);

    getframe;

    Ez0 = Ez1;
    H0x = H1x;
    H0y = H1y;
end
