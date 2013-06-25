From: Felipe Balbi <balbi@ti.com>
Date: Tue, 25 Jun 2013 15:08:13 +0000
Subject: Re: [PATCH v2 3/5] video: exynos_mipi_dsim: Use generic PHY driver
Message-Id: <20130625150813.GB21334@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
 <1372170110-12993-3-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1372170110-12993-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2013 at 04:21:48PM +0200, Sylwester Nawrocki wrote:
> Use the generic PHY API instead of the platform callback to control
> the MIPI DSIM DPHY. The 'phy_label' field is added to the platform
> data structure to allow PHY lookup on non-dt platforms.
>=20
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

this is awesome :-)

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRybJdAAoJEIaOsuA1yqREvw4QAJNdJCiPv3WGbVora7qyh0zc
Ch97HxJ1pgzjJOKK8f/WjuXaYK1HCl1Ly/PxWSRsERPk7l83HkQImebOCJl3XwFj
R63wGnO10FoHo2ygw1Rw7MwiLl8L/1FPkVct75Z4IPPPuMIRrE0AEsvYomUEwCzp
hv6M1mEc37So1u0Dcsc5bc25vbHp5U8hxCTB7/W9mUcWkwgvHoPShGQFQlCDyc7A
jDoQc5KghJaQ9hinTfx8aoBdrJhl+nKPz1eeyuXJq9rHxh8UMayxzaIGeQTYakaq
FHQwkXfQPd0ZHFSLjNkQAzQ0GGUDNWqiOgWnpE7lGeu+MPZd6w3MoJ9kBWZdq0UE
h8uAcJd4dVZtzwWargRjHUWYhvaupUAJM5GWLE6Eum4Y18jNN1bOjoWOIH2oDhCo
fOVhwL+uCYKAfeJdkvGisON5UPs8GixHVXGyOk9kdLl5e5sA5orOIfJLGMaXrCmB
31l/C9fA2oSyDfgYyUFJ8pXAO+IFwU7gr12AMVYqIK8+gfwta75f5XY1NuesoOw+
kWrKqE82ey6N+puR8O2Z+RZHxI4Z0Wh7BBag8qQjgh7dDfWfAIRsSclvm6SNENs+
smC5NViiIsg7NkWGMl/zawaJMG/qs0Z18zWJmhAnuuiT9jPX9LUCd0NNtw16YeeN
oHA+ftgU7Vgr7lMjwb/H
=AUJ2
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
