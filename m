From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 13 Jul 2017 08:17:31 +0000
Subject: Re: [PATCH v3] backlight: lm3630a: bump REG_MAX value to 0x50 instead of 0x1F
Message-Id: <20170713081731.zzsogrohfna6lscp@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170623035433.3446-1-bshah@kde.org>
In-Reply-To: <20170623035433.3446-1-bshah@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bhushan Shah <bshah@kde.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 23 Jun 2017, Bhushan Shah wrote:

> In the lm3630a_chip_init we try to write to 0x50 register, which is
> higher value then the max_register value, this resulted in regmap_write
> return -EIO.
>=20
> Fix this by bumping REG_MAX value to 0x50.
>=20
> This code was introduced with the chip revision in commit 28e64a68a2ef,
> however setting filter strength was failing silently because it used
> unsigned int for storing and comparing the return values. Bug related to
> signedness was fixed in 2a0c316bf3cc, which made it error out correctly
> instead of failing silently.
>=20
> I found this issue by using this driver on LGE Nexus 5 (hammerhead).
> After this commit lm3630a_chip_init succeeds instead of failing with
> -EIO.
>=20
> Fixes: 28e64a68a2ef ("backlight: lm3630: apply chip revision")
> Fixes: 2a0c316bf3cc ("drivers/video/backlight/lm3630a_bl.c: fix
> signedness bug in lm3630a_chip_init()")
>=20
> Signed-off-by: Bhushan Shah <bshah@kde.org>
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>=20
> Changes since v2:
>     - Include information about commits which introduced bug in commit me=
ssage
>     - Include information about test hardware in commit message
>     - Expand define name to REG_FILTER_STRENGTH
>=20
>  drivers/video/backlight/lm3630a_bl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlig=
ht/lm3630a_bl.c
> index 60d6c2ac87aa..2030a6b77a09 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -31,7 +31,8 @@
>  #define REG_FAULT	0x0B
>  #define REG_PWM_OUTLOW	0x12
>  #define REG_PWM_OUTHIGH	0x13
> -#define REG_MAX		0x1F
> +#define REG_FILTER_STRENGTH	0x50
> +#define REG_MAX		0x50
> =20
>  #define INT_DEBOUNCE_MSEC	10
>  struct lm3630a_chip {
> @@ -80,7 +81,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
> =20
>  	usleep_range(1000, 2000);
>  	/* set Filter Strength Register */
> -	rval =3D lm3630a_write(pchip, 0x50, 0x03);
> +	rval =3D lm3630a_write(pchip, REG_FILTER_STRENGTH, 0x03);
>  	/* set Cofig. register */
>  	rval |=3D lm3630a_update(pchip, REG_CONFIG, 0x07, pdata->pwm_ctrl);
>  	/* set boost control */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
