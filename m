From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 06 Mar 2014 09:32:12 +0000
Subject: Re: [PATCH] video: fbdev: uvesafb: Remove impossible code path in uvesafb_init_info
Message-Id: <5318409C.5080101@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XftBeSl7n8Qhi3uWxFsM07FIGJiIpRdMp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140305155619.GA32166@udknight>
In-Reply-To: <20140305155619.GA32166@udknight>
To: Wang YanQing <udknight@gmail.com>
Cc: plagnioj@jcrosoft.com, fengguang.wu@intel.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--XftBeSl7n8Qhi3uWxFsM07FIGJiIpRdMp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/03/14 17:56, Wang YanQing wrote:
> Because uvesafb_vbe_init will fail when get zero avaiable modes,
> and we have checked the return value of uvesafb_vbe_init_mode,
> so it is impossible to pass NULL as mode into uvesafb_init_info.
>=20
> [ This patch fix warning report by fengguang.wu@intel.com
>   "drivers/video/fbdev/uvesafb.c:1509 uvesafb_init_info()
>    error: we previously assumed 'mode' could be null" ]
>=20
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  drivers/video/fbdev/uvesafb.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesaf=
b.c
> index 18352b2..509d452 100644
> --- a/drivers/video/fbdev/uvesafb.c
> +++ b/drivers/video/fbdev/uvesafb.c
> @@ -1474,12 +1474,7 @@ static void uvesafb_init_info(struct fb_info *in=
fo, struct vbe_mode_ib *mode)
>  	 *                 used video mode, i.e. the minimum amount of
>  	 *                 memory we need.
>  	 */
> -	if (mode !=3D NULL) {
> -		size_vmode =3D info->var.yres * mode->bytes_per_scan_line;
> -	} else {
> -		size_vmode =3D info->var.yres * info->var.xres *
> -			     ((info->var.bits_per_pixel + 7) >> 3);
> -	}
> +	size_vmode =3D info->var.yres * mode->bytes_per_scan_line;
> =20
>  	/*
>  	 *   size_total -- all video memory we have. Used for mtrr
>=20

Thanks, queuing for 3.15.

 Tomi



--XftBeSl7n8Qhi3uWxFsM07FIGJiIpRdMp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGECdAAoJEPo9qoy8lh71/fcP/iAyLWcG199jGtArXzZY2gIA
t0A1+CMeWQHSjKgzMqqnkzQBwXL/nCmfIUM+v/Abv2P6CBfWSbXne9yZNSEWJ4+n
Vg52vZqVwxIJTecrXmOHqnLFJCBadQqN+9aeDqisJfGwhbg6nnNwjVdd0aFiRi8U
VjX+9PAQeMIzJ1WyCQD2LJf/bigLnP4cENXiAMxcbWTFIf6VnvZn9S7GsMk4UObu
EfabVnKsud/aPJstl53+ge7SH3A5ElHdIpwj+v3KJKEg2r4MmcJauUdl6kbfPP9Y
RrOoJ7ouD7bMfhyGvluCTMXD8YWyD8Pd/MtnSRubc6e8U1LZdabH2FCqvpBheCwG
b8CqN/Sn72OehVZ7jA1jyVGWdRPfPy52KTSy3Es8zlkYifhHK6GU9IMUuCstzBiq
sGRP6Fb/nPpU6vRyBT147nVTUGbSUgnE1G6WamQS26fUnfTW1+Fo56L8zdNyCZNj
BykiAlwPn2VaEAf3LAxReugJkR6VPCViy5Z/osl9mHSAX9797pBCE8DHntpbGfoD
Hd5ftordCgs7rzsiZ6anF+x4K92MDBidBl6VCRvXRwhhqVWiTs2JSIFxLAVEgEs+
laGaNDFJZsDc8pCEpH3ym7wq96ILaGIftxLQuQSjs82warRrAfBxPNwfcTiqCWbd
k5qqBbMFbcqYewTm361g
=8Xlp
-----END PGP SIGNATURE-----

--XftBeSl7n8Qhi3uWxFsM07FIGJiIpRdMp--
