Unofficial MATLAB Re-implementation of Selected Tools for Fitting Spherical Harmonics in DIPY
=============================================================================================

This repository contains an unofficial MATLAB re-implementation of selected tools for fitting spherical harmonics in DIPY. In particular, the following tools have been re-implemented:

- `real_sh_descoteaux` - returns the real spherical harmonics at the given `m`, `l`, `theta`, `phi` values.
- `Ylm` - returns the spherical harmonics at the given `m`, `l`, `theta`, `phi` values. This implementation is consistent with the SciPy implementation expect the notation for `theta` and `phi`.
    - MATLAB and DIPY uses `theta` for the polar angle and `phi` for the azimuthal angle.
    - SciPy uses `theta` for the azimuthal angle and `phi` for the polar angle.
- `sf_to_sh` - converts a spherical function to the fitted spherical harmonics coefficients.
- `sh_to_sf` - converts spherical harmonics coefficients to the corresponding spherical function.

In addition, in this toolbox, a helpful tool `bvec_to_theta_phi` is also included. This tool converts the gradient directions `bvec` in the Cartesian coordinate system to the corresponding `theta` and `phi` values.

Following the convention in dMRI, images are assumed to be of shape `H x W x L x N`, where `H`, `W`, `L` are the height, width, and length of the image, respectively, and `N` is the number of gradient directions. Similarly, the gradient directions, `bvec`, are assumed to be of shape `3 x N`.

Examples
--------

In Python with DIPY:

```python
from dipy.core.sphere import Sphere
from dipy.reconst.shm import sf_to_sh, sh_to_sf

odf = ...  # shape (H, W, L, N)
theta = ...  # shape (N,)
phi = ...  # shape (N,)
new_theta = ...  # shape (M,)
new_phi = ...  # shape (M,)

sphere = Sphere(theta=theta, phi=phi)
new_sphere = Sphere(theta=new_theta, phi=new_phi)

sh = sf_to_sh(odf, sphere, 8)
sf = sh_to_sf(sh, new_sphere, 8)
```

Similarly, in MATLAB with this toolbox:

```matlab
odf = ...;  % shape (H, W, L, N)
theta = ...;  % shape (N,)
phi = ...;  % shape (N,)
new_theta = ...;  % shape (M,)
new_phi = ...;  % shape (M,)

sh = sf_to_sh(odf, theta, phi, 8);
sf = sh_to_sf(sh, new_theta, new_phi, 8);
```

Detailed versions of the examples can be found here: [test.m](test.m) and [test.py](test.py).

Notes
-----

[Accompanying note for Spherical Harmonics Fitting](https://kvttt.github.io/files/Spherical_Harmonics_Fitting.pdf)


Referneces
----------

[Official DIPY Implementation](https://github.com/dipy/dipy/blob/master/dipy/reconst/shm.py)

[Spherical Harmonics from SciPy](https://docs.scipy.org/doc/scipy/reference/generated/scipy.special.sph_harm.html)

Descoteaux, M., et al. 2007. Regularized, fast, and robust analytical Q-ball imaging.

