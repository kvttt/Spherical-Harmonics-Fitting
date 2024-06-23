function [real_sh, m, l] = real_sh_descoteaux(sh_order_max, theta, phi, full_basis, legacy)
% REAL_SH_DESCOTEAUX Calculate the real spherical harmonics
%
% Inputs:
%  sh_order_max: maximum SH order
%  theta: polar angle (theta), supports vectorization
%  phi: azimuthal angle (phi), supports vectorization
%  full_basis: whether to use the full basis (default: false)
%  legacy: whether to use the legacy implementation as in DIPY (default: true)
%
% Outputs:
%  real_sh: real harmonics $Y^m_l$ for specified (m, l) at (theta, phi)
%  m: column vector of phase factor (m)
%  l: column vector of order (l)
% 
% Kaibo, 2024

if nargin < 4
    full_basis = false;
end

if nargin < 5
    legacy = true;
end

[m, l] = sph_harm_ind_list(sh_order_max, full_basis);
real_sh = real_sh_descoteaux_from_index(m, l, theta, phi, legacy);

end


function [m, l] = sph_harm_ind_list(sh_order_max, full_basis)

if nargin < 2
    full_basis = false;
end

if full_basis
    m = zeros((sh_order_max+1)*(sh_order_max+1), 1);
    l = zeros((sh_order_max+1)*(sh_order_max+1), 1);  
    for curr_l = 0:sh_order_max
        m(curr_l^2+1:(curr_l+1)^2) = -curr_l:curr_l;
        l(curr_l^2+1:(curr_l+1)^2) = curr_l;
    end
else
    m = zeros((sh_order_max+1)*(sh_order_max+2)/2, 1);
    l = zeros((sh_order_max+1)*(sh_order_max+2)/2, 1);
    for curr_l = 0:2:sh_order_max
        m((curr_l-1)*curr_l/2+1:(curr_l+1)*(curr_l+2)/2) = -curr_l:curr_l;
        l((curr_l-1)*curr_l/2+1:(curr_l+1)*(curr_l+2)/2) = curr_l;
    end
end

end


function real_sh = real_sh_descoteaux_from_index(m, l, theta, phi, legacy)

if nargin < 5
    legacy = true;
end

if legacy
    sh = Ylm(abs(m), l, phi, theta);
else
    sh = Ylm(m, l, phi, theta);
end

real_sh = (m>0).*imag(sh)*sqrt(2) ...
        + (m==0).*real(sh) ...
        + (m<0).*real(sh)*sqrt(2);

end
        