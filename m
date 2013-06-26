From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 07:55:51 +0000
Subject: Re: [PATCH 07/23] video: da8xx-fb: pix clk and clk div handling cleanup
Message-Id: <51CA9E87.5000408@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2WQANCTSTEMVHNVAUBDGQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170171-9561-8-git-send-email-detheridge@ti.com>
In-Reply-To: <1372170171-9561-8-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

------enig2WQANCTSTEMVHNVAUBDGQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 17:22, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> Use the new modedb field to store pix clk. Reorganize existing clock
> divider functions with names now corresponding to what they do, add
> common function prefix.
>=20
> Fix existing panel modedb pixclock to be in ps instead of Hz. This
> needed a change in the way clock divider is calculated. As modedb
> pixclock information is now in ps, override on "var" pixclock over
> modedb to var conversion is removed.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  drivers/video/da8xx-fb.c |   48 +++++++++++++++++---------------------=
-------
>  1 files changed, 18 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index f1d88ac..7f08644 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -160,7 +160,6 @@ struct da8xx_fb_par {
>  	struct clk *lcdc_clk;
>  	int irq;
>  	unsigned int palette_sz;
> -	unsigned int pxl_clk;
>  	int blank;
>  	wait_queue_head_t	vsync_wait;
>  	int			vsync_flag;
> @@ -201,7 +200,7 @@ static struct fb_videomode known_lcd_panels[] =3D {=

>  		.name           =3D "Sharp_LCD035Q3DG01",
>  		.xres           =3D 320,
>  		.yres           =3D 240,
> -		.pixclock       =3D 4608000,
> +		.pixclock       =3D 217014,

Maybe it'd be better to use a macro here and convert from Hz to ps. The
panel specs always (afaik) report the pixel clock in Hz, and it also
makes the units clear to the reader.

 Tomi



------enig2WQANCTSTEMVHNVAUBDGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyp6HAAoJEPo9qoy8lh71c5kQAKrs5b+9OwImgfDQBhDrMDcv
D5np1eMb255dxHmu7M8KYl7L2Fuu25j+jyzWSUdh4WVp4ZL+SG8CJ6CDSDpjiiCW
Wrz+srofn2U1s6OZTvFfZBnMOmUIqK22t1wmMBBN5yNlNY/gRLKvSLhOULaCdVfA
oRDr/hqjBxdPkmUUEusGvAEjmsuKWUS0FWHwY6xRNMAmzi2EuaoQ0Hq8QW5c9UQd
kAsIrQqKEdaD4j6qUAhsiOvh4HL/Gsl/e44X31peVrilnFju9dnaMGAhCkWBqi1T
RdcWWvw7skLEMFcje/OPcCptRfevtUV7NYWDGDNxNP8fxZllfCCLYkMwHgfNwVJn
AJX7VXNTjdmYbYxJW5ZKUTQR5cc/OejwKDgtjPbTM2P7PL+SoF/QerSx8W+vA7lW
YYlDUj6am80fSVnk1NnM8YbVQ/CTCZ8ozOcpj7Ps6kApmd1DtW/GUknxw0CT0zDk
Fy5iWNkGCuiX+ewMuvtQ1bojwibW8P2LpbAHoJsYQOrugVfDcI66CxPLhpWdpPAQ
ZhN1xjp0AG2OmE6Nb3EAYxKyPXKLWqoS2FAfn5vckMctlrqPQM47pI/z3D5tdeQ7
wQ8osmN22KTozyN88Q8fBdmdI7Siq3KeUIBFOBUkZOD6EANhIMLSo3qGz1/nXzq2
GnRK8NUit/a+rHfVYTNN
=TiG1
-----END PGP SIGNATURE-----

------enig2WQANCTSTEMVHNVAUBDGQ--
