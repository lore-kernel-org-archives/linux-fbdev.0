From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 05 Mar 2015 22:12:04 +0000
Subject: Re: [PATCHv2 07/10] fbdev: ssd1307fb: Add module parameter to set refresh rate of the display
Message-Id: <20150305221204.GF4522@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yH1ZJFh+qWm+VodA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-8-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-8-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 01, 2015 at 11:28:00PM +0100, Thomas Niederpr=FCm wrote:
> This patch adds the module parameter "refreshrate" to set delay for the
> deferred io. The refresh rate is given in units of Hertz. The default
> refresh rate is 1 Hz.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index c7ed287..ea58e87 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -43,6 +43,11 @@
>  #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
>  #define	SSD1307FB_SET_VCOMH		0xdb
> =20
> +#define REFRASHRATE 1
> +
> +static u_int refreshrate =3D REFRASHRATE;
> +module_param(refreshrate, uint, 0);
> +
>  static u_int contrast =3D 128;
>  module_param(contrast, uint, S_IRUGO);
> =20
> @@ -270,11 +275,6 @@ static void ssd1307fb_deferred_io(struct fb_info *in=
fo,
>  	ssd1307fb_update_display(info->par);
>  }
> =20
> -static struct fb_deferred_io ssd1307fb_defio =3D {
> -	.delay		=3D HZ,
> -	.deferred_io	=3D ssd1307fb_deferred_io,
> -};
> -
>  static int ssd1307fb_init(struct ssd1307fb_par *par)
>  {
>  	int ret;
> @@ -475,6 +475,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  {
>  	struct fb_info *info;
>  	struct device_node *node =3D client->dev.of_node;
> +	struct fb_deferred_io *ssd1307fb_defio;
>  	u32 vmem_size;
>  	struct ssd1307fb_par *par;
>  	u8 *vmem;
> @@ -544,10 +545,20 @@ static int ssd1307fb_probe(struct i2c_client *clien=
t,
>  		goto fb_alloc_error;
>  	}
> =20
> +	ssd1307fb_defio =3D devm_kzalloc(&client->dev, sizeof(struct fb_deferre=
d_io), GFP_KERNEL);
> +	if (!ssd1307fb_defio) {
> +		dev_err(&client->dev, "Couldn't allocate deferred io.\n");
> +		ret =3D -ENOMEM;
> +		goto fb_alloc_error;
> +	}
> +
> +	ssd1307fb_defio->delay =3D HZ/refreshrate;

a space around the operator.

I'm not so sure this is a good solution, since you might perfectly
want to have an SSD1305 with a refreshrate of 1Hz, and an SSD1306 with
a refreshrate of 20Hz.

Unfortunately, beside sysfs, I don't really have a better suggestion.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+NS0AAoJEBx+YmzsjxAgaj8P+weoBStKu0OvkV8YeqAyvdCw
Zh3CbSw2v0O/xiHOoG2IP1T8c9dgZugqzxQ0pgGk3NbhymV58il5HtraSVHDhX95
AbPg08XCbTtBg+H6A6CE0qW0LOgeYnDoZF4ugvljSsQ4HhpRBnaq7QZdrRF9VyP1
1ojTIgSgSVkiazAkBfBQrYHBiF2C7JN0i1hMhcMgCYCEIq6qfWgvm3s+VSnQFZxV
/TYlbgagd8gpj8ydArUZl7wynCCnv4Uwi6EErmq/mSpvhenhGyyGI3MIj2CaesHb
vf0GfSC0zAt2HyU4TGQMHDhq1AHQEOs4hnLHD7QNJGqPS7I03PutMwrQqT4OjLw1
DKigTTBtdBgvh3n0GSreaK3kO7eoV9dbClMZxnQEF+u5/ZAgmT90ZHeTUNaaKLKV
aVXX8OWpxEL2dHlIST1iURUC8GhS1jiNGYsh0fH5j/JPn94yGPxITTSBXsH/R3yK
D9LgKURYtyzgCE5we+FqOn83JY4bjjhpZWA0QRAXMms5JVV6apzHeM2o5m+guwxs
hsk9rM5YV5f8+CdWQC99fzOXD09aRSatynzJfDen/bfXbroLTQcBDl2q3gDF78b8
i8eANlRsm4Ws2p91AF9t07mfs4TJw9sZRf9fYnJQKDSy4ZgNZBffXaBThxiVwRng
bwMFVjXCWW4XzroT+N0D
=IXOH
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
