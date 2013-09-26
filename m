From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 09:10:43 +0000
Subject: Re: [PATCH 1/4] video: vfb: Remove incorrect check
Message-Id: <5243FA13.9050801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jJhn0NQco5WJrbxN8vWsFcOXrjHD6ajRa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380110579-3665-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380110579-3665-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--jJhn0NQco5WJrbxN8vWsFcOXrjHD6ajRa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 15:02, Sachin Kamat wrote:
> 'yoffset' is unsigned and hence cannot be less than 0.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/vfb.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
> index ee5985e..ea2b523 100644
> --- a/drivers/video/vfb.c
> +++ b/drivers/video/vfb.c
> @@ -390,9 +390,8 @@ static int vfb_pan_display(struct fb_var_screeninfo=
 *var,
>  			   struct fb_info *info)
>  {
>  	if (var->vmode & FB_VMODE_YWRAP) {
> -		if (var->yoffset < 0
> -		    || var->yoffset >=3D info->var.yres_virtual
> -		    || var->xoffset)
> +		if (var->yoffset >=3D info->var.yres_virtual ||
> +		    var->xoffset)
>  			return -EINVAL;
>  	} else {
>  		if (var->xoffset + info->var.xres > info->var.xres_virtual ||
>=20

Thanks, queueng the series for 3.13.

 Tomi



--jJhn0NQco5WJrbxN8vWsFcOXrjHD6ajRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQ/oTAAoJEPo9qoy8lh716tAQAILxL/vWn3vyGVdoM8FNIsHa
Da9BxLjc3ArckWSW02SVwc4tfFeGLnrLsy7I4vvhpKO9CAG0DZFQjMk6ets0Em5e
MyUwIKoFlWGDsLD2U9g5AKFeCie8Xl7v8+Wgf8huHtIMr42nQX2eL+l6mZJOYBVR
Nd4sK75ep01nHG6Qsf4zaB6E0UAzos4IcI8mhI4qcCxm+ZRH5ozi6u9taLTOfKfE
ELRKlwaY3KtRXcmS9Z9izQ7dXLD+mjAnONCig9ibIUH/I1daepWTHE/ZopK++pkl
AN3DzltXcBF0JPg8rUXSPcGFvm8kkzVtMSBexNoaP1DG2fHGnuVi7eecJQ5y0vgq
TPNvRIb5VJ4Onw361VOHYh0e+yyUKASH8weq+AOGfJCTl1FXtFaqs/NW80u6hfqT
URp3hephtNhEZ6uzt85GGURGHlDb7ImJjC706b1YG1qS1SvkBz4DkF0+n3OiFz0o
SaENS666vsH10vI/Il+QN07Lwp4SOW4biomejz0zoIetBuMIdm1J4TJanVajeZgk
xueUb13aG5+A0CjUYpsIxTDMZiRkObY96IFGQYUVdohqc8EXCgk/VjIdLRlHfYIR
7GUqDVybdzlGg8fO6uP2tX30qkKTlHZM0wxUYlxkHDcEMwr+nFaNUxI6hAfT1+/V
XXTxumNKDsE/Kg3gl7a9
=GdqP
-----END PGP SIGNATURE-----

--jJhn0NQco5WJrbxN8vWsFcOXrjHD6ajRa--
