From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 29 Sep 2016 10:55:36 +0000
Subject: Re: [PATCH v2 3/3] video: of: display_timing: Add support for syncclk-active property
Message-Id: <f2d2e5df-07ef-854d-9128-6adc91c83b95@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AoekTJxip2eUwhwRA9krLrDwrQEHmJPJc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160922103526.24925-1-peter.ujfalusi@ti.com>
 <20160922103526.24925-4-peter.ujfalusi@ti.com>
In-Reply-To: <20160922103526.24925-4-peter.ujfalusi@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, robh+dt@kernel.org, airlied@linux.ie, thierry.reding@gmail.com
Cc: daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org

--AoekTJxip2eUwhwRA9krLrDwrQEHmJPJc
Content-Type: multipart/mixed; boundary="wKPrXeOmNt1WcMUV6ASi7fNlRawp05Evk";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, robh+dt@kernel.org,
 airlied@linux.ie, thierry.reding@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Message-ID: <f2d2e5df-07ef-854d-9128-6adc91c83b95@ti.com>
Subject: Re: [PATCH v2 3/3] video: of: display_timing: Add support for
 syncclk-active property
References: <20160922103526.24925-1-peter.ujfalusi@ti.com>
 <20160922103526.24925-4-peter.ujfalusi@ti.com>
In-Reply-To: <20160922103526.24925-4-peter.ujfalusi@ti.com>

--wKPrXeOmNt1WcMUV6ASi7fNlRawp05Evk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/09/16 13:35, Peter Ujfalusi wrote:
> Configure the DISPLAY_FLAGS_SYNC_POSEDGE/NEGEDGE flags according to the=

> binding document.
> If the syncclk-active is present in DT, configure the flags accordingly=
, if
> it is omitted it means that the SYNC edge is following the pixdata
> configuration.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> ---
>  drivers/video/of_display_timing.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_displ=
ay_timing.c
> index 8a1076beecd3..db992c684f09 100644
> --- a/drivers/video/of_display_timing.c
> +++ b/drivers/video/of_display_timing.c
> @@ -88,6 +88,15 @@ static int of_parse_display_timing(const struct devi=
ce_node *np,
>  		dt->flags |=3D val ? DISPLAY_FLAGS_PIXDATA_POSEDGE :
>  				DISPLAY_FLAGS_PIXDATA_NEGEDGE;
> =20
> +	if (!of_property_read_u32(np, "syncclk-active", &val))
> +		dt->flags |=3D val ? DISPLAY_FLAGS_SYNC_POSEDGE :
> +				DISPLAY_FLAGS_SYNC_NEGEDGE;
> +	else if (dt->flags & (DISPLAY_FLAGS_PIXDATA_POSEDGE |
> +			      DISPLAY_FLAGS_PIXDATA_NEGEDGE))
> +		dt->flags |=3D dt->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE ?
> +				DISPLAY_FLAGS_SYNC_POSEDGE :
> +				DISPLAY_FLAGS_SYNC_NEGEDGE;
> +
>  	if (of_property_read_bool(np, "interlaced"))
>  		dt->flags |=3D DISPLAY_FLAGS_INTERLACED;
>  	if (of_property_read_bool(np, "doublescan"))
>=20

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--wKPrXeOmNt1WcMUV6ASi7fNlRawp05Evk--

--AoekTJxip2eUwhwRA9krLrDwrQEHmJPJc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX7PMoAAoJEPo9qoy8lh71d+gP/RTR8cHx87dvkEO1k4M8KIGA
OYx0zNUWlFgGmB+WAlbblSigoB/MoWDFeAV52XWgtRdX18hhjPDjSYLVcZDJCp0M
qnrpYVXgyy582DpE8cYfhYpYnW4hj/hrOmSeOsmv+mvCmWbUPMW33Lxtr5aNBKM+
PV5mX5f9664SE/EwRv+TAM4cLzhUKpLXHlxlYxbl37cfPkLahOB3TGnyCWKo4/Jx
3QN4HC7e3y80KvIbyMJihwy+B1KXDOStlJ23tfZOy6VbAf2VqiWPjLz66J8jYtot
xNArb2559X3S6iRCsAxJNlyIjxPDLod+SDwgcQ5Ba6nYXTuhqppUyQVcW7vrBiPi
mXOtDxwRAZ8hCoNc2ZJa9MzeTN1ogdrHBozLLFFzDpBtWb6vA7lnf3npiLe3cWuq
K1pw73yPRFVCOTzqHoTG5HMIGv2FkEhOLJKgFzUjllQvso9wQT/3Hd5Bddoma6jL
d2fY1QjMCXrLhw5DJK0DkP0E2g/nk+YAl64yR5Pl2zpsmE1dJpRWGUKjN3PrHwT8
i4Z4Ujq0egKOhxfc16DDneNxlrCnmc1YG/fkLUieUWJ5lWcQk67py3PBgdSXkSaZ
liFYvG2ZsrFC/sA3lNV+WZpIKszMLIbE+AGy1hwH8eIY0pS8O/dvzBWpVty65+53
TO9CoDgvmHQOf2HtTIzG
=hunD
-----END PGP SIGNATURE-----

--AoekTJxip2eUwhwRA9krLrDwrQEHmJPJc--
