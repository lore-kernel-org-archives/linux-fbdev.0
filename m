From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 28 Sep 2015 08:08:50 +0000
Subject: Re: [PATCHv3 1/3] leds: Add of_led_get() and led_put()
Message-Id: <5608F592.7010008@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KGrvgXVCDwHBT1GrLca4vtUQ9dSPJ82kd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441976857-26548-1-git-send-email-tomi.valkeinen@ti.com>
 <1441976857-26548-2-git-send-email-tomi.valkeinen@ti.com>
 <55F2DC3C.6090100@samsung.com>
In-Reply-To: <55F2DC3C.6090100@samsung.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--KGrvgXVCDwHBT1GrLca4vtUQ9dSPJ82kd
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 11/09/15 16:50, Jacek Anaszewski wrote:

>> +/**
>> + * led_put() - release a LED device, reserved with led_get()
>=20
> s/led_get/of_led_get/
>=20
> or we should add led_get, but since class_find_device, which increments=

> device ref count, takes led_node and led_match_led_node, it is tightly
> coupled tightly with OF. OTOH we could have of_led_put for symmetry,
> but it would have nothing to do with OF. Amending the comment is the
> best option here, I think.

I agree. I've changed the comment.

 Tomi


--KGrvgXVCDwHBT1GrLca4vtUQ9dSPJ82kd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWCPWSAAoJEPo9qoy8lh71oUoP/1XL0l+p0RD+vzy2C1sOm9cn
5GBTYPADKWPvJUx6HYptu4ewyCA9mjJ4Tm7T8vI+PyAZgRV8Sjua0PH0+8pj+98Z
z150RtWS70QaUw1hUyjupfViFmv+jJwQo1NQ5qWewu9HIz7690ntZZL/9jkuFVEp
lts8MkSOeuoOtX6EKDw7PhBoSL+N5AqYlEbA0ljQcWSLI6NcVDXIqeeYR14kltk8
+/1hjIleKx0a4BEmEm7j8WzyS4/PbWIAyBlfoC8Faa0UUOJXl2aDVjuw1wc43hXH
e48X8EMYzHTedtSZRowRiOzZ3zl81G/k1pAnwrdfKMYvu2MUaevA2PNRsOiXGCkr
BRcU73KK4N317pIt11hD8aWjujuSw00Wa9gSsSEb+LzXBtER3Add1Lxjg25Rx0f2
eaST3nLOtubAqUxMOo/QjTElc5XH+ciwzIt2v2n0syIdIlxC9nyC9HdTPSVREcMF
WAB/RcB4oiNZyDrjCBD4HOMsqxVjSI1MXv3o2THz3/Kvn/tIZz04864BQa4EY3+L
HE+lcqcypNivdLmfftjqESjmzNql+MKOSVz8w54oef/zO7Q3dIYIFLuopo1Q3CFX
5O4bOsm3zwQy1oCgVqOncJKrRnNGD02iQ8c/IUhOoVawLVGoGAVnu0zicoMoK3+Y
hghTqBVD78fELPKDrgsq
=U2IK
-----END PGP SIGNATURE-----

--KGrvgXVCDwHBT1GrLca4vtUQ9dSPJ82kd--
