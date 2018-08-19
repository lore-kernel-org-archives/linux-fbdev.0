From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Sun, 19 Aug 2018 10:26:28 +0000
Subject: Re: [PATCH] mach64: fix console corruption in 24bpp mode
Message-Id: <20180819102628.GA11867@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1808171514010.31883@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808171514010.31883@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Aug 17, 2018 at 03:15:52PM -0400, Mikulas Patocka wrote:
> There's console font corruption when using the mach64 driver in 24bpp
> mode.
>=20
> In 24bpp mode, the mach64 accelerator is set up for 8-bpp mode (with
> horizontal width and stride multiplied by 3). In this mode, the
> accelerator can't even possibly support color expansion. Consquently, we
> have to use an unaccelerated function cfb_imageblit for color expansion.

Hmm. I would think it should work just fine since we feed in each bit
three times and the hw 24bpp rotate thing should take care of selecting
the right component.

-               if (M64_HAS(HW_TRIPLE) && image->width % 8 =3D 0)
+               if (M64_HAS(HW_TRIPLE) && width % 8 =3D 0)
		                        pix_width |=3D DP_HOST_TRIPLE_EN;
perhaps?

> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
>=20
> ---
>  drivers/video/fbdev/aty/mach64_accel.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Index: linux-stable/drivers/video/fbdev/aty/mach64_accel.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-stable.orig/drivers/video/fbdev/aty/=
mach64_accel.c	2018-04-20 18:11:01.000000000 +0200
> +++ linux-stable/drivers/video/fbdev/aty/mach64_accel.c	2018-08-13 17:37:=
04.000000000 +0200
> @@ -291,7 +291,8 @@ void atyfb_imageblit(struct fb_info *inf
>  	if (!image->width || !image->height)
>  		return;
>  	if (!par->accel_flags ||
> -	    (image->depth !=3D 1 && info->var.bits_per_pixel !=3D image->depth)=
) {
> +	    (image->depth !=3D 1 && info->var.bits_per_pixel !=3D image->depth)=
 ||
> +	    (image->depth =3D 1 && info->var.bits_per_pixel =3D 24)) {
>  		cfb_imageblit(info, image);
>  		return;
>  	}
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
