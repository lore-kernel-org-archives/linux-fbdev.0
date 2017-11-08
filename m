From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 08 Nov 2017 10:43:31 +0000
Subject: Re: [PATCH] backlight: ili922x: remove redundant variable len
Message-Id: <20171108104331.phpfymg2kslgwg3v@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171105115326.5276-1-colin.king@canonical.com>
In-Reply-To: <20171105115326.5276-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Colin King <colin.king@canonical.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Sun, 05 Nov 2017, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable len is assigned but never read, therefore it is redundant
> and can be removed. Cleans up clang warning:
>=20
> drivers/video/backlight/ili922x.c:276:2: warning: Value stored to 'len'
> is never read
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/video/backlight/ili922x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/=
ili922x.c
> index a9e9cef..2b6c6aa 100644
> --- a/drivers/video/backlight/ili922x.c
> +++ b/drivers/video/backlight/ili922x.c
> @@ -251,7 +251,7 @@ static int ili922x_write(struct spi_device *spi, u8 r=
eg, u16 value)
>  	struct spi_transfer xfer_regindex, xfer_regvalue;
>  	unsigned char tbuf[CMD_BUFSIZE];
>  	unsigned char rbuf[CMD_BUFSIZE];
> -	int ret, len =3D 0;
> +	int ret;
> =20
>  	memset(&xfer_regindex, 0, sizeof(struct spi_transfer));
>  	memset(&xfer_regvalue, 0, sizeof(struct spi_transfer));
> @@ -273,7 +273,6 @@ static int ili922x_write(struct spi_device *spi, u8 r=
eg, u16 value)
>  	ret =3D spi_sync(spi, &msg);
> =20
>  	spi_message_init(&msg);
> -	len =3D 0;
>  	tbuf[0] =3D set_tx_byte(START_BYTE(ili922x_id, START_RS_REG,
>  					 START_RW_WRITE));
>  	tbuf[1] =3D set_tx_byte((value & 0xFF00) >> 8);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
