From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 07 Jul 2014 10:50:35 +0000
Subject: Re: [PATCH] video: backlight: jornada720_lcd.c:  Cleaning up variable that is never used
Message-Id: <20140707105035.GC6407@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404562325-18471-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404562325-18471-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 05 Jul 2014, Rickard Strandqvist wrote:

> From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>
>=20
> Variable ar assigned a value that is never used.
> I have also removed all the code that thereby serves no purpose.
>=20
> This was found using a static code analysis program called cppcheck
>=20
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.s=
e>
> ---
>  drivers/video/backlight/jornada720_lcd.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Is this different from the patch I just NACKed?

> diff --git a/drivers/video/backlight/jornada720_lcd.c b/drivers/video/bac=
klight/jornada720_lcd.c
> index da3876c..b304319 100644
> --- a/drivers/video/backlight/jornada720_lcd.c
> +++ b/drivers/video/backlight/jornada720_lcd.c
> @@ -56,12 +56,10 @@ static int jornada_lcd_get_contrast(struct lcd_device=
 *ld)
> =20
>  static int jornada_lcd_set_contrast(struct lcd_device *ld, int value)
>  {
> -	int ret;
> -
>  	jornada_ssp_start();
> =20
>  	/* start by sending our set contrast cmd to mcu */
> -	ret =3D jornada_ssp_byte(SETCONTRAST);
> +	jornada_ssp_byte(SETCONTRAST);
> =20
>  	/* push the new value */
>  	if (jornada_ssp_byte(value) !=3D TXDUMMY) {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
