From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 14 Mar 2014 21:06:13 +0000
Subject: Re: [PATCH v2] RFC: framebuffer: provide generic get_fb_unmapped_area
Message-Id: <20140314210613.GL15674@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391447684-22556-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1391447684-22556-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, Feb 03, 2014 at 06:14:44PM +0100, Uwe Kleine-K=F6nig wrote:
> This patch makes mmapping the simple-framebuffer device work on a no-MMU
> ARM target. The code is mostly taken from
> arch/blackfin/kernel/sys_bfin.c.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> note this is only tested on this no-MMU machine and I don't know enough
> about framebuffers and mm to decide if this patch is sane. Also I'm
> a bit unsure about the size check, I just believed Geert that
> PAGE_ALIGN(info->fix.smem_len) is the right value to check against.
Do you still have this patch on your radar?

Best regards
Uwe

>  drivers/video/fbmem.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 7309ac704e26..d0ccedafec8c 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1491,6 +1491,22 @@ __releases(&info->lock)
>  	return 0;
>  }
> =20
> +#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
> +#define fb_get_unmapped_area get_fb_unmapped_area
> +#else
> +unsigned long fb_get_unmapped_area(struct file *filp, unsigned long orig=
_addr,
> +		unsigned long len, unsigned long pgoff, unsigned long flags)
> +{
> +	struct fb_info * const info =3D filp->private_data;
> +	unsigned long fb_size =3D PAGE_ALIGN(info->fix.smem_len);
> +
> +	if (pgoff > fb_size || len > fb_size - pgoff)
> +		return -EINVAL;
> +
> +	return (unsigned long)info->screen_base + pgoff;
> +}
> +#endif
> +
>  static const struct file_operations fb_fops =3D {
>  	.owner =3D	THIS_MODULE,
>  	.read =3D		fb_read,
> @@ -1502,9 +1518,7 @@ static const struct file_operations fb_fops =3D {
>  	.mmap =3D		fb_mmap,
>  	.open =3D		fb_open,
>  	.release =3D	fb_release,
> -#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
> -	.get_unmapped_area =3D get_fb_unmapped_area,
> -#endif
> +	.get_unmapped_area =3D fb_get_unmapped_area,
>  #ifdef CONFIG_FB_DEFERRED_IO
>  	.fsync =3D	fb_deferred_io_fsync,
>  #endif
> --=20
> 1.8.5.2
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
