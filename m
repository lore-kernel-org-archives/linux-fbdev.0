From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 07 Jul 2014 10:48:00 +0000
Subject: Re: [PATCH] video: backlight: ili922x.c:  Cleaning up variable that is never used
Message-Id: <20140707104800.GB6407@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404670847-17249-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404670847-17249-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 06 Jul 2014, Rickard Strandqvist wrote:

> Variable ar assigned a value that is never used.
> I have also removed all the code that thereby serves no purpose.
>=20
> This was found using a static code analysis program called cppcheck
>=20
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.s=
e>
> ---
>  drivers/video/backlight/ili922x.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/=
ili922x.c
> index ea67fe1..06936c8 100644
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
