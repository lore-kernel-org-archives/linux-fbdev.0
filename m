From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 22 Jul 2019 21:04:07 +0000
Subject: Re: [PATCH] Enable backlight when trigger is activated
Message-Id: <20190722210407.GA25617@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190718190849.GA11409@amd>
 <22d7eca4ad8aa2e73933c4f83c92221ce6e0945a.camel@collabora.com>
 <20190722075032.GA27524@amd>
 <6fc6af89-1455-7665-47e7-0568ecd87c9c@gmail.com>
In-Reply-To: <6fc6af89-1455-7665-47e7-0568ecd87c9c@gmail.com>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: linux-fbdev@vger.kernel.org, mpartap@gmx.net, b.zolnierkie@samsung.com, tony@atomide.com, merlijn@wizzup.org, kernel list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, sre@kernel.org, nekit1000@gmail.com, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> This looks fishy.
> >>
> >> Maybe you should use a default-state =3D "keep" instead? (and you'll h=
ave
> >> to support it in the LED driver).
> >>
> >> That'll give you proper "don't touch the LED if it was turned on" beha=
vior,
> >> which is what you seem to want.
> >=20
> > Actually no, that's not what I want. LED should go on if the display
> > is active, as soon as trigger is activated.
> >=20
> > Unfortunately, I have see no good way to tell if the display is
> > active (and display is usually active when trigger is activated).
>=20
> default-state DT property can be also set to "on"
> (see Documentation/devicetree/bindings/leds/common.txt).

Ok, thanks for the hint, that could work. (I thought we were using
default trigger to set the LED "on").

Now...this gives me option of 0% or 100% brightness, while best would
be 10% brightness.... but I guess we can live with that ;-).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl02JMcACgkQMOfwapXb+vI4ugCeInwKolmtAnBHOQNVsMS09AdN
Kr8AnAq4ihyjYP61ghzcLq9l2lbwoALF
=guhn
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
