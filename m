From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 29 Nov 2019 15:22:33 +0000
Subject: Re: [PATCH v2 01/14] video: fb_defio: preserve user fb_ops
Message-Id: <20191129152233.GF624164@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <022c82429da15d6450ff9ac1a897322ec3124db4.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <022c82429da15d6450ff9ac1a897322ec3124db4.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Jaya Kumar <jayalk@intworks.biz>

On Fri, Nov 29, 2019 at 12:29:31PM +0200, Jani Nikula wrote:
> Modifying fb_ops directly to override fb_mmap with fb_deferred_io_mmap
> and then resetting it to NULL afterwards causes problems all over the
> place. First, it prevents making the fbops member of struct fb_info a
> const pointer, which means we can't make struct fb_ops const
> anywhere. Second, a few places have to go out of their way to restore
> the original fb_mmap pointer that gets reset to NULL.
>=20
> Since the only user of the fbops->fb_mmap hook is fb_mmap() in fbmem.c,
> call fb_deferred_io_mmap() directly when deferred IO is enabled, and
> avoid modifying fb_ops altogether.
>=20
> Simply use info->fbdefio to determine whether deferred IO should be used
> or not. This should be accurate enough for all use cases, although
> perhaps not pedantically correct.
>=20
> v2: Simplify considerably by calling fb_deferred_io_mmap() directly
>     (Daniel, Ville)
>=20
> Cc: Jaya Kumar <jayalk@intworks.biz>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/video/fbdev/core/fb_defio.c |  3 ---
>  drivers/video/fbdev/core/fbmem.c    | 15 +++++++++++----
>  2 files changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index 82c20c6047b0..a591d291b231 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -171,7 +171,6 @@ int fb_deferred_io_mmap(struct fb_info *info, struct =
vm_area_struct *vma)
>  	vma->vm_private_data =3D info;
>  	return 0;
>  }
> -EXPORT_SYMBOL(fb_deferred_io_mmap);
> =20
>  /* workqueue callback */
>  static void fb_deferred_io_work(struct work_struct *work)
> @@ -206,7 +205,6 @@ void fb_deferred_io_init(struct fb_info *info)
> =20
>  	BUG_ON(!fbdefio);
>  	mutex_init(&fbdefio->lock);
> -	info->fbops->fb_mmap =3D fb_deferred_io_mmap;
>  	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
>  	INIT_LIST_HEAD(&fbdefio->pagelist);
>  	if (fbdefio->delay =3D 0) /* set a default of 1 s */
> @@ -237,7 +235,6 @@ void fb_deferred_io_cleanup(struct fb_info *info)
>  		page->mapping =3D NULL;
>  	}
> =20
> -	info->fbops->fb_mmap =3D NULL;
>  	mutex_destroy(&fbdefio->lock);
>  }
>  EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/=
fbmem.c
> index 86b06a599f96..990550930a8e 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1332,16 +1332,23 @@ static int
>  fb_mmap(struct file *file, struct vm_area_struct * vma)
>  {
>  	struct fb_info *info =3D file_fb_info(file);
> -	struct fb_ops *fb;
> +	int (*fb_mmap_fn)(struct fb_info *info, struct vm_area_struct *vma);

Oh I function pointer for tidier control flow, neato.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  	unsigned long mmio_pgoff;
>  	unsigned long start;
>  	u32 len;
> =20
>  	if (!info)
>  		return -ENODEV;
> -	fb =3D info->fbops;
>  	mutex_lock(&info->mm_lock);
> -	if (fb->fb_mmap) {
> +
> +	fb_mmap_fn =3D info->fbops->fb_mmap;
> +
> +#if IS_ENABLED(CONFIG_FB_DEFERRED_IO)
> +	if (info->fbdefio)
> +		fb_mmap_fn =3D fb_deferred_io_mmap;
> +#endif
> +
> +	if (fb_mmap_fn) {
>  		int res;
> =20
>  		/*
> @@ -1349,7 +1356,7 @@ fb_mmap(struct file *file, struct vm_area_struct * =
vma)
>  		 * SME protection is removed ahead of the call
>  		 */
>  		vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
> -		res =3D fb->fb_mmap(info, vma);
> +		res =3D fb_mmap_fn(info, vma);
>  		mutex_unlock(&info->mm_lock);
>  		return res;
>  	}
> --=20
> 2.20.1
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
