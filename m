From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Aug 2015 09:33:34 +0000
Subject: Re: [PATCH] ARM/fb: ep93xx: switch framebuffer to use modedb only
Message-Id: <55C86FEE.6090502@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Vjsar9OrkTMmnKE6gLJb3S32c89cBUq4l"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437744688-29915-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1437744688-29915-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org

--Vjsar9OrkTMmnKE6gLJb3S32c89cBUq4l
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 24/07/15 16:31, Linus Walleij wrote:
> All the EP93xx boards exclusively use modedb to look up video
> modes from the command line. Root out the parametrization of
> custom video modes from the platform data and board files
> and simplify the driver.
>=20
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> J-C/Tomi: please ACK this if you're OK with it so I can take
> it through the ARM SoC tree.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--Vjsar9OrkTMmnKE6gLJb3S32c89cBUq4l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyG/uAAoJEPo9qoy8lh714LUQAIjQ5PtllkAGkPfKpgMgsydX
3ZJOc3cdjUjW/HMn8UoNeHX3mhXUbbmVTmMYp+9H5UzLpz8jkexwppX3PZjk37rv
loKyeZifVSisNLJvob3eKMGtPUVmBJPys7CihJ+29MHL8KfiYOw/bOeBQgPTKn10
btDNhTfQafcJY3B06CXPokfdgiPnXdROhEtUnhdiwkpXmiPf0WL5t2M+di872smv
P6iGNqjSmnIc3H+lBBNHQf2ZSxAyC4bH4HmohbHIaTPE/7IdQ1tEgaFrIqDpLkO0
LduxApqSxvgDald7IRdZr9HzhGu1dQaefIx0GeUeX4RysgAlGugJjUN7evkPMkWF
/hV6LA74LIXrbATKfeADjnzQ47Zk5cD49v2lTadhe1zRU0P9YYnE//7TD4J4lGjJ
fa6gV4T7jcVKe16TDr9gBIijie9dzqtJXB+25i4O3rF59fzOngzddepmJiBF756H
Ixclx3LpNxRYfzi0vHl0hc+7td4GKzcsBCYp3zw5s1iwSbu6L60Cj2JFlRDPGg9K
F3S00ymNAPsJpXTvdXOMgdCkoUnwOPQjV5db/EIh4YJxrsggiBI/v9BuNzhiFVGz
BZja0bjFj/s38WkVZ7UnP9Zb1GvkvTLLUj/cQeO+NnrkZ57tFlWupnpeiWWPGN7T
/CqenRp0pCXZB0EhuRgo
=5qQm
-----END PGP SIGNATURE-----

--Vjsar9OrkTMmnKE6gLJb3S32c89cBUq4l--
