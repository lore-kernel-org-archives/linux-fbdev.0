From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 07 Sep 2016 14:04:33 +0000
Subject: Re: [PATCH 2/6] pinctrl: sunxi: Add GR8 controller support
Message-Id: <20160907140433.GA28134@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-3-maxime.ripard@free-electrons.com>
 <CAGb2v66gZ4q4oJV5=xdbzLKKWtbm1PUQMOrm_J9CsLLHObCJhQ@mail.gmail.com>
In-Reply-To: <CAGb2v66gZ4q4oJV5=xdbzLKKWtbm1PUQMOrm_J9CsLLHObCJhQ@mail.gmail.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Alexander Kaplan <alex@nextthing.co>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2016 at 08:49:55PM +0800, Chen-Yu Tsai wrote:
> > +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
> > +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> > +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> > +                 SUNXI_FUNCTION(0x2, "lcd0"),          /* D6 */
> > +                 SUNXI_FUNCTION(0x3, "emac")),         /* ECRS */
>=20
> The cover letter said ethernet was gone?

That was my understanding, I doubled check and it's indeed there. I'll
amend the commit log. Thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0B5xAAoJEBx+YmzsjxAgFdsP/Rxh317YGdWJqWlUBi3srWMs
+DF/Jk9f7UJ67r83FgOxQxk4dcT92FDglqp3I4L1tWBJBSxXL/rkCQzV5DNCdzu1
+ubCnYi+M5VaqeicZbJzWVnRROliq6RCpvIVEdpRmwXOs9NKbD9z0ifgF9YfOMnI
E+2zRvTIRJwjLX248rsinQYdIP3Me1LMoPJIe5ol50zYHiO64fRn+rGw+lbzJNDd
oHHMkNi9wmrtQ+E6tABcOodmQiSesdIWaLYkPu4tA2fX8J90JNfuvOHHJAbThKh9
JLvWFsPfxsW+HHkPb6vy0+5MouJL9tL0XAAkH2BpXk6J2dZVQ/IDK6ziqRRPBFrW
PgtiKB1VRKZB+IkvsY4wGQAeb7ArkjNgQ7o7wyTL7Bp3s4mme7CmGCXpldV/Tkc5
S7C3VRVf6Q+qHL4zP4xv5G1/k7ABs0HIl2WTBvOUvNEM9hj/AJPWRubkcflrvH2F
w0K+zGJoJrIfwkpbGouCmV+WdU8A5K/Cu31/a/FzhD0su1F1CdcIQOgNV2msfPpG
//YIs9kQsnk6OxowGpaLuCTSsvB+fBQJFOKBAKvyrTRx/hy23tEJmIMsqcA/gnOx
H2myMO3vOAmLN9uNfbCvsx/xcT8tDG+jVcEWvqMcU6Ak4OVadPe9zD7VyBj3f8Ci
bW2+8MnoLwlCj390vTsV
=b/7r
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
