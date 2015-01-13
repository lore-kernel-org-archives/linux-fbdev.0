From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 13 Jan 2015 10:37:06 +0000
Subject: Re: [PATCH 3/3] video: fbdev: Validate mode timing against monspec
Message-Id: <54B4F552.7040705@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jIFvHI8N1bEJ2x2GEhxL7Vc7ubf3pBu0K"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-3-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-3-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--jIFvHI8N1bEJ2x2GEhxL7Vc7ubf3pBu0K
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23/12/14 02:27, David Ung wrote:
> fbmon may generate mode timings that are out of spec of the monitor.
> eg DELL U2410 has a max clock 170mhz but advertises a resolutions of
> 1920x1200@60 in its Standard Timings using 2byte code of D1 00.
> When this is looked up in the DMT table it gives it a 193mhz clock.
> Although the DELL monitor supports 1920x1200@60, it can only run with
> reduced timings at 154mhz or DMT id 0x44 which has no STD 2byte code.
> This patch checks to see if the mode can be supported by the monitor
> by comparing against monspecs.dclkmax.
>=20
> Signed-off-by: David Ung <davidu@nvidia.com>
> ---
>  drivers/video/fbdev/core/fbmon.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/cor=
e/fbmon.c
> index aa1110a..cc3ea6c8 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -496,7 +496,7 @@ static int get_est_timing(unsigned char *block, str=
uct fb_videomode *mode)
>  }
> =20
>  static int get_std_timing(unsigned char *block, struct fb_videomode *m=
ode,
> -		int ver, int rev)
> +			  int ver, int rev, struct fb_monspecs *specs)

Here and in the rest of the functions I believe monspecs is never
supposed to be changed, so it should be marked as const.

 Tomi



--jIFvHI8N1bEJ2x2GEhxL7Vc7ubf3pBu0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtPVSAAoJEPo9qoy8lh71puoP/23FLVDDLjWpWLQHFYHKoJ/f
QGSCN9PzGTlsvdSQ6GYzLhutkzZRxd47usCvhC8+CUbXVNFc1ixYvnxtF11Qzw9R
IPDvzztVejpTO3pRWoMmpWjellZ5YZrgSf5Sma+q0f6IJd+/27EgtD7T56u7FEuO
xH4NXRfToUorrKP4M3xo/BREzZFNxLauaE2fc/5dGWDCqN0pT6/UU2W6kEEPIY9s
0apGcOU6+p3xsXbAo6EyxkkLmbt3uQob3DjJIyfEsvpRgEuyf3xQ9Mpf+KyyvdEv
JPYOJoqGFQGsFyDEIrUPF/P0oCUqhfWvUZ2hnljALiockN6xEsieeZoKd5h3Ag5a
o6azB8vciqBPyxtlTR8p9zPCd+8mk6BG6rsHc+VAovxvOUVLsunvat8IEga8Snti
IwU2zj/h+pzhyAPeVfnxUnWUjcspsU6fLUJqAVuZKcXFagyBYImHXybk/PNcv3xs
8QCHz0m6Fmox966Kfetf4wJ1xkj8nksniPN+tWuOisi6NOqgE04dFENHkl8ezQ7c
AFYr1VkB3e/AzKvXqhewlnUPfJaJSwtzr38MlQ4ssvdDhP4ldPK2HeAzKLcweLpu
8fc+Y4QHp+5d06aIWrKuMDu5dBL/8yplpED6GSqx9YRTDBHM4+LUh4473lwpWC/i
0ucZEdt30gm0dZjNc/JZ
=onrG
-----END PGP SIGNATURE-----

--jIFvHI8N1bEJ2x2GEhxL7Vc7ubf3pBu0K--
