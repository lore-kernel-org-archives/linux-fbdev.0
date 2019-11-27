From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Wed, 27 Nov 2019 17:01:16 +0000
Subject: Re: [PATCH 01/13] video: fb_defio: preserve user fb_ops
Message-Id: <20191127170116.GK1208@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
 <448995ffd954e0cd2287089cb686e351cc095834.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <448995ffd954e0cd2287089cb686e351cc095834.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Jaya Kumar <jayalk@intworks.biz>

On Wed, Nov 27, 2019 at 06:31:57PM +0200, Jani Nikula wrote:
> Modifying fb_ops directly to override fb_mmap with fb_deferred_io_mmap
> and then resetting it to NULL afterwards causes problems all over the
> place. First, it prevents making the fbops member of struct fb_info a
> const pointer, which means we can't make struct fb_ops const
> anywhere. Second, a few places have to go out of their way to restore
> the original fb_mmap pointer that gets reset to NULL.
>=20
> Preserve the passed in fb_ops by making a copy of it and modifying that
> instead. Add a deferred_io_private member to struct fb_info to store the
> pointer to the old fb_ops, and restore that at cleanup.

Quite the horror show. I wonder how hard it would be to just have each
driver that can use defio provide a mmap hook that either dispatches
to the defio one or the native one depending if defio is used or not...

A few drivers at least seem to always use defio so those should be
trivial. Some others seem to make the decision dynamically, which
would require custom .mmap(). Though I suppose all of them could just
be of the form
foo_mmap_wrap{)
{
	if (info->defio)
		defio_mmap()
	else
		foo_mmap();
}

Hmm. Actually is .fb_mmap() called from anywhere but fb_mmap()? If not
we could just shove the defio check there? Or if it's called from
several places we could try to wrap all calls in _fb_mmap() or somesuch.

>=20
> Cc: Jaya Kumar <jayalk@intworks.biz>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>=20
> ---
>=20
> Note: If the approach is acceptable, we'll also need to handle the error
> returns on memory allocation failures at fb_deferred_io_init() call
> sites. There are 13.
> ---
>  drivers/video/fbdev/core/fb_defio.c | 25 ++++++++++++++++++++++---
>  include/linux/fb.h                  |  3 ++-
>  2 files changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index 82c20c6047b0..36697844c1e0 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -200,13 +200,23 @@ static void fb_deferred_io_work(struct work_struct =
*work)
>  	mutex_unlock(&fbdefio->lock);
>  }
> =20
> -void fb_deferred_io_init(struct fb_info *info)
> +int fb_deferred_io_init(struct fb_info *info)
>  {
>  	struct fb_deferred_io *fbdefio =3D info->fbdefio;
> +	struct fb_ops *fbops;
> =20
>  	BUG_ON(!fbdefio);
> +
> +	fbops =3D kmemdup(info->fbops, sizeof(*fbops), GFP_KERNEL);
> +	if (!fbops)
> +		return -ENOMEM;
> +
> +	fbops->fb_mmap =3D fb_deferred_io_mmap;
> +	info->deferred_io_private =3D info->fbops;
> +	info->fbops =3D fbops;
> +
>  	mutex_init(&fbdefio->lock);
> -	info->fbops->fb_mmap =3D fb_deferred_io_mmap;
> +
>  	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
>  	INIT_LIST_HEAD(&fbdefio->pagelist);
>  	if (fbdefio->delay =3D 0) /* set a default of 1 s */
> @@ -229,6 +239,12 @@ void fb_deferred_io_cleanup(struct fb_info *info)
>  	int i;
> =20
>  	BUG_ON(!fbdefio);
> +
> +	/* sanity check against misuse */
> +	if (WARN_ON(!info->deferred_io_private ||
> +		    info->fbops->fb_mmap !=3D fb_deferred_io_mmap))
> +		return;
> +
>  	cancel_delayed_work_sync(&info->deferred_work);
> =20
>  	/* clear out the mapping that we setup */
> @@ -237,7 +253,10 @@ void fb_deferred_io_cleanup(struct fb_info *info)
>  		page->mapping =3D NULL;
>  	}
> =20
> -	info->fbops->fb_mmap =3D NULL;
> +	kfree(info->fbops);
> +	info->fbops =3D info->deferred_io_private;
> +	info->deferred_io_private =3D NULL;
> +
>  	mutex_destroy(&fbdefio->lock);
>  }
>  EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index a6ad528990de..65f2abd47745 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -470,6 +470,7 @@ struct fb_info {
>  #ifdef CONFIG_FB_DEFERRED_IO
>  	struct delayed_work deferred_work;
>  	struct fb_deferred_io *fbdefio;
> +	void *deferred_io_private;
>  #endif
> =20
>  	struct fb_ops *fbops;
> @@ -658,7 +659,7 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, u=
32 d_pitch,
> =20
>  /* drivers/video/fb_defio.c */
>  int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma=
);
> -extern void fb_deferred_io_init(struct fb_info *info);
> +extern int fb_deferred_io_init(struct fb_info *info);
>  extern void fb_deferred_io_open(struct fb_info *info,
>  				struct inode *inode,
>  				struct file *file);
> --=20
> 2.20.1

--=20
Ville Syrj=E4l=E4
Intel
