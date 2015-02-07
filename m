From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 07 Feb 2015 11:43:29 +0000
Subject: Re: [PATCH 7/8] fbdev: ssd1307fb: Add sysfs handles to expose contrast and dim setting to userspace.
Message-Id: <20150207114329.GQ2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="L0TNCHh3fkwjpuuE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-8-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-8-git-send-email-niederp@physik.uni-kl.de>
To: niederp@physik.uni-kl.de
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--L0TNCHh3fkwjpuuE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2015 at 11:28:13PM +0100, niederp@physik.uni-kl.de wrote:
> From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
>=20
> This patch adds sysfs handles to enable userspace control over the display
> contrast as well as the dim mode. The handles are available as "contrast"
> and "dim" in the framebuffers sysfs domain.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 88 +++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index b38315d..02931c7 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -33,6 +33,7 @@
>  #define SSD1307FB_CONTRAST		0x81
>  #define	SSD1307FB_CHARGE_PUMP		0x8d
>  #define SSD1307FB_SEG_REMAP_ON		0xa1
> +#define SSD1307FB_DISPLAY_DIM		0xac
>  #define SSD1307FB_DISPLAY_OFF		0xae
>  #define SSD1307FB_SET_MULTIPLEX_RATIO	0xa8
>  #define SSD1307FB_DISPLAY_ON		0xaf
> @@ -43,6 +44,9 @@
>  #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
>  #define	SSD1307FB_SET_VCOMH		0xdb
> =20
> +#define MIN_CONTRAST 0
> +#define MAX_CONTRAST 255
> +
>  #define BITSPERPIXEL 1
>  #define DELAYDIVIDER 20
> =20
> @@ -69,6 +73,7 @@ struct ssd1307fb_par {
>  	u32 dclk_div;
>  	u32 dclk_frq;
>  	struct ssd1307fb_deviceinfo *device_info;
> +	u32 dim;
>  	struct i2c_client *client;
>  	u32 height;
>  	struct fb_info *info;
> @@ -515,6 +520,79 @@ static const struct of_device_id ssd1307fb_of_match[=
] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
> =20
> +static ssize_t show_contrast(struct device *device,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct fb_info *info =3D dev_get_drvdata(device);
> +	struct ssd1307fb_par *par =3D info->par;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", par->contrast);
> +}
> +
> +static ssize_t store_contrast(struct device *device,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct fb_info *info =3D dev_get_drvdata(device);
> +	struct ssd1307fb_par *par =3D info->par;
> +	unsigned long contrastval;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 0, &contrastval);
> +	if (ret < 0)
> +		return ret;
> +
> +	par->contrast =3D max(min(contrastval,
> +		(ulong)MAX_CONTRAST), (ulong)MIN_CONTRAST);
> +
> +	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
> +	ret =3D ret & ssd1307fb_write_cmd(par->client, par->contrast);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +
> +static ssize_t show_dim(struct device *device,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct fb_info *info =3D dev_get_drvdata(device);
> +	struct ssd1307fb_par *par =3D info->par;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", par->dim);
> +}
> +
> +static ssize_t store_dim(struct device *device,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct fb_info *info =3D dev_get_drvdata(device);
> +	struct ssd1307fb_par *par =3D info->par;
> +	unsigned long dimval;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 0, &dimval);
> +	if (ret < 0)
> +		return ret;
> +
> +	par->dim =3D max(min(dimval, (ulong)1), (ulong)0);
> +	if (par->dim)
> +		ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_DIM);
> +	else
> +		ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static struct device_attribute device_attrs[] =3D {
> +	__ATTR(contrast, S_IRUGO|S_IWUSR, show_contrast, store_contrast),
> +	__ATTR(dim, S_IRUGO|S_IWUSR, show_dim, store_dim),
> +
> +};
> +

I would have thought this was something accessible through the
framebuffer ioctl.

Apparently it's not, at least for the contrast, so maybe it should be
added there, instead of doing it for a single driver?

(oh, and btw, every sysfs file should be documented in
Documentation/ABI)

>  static int ssd1307fb_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
> @@ -523,7 +601,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  	u32 vmem_size;
>  	struct ssd1307fb_par *par;
>  	u8 *vmem;
> -	int ret;
> +	int ret, i;
> =20
>  	if (!node) {
>  		dev_err(&client->dev, "No device tree data found!\n");
> @@ -650,6 +728,14 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  		goto reset_oled_error;
> =20
>  	ret =3D register_framebuffer(info);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(device_attrs); i++)
> +		ret =3D device_create_file(info->dev, &device_attrs[i]);
> +
> +	if (ret) {
> +		dev_err(&client->dev, "Couldn't register sysfs nodes\n");
> +	}
> +

sysfs_create_groups does pretty much that already.

And don't forget to remove these files in the .remove()

>  	if (ret) {
>  		dev_err(&client->dev, "Couldn't register the framebuffer\n");
>  		goto panel_init_error;
> --=20
> 2.1.1
>=20

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--L0TNCHh3fkwjpuuE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1fphAAoJEBx+YmzsjxAgNkoP/3My9GrVdFJ3Q7V3pUV3/eI5
ZldppTOZ6z6GlJpcAUeNh9XT76+CedZm1DDOrm/Kfy6/vZp1LF4yZswo25VGMGWD
j8MtqCIdiSvnhvwApPHW74yfT5kMQyY9CltKUPiS+vM61OJVKxTeDi4dLJxdjrrS
tVwHqjjpAlZgiw4/YI9FAJF2UEZufmiffrFNaYoH0A02Tks816FhezbUzaZrQ08Y
yiCOBpvk0rPEwa9Lf4cfbzG8KviE1D+sSFACYr8QE6VmsofOmwpVbogF5bzGrrvC
mCdDDcz/kQsmy93UzV9eyxKIzJk/YqcGmoIcZJ3iiqJNdeCN9Nm5VQVOqJpgY7TM
WqPKDFbRXB98TZ7a3KlNSGRLVHNwybk+kBKV7sAilDw4nHMIa9cbTdGJk16bi60M
OQTXWobMnpNZ9d2IrNLhaxs5qkOETtAQ7n2j+lExKiNObB4EQ/6J1UkVJX6gcnI4
eFU5NmDthYydwEly3JQ/cWeJ/6mr92vqEhDHK+m2a8YNwVBA2gEwctc7O/rYr869
JJLjIVdx9iz+SsTMCic9OjesrrRSny5UNWuvKSDn39k6vDI0DSAAIiffNres6LIN
FPl4AMYxpkfr/bTs34/r0jqtznzgfXqmXmzIctAvbm3mAvU6V4/8/etTdclgm3Kq
TSIt4ewqK0VDSBWBDgee
=uBJf
-----END PGP SIGNATURE-----

--L0TNCHh3fkwjpuuE--
