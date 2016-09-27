From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:22:14 +0000
Subject: Re: [PATCH] simplefb: Disable and release clocks and regulators in destroy callback
Message-Id: <4f60733b-9ec0-ff8a-638e-50d06a2a9de2@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="U6XIQOpj2tfskAuBG50Js8OABrA6SMltx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160907090919.27187-1-wens@csie.org>
In-Reply-To: <20160907090919.27187-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org

--U6XIQOpj2tfskAuBG50Js8OABrA6SMltx
Content-Type: multipart/mixed; boundary="rRdB8WbRf0UBt6J6haGNskWhWXJiGAGVq";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-ID: <4f60733b-9ec0-ff8a-638e-50d06a2a9de2@ti.com>
Subject: Re: [PATCH] simplefb: Disable and release clocks and regulators in
 destroy callback
References: <20160907090919.27187-1-wens@csie.org>
In-Reply-To: <20160907090919.27187-1-wens@csie.org>

--rRdB8WbRf0UBt6J6haGNskWhWXJiGAGVq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/09/16 12:09, Chen-Yu Tsai wrote:
> simplefb gets unregister when a proper framebuffer driver comes in and
> kicks it out. However the claimed clocks and regulators stay enabled
> as they are only released in the platform device remove function, which=

> in theory would never get called.
>=20
> Move the clock/regulator cleanup into the framebuffer destroy callback,=

> which gets called as part of the framebuffer unregister process.
>=20
> Note this introduces asymmetry in how the resources are claimed and
> released.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/video/fbdev/simplefb.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks, queued for 4.9.

 Tomi


--rRdB8WbRf0UBt6J6haGNskWhWXJiGAGVq--

--U6XIQOpj2tfskAuBG50Js8OABrA6SMltx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6iw2AAoJEPo9qoy8lh71eugP/jJjBYJSjbxtJwh85RiRuGy9
qCQgQChJQKIZ88C3SxG5j/QwecO5LbFuilAYRt0lugTNx81Ew/GbChn4rf3bn6o9
ouaDQCtLwwciWxnLjiGeWekXN49Zh4zv+ALvTOqnAOgonouoQMcmZUg1qcTTgdNg
uiu4w1IWVRcFfDPIjd7QqHYrmzObli2pu1VX5OY099pjW7D76OvJtldQUw8MZCXv
Vtvrc8Ws9BX6wq/ipYkMQ33vTgwvO5oPK2aS1i11pOCH5kTk4j+vCbnWP9MqljPH
A2EmxihssCOHlpRvKZHzrX4SQwOv2OcqdtfzQb4p912oHVZGOM8FIoYeYPQAlgWZ
T8c/iMeYeeNMR8vqHEYy042KQ0a4LCdnaxTe8Ez3Nc5sP0yIEQIND5rT0iZdEZSX
VTzUXK1aE6/z2YGMv7FoHRDR0OId4HwCgGabDScgm4Rv9ug+McjLcTDyIHYCnSlC
cSRZVsq1QB8TIPqD2/tkecnRDw/dkxRvoasVsWVS0nL2VOyqZSPln19+lN2crZKR
ZXrS+JPE4X8qaO9foHohyXjePXmmWhhiRznzrkThD02pX0K26NRF3RjtlIgWVIJD
IOgfMO5cwHuCEiR22+b5BnSJfyFQFBXUjTGQIQy5BswxP7JWcLta2gdKSMn4JqP2
6SnJ6dX3psfMr3f5m7An
=rIL2
-----END PGP SIGNATURE-----

--U6XIQOpj2tfskAuBG50Js8OABrA6SMltx--
