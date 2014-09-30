From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Sep 2014 10:54:58 +0000
Subject: Re: [RFC] fbdev: mxsfb: Add support for mx6sl and mx6sx
Message-Id: <542A8C02.4060305@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="coTSmNIkDfSUjFao8ODXFFABNjki4J90M"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--coTSmNIkDfSUjFao8ODXFFABNjki4J90M
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19/08/14 21:23, Fabio Estevam wrote:
> mx6sl and mx6sx share the same LCD controller as mx23 and mx28.
>=20
> Add support for it.
>=20
> The basic difference is the number of clocks that are required:
>=20
> - mx23/mx28: only one clock
> - mx6sl: two clocks
> - mx6sx: three clocks
>=20
> Tested on a mx28evk and mx6slevk.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> I am sending it as RFC because the scrolling is showing some artifacts =
when
> I boot with console=3Dtty0. The kernel messages are displayed correctly=
, but when
> it scrolls I see some garbage.

Is the garbage on the framebuffer memory? If so, I don't think this
patch can cause it.

> Appreciate any comment/suggestion to improve this.
>=20
>  drivers/video/fbdev/Kconfig |  2 +-
>  drivers/video/fbdev/mxsfb.c | 47 +++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index e911b9c..fd28987 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2420,7 +2420,7 @@ config FB_JZ4740
> =20
>  config FB_MXS
>  	tristate "MXS LCD framebuffer support"
> -	depends on FB && ARCH_MXS
> +	depends on FB && (ARCH_MXS || ARCH_MXC)
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
> index accf48a2..a567cc6 100644
> --- a/drivers/video/fbdev/mxsfb.c
> +++ b/drivers/video/fbdev/mxsfb.c
> @@ -172,6 +172,10 @@ struct mxsfb_info {
>  	struct fb_info fb_info;
>  	struct platform_device *pdev;
>  	struct clk *clk;
> +	struct clk *clk_axi;
> +	struct clk *clk_disp_axi;
> +	bool clk_axi_enabled;
> +	bool clk_disp_axi_enabled;
>  	void __iomem *base;	/* registers */
>  	unsigned allocated_size;
>  	int enabled;
> @@ -185,6 +189,42 @@ struct mxsfb_info {
>  #define mxsfb_is_v3(host) (host->devdata->ipversion =3D=3D 3)
>  #define mxsfb_is_v4(host) (host->devdata->ipversion =3D=3D 4)
> =20
> +/* Enable lcdif axi clock */
> +static inline void clk_enable_axi(struct mxsfb_info *host)
> +{
> +	if (!host->clk_axi_enabled && (!IS_ERR(host->clk_axi))) {
> +		clk_prepare_enable(host->clk_axi);
> +		host->clk_axi_enabled =3D true;
> +	}
> +}
> +
> +/* Disable lcdif axi clock */
> +static inline void clk_disable_axi(struct mxsfb_info *host)
> +{
> +	if (host->clk_axi_enabled && (!IS_ERR(host->clk_axi))) {
> +		clk_disable_unprepare(host->clk_axi);
> +		host->clk_axi_enabled =3D false;
> +	}

I think you could do the IS_ERR(clk_axi) check when getting the clock,
and if there's an error, do host->clk_axi =3D NULL. Then above you can do=

just:

if (host->clk_axi)
	clk_disable_unprepare(host->clk_axi);

And no need to clk_axi_enabled. And probably the helper functions can be
left out and have the code inline.

And similarly for clk_disp_axi, of course.

 Tomi



--coTSmNIkDfSUjFao8ODXFFABNjki4J90M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKowCAAoJEPo9qoy8lh71emYP/iu81fXZbj4weyZmjejE7Fx1
pkSW+PM82RdtuurRTBRiKM9psqmX/rQ/DKx2bYRsfarhWJ4Mtoys7iIULeRcEtT9
Cy3IfNv8V2MbW1dVNc6CKIGarsOycfMpQIjNEc11zM9/cCzIOqx6QtDIyA8wce/L
ibkx/czq0FuHDrI3M/b1xNQak14Fix159AV8/nkI8wCZrjHltHJeK24Kd0xySEmF
P/IIy2WAL/AcwvzxW+VYakO5FLCIuzIQ8RQV+/oJ5YAA9BP/WbsykTcrCQ/XAQH8
fRJ/6+91Sw53BZD89enVYKo7+hBAu6U5fxskcA84OVLhzW8TFtr3IjflefPJMFrW
xJwxOuVFLwwUbdYzxDoy/+hKizENyqOTdsrm3Vw0JntR+CYy8bt6qk/yUU6WlOwI
JtrA+0jePLRNNsU2OzpeB8kacg4eFf+OPgh/3sY/qRM+bPN5NpflSswc9bLc06MF
oL7T/PT89Wlq+324gCBIGSNQDJ8C3caEOvyjKLx+8YiECKp9M6tiGyhMzdRr+rpW
KuloSR8dV14LNBuXQIFPnconarwqpdmysgL2ee/rzBaGIFY0cslyjeU5XO4qqcnO
RkgTqEPeQ0//+C6Bqk/pnjzUzVXwO3IHEE3L15z0DVa5xuma5oFZwGGbEEITMB0r
VQxpq5lVtisPsItRV2Rv
=zfXf
-----END PGP SIGNATURE-----

--coTSmNIkDfSUjFao8ODXFFABNjki4J90M--
