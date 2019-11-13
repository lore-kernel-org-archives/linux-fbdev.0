From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Wed, 13 Nov 2019 15:26:39 +0000
Subject: Re: [PATCH v4 1/3] drm/udl: Replace fbdev code with generic emulation
Message-Id: <7c9289a6-1a4e-e0d3-ce9e-3f5d6305da69@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191113115233.18483-1-tzimmermann@suse.de>
 <20191113115233.18483-2-tzimmermann@suse.de>
In-Reply-To: <20191113115233.18483-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org



Den 13.11.2019 12.52, skrev Thomas Zimmermann:
> The udl driver can use the generic fbdev implementation. Convert it.
>=20
> v4:
> 	* hardcode console bpp to 16
> v3:
> 	* remove module parameter fb_bpp in favor of fbdev's video
> 	* call drm_fbdev_generic_setup() directly; remove udl_fbdev_init()
> 	* use default for struct drm_mode_config_funcs.output_poll_changed
> 	* use default for struct drm_driver.lastclose
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_mai=
n.c
> index 4e854e017390..3be0c0cec49e 100644
> --- a/drivers/gpu/drm/udl/udl_main.c
> +++ b/drivers/gpu/drm/udl/udl_main.c
> @@ -9,6 +9,7 @@
>   */
> =20
>  #include <drm/drm.h>
> +#include <drm/drm_fb_helper.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> =20
> @@ -338,7 +339,7 @@ int udl_init(struct udl_device *udl)
>  	if (ret)
>  		goto err;
> =20
> -	ret =3D udl_fbdev_init(dev);
> +	ret =3D drm_fbdev_generic_setup(dev, 16);

I suggest you put this after drm_dev_register() in _probe() since fbdev
is a client, a user of the driver, not part of it as such.

Either way you choose:

Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>

Btw, nice diffstat!

>  	if (ret)
>  		goto err;
> =20
> @@ -367,6 +368,4 @@ void udl_fini(struct drm_device *dev)
> =20
>  	if (udl->urbs.count)
>  		udl_free_urb_list(dev);
> -
> -	udl_fbdev_cleanup(dev);
>  }
