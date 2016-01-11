From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 11 Jan 2016 07:57:40 +0000
Subject: Re: [PATCH] backlight: adp8860: fix another uninitialized variable use
Message-Id: <20160111075740.GP3331@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3284846.T0rzz6n1As@wuerfel>
In-Reply-To: <3284846.T0rzz6n1As@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, 30 Nov 2015, Arnd Bergmann wrote:

> A recent patch I did fixed two potential uses of uninitialized
> variables in the adp8870 and adp8860 drivers. Unfortunately,
> I missed another one:
>=20
> drivers/video/backlight/adp8860_bl.c: In function 'adp8860_bl_ambient_lig=
ht_level_show':
> drivers/video/backlight/adp8860_bl.c:570:11: warning: 'reg_val' may be us=
ed uninitialized in this function
>=20
> This does the same change as before in one additional function,
> and also changes the check for the return value in a way that
> avoids another false positive warning with a similar message.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6be3a5a9cd91 ("backlight: adp88x0: Fix uninitialized variable use")
> ---
> Sorry for missing this third hunk the first time around.

Where's your diff?

Applied anyway, thanks.

> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlig=
ht/adp8860_bl.c
> index f0d4c0324580..510e559c060e 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -566,11 +566,13 @@ static ssize_t adp8860_bl_ambient_light_level_show(=
struct device *dev,
> =20
>  	mutex_lock(&data->lock);
>  	error =3D adp8860_read(data->client, ADP8860_PH1LEVL, &reg_val);
> -	ret_val =3D reg_val;
> -	error |=3D adp8860_read(data->client, ADP8860_PH1LEVH, &reg_val);
> +	if (!error) {
> +		ret_val =3D reg_val;
> +		error =3D adp8860_read(data->client, ADP8860_PH1LEVH, &reg_val);
> +	}
>  	mutex_unlock(&data->lock);
> =20
> -	if (error < 0)
> +	if (error)
>  		return error;
> =20
>  	/* Return 13-bit conversion value for the first light sensor */
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
