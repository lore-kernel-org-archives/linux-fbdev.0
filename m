From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 12 Jul 2013 09:11:23 +0000
Subject: Re: [PATCH 1/2] fb: backlight: HX8357: Make IM pins optionnal
Message-Id: <20130712091123.GD24370@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yudcn1FV7Hsu/q59"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371839259-543-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20130624142645.GG305@game.jcrosoft.org>
 <20130625135015.GM26008@lukather>
In-Reply-To: <20130625135015.GM26008@lukather>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-fbdev@vger.kernel.org, jimwall@q.com, brian@crystalfontz.com, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 03:50:15PM +0200, Maxime Ripard wrote:
> > >  };
> > > =20
> > >  static u8 hx8357_seq_power[] =3D {
> > > @@ -250,9 +251,11 @@ static int hx8357_lcd_init(struct lcd_device *lc=
dev)
> > >  	 * Set the interface selection pins to SPI mode, with three
> > >  	 * wires
> > >  	 */
> > > -	gpio_set_value_cansleep(lcd->im_pins[0], 1);
> > > -	gpio_set_value_cansleep(lcd->im_pins[1], 0);
> > > -	gpio_set_value_cansleep(lcd->im_pins[2], 1);
> > > +	if (lcd->use_im_pins) {
> > > +		gpio_set_value_cansleep(lcd->im_pins[0], 1);
> > > +		gpio_set_value_cansleep(lcd->im_pins[1], 0);
> > > +		gpio_set_value_cansleep(lcd->im_pins[2], 1);
> > > +	}
> >=20
> > base on the dt probe you may have gpios betwee 0 to HX8357_NUM_IM_PINS
> >=20
> > so this look wrong
>=20
> How so?
>=20
> HX8357_NUM_IM_PINS is defined to 3, the probe checks to see if we
> actually have HX8357_NUM_IM_PINS, otherwise returns an error, what is
> wrong in setting these pins here?

Ping?

I'd really like to get this merged, could you clarify what you want?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR38g7AAoJEBx+YmzsjxAgrnMP/RsfQfsHqKBBJw7JTI6aMYKA
Cqht8j7s80/zr4EnKzWbmsBpxLhdkZ+8jthYOsk+USEWhLYyO1IK0LmVrygpL+jg
KVU3R0GYkNYaTLIJhhah/RV53mZNuCuklLppJzMotWOIOJYQGU2HIEL/LcdZhtdI
qhpLe10V/2TiqM4LVv7cV1mEDiQ9oGJLXBJJ0cieJwGPrxyFJg0IIoISHsvTGty2
w2POECARnXoHqfytXshrWq5pubU2BJ5X4A90taHNQ6/SrvJB/ra7qAI2l+TwTcMu
xIKbAm8XSz5wfur1DNgsH0O6VSiMYhuqHza4Pex1d5zu33/53YUdqGa9t7W5Jvl1
nWflGIogu9wOntPsW6Y6HxHYzr3f2u5OxZVAoisGAFCg4qS+sC/kdlISIULeraCT
HmKbZl+B0gYbVQRAdCx+nUmxZ6ZUuY51NUUJ7axLWLMrbCF2aLYfH0rz4hu6jWtj
LG+FYI0Al4qWdisObCK46Mmfq+sG7S1Hf1ppFtqUDG4sTlYzX4bZ1LO+Wl+yqjBp
witiSADGZQCfWCrZ/JQdtP0rQp2FJr+HV1xjdQuJ5pNaIjCzFgc6v7MmDfIHldqi
sLJf3uhAtMRmvMAOGektt5wk4HD5PNW9H11YcxQ9UW2qgnTtXTEjI2xhpcGjuzKj
mfnA1lqjaqvpjiY5Uf34
=DiKc
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
