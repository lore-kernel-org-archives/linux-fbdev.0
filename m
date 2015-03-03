From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 03 Mar 2015 08:52:55 +0000
Subject: Re: [PATCHv2 02/10] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150303085255.GB4911@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uZ3hkaAS1mZxFaxD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-3-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-3-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 01, 2015 at 11:27:55PM +0100, Thomas Niederpr=FCm wrote:
> It makes sense to use vmalloc to allocate the video buffer since it has t=
o be
> page aligned memory for using it with mmap. Also deffered io seems buggy =
in
> combination with kmalloc'ed memory (crash on unloading the module).
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index 61e0ce8..25dd08d 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -11,6 +11,7 @@
>  #include <linux/i2c.h>
>  #include <linux/fb.h>
>  #include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pwm.h>
> @@ -489,7 +490,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
> =20
>  	vmem_size =3D par->width * par->height / 8;
> =20
> -	vmem =3D devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
> +	vmem =3D vzalloc(vmem_size);
>  	if (!vmem) {
>  		dev_err(&client->dev, "Couldn't allocate graphical memory.\n");
>  		ret =3D -ENOMEM;
> @@ -559,6 +560,7 @@ panel_init_error:
>  		par->ops->remove(par);
>  reset_oled_error:
>  	fb_deferred_io_cleanup(info);
> +	vfree(vmem);
>  fb_alloc_error:
>  	framebuffer_release(info);
>  	return ret;

Don't you need the vfree in the remove too?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9XZnAAoJEBx+YmzsjxAgNPcQAJUAoS4YsapgkOOn9/wVhwg7
HbNq7Q/BuK70SC8nmB83gkiBm/3HwbbNzNPm2JEFzERZC1PfKiYPxqHv0Fircd8z
GPBVmuAGwf01SB6/ILYWxEETwxjpfbmnhTY6BxLYpMF3YnlGg8jH/yhgfQiEm8fE
fxXpy9rJVnMuS0Z+e/763eX5vjUU+Ez/zjyDLIXahLw5GRY79OhVshfGvSXZaBX6
CRj8DcCKdDD/+olmuvKwMznPwqG5AZv1P9Q1D2vkAdcD3oUWZafxAe30PXQD4e5V
TcV6y9cF/fboZVB5LlJ491FbJRIodZ8A9haW25bGPm3p6AHr56Uivx5SMa4dp5Yg
vdawIF+BQnWXA0dcQvrFoi7aNgIr/pHqNWGLkEynEPBPZv0sHgVAFQj8F0Fsgo7U
SYShg6iGycjdTSk9a2CbGaOsNVsLBwQnA02tAAu1X/2dWXLOVhDT9ep1dvR9Yp4t
+N0IFqm1gjw2r/rK0CkmqHb/T1ugKHarXm65c9BUj2R2LeGUKwyHBR8WFA7jHerx
qW9dkLoPzVTShRruU7vEXhoFlkmJ5StlMZAJf6so2ZHf24Grn7gea/oysYDPunQq
T2hR2+8KpL06pfcNFkqvFJ6jqV1wXSZj62M1scrCvdKhnNighZ+e2Sjg5WYUEKSg
1Xnx6CfrxUMnUpyUplo9
=QMrq
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
