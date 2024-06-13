% 2D 有限差分方法

phi = zeros(101,101);
phi(101,:) = -5;

err = 100;
eps = 1e-5;

% phi(,) 中索引为 1 和 101 的区域是边界。

while(err > eps)
    phi1 = phi;
    phi1(2:100,2:100) = 0.25*(phi(1:99,2:100)+phi(3:101,2:100)+phi(2:100,1:99)+phi(2:100,3:101));

    phi1(:,101) = phi1(:,100);
    
    err = max(max(abs(phi1-phi)));
    phi = phi1;
end

contour(phi);
axis equal;