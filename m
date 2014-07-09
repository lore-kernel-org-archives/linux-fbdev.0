From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 09 Jul 2014 16:30:50 +0000
Subject: Re: [PATCH] video: backlight: jornada720_lcd.c:  Cleaning up variable that is never used
Message-Id: <20140709163050.GM2635@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404763270-24932-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404763270-24932-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 07 Jul 2014, Rickard Strandqvist wrote:

> Variable ar assigned a value that is never used.
> I have also removed all the code that thereby serves no purpose,
> and made same change to clarify the similarities in function.
>=20
> This was found using a static code analysis program called cppcheck
>=20
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.s=
e>
> ---
>  drivers/video/backlight/jornada720_lcd.c |   31 ++++++++++++++----------=
------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/video/backlight/jornada720_lcd.c b/drivers/video/bac=
klight/jornada720_lcd.c
> index da3876c..d16abcf 100644
> --- a/drivers/video/backlight/jornada720_lcd.c
> +++ b/drivers/video/backlight/jornada720_lcd.c
> @@ -36,44 +36,41 @@ static int jornada_lcd_get_power(struct lcd_device *l=
d)
> =20
>  static int jornada_lcd_get_contrast(struct lcd_device *ld)
>  {
> -	int ret;
> +	int ret =3D -ETIMEDOUT;
> =20
>  	if (jornada_lcd_get_power(ld) !=3D FB_BLANK_UNBLANK)
>  		return 0;
> =20
>  	jornada_ssp_start();
> =20
> -	if (jornada_ssp_byte(GETCONTRAST) !=3D TXDUMMY) {
> +	if (jornada_ssp_byte(GETCONTRAST) !=3D TXDUMMY)
>  		dev_err(&ld->dev, "get contrast failed\n");
> -		jornada_ssp_end();
> -		return -ETIMEDOUT;
> -	} else {
> +	else
>  		ret =3D jornada_ssp_byte(TXDUMMY);
> -		jornada_ssp_end();
> -		return ret;
> -	}
> +
> +	jornada_ssp_end();
> +
> +	return ret;
>  }
> =20
>  static int jornada_lcd_set_contrast(struct lcd_device *ld, int value)
>  {
> -	int ret;
> +	int ret =3D -ETIMEDOUT;
> =20
>  	jornada_ssp_start();
> =20
>  	/* start by sending our set contrast cmd to mcu */
> -	ret =3D jornada_ssp_byte(SETCONTRAST);
> -
> +	if (jornada_ssp_byte(SETCONTRAST) !=3D TXDUMMY)
> +		dev_err(&ld->dev, "set contrast failed\n");
>  	/* push the new value */
> -	if (jornada_ssp_byte(value) !=3D TXDUMMY) {
> +	else if (jornada_ssp_byte(value) !=3D TXDUMMY)
>  		dev_err(&ld->dev, "set contrast failed\n");
> -		jornada_ssp_end();
> -		return -ETIMEDOUT;
> -	}
> +	else /* if we get here we can assume everything went well */
> +		ret =3D 0;
> =20
> -	/* if we get here we can assume everything went well */
>  	jornada_ssp_end();
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int jornada_lcd_set_power(struct lcd_device *ld, int power)

Counter suggestion.

What do you think, I think this looks cleaner:

static int jornada_lcd_get_contrast(struct lcd_device *ld)
{
	int ret;

	if (jornada_lcd_get_power(ld) !=3D FB_BLANK_UNBLANK)
		return 0;

	jornada_ssp_start();

	if (jornada_ssp_byte(GETCONTRAST) =3D TXDUMMY) {
		ret =3D jornada_ssp_byte(TXDUMMY);
		goto success;
	}

	dev_err(&ld->dev, "failed to set contrast\n");
	ret =3D -ETIMEDOUT;

success:
	jornada_ssp_end();
	return ret;
}

static int jornada_lcd_set_contrast(struct lcd_device *ld, int value)
{
	int ret =3D 0;

	jornada_ssp_start();

	/* start by sending our set contrast cmd to mcu */
	if (jornada_ssp_byte(SETCONTRAST) =3D TXDUMMY) {
		/* if successful, push the new value */
		if (jornada_ssp_byte(value) =3D TXDUMMY)
			goto success;
	}

	dev_err(&ld->dev, "failed to set contrast\n");
	ret =3D -ETIMEDOUT;

success:
	jornada_ssp_end();
	return ret;
}

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
