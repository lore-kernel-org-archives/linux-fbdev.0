From: Felipe Balbi <balbi@ti.com>
Date: Thu, 24 Oct 2013 15:31:29 +0000
Subject: Re: [PATCH] drivers: video: exynos: Fix compiler Warning
Message-Id: <20131024153129.GH2834@gimli>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UthUFkbMtH2ceUK2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOesGMhwotSY-1WQmt+wtsrsH2m30VE=j-MwyhpYU3mt_PSPPw@mail.gmail.com>
 <1382628454-11951-1-git-send-email-kishon@ti.com>
In-Reply-To: <1382628454-11951-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org

--UthUFkbMtH2ceUK2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2013 at 08:57:34PM +0530, Kishon Vijay Abraham I wrote:
> Fixed the following compilation warning:
> ../../drivers/video/exynos/exynos_mipi_dsi.c: In function
> 'exynos_mipi_dsi_blank_mode':
> ../../drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning: unused
> variable 'pdev' [-Wunused-variable]
>   struct platform_device *pdev =3D to_platform_device(dsim->dev);
>=20
> Reported-by: Olof Johansson <olof@lixom.net>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

pretty obvious patch:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--UthUFkbMtH2ceUK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSaT1RAAoJEIaOsuA1yqREtMAP/17EdIiqHvo3gmNeb02LwVQz
Fblw1hayYmeoNSix/avOSqjtljBOM+qdqCusH4GoxjY5VphYJjrch/+GpvmlTVYV
WOWvmdRdRv43CHBkTIexgWaVh9NIUKQUbtNwG5e7bYUcaBe27l4QsuQ41fUvd426
TfaCHiTYqSXR+mSGBbbXtL4IK8Z1o8JtLg6ETmbYaoEDmQX4cF3Pu8MO7fGWFq0I
Bnm4WI/E/ngbTGWiyUMyxFOi/HqMkvWiCLWs4wxCo1J8oD3o6DwcVCwlQ0IYdgkH
JwB1nb0eNwxqRqpygMaAe+BwvvwczQ2O9Q2tKBM8I0qWUXb0UcodMTn20iEy09je
GTwSNA0F30mX/jnc8tss8u57YIEo5SS46ELiqfhhqEiO42EtX/HRzovxjvrn/jwH
ei2r1EZQd4z2S4z9LIbSf8BjeEYisVuWK+94yoxnCjyCX4dre4PlcxK6Qmvq9auf
+ZZi83Cap3wc72KvJMEsJ3+uPBDrnR/6t2FWofVzlsIqygghQyPNF2tfncHrbvAj
khXxfxIh08tbZTB7mD9LxyhZGipMBfZa6eqUxMQ6OSw+sYT+vru1zkDt+krAcBwC
szFj0Xc2XtetN9dFsW3/4GUmq5v5t4pEwFACCeQ4hnTPZOe6YjMID5djfwqB/2Z8
0hcIlK/vPaitAnJj8GDY
=3Wlx
-----END PGP SIGNATURE-----

--UthUFkbMtH2ceUK2--
