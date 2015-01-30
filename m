From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Jan 2015 07:46:22 +0000
Subject: Re: [PATCH] video/mmpfb: allow modular build
Message-Id: <54CB36CE.3090404@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dN8cTOKQWPp48AwPLre0Ku7RBux7SUaR1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <8150312.I9dm5QVFgr@wuerfel>
In-Reply-To: <8150312.I9dm5QVFgr@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--dN8cTOKQWPp48AwPLre0Ku7RBux7SUaR1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 28/01/15 22:13, Arnd Bergmann wrote:
> The frame buffer core can be a module, which means any fb drivers
> should be able to build as modules too. This turns mmpfb into
> a tristate option to allow that and fix a possible randconfig
> build error.
>=20
> drivers/built-in.o: In function `modes_setup':
> :(.text+0x11b34): undefined reference to `fb_videomode_to_modelist'
> :(.text+0x11b5c): undefined reference to `fb_videomode_to_var'
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> diff --git a/drivers/video/fbdev/mmp/Makefile b/drivers/video/fbdev/mmp=
/Makefile
> index a014cb358bf8..924dd0930cc7 100644
> --- a/drivers/video/fbdev/mmp/Makefile
> +++ b/drivers/video/fbdev/mmp/Makefile
> @@ -1 +1,3 @@
> -obj-y +=3D core.o hw/ panel/ fb/
> +obj-$(CONFIG_MMP_DISP) +=3D mmp_disp.o hw/ panel/ fb/
> +
> +mmp_disp-y		+=3D core.o
> diff --git a/drivers/video/fbdev/mmp/fb/Kconfig b/drivers/video/fbdev/m=
mp/fb/Kconfig
> index 9b0141f105f5..985e1a7cd254 100644
> --- a/drivers/video/fbdev/mmp/fb/Kconfig
> +++ b/drivers/video/fbdev/mmp/fb/Kconfig
> @@ -1,7 +1,7 @@
>  if MMP_DISP
> =20
>  config MMP_FB
> -	bool "fb driver for Marvell MMP Display Subsystem"
> +	tristate "fb driver for Marvell MMP Display Subsystem"
>  	depends on FB
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>=20

Thanks, queued for 3.20.

 Tomi



--dN8cTOKQWPp48AwPLre0Ku7RBux7SUaR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyzbOAAoJEPo9qoy8lh71H1IP/36bOvOAPYXeVNqOqVsVkX2I
1zjaKXbs7x0KQ8tfNvu55IfPcp2o74vex3+j0lKp57dV1qYPotR/PrUKf4F8uTmp
vnMIXL1GLiq1eiYDcgdihpHuEeGQSqdp90l3g9cmO2NPkRuLtsxPOXlb/bKO30Fq
GZUMZoUKzixkhdlT8evIgh1at9C3d63rzjj3KBmoeqWh6MB42pL8YkLMd8xJLeFP
u5jpbpNIaPByN3AGonDIbejCz8CnjItE77TVv629Qpt7QmHZskfAIwOId7/ybdla
DRgQ74JLbBjhd7LB+BsZpz6jIbP7WrA/Vi+Pzqa1itLdLi0d/GCuuepUZ8++P8ma
Em9aSUpCzu4FaUPN151hY42j1Aq0L7brPsi/5lwnFxLhunIPURuH1u0p/Sx0do+l
8AZ5/7HM2O5Q8HITLsZq72ZVj+nFNFBVOOWsFfPi8nGJp6w9VjAa+yIxHVYT8YBx
3lvWu7Pi0pEFoLhn8dSe8CB3/q09CEMVNRmAeCzEdXi8iXUr0Qbbdg8li74Vx8Dn
gCenAhIQMOneFz2m67nEuQtET56V7Xc1zRW/QSwYSsGXXs6GouCWUGKafS75oSE+
54z3Iqkw2IkfiWXPmYT8t/Cst0WSmup18opDZAzv1Wu63f0nwOQahSz7+I/MDzBL
dfvWHAO9wULL81KPJlKj
=osxK
-----END PGP SIGNATURE-----

--dN8cTOKQWPp48AwPLre0Ku7RBux7SUaR1--
