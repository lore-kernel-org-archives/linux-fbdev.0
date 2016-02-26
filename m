From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 10:34:34 +0000
Subject: Re: [PATCH 3/7 v2] video: ARM CLCD: support DT signal inversion flags
Message-Id: <56D02A3A.6010701@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="plldgL8U0QlsksNTpLGbQlijrAGTTbWlX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <1456221704-5792-4-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1456221704-5792-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org

--plldgL8U0QlsksNTpLGbQlijrAGTTbWlX
Content-Type: multipart/mixed; boundary="N3Io4b1kBqT5xvclINRr2bQNUARcq8Nrc"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Ray Jui <ray.jui@broadcom.com>
Message-ID: <56D02A3A.6010701@ti.com>
Subject: Re: [PATCH 3/7 v2] video: ARM CLCD: support DT signal inversion flags
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <1456221704-5792-4-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1456221704-5792-4-git-send-email-linus.walleij@linaro.org>

--N3Io4b1kBqT5xvclINRr2bQNUARcq8Nrc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/02/16 12:01, Linus Walleij wrote:
> The device tree bindings from display-timing.txt allows us to
> specify if data enable, hsync, vsync or the pixed clock should be
> inverted on the way to the display. The driver does not currently
> handle this so add support for those flags as it is needed for
> the Versatile Sanyo LCD display.
>=20
> Note that the previous behaviour was to invert the pixel clock
> for all displays, so unless the pixel clock polarity is
> explicitly defined in the device tree (i.e. the timings node
> has the "pixelclk-active" property) we fall back to inverting
> the pixel clock. This needs some extra compatibility code.
>=20
> Since the timing flags have to be set up inside the struct
> clcd_panel, we need to refactor the code a bit to pass around
> the panel rather than just the mode.
>=20
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - No changes. Just reposting.
> ---
>  drivers/video/fbdev/amba-clcd.c | 41 +++++++++++++++++++++++++++++++++=
+-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba=
-clcd.c
> index c5d1e9ca81ab..8903a42c4122 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -567,10 +567,11 @@ static int clcdfb_register(struct clcd_fb *fb)
> =20
>  #ifdef CONFIG_OF
>  static int clcdfb_of_get_dpi_panel_mode(struct device_node *node,
> -		struct fb_videomode *mode)
> +		struct clcd_panel *clcd_panel)
>  {
>  	int err;
>  	struct display_timing timing;
> +	struct device_node *timnp;
>  	struct videomode video;
> =20
>  	err =3D of_get_display_timing(node, "panel-timing", &timing);
> @@ -579,10 +580,34 @@ static int clcdfb_of_get_dpi_panel_mode(struct de=
vice_node *node,
> =20
>  	videomode_from_timing(&timing, &video);
> =20
> -	err =3D fb_videomode_from_videomode(&video, mode);
> +	err =3D fb_videomode_from_videomode(&video, &clcd_panel->mode);
>  	if (err)
>  		return err;
> =20
> +	/* Set up some inversion flags */
> +	timnp =3D of_get_child_by_name(node, "panel-timing");
> +	if (timnp && of_property_read_bool(timnp, "pixelclk-active")) {

Hmm, why are you poking in the videomode DT properties directly? If the
pixelclk-active was not defined in the DT, you should see it in the
videomode struct as neither DISPLAY_FLAGS_PIXDATA_POSEDGE nor
DISPLAY_FLAGS_PIXDATA_NEGEDGE being set (I think, I didn't go through
the code in detail).

 Tomi


--N3Io4b1kBqT5xvclINRr2bQNUARcq8Nrc--

--plldgL8U0QlsksNTpLGbQlijrAGTTbWlX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0Co6AAoJEPo9qoy8lh71q6MP/jI+4OGacG+ZavvynNVW+R6H
/TEQeMLzCAHrgyKWtbubL/00sbtq6OenXFGUS7hQN3OzOge8ThsFlnT47b0G/Wbm
0f2JygGXfcJYVBjBZi4ahSoAJIPPLoauPNyVPg7uqN4jWLpXqonJGRlXzOzNJTWI
AUtHE9E7ewaGaIJaQhwQyHWkKkt8ca3X8C+4wuGQyCors9HWv9as+KSYpu6xIBn1
DNdXT/VKQhqfueCv4sXH8hlIe6/3QW6yVgGN3P2wpaoSQSexcNPBLYGAg0o36A2d
PeBGeVNF04C+Ml1bYVpcA/fNUoTaiZXYRHWKSadChSLoiGANd7vdI6FbUuNAHd7s
1f+hq0iP+bBrfNCr4CLNtV+2cXjUZ+uA9jelWlHiQtV080MMg6MhGcbzjjBgCv8W
SvTm/sht0bdex0pDMzpeEIqiSu6Xhlj+flWE48rYEhs5YO3T4xX5PGnYP1Mw6myD
iiVaUXBM1dDm2dvImz5uht1OzA+365gObNgvnjIS9TQBmdW4U3msaTr8htD7OwPx
Z+MrJYZEo39mVKmOMeTA6b8L4qi8Pe8DlaJDcKajpjGLKpfBf/zkDCZA8OzsSPF8
srWjXknI82kKHQCJqd8x9HfEw1YslBYqvu0QK46dUr+BHOvCGR3Ko87iK9LgkpVg
ETPKiKPJN0GU/B8tYLlC
=HmR8
-----END PGP SIGNATURE-----

--plldgL8U0QlsksNTpLGbQlijrAGTTbWlX--
