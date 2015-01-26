From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 26 Jan 2015 12:43:30 +0000
Subject: Re: [PATCH] video: hgafb: remove unneeded comparison
Message-Id: <54C63672.6010700@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="K12w4wi7VGcoJSC0P1uKSCCT5xQQ2BBcn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421165699-9033-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1421165699-9033-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-nvidia@lists.surfsouth.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--K12w4wi7VGcoJSC0P1uKSCCT5xQQ2BBcn
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 13/01/15 18:14, Sudip Mukherjee wrote:
> var->yoffset is of the type __u32, hence the comparison will always
> be false.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/video/fbdev/hgafb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
> index 5ff9fe2..15d3ccf 100644
> --- a/drivers/video/fbdev/hgafb.c
> +++ b/drivers/video/fbdev/hgafb.c
> @@ -417,8 +417,7 @@ static int hgafb_pan_display(struct fb_var_screenin=
fo *var,
>  			     struct fb_info *info)
>  {
>  	if (var->vmode & FB_VMODE_YWRAP) {
> -		if (var->yoffset < 0 ||=20
> -		    var->yoffset >=3D info->var.yres_virtual ||
> +		if (var->yoffset >=3D info->var.yres_virtual ||
>  		    var->xoffset)
>  			return -EINVAL;
>  	} else {
>=20

Thanks, queued for 3.20.

 Tomi



--K12w4wi7VGcoJSC0P1uKSCCT5xQQ2BBcn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxjZyAAoJEPo9qoy8lh71td0P/j55yqcoaYO9dNSx7aPJaue8
rsJueRFAN5+ZhV1Pr9WHMhcePXqC2jLP771EycLvZ1EHnVMm+J5vwXF+1rjo8CQr
/7iUy74fUCF3iADjloI8pHyfDMi40jSfr+OWM2nmwRrBE0becH75kZVFGJIqymOf
bj0Wp1/yYhcN4LJZ2MvLDi/iG/gAK4hHWtcLyZqIVsyKq/3H8xaZqOL39JIPC/kY
kZ4tQjOeWDfY77rqKoDa5rhe8/pxx1lDUV91MpzN/ZMnk/SCK3Ml6eL6KIIrLNkK
qtZKGcwdEzMjxxoMGa/7bmMWYcx/cOt6Zkg2ED33IuZ++nUMqbm+1cZpzZPSeaez
quZ9cp7pxj62qLmFzpBnJaNBmuUa6Nji4UIWCVhG87/6Lo3o7VlgkvQfT7RJ5pd+
6Fit7/xG9Oi4Y4uKqCxuWSElmfDVq4GgA1lsDXE8BMGhIpF6xaXrBAC6wQX02CoZ
VfuRrDzh6Yb7Di07v/oZcB8KP48ojzs1wZbpZeR8CrVrD68TWGXDQ9sTaQ1UOUtF
prT8JuDSvjBHlntn9xh8XSjlaMDZHHGRWDRFiDXGId1PCjY8yWT44cZHRu5CNK4G
dv8gpubSCsx1JpPzNz/UXJT1c+D4Y3f6uDlisuAGZqODDzPvgcmagq2W6M/Ra0Nl
Q0nFQKFnm9LdC9sRLJsi
=KMA7
-----END PGP SIGNATURE-----

--K12w4wi7VGcoJSC0P1uKSCCT5xQQ2BBcn--
