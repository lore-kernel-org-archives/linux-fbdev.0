From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 02 Sep 2015 11:33:17 +0000
Subject: Re: [PATCH 3/4] [resend #2] fb_ddc: Allow I2C adapters without SCL read capability
Message-Id: <55E6DE7D.9060700@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="16USfXaRsxOUNdglBDl2T6XswfTWTeWjJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440445048-24694-1-git-send-email-linux@rainbow-software.org>
 <1440445048-24694-3-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1440445048-24694-3-git-send-email-linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>, Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

--16USfXaRsxOUNdglBDl2T6XswfTWTeWjJ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 24/08/15 22:37, Ondrej Zary wrote:
> i2c-algo-bit allows I2C adapters without SCL read capability to work bu=
t
> fb_ddc_read fails to work on them.
>=20
> Fix fb_ddc_read to work with I2C adapters not capable of reading SCL.
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
>  drivers/video/fbdev/core/fb_ddc.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fb_ddc.c b/drivers/video/fbdev/co=
re/fb_ddc.c
> index 94322cc..22c694a 100644
> --- a/drivers/video/fbdev/core/fb_ddc.c
> +++ b/drivers/video/fbdev/core/fb_ddc.c
> @@ -69,10 +69,11 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adap=
ter)
>  		algo_data->setscl(algo_data->data, 1);
>  		for (j =3D 0; j < 5; j++) {
>  			msleep(10);
> -			if (algo_data->getscl(algo_data->data))
> +			if (algo_data->getscl &&
> +			    algo_data->getscl(algo_data->data))
>  				break;
>  		}
> -		if (j =3D=3D 5)
> +		if (algo_data->getscl && j =3D=3D 5)
>  			continue;
> =20
>  		algo_data->setsda(algo_data->data, 0);
> @@ -91,7 +92,8 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adapte=
r)
>  		algo_data->setscl(algo_data->data, 1);
>  		for (j =3D 0; j < 10; j++) {
>  			msleep(10);
> -			if (algo_data->getscl(algo_data->data))
> +			if (algo_data->getscl &&
> +			    algo_data->getscl(algo_data->data))
>  				break;
>  		}

Aren't both of those loops pointless if there's no getscl?

 Tomi


--16USfXaRsxOUNdglBDl2T6XswfTWTeWjJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5t59AAoJEPo9qoy8lh716jsP/ih2HN1pegUy1yzfEtyFRR2m
2wGOd0bSMT7ILMPmafqibk+CCsENOLKpL/1i37Z4bAf2PCHyRMVxxuxPvWL9Hvbo
y7BxaoDsjdEHlXmKhXSdmtXjpFPRQUDosQ8kwv083pE3o5CmtaQw2Wluwfaav5p2
N4J+3iObr1TbEZGQ8EvNPeIpUSzRU4ur/UrrIUIdq3QyWJL5glbWTno1z3MpzhoM
8lAZLzEd8nerz5auvSGOaYTk8IQHmnokmUYq4I6N/NS612hmWdTmoaPiGDY3q3io
NljLd1c1GVRCYYwmlCnfhntAVwo9KN3V6mh+qHx5YJdpkm//jlSvBw/WZEVIIPUw
/qe3p+Xx4m91G6iyPG+gGjMj8HThxAXqtkfpe54vUeNhHE5PSTPAcYcYuRb8hiU/
e7SeKmTtk34c1Ii7M0F5cD+pA4WX68WULJORkPh8Yo9/BU7V3BZtUAJPnzUJ+p5Q
l0dst4pPCwQao5u+2fTzPeZC80JAkzrj8vFVMvn+3hxaJJnPT/wjRo0XJb9gsFuD
NfxxZLH7eQXKploA3f4KpWBTyh8fJzEvEYzBJOY8ARdf5I2X2YhIwo8eLgI7d4d8
cqu7fwMvdECuYTDkrFYYDEOhk6JAzNE+lQvE/hPgz94bN1qXr1MxkMJ4JxKTEFzj
auwlP+GrAo8V/slKkUm+
=AhNR
-----END PGP SIGNATURE-----

--16USfXaRsxOUNdglBDl2T6XswfTWTeWjJ--
