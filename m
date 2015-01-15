From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Jan 2015 11:27:06 +0000
Subject: Re: [PATCH 1/2] fbdev: ssd1307fb: set default height if not found in DT node
Message-Id: <54B7A40A.3050509@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="r9b76Td07I7h6u0r5SVtBU9muBM0fsWMx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420705079-3741-1-git-send-email-prabhakar.csengg@gmail.com> <1420705079-3741-2-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1420705079-3741-2-git-send-email-prabhakar.csengg@gmail.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, LFBDEV <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>

--r9b76Td07I7h6u0r5SVtBU9muBM0fsWMx
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/01/15 10:17, Lad, Prabhakar wrote:
> this patch sets the default height if its not found in DT.
>=20
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1=
307fb.c
> index f4daa59..70e3ce8 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -460,7 +460,7 @@ static int ssd1307fb_probe(struct i2c_client *clien=
t,
>  		par->width =3D 96;
> =20
>  	if (of_property_read_u32(node, "solomon,height", &par->height))
> -		par->width =3D 16;
> +		par->height =3D 16;
> =20
>  	if (of_property_read_u32(node, "solomon,page-offset", &par->page_offs=
et))
>  		par->page_offset =3D 1;
>=20

Thanks, queued for 3.20.

 Tomi



--r9b76Td07I7h6u0r5SVtBU9muBM0fsWMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt6QKAAoJEPo9qoy8lh71FxAQALGNDABKCbo8XSeGr7TjKtmn
oF8YbLLFqw54ht5VVLEXf4stKjKWNiofQoj/gIU7MMDs/tw0zO1joRogSjL5gQoB
h+FT7AvJ6qK3sSfr3Q/2Rtfq1Cinr3cfd7yQJZITtjn3V/H3Mgs3Rhq1SmJjWrOS
S2o4eB40V4GjSXViaLplxnn6Q+9IAs1/otpElFvm5YW0xiDeTyTGMZectvPbY7Cb
6s/mSSrwaxEFDy2cklFYX68UDiObCYnUwWV4Rwq0aB71GmWhb6qJCU70P0grbSqJ
Y2eAD2hR0KKE7ryx1LeN/YcozXX8DAwMdJNLv0MZZ72IW0tHCtMmUmZxqZIbaBqV
n9v5MtzjSSt8eJnCN638F0Od+T0C3aO5MG+y7P7PZZvzNbhYkMQ8LHDCp7s8ueql
HUa5hF97Zto/GbMho7/BMkV24Nw+59JMonoSG12TMsCvatbq/2An8BW1rN5RDU6s
pszOTHMX12YqjE8PaTtLEUUfy0PzgKLcErsSFPnj0HOT8dycQSodjlMrX9DQ+2i/
Lk2DeeQURGr/6vH5g0l6yUUEJnOq7r+kJldwbZw8whXaiW3JLOjT+j99nxB73IqP
H3dsnFZj42G3braGG5eGwKx33Bg33YmY5FB2HSpHwShGiLXkycncvbp9m2OvGTQX
7hp2eR+6PO2qqlDgwcs6
=Skr8
-----END PGP SIGNATURE-----

--r9b76Td07I7h6u0r5SVtBU9muBM0fsWMx--
