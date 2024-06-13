% 3D 有限差分方法

phi = zeros(101,101,101);
% phi(:,:,101) = 5;
phi1(25:75,25:75,25:75) = 5;

err = 100;
eps = 1e-4;
while(err > eps)
    phi1 = phi;
    phi1(2:100,2:100,2:100) = (phi(1:99,2:100,2:100)+phi(3:101,2:100,2:100)+phi(2:100,1:99,2:100)+phi(2:100,3:101,2:100)+phi(2:100,2:100,1:99)+phi(2:100,2:100,3:101))/6;
    
%     phi1(101,:,:) = phi1(100,:,:);
    phi1(25:75,25:75,25:75) = 5;

    err = max(max(max(abs(phi1-phi))));
    phi = phi1;
end

% contour(squeeze(phi(5,:,:)));
xslice = 1:10:101;   
% yslice = 1:5:101;
yslice = [];
zslice = [];
contourslice(1:101,1:101,1:101,phi,xslice,yslice,zslice)
view(3)

