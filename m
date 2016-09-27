From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:42:06 +0000
Subject: Re: [PATCH 1/2] fbdev: ssd1307fb: constify the device_info pointer
Message-Id: <260fc0f0-374f-0a1c-fb8a-36e7d4589414@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gf9N0hJsATLijcUEXHiMk0IIpAM07eGdQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471339638-25134-1-git-send-email-clabbe.montjoie@gmail.com>
In-Reply-To: <1471339638-25134-1-git-send-email-clabbe.montjoie@gmail.com>
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--gf9N0hJsATLijcUEXHiMk0IIpAM07eGdQ
Content-Type: multipart/mixed; boundary="29KPBHwlDbgJPku4ILN2AECbAOqpAklIw";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <260fc0f0-374f-0a1c-fb8a-36e7d4589414@ti.com>
Subject: Re: [PATCH 1/2] fbdev: ssd1307fb: constify the device_info pointer
References: <1471339638-25134-1-git-send-email-clabbe.montjoie@gmail.com>
In-Reply-To: <1471339638-25134-1-git-send-email-clabbe.montjoie@gmail.com>

--29KPBHwlDbgJPku4ILN2AECbAOqpAklIw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16/08/16 12:27, LABBE Corentin wrote:
> of_match_device return const data, so instead of casting its return val=
ue
> this patch constify the device_info pointer.
>=20
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1=
307fb.c
> index a9c45c8..b6c9ecf 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -64,7 +64,7 @@ struct ssd1307fb_par {
>  	u32 contrast;
>  	u32 dclk_div;
>  	u32 dclk_frq;
> -	struct ssd1307fb_deviceinfo *device_info;
> +	const struct ssd1307fb_deviceinfo *device_info;
>  	struct i2c_client *client;
>  	u32 height;
>  	struct fb_info *info;
> @@ -559,8 +559,8 @@ static int ssd1307fb_probe(struct i2c_client *clien=
t,
>  	par->info =3D info;
>  	par->client =3D client;
> =20
> -	par->device_info =3D (struct ssd1307fb_deviceinfo *)of_match_device(
> -			ssd1307fb_of_match, &client->dev)->data;
> +	par->device_info =3D of_match_device(ssd1307fb_of_match,
> +					   &client->dev)->data;
> =20
>  	par->reset =3D of_get_named_gpio(client->dev.of_node,
>  					 "reset-gpios", 0);
>=20

Thanks, queued these for 4.9.

 Tomi


--29KPBHwlDbgJPku4ILN2AECbAOqpAklIw--

--gf9N0hJsATLijcUEXHiMk0IIpAM07eGdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6jDeAAoJEPo9qoy8lh71DS8QAJS+r87KKT20s9bUP4D5WYV1
nRbLzrIzNNDmcSchlr4+Jk+XVKtBnu8JlNzMqgxDYCSV0L7mZrXP0DDoYgMde0ow
tLCmPGeAPvq81pE84zYUflOFq7QC5EDsvHx+UTDNqpOBNsViZ8cqsoQrgmBWCdBS
x6vEh8kxl2wNRqIxKejJRl9QIJfeO6nojI6QO/yy4nCUd7R0kJFqUIb4ErekLEUb
LwPirgvAARVb+w81oBDOR9HStq3u9igkmCOlJkBXp2zzmjJvPlBg+U86xKYi1WN9
eEYtWUwjvVBA3sa56IEjAC6Lb/xIP44npQFTk9nfUVJYzR0k4LgQR26CnaCntig5
PjgXBA/rGIKmx156DajGOet0DcuUn6T2NAb8TpgQC1174rn9B2mbSex+y1atRbBK
C6gZvLySbyK9BFktFCy6Bjq9AbDe0fg6iqUPbvQBx3LqysVgN0Z7r5269sYbkhmm
w/pTktur26yleEJ1l0oMbTzHR+fR0JkEAFW5hCnzSBY1vz1bioLIhgMKS7yRQyP2
alD9IHvfqvoQwNsq4q7M4JlNax4tFtk4BcwYnuDHHzDsiSGO2AYSxWkgGJCD54GF
5TH3v9EzFY4rvTKI2L6hKkW43qhLmhnauK7XpqESL+YwY2MdcRulemvUvISxuLln
+mG2QyY0BUgJkwCehf21
=Q4At
-----END PGP SIGNATURE-----

--gf9N0hJsATLijcUEXHiMk0IIpAM07eGdQ--
