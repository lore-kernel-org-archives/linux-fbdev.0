From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 16:57:37 +0000
Subject: Re: [PATCH v3] video: fbdev: fsl: Fix kernel crash when diu_ops is not implemented
Message-Id: <5665BA81.4050907@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HHbGdWUfJ7odkEmn0aXfLklPEvuJacgfp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449107652-5134-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1449107652-5134-1-git-send-email-dongsheng.wang@freescale.com>
To: linux-fbdev@vger.kernel.org

--HHbGdWUfJ7odkEmn0aXfLklPEvuJacgfp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/12/15 03:54, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> If diu_ops is not implemented on platform, kernel will access a NULL
> pointer. We need to check this pointer in DIU initialization.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> v3:
> - Fix capitalization in patch description.
> - Add comments for verify diu_ops.set_pixel_clock.
>=20
> v2:
> - Move set_pixel_clock judgement to fsl_diu_init.
>=20
>  drivers/video/fbdev/fsl-diu-fb.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Thanks, queued for 4.4 fixes.

 Tomi


--HHbGdWUfJ7odkEmn0aXfLklPEvuJacgfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZbqBAAoJEPo9qoy8lh71zOsQAKt+2FQmrWISYfbWdBMUQAiU
kUq2p5PI7s+ty1mL25aDjR2d4m8jDsUmm83vbqrzZZHdECfDYMzL5g5eFrhiPvuY
XVjRL1yIp17RKhS+jDF6lHIuPyUz59zUmXcNZ5cSaIZj8fL5XWyUyIbS7LpycS2P
oDKHK/3yp9LSG0ewe3nI6gEMBD2FnqWfAbIZNXzpeH/0TiRJmjYEoR3z+dAdewNu
9izi+kKd4EHmW7hIQkX+EUSAhFBZ5cHjBvTLtWdA9Q/oByoq/5g64YgBSC6+UEie
Fh1VUYTta/b6RfPO7CYobvMWHj7ZI1iaiHe98i8dzB7O66qbt/HFDPx0Cx196JgA
Xzj3IpXVk4IdKNwXlchhvDdopCgtPznOSBHtmmnKwD2Ue4OdqhAlDIlbUJYBUGlr
qHTBBMwUqdq8RRchmCwpd6E5T3FfF8AewwI8DppmZWbrm6RqQcj7rPg6Xm3crjiw
8hAorFJXOXsOIuEDLot8go3bWRDP5ItNeXhyme0WAHULMKL4wusi03OVKFQ5o3RG
Tc/kyXxnE8FsT7HlpxGyEOArskYhWGG9hLk7XOc+AyoMsf2WS7nEJE4GYjseupYu
NR0Viotfkqk+5R0voV/mwKZbt92jEcBqskYwyPOI5i6KGdWi/ysGX9/WWCMommxA
0EmwUWjEOkdVJOxpfnCJ
=r1eq
-----END PGP SIGNATURE-----

--HHbGdWUfJ7odkEmn0aXfLklPEvuJacgfp--
