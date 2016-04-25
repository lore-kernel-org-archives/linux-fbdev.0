From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 25 Apr 2016 09:15:17 +0000
Subject: Re: [PATCH v2 6/8] drm/fb-cma-helper: Add fb_deferred_io support
Message-Id: <20160425091517.GS2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
 <1461530942-22485-7-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461530942-22485-7-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com

On Sun, Apr 24, 2016 at 10:49:00PM +0200, Noralf Tr=F8nnes wrote:
> This adds fbdev deferred io support if CONFIG_FB_DEFERRED_IO is enabled.
> The driver has to provide a (struct drm_framebuffer_funcs *)->dirty()
> callback to get notification of fbdev framebuffer changes.
> If the dirty() hook is set, then fb_deferred_io is set up automatically
> by the helper.
>=20
> Two functions have been added so that the driver can provide a dirty()
> function:
> - drm_fbdev_cma_init_with_funcs()
>   This makes it possible for the driver to provided a custom
>   (struct drm_fb_helper_funcs *)->fb_probe() function.
> - drm_fbdev_cma_create_with_funcs()
>   This is used by the .fb_probe hook to set a driver provided
>   (struct drm_framebuffer_funcs *)->dirty() function.
>=20
> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> ---
>  drivers/gpu/drm/drm_fb_cma_helper.c | 190 ++++++++++++++++++++++++++++++=
+++---
>  include/drm/drm_fb_cma_helper.h     |  14 +++
>  2 files changed, 192 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb=
_cma_helper.c
> index bb88e3d..d1e9db0 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -25,6 +25,8 @@
>  #include <drm/drm_fb_cma_helper.h>
>  #include <linux/module.h>
> =20
> +#define DEFAULT_FBDEFIO_DELAY_MS 50
> +
>  struct drm_fb_cma {
>  	struct drm_framebuffer		fb;
>  	struct drm_gem_cma_object	*obj[4];
> @@ -35,6 +37,61 @@ struct drm_fbdev_cma {
>  	struct drm_fb_cma	*fb;
>  };
> =20
> +/**
> + * DOC: framebuffer cma helper functions
> + *
> + * Provides helper functions for creating a cma (contiguous memory alloc=
ator)
> + * backed framebuffer.
> + *
> + * drm_fb_cma_create() is used in the
> + * (struct drm_mode_config_funcs *)->fb_create callback function to crea=
te the

Nit: If you use &drm_mode_config_funcs kerneldoc will insert a hyperlink
to the corresponding kerneldoc for the struct. So common style is=20

"drm_fb_cma_create() is used in the &drm_mode_config_funcs ->fb_create()
callback function ..."

Please roll this it to other places where you reference structs.
Eventually kerneldoc people have the dream to enable cross-referencing
across the entire kernel tree (so stuff like &delayed_work hopefully works
then too).

> + * cma backed framebuffer.
> + *
> + * An fbdev framebuffer backed by cma is also available by calling
> + * drm_fbdev_cma_init(). drm_fbdev_cma_fini() tears it down.
> + * If CONFIG_FB_DEFERRED_IO is enabled and the callback
> + * (struct drm_framebuffer_funcs)->dirty is set, fb_deferred_io
> + * will be set up automatically. dirty() is called by
> + * drm_fb_helper_deferred_io() in process context (struct delayed_work).
> + *
> + * Example fbdev deferred io code:
> + *
> + *     static int driver_fbdev_fb_dirty(struct drm_framebuffer *fb,
> + *                                      struct drm_file *file_priv,
> + *                                      unsigned flags, unsigned color,
> + *                                      struct drm_clip_rect *clips,
> + *                                      unsigned num_clips)
> + *     {
> + *         struct drm_gem_cma_object *cma =3D drm_fb_cma_get_gem_obj(fb,=
 0);
> + *         ... push changes ...
> + *         return 0;
> + *     }
> + *
> + *     static struct drm_framebuffer_funcs driver_fbdev_fb_funcs =3D {
> + *         .destroy       =3D drm_fb_cma_destroy,
> + *         .create_handle =3D drm_fb_cma_create_handle,
> + *         .dirty         =3D driver_fbdev_fb_dirty,
> + *     };
> + *
> + *     static int driver_fbdev_create(struct drm_fb_helper *helper,
> + *             struct drm_fb_helper_surface_size *sizes)
> + *     {
> + *         return drm_fbdev_cma_create_with_funcs(helper, sizes,
> + *                                                &driver_fbdev_fb_funcs=
);
> + *     }
> + *
> + *     static const struct drm_fb_helper_funcs driver_fb_helper_funcs =
=3D {
> + *         .fb_probe =3D driver_fbdev_create,
> + *     };
> + *
> + *     Initialize:
> + *     fbdev =3D drm_fbdev_cma_init_with_funcs(dev, 16,
> + *                                           dev->mode_config.num_crtc,
> + *                                           dev->mode_config.num_connec=
tor,
> + *                                           &driver_fb_helper_funcs);
> + *
> + */
> +
>  static inline struct drm_fbdev_cma *to_fbdev_cma(struct drm_fb_helper *h=
elper)
>  {
>  	return container_of(helper, struct drm_fbdev_cma, fb_helper);
> @@ -45,7 +102,7 @@ static inline struct drm_fb_cma *to_fb_cma(struct drm_=
framebuffer *fb)
>  	return container_of(fb, struct drm_fb_cma, fb);
>  }
> =20
> -static void drm_fb_cma_destroy(struct drm_framebuffer *fb)
> +void drm_fb_cma_destroy(struct drm_framebuffer *fb)
>  {
>  	struct drm_fb_cma *fb_cma =3D to_fb_cma(fb);
>  	int i;
> @@ -58,8 +115,9 @@ static void drm_fb_cma_destroy(struct drm_framebuffer =
*fb)
>  	drm_framebuffer_cleanup(fb);
>  	kfree(fb_cma);
>  }
> +EXPORT_SYMBOL(drm_fb_cma_destroy);
> =20
> -static int drm_fb_cma_create_handle(struct drm_framebuffer *fb,
> +int drm_fb_cma_create_handle(struct drm_framebuffer *fb,
>  	struct drm_file *file_priv, unsigned int *handle)
>  {
>  	struct drm_fb_cma *fb_cma =3D to_fb_cma(fb);
> @@ -67,6 +125,7 @@ static int drm_fb_cma_create_handle(struct drm_framebu=
ffer *fb,
>  	return drm_gem_handle_create(file_priv,
>  			&fb_cma->obj[0]->base, handle);
>  }
> +EXPORT_SYMBOL(drm_fb_cma_create_handle);
> =20
>  static struct drm_framebuffer_funcs drm_fb_cma_funcs =3D {
>  	.destroy	=3D drm_fb_cma_destroy,
> @@ -76,7 +135,7 @@ static struct drm_framebuffer_funcs drm_fb_cma_funcs =
=3D {
>  static struct drm_fb_cma *drm_fb_cma_alloc(struct drm_device *dev,
>  	const struct drm_mode_fb_cmd2 *mode_cmd,
>  	struct drm_gem_cma_object **obj,
> -	unsigned int num_planes)
> +	unsigned int num_planes, struct drm_framebuffer_funcs *funcs)
>  {
>  	struct drm_fb_cma *fb_cma;
>  	int ret;
> @@ -91,7 +150,7 @@ static struct drm_fb_cma *drm_fb_cma_alloc(struct drm_=
device *dev,
>  	for (i =3D 0; i < num_planes; i++)
>  		fb_cma->obj[i] =3D obj[i];
> =20
> -	ret =3D drm_framebuffer_init(dev, &fb_cma->fb, &drm_fb_cma_funcs);
> +	ret =3D drm_framebuffer_init(dev, &fb_cma->fb, funcs);
>  	if (ret) {
>  		dev_err(dev->dev, "Failed to initialize framebuffer: %d\n", ret);
>  		kfree(fb_cma);
> @@ -145,7 +204,7 @@ struct drm_framebuffer *drm_fb_cma_create(struct drm_=
device *dev,
>  		objs[i] =3D to_drm_gem_cma_obj(obj);
>  	}
> =20
> -	fb_cma =3D drm_fb_cma_alloc(dev, mode_cmd, objs, i);
> +	fb_cma =3D drm_fb_cma_alloc(dev, mode_cmd, objs, i, &drm_fb_cma_funcs);
>  	if (IS_ERR(fb_cma)) {
>  		ret =3D PTR_ERR(fb_cma);
>  		goto err_gem_object_unreference;
> @@ -233,8 +292,79 @@ static struct fb_ops drm_fbdev_cma_ops =3D {
>  	.fb_setcmap	=3D drm_fb_helper_setcmap,
>  };
> =20
> -static int drm_fbdev_cma_create(struct drm_fb_helper *helper,
> -	struct drm_fb_helper_surface_size *sizes)
> +#ifdef CONFIG_FB_DEFERRED_IO

Same question about config handling. Imo just selecting this is ok, and
would remove a few #ifdef from the code.

Otherwise lgtm, but needs an ack/r-b from Laurent.
-Daniel

> +static int drm_fbdev_cma_deferred_io_mmap(struct fb_info *info,
> +					  struct vm_area_struct *vma)
> +{
> +	fb_deferred_io_mmap(info, vma);
> +	vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
> +
> +	return 0;
> +}
> +
> +static int drm_fbdev_cma_defio_init(struct fb_info *fbi,
> +				    struct drm_gem_cma_object *cma_obj)
> +{
> +	struct fb_deferred_io *fbdefio;
> +	struct fb_ops *fbops;
> +
> +	/*
> +	 * Per device structures are needed because:
> +	 * fbops: fb_deferred_io_cleanup() clears fbops.fb_mmap
> +	 * fbdefio: individual delays
> +	 */
> +	fbdefio =3D kzalloc(sizeof(*fbdefio), GFP_KERNEL);
> +	fbops =3D kzalloc(sizeof(*fbops), GFP_KERNEL);
> +	if (!fbdefio || !fbops) {
> +		kfree(fbdefio);
> +		return -ENOMEM;
> +	}
> +
> +	/* can't be offset from vaddr since dirty() uses cma_obj */
> +	fbi->screen_buffer =3D cma_obj->vaddr;
> +	/* fb_deferred_io_fault() needs a physical address */
> +	fbi->fix.smem_start =3D page_to_phys(virt_to_page(fbi->screen_buffer));
> +
> +	*fbops =3D *fbi->fbops;
> +	fbi->fbops =3D fbops;
> +
> +	fbdefio->delay =3D msecs_to_jiffies(DEFAULT_FBDEFIO_DELAY_MS);
> +	fbdefio->deferred_io =3D drm_fb_helper_deferred_io;
> +	fbi->fbdefio =3D fbdefio;
> +	fb_deferred_io_init(fbi);
> +	fbi->fbops->fb_mmap =3D drm_fbdev_cma_deferred_io_mmap;
> +
> +	return 0;
> +}
> +
> +static void drm_fbdev_cma_defio_fini(struct fb_info *fbi)
> +{
> +	if (!fbi->fbdefio)
> +		return;
> +
> +	fb_deferred_io_cleanup(fbi);
> +	kfree(fbi->fbdefio);
> +	kfree(fbi->fbops);
> +}
> +#else
> +static int drm_fbdev_cma_defio_init(struct fb_info *fbi,
> +				    struct drm_gem_cma_object *cma_obj)
> +{
> +	return 0;
> +}
> +
> +static void drm_fbdev_cma_defio_fini(struct fb_info *fbi)
> +{
> +}
> +#endif /* CONFIG_FB_DEFERRED_IO */
> +
> +/*
> + * For use in a (struct drm_fb_helper_funcs *)->fb_probe callback functi=
on that
> + * needs custom struct drm_framebuffer_funcs, like dirty() for deferred_=
io use.
> + */
> +int drm_fbdev_cma_create_with_funcs(struct drm_fb_helper *helper,
> +	struct drm_fb_helper_surface_size *sizes,
> +	struct drm_framebuffer_funcs *funcs)
>  {
>  	struct drm_fbdev_cma *fbdev_cma =3D to_fbdev_cma(helper);
>  	struct drm_mode_fb_cmd2 mode_cmd =3D { 0 };
> @@ -270,7 +400,7 @@ static int drm_fbdev_cma_create(struct drm_fb_helper =
*helper,
>  		goto err_gem_free_object;
>  	}
> =20
> -	fbdev_cma->fb =3D drm_fb_cma_alloc(dev, &mode_cmd, &obj, 1);
> +	fbdev_cma->fb =3D drm_fb_cma_alloc(dev, &mode_cmd, &obj, 1, funcs);
>  	if (IS_ERR(fbdev_cma->fb)) {
>  		dev_err(dev->dev, "Failed to allocate DRM framebuffer.\n");
>  		ret =3D PTR_ERR(fbdev_cma->fb);
> @@ -296,31 +426,48 @@ static int drm_fbdev_cma_create(struct drm_fb_helpe=
r *helper,
>  	fbi->screen_size =3D size;
>  	fbi->fix.smem_len =3D size;
> =20
> +	if (funcs->dirty) {
> +		ret =3D drm_fbdev_cma_defio_init(fbi, obj);
> +		if (ret)
> +			goto err_cma_destroy;
> +	}
> +
>  	return 0;
> =20
> +err_cma_destroy:
> +	drm_framebuffer_unregister_private(&fbdev_cma->fb->fb);
> +	drm_fb_cma_destroy(&fbdev_cma->fb->fb);
>  err_fb_info_destroy:
>  	drm_fb_helper_release_fbi(helper);
>  err_gem_free_object:
>  	dev->driver->gem_free_object(&obj->base);
>  	return ret;
>  }
> +EXPORT_SYMBOL(drm_fbdev_cma_create_with_funcs);
> +
> +static int drm_fbdev_cma_create(struct drm_fb_helper *helper,
> +	struct drm_fb_helper_surface_size *sizes)
> +{
> +	return drm_fbdev_cma_create_with_funcs(helper, sizes, &drm_fb_cma_funcs=
);
> +}
> =20
>  static const struct drm_fb_helper_funcs drm_fb_cma_helper_funcs =3D {
>  	.fb_probe =3D drm_fbdev_cma_create,
>  };
> =20
>  /**
> - * drm_fbdev_cma_init() - Allocate and initializes a drm_fbdev_cma struct
> + * drm_fbdev_cma_init_with_funcs() - Allocate and initializes a drm_fbde=
v_cma struct
>   * @dev: DRM device
>   * @preferred_bpp: Preferred bits per pixel for the device
>   * @num_crtc: Number of CRTCs
>   * @max_conn_count: Maximum number of connectors
> + * @funcs: fb helper functions, in particular fb_probe()
>   *
>   * Returns a newly allocated drm_fbdev_cma struct or a ERR_PTR.
>   */
> -struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
> +struct drm_fbdev_cma *drm_fbdev_cma_init_with_funcs(struct drm_device *d=
ev,
>  	unsigned int preferred_bpp, unsigned int num_crtc,
> -	unsigned int max_conn_count)
> +	unsigned int max_conn_count, const struct drm_fb_helper_funcs *funcs)
>  {
>  	struct drm_fbdev_cma *fbdev_cma;
>  	struct drm_fb_helper *helper;
> @@ -334,7 +481,7 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_d=
evice *dev,
> =20
>  	helper =3D &fbdev_cma->fb_helper;
> =20
> -	drm_fb_helper_prepare(dev, helper, &drm_fb_cma_helper_funcs);
> +	drm_fb_helper_prepare(dev, helper, funcs);
> =20
>  	ret =3D drm_fb_helper_init(dev, helper, num_crtc, max_conn_count);
>  	if (ret < 0) {
> @@ -364,6 +511,24 @@ err_free:
> =20
>  	return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(drm_fbdev_cma_init_with_funcs);
> +
> +/**
> + * drm_fbdev_cma_init() - Allocate and initializes a drm_fbdev_cma struct
> + * @dev: DRM device
> + * @preferred_bpp: Preferred bits per pixel for the device
> + * @num_crtc: Number of CRTCs
> + * @max_conn_count: Maximum number of connectors
> + *
> + * Returns a newly allocated drm_fbdev_cma struct or a ERR_PTR.
> + */
> +struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
> +	unsigned int preferred_bpp, unsigned int num_crtc,
> +	unsigned int max_conn_count)
> +{
> +	return drm_fbdev_cma_init_with_funcs(dev, preferred_bpp, num_crtc,
> +				max_conn_count, &drm_fb_cma_helper_funcs);
> +}
>  EXPORT_SYMBOL_GPL(drm_fbdev_cma_init);
> =20
>  /**
> @@ -373,6 +538,7 @@ EXPORT_SYMBOL_GPL(drm_fbdev_cma_init);
>  void drm_fbdev_cma_fini(struct drm_fbdev_cma *fbdev_cma)
>  {
>  	drm_fb_helper_unregister_fbi(&fbdev_cma->fb_helper);
> +	drm_fbdev_cma_defio_fini(fbdev_cma->fb_helper.fbdev);
>  	drm_fb_helper_release_fbi(&fbdev_cma->fb_helper);
> =20
>  	if (fbdev_cma->fb) {
> diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_hel=
per.h
> index be62bd3..6554b6f 100644
> --- a/include/drm/drm_fb_cma_helper.h
> +++ b/include/drm/drm_fb_cma_helper.h
> @@ -4,11 +4,18 @@
>  struct drm_fbdev_cma;
>  struct drm_gem_cma_object;
> =20
> +struct drm_fb_helper_surface_size;
> +struct drm_framebuffer_funcs;
> +struct drm_fb_helper_funcs;
>  struct drm_framebuffer;
> +struct drm_fb_helper;
>  struct drm_device;
>  struct drm_file;
>  struct drm_mode_fb_cmd2;
> =20
> +struct drm_fbdev_cma *drm_fbdev_cma_init_with_funcs(struct drm_device *d=
ev,
> +	unsigned int preferred_bpp, unsigned int num_crtc,
> +	unsigned int max_conn_count, const struct drm_fb_helper_funcs *funcs);
>  struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
>  	unsigned int preferred_bpp, unsigned int num_crtc,
>  	unsigned int max_conn_count);
> @@ -16,6 +23,13 @@ void drm_fbdev_cma_fini(struct drm_fbdev_cma *fbdev_cm=
a);
> =20
>  void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
>  void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
> +int drm_fbdev_cma_create_with_funcs(struct drm_fb_helper *helper,
> +	struct drm_fb_helper_surface_size *sizes,
> +	struct drm_framebuffer_funcs *funcs);
> +
> +void drm_fb_cma_destroy(struct drm_framebuffer *fb);
> +int drm_fb_cma_create_handle(struct drm_framebuffer *fb,
> +	struct drm_file *file_priv, unsigned int *handle);
> =20
>  struct drm_framebuffer *drm_fb_cma_create(struct drm_device *dev,
>  	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd);
> --=20
> 2.2.2
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
