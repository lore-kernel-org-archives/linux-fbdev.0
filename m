From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 24 Mar 2015 21:54:23 +0000
Subject: Re: [PATCHv5 07/11] fbdev: ssd1307fb: Add a module parameter to set the refresh rate
Message-Id: <20150324215423.GB23664@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ftEhullJWpWg/VHq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
 <1427232238-21099-8-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427232238-21099-8-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2015 at 10:23:54PM +0100, Thomas Niederpr=FCm wrote:
> This patch adds the module parameter "refreshrate" to set delay for the
> deferred io. The refresh rate is given in units of Hertz. The default
> refresh rate is 1 Hz. The refresh rate set through the newly introduced
> parameter applies to all instances of the driver and for now it is not
> possible to change it individually.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEd0PAAoJEBx+YmzsjxAgagwP/iEfhDCBFiVJZPcMw+QXccwT
Y3u08OTi1norXjL3SdOugMyN1TQrkndrMo7NY0fFlAWZ4LaBXexlNEbteyuXCSJe
HheG069Lone9R4jWtSG9j6RKyATvYagqUoyP0wbjC/xmWv5sNsiJoPJNBZc+GrYA
KYP0wU992Es2hYQkGGOtjvvGv5R8d0gGTYSsKJeaZsJ6dahl1+woPxLgsIF52zJW
8zhfRAcN7gnhWdvaDOmKefYR2qLd2g9vMp+nPm2Ty33FBEfycZ15occRYsxQAIuD
REqRbvizjNNwErOT2TkswIvY3Qaa1sRAUMtPu0ccy1SRXmG9mNa9rVHsOckCOgGi
pY+MoLRfe3J1qkcsVwABOfrqztB0s2VL1WYI3FpYvp8wXbZ+T24MEJuktsyfCa8c
i7oYrU/yjhx1rFdMTQYmQZa7oUdUMziuV5clRUoRHvNKKRVlhkhxnJJAJrTK7V6w
AmiBuIeqN0j8o4hkCZdkmGtqkXqKhDhARGZsuhN7kjrO2qSYgNIO5YsboXmaO1Ri
9W9kuDPgsT7EKTy2w/5LHkX/ZmEG4MnRvdcf03nedAlLP7ckg10Etn1ma73EHMIS
MQ8LHXOj3L8rmz4vJtnHuNPYOVfGM5TjreZmg3V7jcUKxn0sIc4D4BJAbCO1NXB1
0jyCRJiz5D2FeFCMwEFd
=ytnd
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
