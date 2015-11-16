From: Mark Brown <broonie@kernel.org>
Date: Mon, 16 Nov 2015 10:55:58 +0000
Subject: Re: [PATCH v4 09/24] regulator: pwm: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <20151116105558.GB31303@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2015 at 09:56:32AM +0100, Boris Brezillon wrote:

> +++ b/drivers/regulator/pwm-regulator.c
> @@ -56,7 +56,7 @@ static int pwm_regulator_set_voltage_sel(struct regulat=
or_dev *rdev,
>  	int dutycycle;
>  	int ret;
> =20
> -	pwm_reg_period =3D pwm_get_period(drvdata->pwm);
> +	pwm_reg_period =3D pwm_get_default_period(drvdata->pwm);
> =20
>  	dutycycle =3D (pwm_reg_period *
>  		    drvdata->duty_cycle_table[selector].dutycycle) / 100;

It's not clear to me that we're not looking for the current period here
or in the other use.  Won't configuring based on a period other than the
one that has been set give the wrong answer?

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWSbY+AAoJECTWi3JdVIfQP9YH/3HzShiMLEHM9htE9zNi+b1X
MKled9NiDc/GeTF0N91okJI0AYB953qVhV2jETJCizDuZlnLQS5o4d4dwFMcxo5V
073JdENcBmchGG17/ZXvRViugGvrNtlGr9GetDwiL0CvD0kAxDnhWEoo/KPKsK05
PEUzGzCsmaAsREQrybun3RQZHqBuBltRt1rYY8dO67r9DmYiqgOP6OUUC5Ra7W/m
VkUjVpTMQh9CgjYpnMbXOTVo1K2H8RTS8Dd1httZ/jAbgeXo839WSmxynpWOz089
+OPFh9ouikJsJ29QUyBCqXuXozYcSOpQP80sFx+Jv8QyrEXGihhzEiG2pFxlYsE=
=WKGz
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
