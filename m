From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
Date: Fri, 12 Jul 2013 12:30:28 +0000
Subject: Re: [PATCH RESEND] video: mxsfb: fix color settings for 18bit data bus and 32bpp
Message-Id: <20130712123028.GJ24370@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rmUrFcWP4LYae1gV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <51C01DE1.8030300@digi.com>
 <20130703085505.GG2969@lukather>
In-Reply-To: <20130703085505.GG2969@lukather>
To: linux-arm-kernel@lists.infradead.org


--rmUrFcWP4LYae1gV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2013 at 10:55:05AM +0200, maxime.ripard@free-electrons.com =
wrote:
> Hi Jean-Christophe,
>=20
> On Tue, Jun 18, 2013 at 10:44:17AM +0200, Hector Palacios wrote:
> > For a combination of 18bit LCD data bus width and a color
> > mode of 32bpp, the driver was setting the color mapping to
> > rgb666, which is wrong, as the color in memory realy has an
> > rgb888 layout.
> >=20
> > This patch also removes the setting of flag CTRL_DF24 that
> > makes the driver dimiss the upper 2 bits when handling 32/24bpp
> > colors in a diplay with 18bit data bus width. This flag made
> > true color images display wrong in such configurations.
> >=20
> > Finally, the color mapping rgb666 has also been removed as nobody
> > is using it and high level applications like Qt5 cannot work
> > with it either.
> >=20
> > Reference: https://lkml.org/lkml/2013/5/23/220
> > Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> > Acked-by: Juergen Beisert <jbe@pengutronix.de>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> I don't see this patch in your for-next branch.
>=20
> It would be really great to have it for 3.11 if possible.
>=20
> Could you take a look at this patch please?

Ping?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--rmUrFcWP4LYae1gV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3/bkAAoJEBx+YmzsjxAg8FYQAKx3vgtHNyCIYq4cC4LY5Q3b
Dm2H5n27pa0GVq0hTCiAAroFYpvynOOZsGwP1E7sAnsXTWsZiIk8jROoSIYS7Vh7
ZrQC6luH+aG3mchbRHlNA4CB/+AVZ5UNUk0k5DJOd/d9WDYR2gcthb4emS4yL5Un
l9ReecsH5QVUUz8OaTGptwzRcCrBtVa3wZPOStRiMRc4kHsDFdAsS3kjGnuWl25J
iKztRHO8i8lnlL5WtdwDrmOGRt/4A+WZ9Ji+x7Jv4Kwgceq+cD8Tbeg6cPoHPOzK
AOWK/cISf7lwPEnt0Vvfo5136WBmaJ+sm74N95c3HU9pict0AMCEyEXwFpmBDoA8
xp9/zyRWqzBXynPMmo0aaiQOxsgdfBKBfLo+YzNrbTeGjBUMEHI+/q/t4vU/NSZz
hvHjWGRlgsYVHoqxBVVhj4INGGMDGacp+or9PnxQPOpekLX6cB14UViGitUX4ep7
GYqbFamx7yHb5TfUYM02YKllJ+IFUt2e5QkEzIlkXOepPRiAaSHZUpJvW/qSGXNu
8dT8anAao7O9Nn0WTk/pqSDCSGwXNJpNEILKPNIdEVSKLB0Rv48GJjAB6OIMApYR
0j0yqVzAOZgXkf4JcNVd9y5A7IBjMHfLSdOg3STO8dcO7uzrPW/6OKcYwsR/VqKi
QGkK3qQnMuTnm65ImSJ5
=w+8O
-----END PGP SIGNATURE-----

--rmUrFcWP4LYae1gV--
