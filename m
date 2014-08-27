From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 27 Aug 2014 13:43:50 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827134350.GV15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="f/EACO4z5I3O9Pl6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
In-Reply-To: <20140827093121.GA23186@ulmo>
To: linux-arm-kernel@lists.infradead.org


--f/EACO4z5I3O9Pl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 27, 2014 at 11:31:24AM +0200, Thierry Reding wrote:
> > and only pretty much you against it,
>=20
> At least Stephen also spoke out about it. But this quickly devolved into
> the kind of thread you want to get out of as quickly as possible, so I
> can't blame him for not continuing this discussion. In fact I'm very
> much regretting getting into this in the first place. You clearly have
> no intention to even consider any possible other solution that what was
> posted, so it's pretty useless to try and convince you.

No. I'm ready to consider any solution that doesn't involve hardcoding
these clocks in the kernel clock driver. I believe that is a pretty
similar, yet opposite, stance than the one you're currently making.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--f/EACO4z5I3O9Pl6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/eCWAAoJEBx+YmzsjxAgLxcP/3JprJbCIY13FoUsPcz68bBV
1xRtNBWCelbsKihajhrmw2TCaEDjaUiuwxFCGRgxHt3Zb/Ap/P0++8JWRkQUYzxh
HH8B6/dAE6YwlLUv545UnzQJwGwLC6mTH4gg2dKoPz5ISx5cDjnL4GNLE4toKUSI
lxv6NwkbT2EGcaqmmCozTRES1L0WQeYo6RzkoO7w3zM5PlyH/VrII/OiY0akA6nB
ougrG7MLJcldm8eHJsaJHLfzY3+PNCdVMHJfaQT8iQXKHAmDxrBZn/z1n87gmTuc
rqg4eJQGRkWXix+SGJ6dIWlDTwKdFbY+edZFm+rqcF8+/lGzHvV/UJsSNeLbd1ab
Cbt4QYZ5YX2T1GR9pVQQEaqOX8+ejoGYehsV+BsVOyZHHx4ZfJUPxrsfGKUhZ4b4
8sMehKsPfwPbB375+fbllBbkn91TJstYbGJnYmfxHvZ+eAXXKSfW9FKEGZ9+irbu
oWcIRF8V27G/dlBWG9Ao8BdixLbxClfZa0KLHkyXgHqn9gQmHfeb68y/59XUPQTa
kvM9tDaGCW54d8eiJNTYKEnPX0xJEJiuhijJHkqvTJ+yRwfsvgVGDQBAgNLk0MqZ
0FRJzaKAxdDINN/ZdOk/TQHaKNf/SgSy4wKEjm0Cf8z7a07VMRtkTn4kIDk2xUEU
oBb0uCZg5pnwd12nu2he
=C3OD
-----END PGP SIGNATURE-----

--f/EACO4z5I3O9Pl6--
