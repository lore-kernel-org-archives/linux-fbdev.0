From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 21 Nov 2012 12:50:38 +0000
Subject: Re: [PATCH v12 5/6] drm_modes: add videomode helpers
Message-Id: <50ACCE1E.4030707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig8214106EC427CEF349D81767"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353426896-6045-1-git-send-email-s.trumtrar@pengutronix.de> <1353426896-6045-6-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1353426896-6045-6-git-send-email-s.trumtrar@pengutronix.de>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: devicetree-discuss@lists.ozlabs.org, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thierry Reding <thierry.reding@avionic-design.de>, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, David Airlie <airlied@linux.ie>

--------------enig8214106EC427CEF349D81767
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-20 17:54, Steffen Trumtrar wrote:
> Add conversion from videomode to drm_display_mode
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
> Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/gpu/drm/drm_modes.c |   37 +++++++++++++++++++++++++++++++++++=
++
>  include/drm/drmP.h          |    6 ++++++
>  2 files changed, 43 insertions(+)
>=20

> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index 3fd8280..de2f6cf 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -56,6 +56,7 @@
>  #include <linux/cdev.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/videomode.h>
>  #if defined(__alpha__) || defined(__powerpc__)
>  #include <asm/pgtable.h>	/* For pte_wrprotect */
>  #endif
> @@ -1454,6 +1455,11 @@ extern struct drm_display_mode *
>  drm_mode_create_from_cmdline_mode(struct drm_device *dev,
>  				  struct drm_cmdline_mode *cmd);
> =20
> +#if IS_ENABLED(CONFIG_VIDEOMODE)
> +extern int drm_display_mode_from_videomode(const struct videomode *vm,=

> +					   struct drm_display_mode *dmode);
> +#endif
> +
>  /* Modesetting support */
>  extern void drm_vblank_pre_modeset(struct drm_device *dev, int crtc);
>  extern void drm_vblank_post_modeset(struct drm_device *dev, int crtc);=

>=20

And the same comments apply to this header file.

 Tomi



--------------enig8214106EC427CEF349D81767
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrM4eAAoJEPo9qoy8lh71L8EP/A9fQOMiK/l9aZ9naaO0Unbg
xqiyCTEM+kA3UEoJaNvbPNMtjvDD5pQGX7yvRChpEBDchjfg3CJXR/raqLbbfLgf
kDOdkux8ZGleCLmg7tKo/LwOVigPEI0CMVK3NfOZk6Cvw9+SiL+7rxDP+PwQacm0
LpxuWLAs8yen/dWkKdax2mEK3GmY4yBQ+4by5zAwG5jZM38gzGlgxZcn1h2jd+Wa
SlHZfuF43+XyyAlgZMxDOJUV8PEnLMY3WOBvuxkdMIZx1A51pJDT84NS/SVsp5PT
unYdOME2B6ho3/a4NeBD7xIP/5o2RMMU21jI3ZpuKusTZC0c/dEnDgil4tDf+Czb
F470mxES0OFOnjArV84Afw1JQi0MLE5I/wBiKqi0sMKWVEeFrMgtGy9XsFsLrNrH
EBFCxXCjtk9RId7FtwELJIjbocVCQy0SkoYfvEe3js4QfSoCSXyOlBDAV4W/9zdJ
hBtMl7adAQFDrs9Pf43cBfYYiJ4Ow0JF4QEkUTKWvREvkxJaZoH4cBGxo6FuHVLe
x2E3SGkYk5LuWWUH3GkQPnfswCxHL0gfIWJmGhervlIkMPK/Civ1EIIGXc5NFZU8
KVMcXA7R2lSfMoISXSbA++fNCxgfEY+682ltIn5BhmIQhuuC6668CKGbDumkA6Ec
KgbIs4e8OsyoN8b1WjqJ
=j45y
-----END PGP SIGNATURE-----

--------------enig8214106EC427CEF349D81767--
