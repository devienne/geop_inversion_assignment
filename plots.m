%% plot vs0 as a function of depth z;
figure;
plot (z, vs0, 'bo-');
xlabel ("depth (km)");
ylabel ("v_{s0} (km/s)");
title ("Initial velocity model v_{s0}");
grid on;
dpi = 300;
print('vs0.png', ['-r', num2str(dpi)], '-dpng');

%%% plot vf0 and vfm to compare the measured and inverted results ;
figure;
plot (T, vf0, 'ro-', T, vfm, 'bo-');
xlabel ("Period, T (s)");
ylabel ("v_{fm} (km/s)");
title ("Observed phase velocity v_{fm}");
grid on;
dpi = 300;
print('vf0.png', ['-r', num2str(dpi)], '-dpng');

%%% plot G^T;
figure;
colormap ("default");
pcolor (T,z,Gt);
shading interp;
axis tight;
imagesc (Gt);
colorbar ();
xlabel ("Period (s)");
ylabel ("Depth (km)");
title ("G^T sensibility to d_{vf} and d_{vs}");
dpi = 300;
print('G^T.png', ['-r', num2str(dpi)], '-dpng');

lambda = 6e-5

G_transpose = transpose(G);
G_transpose_G = G_transpose * G;
identity = eye(size(G_transpose_G));
G_transpose_G_damped = G_transpose_G + lambda^2 * identity;
G_transpose_dvf = G_transpose * dvf;
dvs = G_transpose_G_damped \ G_transpose_dvf;

