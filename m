From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Fri, 06 Sep 2019 18:17:14 +0000
Subject: Re: [PATCH] fbdev: matrox: make array wtst_xlat static const, makes object smaller
Message-Id: <20190906181714.GU7482@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190906181114.31414-1-colin.king@canonical.com>
In-Reply-To: <20190906181114.31414-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Colin King <colin.king@canonical.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 07:11:14PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Don't populate the array wtst_xlat on the stack but instead make it
> static const. Makes the object code smaller by 89 bytes.
>=20
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   14347	    840	      0	  15187	   3b53	fbdev/matrox/matroxfb_misc.o
>=20
> After:
>    text	   data	    bss	    dec	    hex	filename
>   14162	    936	      0	  15098	   3afa	fbdev/matrox/matroxfb_misc.o
>=20
> (gcc version 9.2.1, amd64)
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/video/fbdev/matrox/matroxfb_misc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/matrox/matroxfb_misc.c b/drivers/video/f=
bdev/matrox/matroxfb_misc.c
> index c7aaca12805e..feb0977c82eb 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_misc.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_misc.c
> @@ -673,7 +673,10 @@ static int parse_pins5(struct matrox_fb_info *minfo,
>  	if (bd->pins[115] & 4) {
>  		minfo->values.reg.mctlwtst_core =3D minfo->values.reg.mctlwtst;
>  	} else {
> -		u_int32_t wtst_xlat[] =3D { 0, 1, 5, 6, 7, 5, 2, 3 };
> +		static const u_int32_t wtst_xlat[] =3D {
> +			0, 1, 5, 6, 7, 5, 2, 3

All of those would easily fit in u8 as well.

> +		};
> +
>  		minfo->values.reg.mctlwtst_core =3D (minfo->values.reg.mctlwtst & ~7) |
>  						  wtst_xlat[minfo->values.reg.mctlwtst & 7];
>  	}
> --=20
> 2.20.1
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Ville Syrj=E4l=E4
Intel
