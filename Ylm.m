function Ylm = Ylm(m, l, theta, phi)
% SPHERICAL_HARMONICS Calculate the spherical harmonics
% 
% Inputs:
%  m: phase factor (m), supports vectorization
%  l: order (l), supports vectorization (need to be the same size as m)
%  theta: polar angle (theta), supports vectorization
%  phi: azimuthal angle (phi), supports vectorization
% 
% Outputs:
%  Ylm: harmonics $Y^m_l$ for specified (m, l) at (theta, phi)
%
% The following MATLAB and Python code are equivalent:
%  - MATLAB: Ylm(m, l, theta, phi)
%  - Python: scipy.special.sph_harm(m, l, phi, theta)
%  - The reason why the order of phi and theta are swapped is because
%    MATLAB and DIPY use theta for the polar angle and phi for the azimuthal angle
%    while SciPy uses phi for the polar angle and theta for the azimuthal angle
% 
% Caveats:
%  - m and l are internally converted to column vector
%  - theta and phi are internally converted to row vectors
%
% Kaibo, 2024

m = m(:); 
mask = (-1).^m.*(m>=0)+(m<0); % for undoing Condon-Shortley factor

l = l(:);

theta = theta(:)';
phi = phi(:)';

Ylm = zeros(length(m), length(theta));

for curr_l = unique(l)'
    curr_m = m(l==curr_l);
    curr_Pl = legendre(curr_l, cos(theta), 'norm');
    curr_Plm = curr_Pl(abs(curr_m)+1, :).*mask(l==curr_l);
    curr_Ylm = (1/sqrt(2*pi))*curr_Plm.*exp(1i*curr_m*phi);
    Ylm(l==curr_l, :) = curr_Ylm;
end

end