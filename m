From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 20 Apr 2016 17:44:14 +0000
Subject: Re: [PATCH 5/8] fbdev: fb_defio: Export fb_deferred_io_mmap
Message-Id: <20160420174414.GQ2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-6-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461165929-11344-6-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com

On Wed, Apr 20, 2016 at 05:25:26PM +0200, Noralf Tr=F8nnes wrote:
> Export fb_deferred_io_mmap so drivers can change vma->vm_page_prot.
> When the framebuffer memory is allocated using dma_alloc_writecombine()
> instead of vmalloc(), I get cache syncing problems.
> This solves it:
>=20
> static int drm_fbdev_cma_deferred_io_mmap(struct fb_info *info,
> 					  struct vm_area_struct *vma)
> {
> 	fb_deferred_io_mmap(info, vma);
> 	vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);

Hm, do we need pgpropt_writecombine? There recently was some discussion
(on the arc platform) that fbdev pgprots need to be fixed up in fbdev
code. I have no idea, just repeating from memory ...
-Daniel

>=20
> 	return 0;
> }
>=20
> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> ---
>  drivers/video/fbdev/core/fb_defio.c | 3 ++-
>  include/linux/fb.h                  | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index 57721c7..74b5bca 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -164,7 +164,7 @@ static const struct address_space_operations fb_defer=
red_io_aops =3D {
>  	.set_page_dirty =3D fb_deferred_io_set_page_dirty,
>  };
> =20
> -static int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_stru=
ct *vma)
> +int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
>  {
>  	vma->vm_ops =3D &fb_deferred_io_vm_ops;
>  	vma->vm_flags |=3D VM_DONTEXPAND | VM_DONTDUMP;
> @@ -173,6 +173,7 @@ static int fb_deferred_io_mmap(struct fb_info *info, =
struct vm_area_struct *vma)
>  	vma->vm_private_data =3D info;
>  	return 0;
>  }
> +EXPORT_SYMBOL(fb_deferred_io_mmap);
> =20
>  /* workqueue callback */
>  static void fb_deferred_io_work(struct work_struct *work)
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index dfe8835..a964d07 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -673,6 +673,7 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, u=
32 d_pitch,
>  }
> =20
>  /* drivers/video/fb_defio.c */
> +int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma=
);
>  extern void fb_deferred_io_init(struct fb_info *info);
>  extern void fb_deferred_io_open(struct fb_info *info,
>  				struct inode *inode,
> --=20
> 2.2.2
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
