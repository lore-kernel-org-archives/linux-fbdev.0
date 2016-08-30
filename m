From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Aug 2016 08:54:42 +0000
Subject: Re: [PATCH] video: ARM CLCD: fix up Integrator support
Message-Id: <533a2463-daf2-be9c-491a-da7d6037728b@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BmN3TjheETfQiFDnAnWAEEd2XE06hvFFR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472462971-8935-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1472462971-8935-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org

--BmN3TjheETfQiFDnAnWAEEd2XE06hvFFR
Content-Type: multipart/mixed; boundary="bSDGIUjlW2HImNkPC646CjGkqgVvTTdaF";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Ray Jui <ray.jui@broadcom.com>
Message-ID: <533a2463-daf2-be9c-491a-da7d6037728b@ti.com>
Subject: Re: [PATCH] video: ARM CLCD: fix up Integrator support
References: <1472462971-8935-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1472462971-8935-1-git-send-email-linus.walleij@linaro.org>

--bSDGIUjlW2HImNkPC646CjGkqgVvTTdaF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/08/16 12:29, Linus Walleij wrote:
> We need to mask all registers of the Integrator/CP core module
> control register, and actually write the calculated value to the
> control register, not the mask.
>=20
> Tested on the Integrator/CP with RGB5551 VGA and works like a
> charm after this patch.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/video/fbdev/amba-clcd-versatile.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Thanks, queued for 4.9.

 Tomi


--bSDGIUjlW2HImNkPC646CjGkqgVvTTdaF--

--BmN3TjheETfQiFDnAnWAEEd2XE06hvFFR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxUnSAAoJEPo9qoy8lh71CUMQAKf0UNHlWM7c5rV7rDtAeD/s
+Yy3CFMJ1UdCF4st5+K/XuwuZT+dwjY6nLBLrfyMaJDrcr44EFVlBLOEw7PBgPx1
D23jvPP5vxAY1rZOnjslfWM+btzxR0tqoT8Q9i6Goc0LaOqYf4aB/s/vqfsg2bMX
IpWEYoi5xhP9ByT28XJjQadInwv7lvSJruWm2K14yl5GawkZYRM3lC13a8hJ5agi
KFwgqHX647IK8/OaPZoGl5d5brV5GXg1oLPAfm3MF4VJ1BBkMCFEtlhPSgXdMEF3
TvYSJtuVHqOuh85oFNuP4rFXriNi8ll11B2ZWQFPTMW0G9/I4hSIiYwPxEVo/yVs
zyVMqLqcuUEBzBiBsOd852e1l8A8MA6eHv7H1zLzbXc7tYgKyog9QNRuwRyMlZSa
tHCw9oay/W8tKigwfVI7LKNOJz8O/OrgmXWO9xM2LHV979LWKaWkqmgL4PNpQg02
uvE4PLDNKnKIx+gkpqrWiH+9kyBnD8AQF/wJV/X8haMnOnWWYsS39nk6NkUa/Fk/
uMzHZVtHgbfg1UiNG1qNQXreSesJcDX75RJ1t48cBKRSn/eY03vAeMWmvEbBDPz7
Try7HL85D8BoyfVXCUfZ2amnQ9W2pF2PVN9Ep61VWutA2xY5EoV781lZFt79L/J5
W/sYNqmeeGMqGrjwGXqQ
=yA3F
-----END PGP SIGNATURE-----

--BmN3TjheETfQiFDnAnWAEEd2XE06hvFFR--
