From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2016 08:47:38 +0000
Subject: Re: [PATCH v2 0/3] video: fbdev: imxfb: make it work again
Message-Id: <5731A02A.2070309@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cV8o4OcQDB9iCHbPJQfBcirJEkpUfiT0a"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

--cV8o4OcQDB9iCHbPJQfBcirJEkpUfiT0a
Content-Type: multipart/mixed; boundary="MKjqKTBGpt8u6tW1B0eb1wWjkP9E84WbP"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: kernel@pengutronix.de, linux-fbdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <5731A02A.2070309@ti.com>
Subject: Re: [PATCH v2 0/3] video: fbdev: imxfb: make it work again
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>

--MKjqKTBGpt8u6tW1B0eb1wWjkP9E84WbP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 04/05/16 12:43, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this is v2 of the series which addresses the review comments I got vor
> (implicit) v1.
>=20
> For patch 2 the question is still open if this is the right fix, but
> without this the display doesn't stay on. Patches 1 and 3 should be
> applicable independant of patch 2.

I picked patches 1 and 3, they look fine.

I still think patch 2 is just broken, it doesn't make sense to me.

If the regulator is enabled in probe, then it's always on, and
imxfb_lcd_set_power() should be removed as it never has any effect. But
that doesn't sound correct, as presumably the imxfb_lcd_set_power() has
worked at some point.

And shouldn't the regulator be disabled at least when suspending?

 Tomi


--MKjqKTBGpt8u6tW1B0eb1wWjkP9E84WbP--

--cV8o4OcQDB9iCHbPJQfBcirJEkpUfiT0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMaAqAAoJEPo9qoy8lh71EzgP/jZqTGHBIYKIf8RHqdm51kzu
MY3Yy9LLaUZqvg90MyziC2qvXOGLbUyV9FetgCKUXNYlZa3RyPE4vQOdsEUzrWNB
l/807sva31ku+Y1gdgunabWG59zTi55uC6AFs6wdsbz8rmb8bOQSEQT80V8oJU6H
/+c9Q9ThDsjvYtwEAG7Ngb6OgdRcy2jJ2F3HE/Nbs+EKvo0+PDSp/OZ5YiFNAKWV
Sx0rin+SBqwWpKQMgrwhmgpF0JB3yBW1MsYEAO60d8WhtOsozmBFCwnOCHrhvdEB
vO4/N9pQ7W8JdY2JdnZirrT5uh5LHqfd8Dk46bT/LMIlbNSV4T/mMPhnhpLYylHJ
IOzuTL8Cyu7Canr4J2nqNg/0riRHawxLvJP4zZN7f4RJ5QpmqsKYRJI0q3D0X6W9
YmqSm/nVnkFuWNqD4wvJvHzsRV1ZuKmA+YzelnSKf81VTxLmGlncWt2l66KSx4fx
k7bl4FCxGBfFihdBfgriB/9FnENaifpag6ktiJOjbehkwxJnyB8QcJUEII5YJOmi
Qu3LBa8JCFoW+iB3LHexTORv30qmmJDhsfZAFeYbUghrYfyMLE7j/diJKReVZl3C
SkUZxvEHvu1HW/00Bar3lCWChoyKe//8gDfTSy4hJ8ckiDie0I4mlwF8AFu1VPsk
UvD2h9aaMggyFrdPZgi+
=ELE9
-----END PGP SIGNATURE-----

--cV8o4OcQDB9iCHbPJQfBcirJEkpUfiT0a--
