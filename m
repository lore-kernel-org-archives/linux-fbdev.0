From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Mon, 27 Aug 2018 12:54:52 +0000
Subject: Re: [PATCH 1/3] mach64: fix display corruption on big endian machines
Message-Id: <20180827125452.GD11867@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1808251549550.8284@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808251549550.8284@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Sat, Aug 25, 2018 at 03:51:00PM -0400, Mikulas Patocka wrote:
> The code for manual bit triple is not endian-clean. It builds the variable
> "hostdword" using byte accesses, therefore we must read the variable with
> "le32_to_cpu".
>=20
> The patch also enables (hardware or software) bit triple only if the image
> is monochrome (image->depth). If we want to blit full-color image, we
> shouldn't use the triple code.

Makes sense.
Reviewed-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>

>=20
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
>=20
> ---
>  drivers/video/fbdev/aty/mach64_accel.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> Index: linux-stable/drivers/video/fbdev/aty/mach64_accel.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-stable.orig/drivers/video/fbdev/aty/=
mach64_accel.c	2018-08-24 17:31:21.000000000 +0200
> +++ linux-stable/drivers/video/fbdev/aty/mach64_accel.c	2018-08-24 19:12:=
40.000000000 +0200
> @@ -345,7 +345,7 @@ void atyfb_imageblit(struct fb_info *inf
>  		 * since Rage 3D IIc we have DP_HOST_TRIPLE_EN bit
>  		 * this hwaccelerated triple has an issue with not aligned data
>  		 */
> -		if (M64_HAS(HW_TRIPLE) && image->width % 8 =3D 0)
> +		if (image->depth =3D 1 && M64_HAS(HW_TRIPLE) && image->width % 8 =3D 0)
>  			pix_width |=3D DP_HOST_TRIPLE_EN;
>  	}
> =20
> @@ -382,7 +382,7 @@ void atyfb_imageblit(struct fb_info *inf
>  	src_bytes =3D (((image->width * image->depth) + 7) / 8) * image->height;
> =20
>  	/* manual triple each pixel */
> -	if (info->var.bits_per_pixel =3D 24 && !(pix_width & DP_HOST_TRIPLE_EN)=
) {
> +	if (image->depth =3D 1 && info->var.bits_per_pixel =3D 24 && !(pix_widt=
h & DP_HOST_TRIPLE_EN)) {
>  		int inbit, outbit, mult24, byte_id_in_dword, width;
>  		u8 *pbitmapin =3D (u8*)image->data, *pbitmapout;
>  		u32 hostdword;
> @@ -415,7 +415,7 @@ void atyfb_imageblit(struct fb_info *inf
>  				}
>  			}
>  			wait_for_fifo(1, par);
> -			aty_st_le32(HOST_DATA0, hostdword, par);
> +			aty_st_le32(HOST_DATA0, le32_to_cpu(hostdword), par);
>  		}
>  	} else {
>  		u32 *pbitmap, dwords =3D (src_bytes + 3) / 4;

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
