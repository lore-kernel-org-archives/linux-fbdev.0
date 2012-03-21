From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 21 Mar 2012 12:50:00 +0000
Subject: Re: [PATCH 1/2] OMAPDSS: TPO-TD03MTEA1: Check for errors from regulator_enable()
Message-Id: <1332334200.2236.13.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-gBXtJRkVb6S5CkDYVEzZ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-gBXtJRkVb6S5CkDYVEzZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 15:02 +0000, Mark Brown wrote:
> It is possible for regulator_enable() to fail and if it does fail that's
> generally a bad sign for anything we try to do with the hardware afterwar=
ds
> so check for and immediately return an error if regulator_enable() fails.
>=20
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/driver=
s/video/omap2/displays/panel-tpo-td043mtea1.c
> index 32f3fcd..74c6b87 100644
> --- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> +++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> @@ -272,11 +272,14 @@ static const struct omap_video_timings tpo_td043_ti=
mings =3D {
>  static int tpo_td043_power_on(struct tpo_td043_device *tpo_td043)
>  {
>  	int nreset_gpio =3D tpo_td043->nreset_gpio;
> +	int r;
> =20
>  	if (tpo_td043->powered_on)
>  		return 0;
> =20
> -	regulator_enable(tpo_td043->vcc_reg);
> +	r =3D regulator_enable(tpo_td043->vcc_reg);
> +	if (r !=3D 0)
> +		return r;
> =20
>  	/* wait for regulator to stabilize */
>  	msleep(160);

Thanks, I'll apply this series to omapdss tree.

 Tomi


--=-gBXtJRkVb6S5CkDYVEzZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPac54AAoJEPo9qoy8lh717j8QAIKNPQZGE/3gvGw1xJmccKKY
Z/XgHj9VTljpBCdxAreb94Fmjl6aX2ZpMJGFZ8fIUWnLIMsA2bsLaJtELWh0TTgX
zKsbNdKBBVrBd8BKWpo41fme3qLYPBm07Cv7na3KhIhQrdU7Cs5lpcoUCpGMHOTo
N4H3vOg2Q1lNxpAi7TWSJF5mvaxMXGeaBZwxI16+Us6ZH9XBkylZbC5nFQoIbCbv
ylut0ekYHOwpuh3lKXm+i0Ss2XM5DSi17VxR84BPPe626oEA+MYDCYWLZ/TcyvZ5
1/cU1CRWwsNaz/lkNtWEjMeWAqzMzuXk8LLWVwRaI+DlcXoQnu5iDSSMLZ/4Adkx
cbEhJXEMu4ANlXqJoX7JJ7XYX3mZNBPQ7CIR0iCuFZ+6wMnfBPykMmHKQuj9jhYS
4rqfThrQpMTnxaT7lIzRDv+o/GkVXRp/kBnYYT7XCmDAB+ijZnC5/K74DZdIW3hK
yekSHErEAWNJdj6faN+2WfZ1vSuXa9+SrYzXUAEGmqiiihOg+CC4agchU1eqTetp
+WdVicQiNK5mKysTezqU9phn6pF94WBWNjLY8g5hgcQ/XxMzcAa/aeOpqoZessA4
oqYYKJmkHplfQZ1BemU29hQT0E5ARFmJsRbb5Pk/eI8klrX4wU8NqljqX9wqdpNJ
vE5c96xH82Xs/b1CifqQ
=ew8t
-----END PGP SIGNATURE-----

--=-gBXtJRkVb6S5CkDYVEzZ--

