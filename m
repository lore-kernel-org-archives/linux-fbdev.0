From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Feb 2016 11:47:36 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56CD9858.40104@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3jb4dx1J7KmXxJb9HW2s84SP0FvRL8nTA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com> <20160224104638.GL19428@n2100.arm.linux.org.uk>
 <56CD924F.50108@ti.com> <20160224113549.GN19428@n2100.arm.linux.org.uk>
In-Reply-To: <20160224113549.GN19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--3jb4dx1J7KmXxJb9HW2s84SP0FvRL8nTA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/02/16 13:35, Russell King - ARM Linux wrote:

> If the connector is a flexi-strip or LVDS connector designed to be
> connected directly to a panel, it is not designed as a user connector,
> and the display can be regarded as part of the board: the connector
> probably isn't rated for a large number of mating cycles.
>=20
> If the connector is a board-edge external-unit connector, then the
> panel is not part of the board.

Ok, I see. I presumed the display-board was attached directly to the
mainboard. Of course, we could still argue about the difference, with
the exact same pins used with an external connector and with an on-board
connector, but lets not go there.

I agree in this case the panels are external devices =3D).

However, I would still be interested in opinions how to implement the
exact same case, but for boards where the panels were considered
on-board panels.

> The displays are not built for "this single board" but for a family of
> boards: not only Versatile PB/AB, but also the Realview family of board=
s
> too.

Alright.

So, if this is to be done correctly, we need to disconnect the display
board code from the CLCD code, as they really have nothing to do with
each other.

Perhaps a panel driver which covers the display boards used here, which
does the probing and contains the video timings for the panels in questio=
n?

One could then use that panel driver with other display controllers too.
Although the probing part is perhaps difficult to make generic, but that
board specific code should still be part of the panel-board driver, not
CLCD driver.

>> But I cannot accept that as a general solution for all similar cases
>> going forward, especially when moving to DRM world, that's just bad SW=

>> design.
>=20
> I think that's a matter of personal opinion, perspective and situation.=

> What is good design today is not necessary good design yesterday or
> tomorrow.  I thought we already ascertained that earlier in this
> discussion. :)

Well, I was mostly referring to combining separate devices into single
driver. CLCD and the external displays, in this case. Then again,
"complexity" is part of the SW design, and splitting the devices drivers
into independent pieces often increases complexity, so...

 Tomi


--3jb4dx1J7KmXxJb9HW2s84SP0FvRL8nTA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzZhYAAoJEPo9qoy8lh71a3YP/0+g7sXV42QRt0wHT+d4pO5X
d++txhXeKB+h/SXbLiXpno+R0qTWY5YpvXSmAzJbo0AbRGaa8oWXmhOUlpVFeW6t
BFst/9Zfg3f0oboSRMXx/DD8jwbZlNI4YAp6ZTiCY/8tWCbrjqFV1zz2ye8+lTF8
ZQLzatDzB3JpWC8D2XwKzBbeJaQhU0Tuz+6oT+5ljPe5XSuleU7TRNlWhvUQkXCI
peg0dxPo2NtkMfd/VCH9h2rmM6pyrggZi8wU/RDNF6dCHXUlCKsCtGDecD8wH//g
pYGB5vgYm8Z5a/4PSq3QN4eHPwt3WxJinaIhq1NP9+5jLk1uM+GF07AkQa5gdAXy
9DYwKuJUPs35xll8RjD+3CTaG2PnluqaMSxx+NvxzpbfsY5Fl5FQX/U1CO2gY0zd
NehyZkJoJ+IkisQRZuBB1ZfPwlatd2j7tph4egwqGclbO2cPwlxKOVbjZ36uj/Y+
DH4JHlothDXi41ZvryUfcmaeO5mkIT3TLvq5wAa7mk8MN2imSRf2vpPcFhzigNAO
T3+iPRD8U3+gQOlzxS8rx3R0qwm+60T+UHeIwkwCGuwyXGqDCy8AHZ5IBrgDaznB
29K9/aShWw/+OtlzANAtdykKzdH3vTGhKYrRrJ51G86dQ2HB2jcWgTQy7DZvqLL6
s6rkwzJW5DV4SoHBGkm/
=nDGK
-----END PGP SIGNATURE-----

--3jb4dx1J7KmXxJb9HW2s84SP0FvRL8nTA--
