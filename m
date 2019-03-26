From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Tue, 26 Mar 2019 16:29:10 +0000
Subject: Re: [PATCH 07/11] drm/fbdevdrm: Add DRM <-> fbdev pixel-format conversion
Message-Id: <20190326162910.GY3888@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-8-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-8-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@linux.ie, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

On Tue, Mar 26, 2019 at 10:17:40AM +0100, Thomas Zimmermann wrote:
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/fbdevdrm/Makefile          |   1 +
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c | 441 +++++++++++++++++++++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h |  26 ++
>  3 files changed, 468 insertions(+)
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h
>=20
> diff --git a/drivers/gpu/drm/fbdevdrm/Makefile b/drivers/gpu/drm/fbdevdrm=
/Makefile
> index b8fab9d52faa..aef60d0f4888 100644
> --- a/drivers/gpu/drm/fbdevdrm/Makefile
> +++ b/drivers/gpu/drm/fbdevdrm/Makefile
> @@ -2,6 +2,7 @@ ccflags-y =3D -Iinclude/drm
>  fbdevdrm-y :=3D fbdevdrm_bo.o \
>  	      fbdevdrm_device.o \
>  	      fbdevdrm_drv.o \
> +	      fbdevdrm_format.o \
>  	      fbdevdrm_modeset.o \
>  	      fbdevdrm_ttm.o
> =20
> diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c b/drivers/gpu/drm=
/fbdevdrm/fbdevdrm_format.c
> new file mode 100644
> index 000000000000..208f7c60e525
> --- /dev/null
> +++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
> @@ -0,0 +1,441 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * One purpose of this driver is to allow for easy conversion of framebu=
ffer
> + * drivers to DRM. As a special exception to the GNU GPL, you are allowe=
d to
> + * relicense this file under the terms of a license of your choice if yo=
u're
> + * porting a framebuffer driver. In order to do so, update the SPDX lice=
nse
> + * identifier to the new license and remove this exception.
> + *
> + * If you add code to this file, please ensure that it's compatible with=
 the
> + * stated exception.
> + */
> +
> +#include "fbdevdrm_format.h"
> +#include <asm/byteorder.h>
> +#include <linux/fb.h>
> +
> +#if defined __BIG_ENDIAN
> +#define HOST_FUNC(_func) \
> +	_func ## _be
> +#elif defined __LITTLE_ENDIAN
> +#define HOST_FUNC(_func) \
> +	_func ## _le
> +#else
> +#error "Unsupported endianess"
> +#endif
> +
> +static bool is_c8(const struct fb_info* fb_info)
> +{
> +	return fb_info->var.bits_per_pixel =3D 8;
> +}
> +
> +static bool is_rgb565_be(const struct fb_info* fb_info)
> +{
> +	return (fb_info->var.bits_per_pixel =3D 16) &&
> +	       (fb_info->var.red.offset =3D 0) &&
> +	       (fb_info->var.red.length =3D 5) &&
> +	       (fb_info->var.green.offset =3D 5) &&
> +	       (fb_info->var.green.length =3D 6) &&
> +	       (fb_info->var.blue.offset =3D 11) &&
> +	       (fb_info->var.blue.length =3D 5);
> +}

You can't distinguish LE vs. BE like this.

Maybe FBINFO_FOREIGN_ENDIAN is trustworthy?

--=20
Ville Syrj=E4l=E4
Intel
