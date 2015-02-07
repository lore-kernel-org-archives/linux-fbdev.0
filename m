From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 07 Feb 2015 11:18:21 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150207111821.GN2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="prC3/KjdfqNV7evK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
To: niederp@physik.uni-kl.de
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--prC3/KjdfqNV7evK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 06, 2015 at 11:28:10PM +0100, niederp@physik.uni-kl.de wrote:
> From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
>=20
> It makes sense to use vmalloc to allocate the video buffer since it
> has to be page aligned memory for using it with mmap.

Please wrap your commit log at 80 chars.

It looks like there's numerous fbdev drivers using this (especially
since you copy pasted that code, without mentionning it).

That should be turned into an allocator so that drivers all get this
right.

> Also deffered io seems buggy in combination with kmalloc'ed memory
> (crash on unloading the module).

And maybe that's the real issue to fix.

> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 43 +++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index 01cfb46..945ded9 100644
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
> @@ -93,6 +94,43 @@ static struct fb_var_screeninfo ssd1307fb_var =3D {
>  	.bits_per_pixel	=3D 1,
>  };
> =20
> +static void *rvmalloc(unsigned long size)
> +{
> +	void *mem;
> +	unsigned long adr;
> +
> +	size =3D PAGE_ALIGN(size);

Isn't vmalloc already taking care of that?

> +	mem =3D vmalloc_32(size);

Why the 32 bits variant?

> +	if (!mem)
> +		return NULL;
> +
> +	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
> +	adr =3D (unsigned long) mem;
> +	while (size > 0) {
> +		SetPageReserved(vmalloc_to_page((void *)adr));

I'm not really sure it makes sense to mark all pages reserved if we're
not even sure we're going to use mmap.

And why do you need to mark these pages reserved in the first place?

> +		adr +=3D PAGE_SIZE;
> +		size -=3D PAGE_SIZE;
> +	}
> +
> +	return mem;
> +}
> +
> +static void rvfree(void *mem, unsigned long size)
> +{
> +	unsigned long adr;
> +
> +	if (!mem)
> +		return;
> +
> +	adr =3D (unsigned long) mem;
> +	while ((long) size > 0) {
> +		ClearPageReserved(vmalloc_to_page((void *)adr));
> +		adr +=3D PAGE_SIZE;
> +		size -=3D PAGE_SIZE;
> +	}
> +	vfree(mem);
> +}
> +
>  static struct ssd1307fb_array *ssd1307fb_alloc_array(u32 len, u8 type)
>  {
>  	struct ssd1307fb_array *array;
> @@ -538,13 +576,13 @@ static int ssd1307fb_probe(struct i2c_client *clien=
t,
>  	if (of_property_read_u32(node, "solomon,vcomh", &par->vcomh))
>  		par->vcomh =3D par->device_info->default_vcomh;
> =20
> -	vmem =3D devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
>  	if (of_property_read_u32(node, "solomon,dclk-div", &par->dclk_div))
>  		par->dclk_div =3D par->device_info->default_dclk_div;
> =20
>  	if (of_property_read_u32(node, "solomon,dclk-frq", &par->dclk_frq))
>  		par->dclk_frq  =3D par->device_info->default_dclk_frq;
> =20
> +	vmem =3D rvmalloc(vmem_size);
>  	if (!vmem) {
>  		dev_err(&client->dev, "Couldn't allocate graphical memory.\n");
>  		ret =3D -ENOMEM;
> @@ -570,7 +608,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  	info->var.blue.offset =3D 0;
> =20
>  	info->screen_base =3D (u8 __force __iomem *)vmem;
> -	info->fix.smem_start =3D (unsigned long)vmem;
> +	info->fix.smem_start =3D __pa(vmem);

Why are you changing from virtual to physical address here?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--prC3/KjdfqNV7evK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1fR9AAoJEBx+YmzsjxAgUcsP/ROxL4UIk0OSctIrHteYa/T6
EtRqDBPnMJHXVzmUjE/ctwSLDmOKpTAoLG+4F8FMZKxSK0xGpTwYBG9QnvfPVmLQ
5c9oGwP1B5SgYManafhuP9iM6aY0smCSXTvUDRM7+ls/GoDy/9DPwwUGgpGncJ76
cyv0yecc7yVi/7KavQ2lIFc0k7ye8ENXO2O5ixFPL6070jDC0hL3LsMFsRYga3TU
hc5C7hzPSc4w+UZR7OXLm4JbKFAiBNXA/kIvPXpySNf86kyaL4hSp7SKuIIc+FbN
lUO3QfCl514sRif+AoWyRvqHJEAMUX1wzKnVBM0rd5wYaykcT3ozgQlEpk2Iq8HA
WhBifaYN/RVBkKhKleVqwxiZsG1uyBb2NoVTRX3YiNbrF586FTT5uGjro7nQJIBq
RrTsHgoupDtu2MdwHiNDHkisfylc9AuhceZUZ9smAS3jvbebAJtY/q9lL+4TYAT8
XROnr+W1EFl2xSAjmhG6I4xHLTzYwOBGlr6qziAr+QDiGcSpiKrrPeWYVgALhSeg
NMXaEi8v9siV3h8ARSv3jUCAX6Mpn/uSCypWt7VxRoCBLYQLS5s1LXcgWyd1Ii56
9Ha0jpvVOTvuf1YzoC1cWqzfI2bHyERrtSYoQ7QuPOBOBtlN5nDbUA+KrO9hXPDS
J6GeE1oMyXFJcAQKo+5S
=0r5+
-----END PGP SIGNATURE-----

--prC3/KjdfqNV7evK--
