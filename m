From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 23 Nov 2015 16:22:49 +0000
Subject: Re: [PATCH] backlight: adp88x0: fix uninitialized variable use
Message-Id: <20151123162159.GC807@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3850346.cL1ocQLBvP@wuerfel>
In-Reply-To: <3850346.cL1ocQLBvP@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, 23 Nov 2015, Arnd Bergmann wrote:

> gcc correctly warns about both the adp8860 and adp8870 backlight
> drivers using an uninitialized variable in their error handling
> path:
>=20
> drivers/video/backlight/adp8870_bl.c: In function 'adp8870_bl_ambient_lig=
ht_zone_store':
> drivers/video/backlight/adp8870_bl.c:811:11: warning: 'reg_val' may be us=
ed uninitialized in this function
>=20
> This changes the code to only write back the data if it was
> correctly read to start with.
>=20
> As a side-note, the drivers are mostly identical, so I think they
> should really be merged into one file to avoid having to fix every
> bug twice.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied with the $SUBJECT line fixed.

> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlig=
ht/adp8860_bl.c
> index 98ffe71e8af2..f0d4c0324580 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -621,10 +621,12 @@ static ssize_t adp8860_bl_ambient_light_zone_store(=
struct device *dev,
> =20
>  		/* Set user supplied ambient light zone */
>  		mutex_lock(&data->lock);
> -		adp8860_read(data->client, ADP8860_CFGR, &reg_val);
> -		reg_val &=3D ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> -		reg_val |=3D (val - 1) << CFGR_BLV_SHIFT;
> -		adp8860_write(data->client, ADP8860_CFGR, reg_val);
> +		ret =3D adp8860_read(data->client, ADP8860_CFGR, &reg_val);
> +		if (!ret) {
> +			reg_val &=3D ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> +			reg_val |=3D (val - 1) << CFGR_BLV_SHIFT;
> +			adp8860_write(data->client, ADP8860_CFGR, reg_val);
> +		}
>  		mutex_unlock(&data->lock);
>  	}
> =20
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlig=
ht/adp8870_bl.c
> index 9d738352d7d4..21acac90fd77 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -807,10 +807,12 @@ static ssize_t adp8870_bl_ambient_light_zone_store(=
struct device *dev,
> =20
>  		/* Set user supplied ambient light zone */
>  		mutex_lock(&data->lock);
> -		adp8870_read(data->client, ADP8870_CFGR, &reg_val);
> -		reg_val &=3D ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> -		reg_val |=3D (val - 1) << CFGR_BLV_SHIFT;
> -		adp8870_write(data->client, ADP8870_CFGR, reg_val);
> +		ret =3D adp8870_read(data->client, ADP8870_CFGR, &reg_val);
> +		if (!ret) {
> +			reg_val &=3D ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> +			reg_val |=3D (val - 1) << CFGR_BLV_SHIFT;
> +			adp8870_write(data->client, ADP8870_CFGR, reg_val);
> +		}
>  		mutex_unlock(&data->lock);
>  	}
> =20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
