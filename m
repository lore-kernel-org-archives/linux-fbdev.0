From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 08:48:11 +0000
Subject: Re: [PATCH 1/2] backlight: l4f00242t03: Remove redundant spi_set_drvdata
Message-Id: <5243F4CB.7040309@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Btajlq143fbV7wpnw4AAtFmX5OfkELtU6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379659133-18799-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1379659133-18799-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--Btajlq143fbV7wpnw4AAtFmX5OfkELtU6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/09/13 09:38, Sachin Kamat wrote:
> Driver core sets driver data to NULL upon failure or remove.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/backlight/l4f00242t03.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/back=
light/l4f00242t03.c
> index a35a38c..59eebe0 100644
> --- a/drivers/video/backlight/l4f00242t03.c
> +++ b/drivers/video/backlight/l4f00242t03.c
> @@ -244,7 +244,6 @@ static int l4f00242t03_remove(struct spi_device *sp=
i)
> =20
>  	l4f00242t03_lcd_power_set(priv->ld, FB_BLANK_POWERDOWN);
>  	lcd_device_unregister(priv->ld);
> -	spi_set_drvdata(spi, NULL);
> =20
>  	return 0;
>  }
>=20

Thanks, queuing this and the second patch for 3.13.

 Tomi



--Btajlq143fbV7wpnw4AAtFmX5OfkELtU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQ/TLAAoJEPo9qoy8lh71VTAP/jVw6notkQZKTirnlMGhm1Rw
CZDTXy9ZmikbBYo2EaCJpPNBFsdLjyUaifHyV24QrVXKjn/a3ztm4Dr7PNvcf78Z
I1YuLixk3j31n3ewRuafzLe2wKk9Zz5SX2hiHhAXtSiY6pddgex//JgMV0M7ACER
mXnlhuzBgQ6BXQ0dCsYzm0A84lSeEzg/H/jSmb+714bWJLyWqS3lOmoju46+oPuw
IkDo8QUESn7osZIx/yqtyNBvD1q0JcPgVtzLsknaMn8C04X86E6DTMv/xTYc2qBJ
4HbP58fCaKR0FQk0BZYZHg1XnfFlxci7yv0fNq5TgknqbV4YY3+hHXd5+oi0X7cT
LF5SAojHyX5xv++KLshjSiccotEWjKBPYuAdp1MzCY6YeL58Kpob/UJCBwWV0jrS
qJ83TGtUNA22L/M4q3sNlsiQqUhoDwF5jiesC00qPdCgSKmCg1dysTbSbUnKJjNP
b5fMMGYsSDjlxgf3KTjvVDsfZMndlFlRKIDF0XdMjnxVNRv0uwzLcy2V4ccgeSUv
hE265+vqj7Y7c2yt/8LZPMpMYAiyA8exGdKWOXQPtyigDTMVvnsYeeRq0z4YB+PO
SuKHCjOZeqfKtzLzaChNDH9a7HR3bKAXfk9fvyUFozW1VFj1r55/g58yTUyqxGYQ
uY0RCXf+zErBhY2Cir47
=SlRg
-----END PGP SIGNATURE-----

--Btajlq143fbV7wpnw4AAtFmX5OfkELtU6--
