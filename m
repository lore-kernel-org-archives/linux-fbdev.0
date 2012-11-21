From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 21 Nov 2012 12:49:30 +0000
Subject: Re: [PATCH v12 4/6] fbmon: add of_videomode helpers
Message-Id: <50ACCDDA.2070606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig09241D6A5698903053C1AEA5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353426896-6045-1-git-send-email-s.trumtrar@pengutronix.de>
 <1353426896-6045-5-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1353426896-6045-5-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--------------enig09241D6A5698903053C1AEA5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-20 17:54, Steffen Trumtrar wrote:
> Add helper to get fb_videomode from devicetree.
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
> Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/fbmon.c |   42 +++++++++++++++++++++++++++++++++++++++++=
-
>  include/linux/fb.h    |    7 +++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)


> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 920cbe3..41b5e49 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -15,6 +15,8 @@
>  #include <linux/slab.h>
>  #include <asm/io.h>
>  #include <linux/videomode.h>
> +#include <linux/of.h>
> +#include <linux/of_videomode.h>

Guess what? =3D)

To be honest, I don't know what the general opinion is about including
header files from header files. But I always leave them out if they are
not strictly needed.

>  struct vm_area_struct;
>  struct fb_info;
> @@ -715,6 +717,11 @@ extern void fb_destroy_modedb(struct fb_videomode =
*modedb);
>  extern int fb_find_mode_cvt(struct fb_videomode *mode, int margins, in=
t rb);
>  extern unsigned char *fb_ddc_read(struct i2c_adapter *adapter);
> =20
> +#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
> +extern int of_get_fb_videomode(const struct device_node *np,
> +			       struct fb_videomode *fb,
> +			       unsigned int index);
> +#endif
>  #if IS_ENABLED(CONFIG_VIDEOMODE)
>  extern int fb_videomode_from_videomode(const struct videomode *vm,
>  				       struct fb_videomode *fbmode);

Do you really need these #ifs in the header files? They do make it look
a bit messy. If somebody uses the functions and CONFIG_VIDEOMODE is not
enabled, he'll get a linker error anyway.

 Tomi



--------------enig09241D6A5698903053C1AEA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrM3aAAoJEPo9qoy8lh71UA4QAIsNHXhDVDdpYMaHRr31ywwQ
Rw97qMUy85bOg1TJ8BFXSAV2Lp3sTgSSBolPcYksauFsKeCupiB3UtKaBUAhDatn
ZKFx3vPbVHh5yu9D+cybOJy5YeN43wyPVZwIZVVAZzcG+XI/X6TqMkGKUoTbh9OO
L6gqMqlIOHdYI4eDkNBO+hJilGXPYhKD5sYz3sTcraAsw+MlwSa4aQqwHh+w9azY
3NAWSamFqVlpeK7j3ALJDC0axwVprFa21K1LyUqUSdVJyj0dxyuv+nBCop7+sQme
lo/3R/YPwA34E3F/Df8FANaNaFqHJ9eOCIqOpgf55fcjCcCvMw59uaAYTSXgx8mY
rbnjcQcIy4tEsCYH8diz1SMGRkFcyg1FXw66b3uuh8xX76w59zftPO3o9hsqfrvO
HvBc0/8upNMY/ZNLb1rhAVTn4fzfmN0XEYd/a7gwX3+w8HoF/oszYPDpzRAhujjX
4rZM4W6hS2z/ZswxycqEj9U08tr2mcyizFGN77li3PXliH/UI2JkREQmtIvtRPb9
VO7UX8iu85qgCIxqop2xXbnSG24EWBmpFwwiLG5NZJsdPwdx4KDdv1x6+cx1WF/H
69j1RAqhk0ATiJD5jfaj3SfYGm1BnOdo5yjRvhau56Lyb/ahYjBgX8U52SRehrKZ
Mr7FzgNL7Zz/0pmen0+o
=Q6T5
-----END PGP SIGNATURE-----

--------------enig09241D6A5698903053C1AEA5--
