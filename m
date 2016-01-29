From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Jan 2016 11:35:02 +0000
Subject: Re: [PATCH resend] ocfb: fix tgdel and tvdel timing parameters
Message-Id: <56AB4E66.4020901@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pSwbpqqqwS2729HvmJp92e6G8cXvqo70l"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453819684-32742-1-git-send-email-andrea.merello@gmail.com>
In-Reply-To: <1453819684-32742-1-git-send-email-andrea.merello@gmail.com>
To: linux-fbdev@vger.kernel.org

--pSwbpqqqwS2729HvmJp92e6G8cXvqo70l
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/01/16 16:48, Andrea Merello wrote:
> According to the ocfb documentation:
> Fix tgdel HW param should be left margin, not right.
> Fix tvdel HW param should upper margin, not lower.
>=20
> This seems to fix lock issues on certain monitors (tested on a
> slightly customized IP, but the FPGA guy said that it should
> be the same wrt this changes).
>=20
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>=20
> diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
> index c9293ae..a970edc2 100644
> --- a/drivers/video/fbdev/ocfb.c
> +++ b/drivers/video/fbdev/ocfb.c
> @@ -123,11 +123,11 @@ static int ocfb_setupfb(struct ocfb_dev *fbdev)
>=20
>  	/* Horizontal timings */
>  	ocfb_writereg(fbdev, OCFB_HTIM, (var->hsync_len - 1) << 24 |
> -		      (var->right_margin - 1) << 16 | (var->xres - 1));
> +		      (var->left_margin - 1) << 16 | (var->xres - 1));
>=20
>  	/* Vertical timings */
>  	ocfb_writereg(fbdev, OCFB_VTIM, (var->vsync_len - 1) << 24 |
> -		      (var->lower_margin - 1) << 16 | (var->yres - 1));
> +		      (var->upper_margin - 1) << 16 | (var->yres - 1));
>=20
>  	/* Total length of frame */
>  	hlen =3D var->left_margin + var->right_margin + var->hsync_len +
> --
> 1.9.1
>=20

Thanks, queued for 4.5 fixes.

 Tomi


--pSwbpqqqwS2729HvmJp92e6G8cXvqo70l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWq05mAAoJEPo9qoy8lh71GXMP/i80cMho3oN4+YhC+aiS6Jnn
08rcI8jw2ba3MdTxJ5F3tzMbHIMWr2giIASRozPtR8GgaNm0+napIWijO5/HYa6n
hh1n5TJJHftp3ppIT+LcS+ldpS2DYg4U812/IU2I9knzsEcC8z0Z6CR0v/FncIiN
MhlVFwqBMFLoChs6wrtCTUnQytYGYQdlReLPNtWKbvwzcvPAvUTt9QAqkQqMUKFp
zw7Cu/Zi17jaVcBg7my5da04F6fVbdQAmlFc7/NjhcMpO1k1ITXwLnixTWoM5KQp
AoByKXm0sQABqWzmbiv5glfgYWZcceC09/xIWnxsNM2rDj0hpvqDBU5ehcpfAY7x
ZxyQAXcSTvhJGoeYcZ52dDOiWdEBKJJIFVqRwcMkIXPR3ofIZB1xEWtURu9sxj9x
raDxoX2uKTjdOsTyxWWjPkIu9OBHtgF+L3fJSctkEisponnps++Z2PDmloZoav4N
OiLL9G6msKXvLq2pINnPHsjPvUO6hn45bkucC2xtqagMvHFNOnedSYK3zmz3tjLy
7EB+Se6USkyIRj1ex2EylrDEJIr2DBwAiiqZYpkbzJDjJ+9JGuZBg2Ri00qQYiQC
E2qB6jsPrwyTbE0N4yrRBcUkVdLP59tD8AFPN1rGlFLwQH2aLt7fjWr5qvOwuDXy
AFCWb6myn1GW5n0v9Jjm
=L5E9
-----END PGP SIGNATURE-----

--pSwbpqqqwS2729HvmJp92e6G8cXvqo70l--
