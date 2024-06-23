function [theta, phi] = bvec_to_theta_phi(bvec)
% BVEC_TO_THETA_PHI Convert bvec to theta and phi
%
% Inputs:
%  bvec: bvec in 3D Cartesian coordinates
%
% Outputs:
%  theta: polar angle (theta)
%  phi: azimuthal angle (phi)
%
% Kaibo, 2024

theta = atan2(sqrt(bvec(1,:).^2+bvec(2,:).^2), bvec(3,:));
phi = atan2(bvec(2,:), bvec(1,:));

r = sqrt(bvec(1,:).^2+bvec(2,:).^2+bvec(3,:).^2);
del_r = abs(r(:)-1);

if any(del_r>1e-6)
    warning('The norm of at least one of the bvecs is not 1.');

end

