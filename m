From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 01 May 2019 08:26:27 +0000
Subject: Re: [PATCH v3 3/3] backlight: lm3630a: add firmware node support
Message-Id: <20190501082627.GA2971@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190415072905.2861-1-masneyb@onstation.org>
 <20190415072905.2861-4-masneyb@onstation.org>
 <0e5e26ba-cf98-913e-8e76-e988a86dc0d1@ti.com>
In-Reply-To: <0e5e26ba-cf98-913e-8e76-e988a86dc0d1@ti.com>
To: Dan Murphy <dmurphy@ti.com>
Cc: Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > @@ -396,13 +506,20 @@ static int lm3630a_probe(struct i2c_client *clien=
t,
> >  				     GFP_KERNEL);
> >  		if (pdata =3D=3D NULL)
> >  			return -ENOMEM;
> > +
> >  		/* default values */
> > -		pdata->leda_ctrl =3D LM3630A_LEDA_ENABLE;
> > -		pdata->ledb_ctrl =3D LM3630A_LEDB_ENABLE;
> > +		pdata->leda_ctrl =3D LM3630A_LEDA_DISABLE;
> > +		pdata->ledb_ctrl =3D LM3630A_LEDB_DISABLE;
>=20
> This is not needed since default is disabled and kzalloc will set these t=
o 0

Let compiler do this kind of optimalizations. Code makes sense as-is.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzJWDMACgkQMOfwapXb+vK/6QCguYAgoaGIpYPAGtybTC9vIfZi
p4UAn2Haq8zwV7EpVgAkDZlkZ4x+gZWb
=7kTY
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
