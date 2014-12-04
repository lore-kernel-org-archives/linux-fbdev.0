From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 04 Dec 2014 14:53:27 +0000
Subject: Re: [PATCH 1/3] video: fbdev: Add additional vesa modes
Message-Id: <54807567.6000608@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nCuBASOiFVg1VufA3G5e7JxN0jcm3MNJJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-1-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-1-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--nCuBASOiFVg1VufA3G5e7JxN0jcm3MNJJ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/12/14 23:49, David Ung wrote:
> Add high resolution modes to vesa_modes struct.
>=20
> Signed-off-by: David Ung <davidu@nvidia.com>
> ---
>  drivers/video/fbdev/core/modedb.c | 27 +++++++++++++++++++++++++++
>  include/linux/fb.h                |  2 +-
>  2 files changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/co=
re/modedb.c
> index 388f797..0b57c1df 100644
> --- a/drivers/video/fbdev/core/modedb.c
> +++ b/drivers/video/fbdev/core/modedb.c
> @@ -468,6 +468,33 @@ const struct fb_videomode vesa_modes[] =3D {
>  	/* 33 1920x1440-75 VESA */
>  	{ NULL, 75, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
>  	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> +	/* 34 1920x1200-60 RB VESA */
> +	{ NULL, 60, 1920, 1200, 6493, 80, 48, 26, 3, 32, 6,
> +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> +	/* 35 1920x1200-60 VESA */
> +	{ NULL, 60, 1920, 1200, 5174, 336, 136, 36, 3, 200, 6,
> +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> +	/* 36 1920x1200-75 VESA */
> +	{ NULL, 75, 1920, 1200, 4077, 344, 136, 46, 3, 208, 6,
> +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> +	/* 37 1920x1200-85 VESA */
> +	{ NULL, 85, 1920, 1200, 3555, 352, 144, 53, 3, 208, 6,
> +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> +	/* 38 2560x1600-60 RB VESA */
> +	{ NULL, 60, 2560, 1600, 3724, 80, 48, 37, 3, 32, 6,
> +	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> +	/* 39 2560x1600-60 VESA */
> +	{ NULL, 60, 2560, 1600, 2869, 472, 192, 49, 3, 280, 6,
> +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> +	/* 40 2560x1600-75 VESA */
> +	{ NULL, 75, 2560, 1600, 2256, 488, 208, 63, 3, 280, 6,
> +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> +	/* 41 2560x1600-85 VESA */
> +	{ NULL, 85, 2560, 1600, 1979, 488, 208, 73, 3, 280, 6,
> +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> +	/* 42 2560x1600-120 RB VESA */
> +	{ NULL, 120, 2560, 1600, 1809, 80, 48, 85, 3, 32, 6,
> +	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },

Where did you take these timings? Are the modes in vesa_modes[] in some
defined order, or just in the order they have been added?

 Tomi



--nCuBASOiFVg1VufA3G5e7JxN0jcm3MNJJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgHVnAAoJEPo9qoy8lh71hKIP/A+J8aoMMXPDZlZvEq024UJb
UIYSmYLVJrvIWess+kDrugh+0xsF/+de2e33Cc2me1AgVrgQLME1VDEQ/y1s1n0f
HK5lv67X9yWe/I971jCi0JmYd8BdMuKsbnAD+FJMQ1d4OQh4Vq71q73d1smdpYS6
jIi08AFs2vmScGTwuxQ59ayDs4UuAbgkBRfzhjRNWTwDn6uf/BVP6c2lvhA7/UKa
Z7uAwWKGAsIzjw/uBCUmIFcTDUFtEzEFjCORAYSuPbPd/hU6dtgdtfTETp6ic4yl
3IDYpXn3cQ+WcZjXWb30jG6NVlNkRLQIYQXVCaaPcOhLYAO4OL1PC0U8RIrq1MfW
WyNIKzCiKTBTvMdXE2JgNwi+RBsvqwTw0p/+qkh/YZCyabZRISKBSa4XqtidR5Nc
zfVlCu0C5R0CAsMwyL+SxsolzFNUH9nQpeyHMmrpDIgwKMeN3CYwdFJapmoEeOh1
vZFkNGKIFEtkp0STvY/q3K4qzcOXKimHbfc2mWAwKlwEukiC9fkkANulAStS0mBf
Ln2mqkK1Md1ap8iulJGE9+vR5b81RWqQK9qn4rBMnHrwluis2EvrH843vgsre9Ko
6vN0gPckGR1euAQLBqYWM7q0iTg/aPRskX15yBi1jo9fkMd3pe0YCgrg1I+c4LLX
hyjwJKz9uR50e8ZPKSFw
=2KOR
-----END PGP SIGNATURE-----

--nCuBASOiFVg1VufA3G5e7JxN0jcm3MNJJ--
