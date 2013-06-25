From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 25 Jun 2013 13:50:15 +0000
Subject: Re: [PATCH 1/2] fb: backlight: HX8357: Make IM pins optionnal
Message-Id: <20130625135015.GM26008@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="L/bWm/e7/ricERqM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371839259-543-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20130624142645.GG305@game.jcrosoft.org>
In-Reply-To: <20130624142645.GG305@game.jcrosoft.org>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-fbdev@vger.kernel.org, jimwall@q.com, brian@crystalfontz.com, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>


--L/bWm/e7/ricERqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean Christophe,

On Mon, Jun 24, 2013 at 04:26:45PM +0200, Jean-Christophe PLAGNIOL-VILLARD =
wrote:
> On 20:27 Fri 21 Jun     , Alexandre Belloni wrote:
> > From: Maxime Ripard <maxime.ripard@free-electrons.com>
> >=20
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/video/backlight/hx8357.c | 53 +++++++++++++++++++++++---------=
--------
> >  1 file changed, 31 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight=
/hx8357.c
> > index a0482b5..69f5672 100644
> > --- a/drivers/video/backlight/hx8357.c
> > +++ b/drivers/video/backlight/hx8357.c
> > @@ -76,6 +76,7 @@ struct hx8357_data {
> >  	unsigned		reset;
> >  	struct spi_device	*spi;
> >  	int			state;
> > +	u8			use_im_pins;
> boolean please

Ok.

> >  };
> > =20
> >  static u8 hx8357_seq_power[] =3D {
> > @@ -250,9 +251,11 @@ static int hx8357_lcd_init(struct lcd_device *lcde=
v)
> >  	 * Set the interface selection pins to SPI mode, with three
> >  	 * wires
> >  	 */
> > -	gpio_set_value_cansleep(lcd->im_pins[0], 1);
> > -	gpio_set_value_cansleep(lcd->im_pins[1], 0);
> > -	gpio_set_value_cansleep(lcd->im_pins[2], 1);
> > +	if (lcd->use_im_pins) {
> > +		gpio_set_value_cansleep(lcd->im_pins[0], 1);
> > +		gpio_set_value_cansleep(lcd->im_pins[1], 0);
> > +		gpio_set_value_cansleep(lcd->im_pins[2], 1);
> > +	}
>=20
> base on the dt probe you may have gpios betwee 0 to HX8357_NUM_IM_PINS
>=20
> so this look wrong

How so?

HX8357_NUM_IM_PINS is defined to 3, the probe checks to see if we
actually have HX8357_NUM_IM_PINS, otherwise returns an error, what is
wrong in setting these pins here?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--L/bWm/e7/ricERqM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRyaAXAAoJEBx+YmzsjxAgXzgP/3tXoq3QODgwp6aMKHu7krYf
R7ke3kNx2+upqhCa3Z1l7lNh1PXq9vaYjoul3+CQnqjzTXrzFt2LGuqSBD0N8Gj1
sgKu5NDhJ7YlJoq7daI+sy6DuC6pui4a7i47GbFFMlwi3ZhWSXc5+Ehw3Wi+W0fC
eOsTwad5quaxNziYvDvi9HfpGvr7He1GdhFGlS04aeZp46EG7QtDJclVz9lxvhfj
iqU2dWV7NHrgcKVy303X7rWTAceVWliYfI2FvuziflOPTvOX9tWaLLRYVOUSrWB+
mC1DULi6b6ybImRxCx8e/wtD6j2k1AfZGTyUnOxnYJfbfH28Xm3tok0EyN47wW0c
FtKPAcW5Wy4ro6bvGU9QjFQVcqIPbDF4DSRUtCzke5h6GT2oTEHoOhJNgnNNlQ9G
wkQVBcwyViNFn88e/Irtmrn0iN5hNGvxf7gQMmPZSvpRnQd3TuZj2kMI6eYA1dWx
s0C7uOfbM4LCPuzNUuNzf6ZDydTdYOb0l78IKoMOGsXJGIHHVcEG1uCKdgakQ1R3
5Ty8LVHA5RWEt74BsAUBnikyroplzKkFW9zTLtLpJo2T2XGOfSZka9L9Gn80pHth
LL4cjrbp+dXFsYvfA3w6IgF0QESZRvTLbhhVfX7M/2M30+RFrxTECnGbN+dXkCs9
25A2FbhFKNwCNsMzIBrb
=B+Ph
-----END PGP SIGNATURE-----

--L/bWm/e7/ricERqM--
