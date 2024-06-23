function sh = sf_to_sh(sf, theta, phi, sh_order_max, smooth, full_basis, legacy)
% SF_TO_SH Convert spherical function to spherical harmonics
%
% Inputs:
%  sf: spherical function
%  theta: polar angle (theta)
%  phi: azimuthal angle (phi)
%  sh_order_max: maximum SH order
%  smooth: regularization paramater for SH fitting (default: 0)
%  full_basis: whether to use the full basis (default: false)
%  legacy: whether to use the legacy implementation as in DIPY (default: true)
% 
% Outputs:
%  sh: spherical harmonics coefficients
%
% Kaibo, 2024

if nargin < 5
    smooth = 0;
end

if nargin < 6
    full_basis = false;
end

if nargin < 7
    legacy = true;
end

sz = size(sf);

[B, ~, l] = real_sh_descoteaux(sh_order_max, theta, phi, full_basis, legacy);

L = -l.*(l+1);
L = sqrt(smooth)*L;
L = diag(L);
B_pinv = pinv([B'; L]);
B_pinv = B_pinv(:, 1:size(B,2));

sf = reshape(sf, [], sz(end));
sh = sf*B_pinv';
sh = reshape(sh, [sz(1:end-1), size(B_pinv,1)]);

end



