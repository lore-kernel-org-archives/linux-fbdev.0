From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Fri, 08 Nov 2019 15:37:04 +0000
Subject: Re: [PATCH 1/4] drm/udl: Replace fbdev code with generic emulation
Message-Id: <e8b90928-fdae-36e0-f116-8b49159c4aad@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191108123333.25274-1-tzimmermann@suse.de>
 <20191108123333.25274-2-tzimmermann@suse.de>
In-Reply-To: <20191108123333.25274-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org



Den 08.11.2019 13.33, skrev Thomas Zimmermann:
> The udl driver can use the generic fbdev implementation. Convert it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

> diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
> index 563cc5809e56..55c0f9dfee29 100644
> --- a/drivers/gpu/drm/udl/udl_drv.c
> +++ b/drivers/gpu/drm/udl/udl_drv.c

> @@ -47,6 +48,8 @@ static struct drm_driver driver = {
>  	.driver_features = DRIVER_MODESET | DRIVER_GEM,
>  	.release = udl_driver_release,
>  
> +	.lastclose = drm_fb_helper_lastclose,
> +

No need to set this, it's already wired up:

drm_lastclose -> drm_client_dev_restore -> drm_fbdev_client_restore ->
drm_fb_helper_lastclose

>  	/* gem hooks */
>  	.gem_create_object = udl_driver_gem_create_object,
>  

> diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
> index f8153b726343..afe74f892a2b 100644
> --- a/drivers/gpu/drm/udl/udl_fb.c
> +++ b/drivers/gpu/drm/udl/udl_fb.c
> @@ -20,19 +20,9 @@
>  
>  #include "udl_drv.h"
>  
> -#define DL_DEFIO_WRITE_DELAY    (HZ/20) /* fb_deferred_io.delay in jiffies */
> -
> -static int fb_defio = 0;  /* Optionally enable experimental fb_defio mmap support */
>  static int fb_bpp = 16;
>  
>  module_param(fb_bpp, int, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);

Maybe fb_bpp can be dropped too?

It's possible to set it on the command line:

video=<xres>x<yres>-<bpp>

I haven't tried it so I can't say for certain that it actually works.

Ref: Documentation/fb/modedb.rst and drm_fb_helper_single_fb_probe()

> -module_param(fb_defio, int, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
> -

> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index bc1ab6060dc6..1517d5e881b8 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c

> @@ -422,7 +423,7 @@ static int udl_crtc_init(struct drm_device *dev)
>  
>  static const struct drm_mode_config_funcs udl_mode_funcs = {
>  	.fb_create = udl_fb_user_fb_create,
> -	.output_poll_changed = NULL,
> +	.output_poll_changed = drm_fb_helper_output_poll_changed,

No need to set this, it's already wired up:

drm_kms_helper_hotplug_event -> drm_client_dev_hotplug ->
drm_fbdev_client_hotplug -> drm_fb_helper_hotplug_event

Noralf.

>  };
>  
>  int udl_modeset_init(struct drm_device *dev)
> 
