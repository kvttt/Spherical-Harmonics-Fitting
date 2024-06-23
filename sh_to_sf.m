function sf = sh_to_sf(sh, theta, phi, sh_order_max, full_basis, legacy)
% SH_TO_SF Convert spherical harmonics to spherical function
%
% Inputs:
%  sh: spherical harmonics coefficients
%  theta: polar angle (theta)
%  phi: azimuthal angle (phi)
%  sh_order_max: maximum SH order
%  full_basis: whether to use the full basis (default: false)
%  legacy: whether to use the legacy implementation as in DIPY (default: true)
%
% Outputs:
%  sf: spherical function
%
% Kaibo, 2024

if nargin < 5
    full_basis = false;
end

if nargin < 6
    legacy = true;
end

[B, ~, ~] = real_sh_descoteaux(sh_order_max, theta, phi, full_basis, legacy);

sf = B'*sh(:);

end