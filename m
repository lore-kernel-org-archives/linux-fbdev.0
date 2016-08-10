From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Aug 2016 10:17:25 +0000
Subject: Re: [PATCH 16/20] fbdev: cobalt_lcdfb: Drop SEAD3 support
Message-Id: <355f078b-b81c-61ef-6c1f-8f5a345cb441@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="X4nskscgpLWoSE2VraiT27ojT48PMUJjT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
 <20160809123546.10190-17-paul.burton@imgtec.com>
In-Reply-To: <20160809123546.10190-17-paul.burton@imgtec.com>
To: Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>, "Maciej W. Rozycki" <macro@linux-mips.org>, Linus Walleij <linus.walleij@linaro.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>

--X4nskscgpLWoSE2VraiT27ojT48PMUJjT
Content-Type: multipart/mixed; boundary="TBJLpd01qRBGFesQsvgsowEibFS5LOsGa"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
 Ralf Baechle <ralf@linux-mips.org>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-fbdev@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>,
 "Maciej W. Rozycki" <macro@linux-mips.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 linux-kernel@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Simon Horman <horms+renesas@verge.net.au>
Message-ID: <355f078b-b81c-61ef-6c1f-8f5a345cb441@ti.com>
Subject: Re: [PATCH 16/20] fbdev: cobalt_lcdfb: Drop SEAD3 support
References: <20160809123546.10190-1-paul.burton@imgtec.com>
 <20160809123546.10190-17-paul.burton@imgtec.com>
In-Reply-To: <20160809123546.10190-17-paul.burton@imgtec.com>

--TBJLpd01qRBGFesQsvgsowEibFS5LOsGa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/16 15:35, Paul Burton wrote:
> The SEAD3 board no longer uses the cobalt_lcdfb driver, so remove the
> SEAD3-specific code from it.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
>  drivers/video/fbdev/Kconfig        |  2 +-
>  drivers/video/fbdev/cobalt_lcdfb.c | 42 ------------------------------=
--------
>  2 files changed, 1 insertion(+), 43 deletions(-)

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--TBJLpd01qRBGFesQsvgsowEibFS5LOsGa--

--X4nskscgpLWoSE2VraiT27ojT48PMUJjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqv81AAoJEPo9qoy8lh71HTIP/1FldFHomssLajEP6Z5Barl7
AL9lRRDMvR2/40LMvJowAqPH+SFO/7jGHwdGtXqPBI4Ts3bOGpetqsy3zA0XicHX
b7RrZ5Khc+tmK9JCFNWuJFYSctHDQnxCHqcwI/FA1vuqhC/yJpRkqFDkZZ7HtsvN
KQ6ElEYC6VZK4q9BwhtfZfn727SC9E468RpAO9KhYw50aooDd9OaBiXHuNRIaHi5
AdOTyMDvPTBp68DkjNRt0YerjtSQGGjHHmrl4F+PbXIgk+F66/dGYtjDX4lBqK0B
eLEf+eiDHsBBjSLBArOkRZWioDVv2X5lsG6MSp79XaNWpJI7uXfj0dhqeiLmwo4w
qqbEnI8MAuJRrcjQkVpszCAum9gBmZ0D0XQZ07gexLLvRbNalpBHcpEpj6F65agV
Kcxfj4rQWVsXUzYOyS3oYpr2RSOwUt3hE//CVpOGztAJqBxKfdnMk9jHNMGuvpjm
wdLPFk8mMIvdLSA6Sl0GLkHzThsWcz+AOVe7eeNgWHkSGz3C1rF9wFAe/XvPcQ/i
nOjJHtaGU4BQnPCE1Wj2x03bKsJdri8w4O0Fttuld/FkQJqBECMmPuMkW/JmDtAA
H2SLuXJ/y2I6mJO6Nn2mbZ90SDZJmte3NBG078usaXE31poeYH+o6bmrlmjNMy6t
CK3y3ew5LNYXNcFvuIQe
=GX+e
-----END PGP SIGNATURE-----

--X4nskscgpLWoSE2VraiT27ojT48PMUJjT--
