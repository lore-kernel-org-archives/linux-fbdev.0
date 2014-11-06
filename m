From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 06 Nov 2014 14:14:40 +0000
Subject: Re: [PATCH] fbdev: mxsfb: Add support for mx6sl and mx6sx
Message-Id: <545B8250.6080409@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5sUhAa15k7hfsV94X7foAL36iF9DQb804"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1414243727-23447-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1414243727-23447-1-git-send-email-festevam@gmail.com>
To: linux-fbdev@vger.kernel.org

--5sUhAa15k7hfsV94X7foAL36iF9DQb804
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/10/14 16:28, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> mx6sl and mx6sx share the same LCD controller as mx23 and mx28.
>=20
> Add support for it.
>=20
> The basic difference is the number of clocks that are required:
>=20
> - mx23/mx28: only one clock=20
> - mx6sl: two clocks
> - mx6sx: three clocks
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since RFC:
> - Simplified the clock handling as suggested by Tomi
>=20
>  drivers/video/fbdev/Kconfig |  2 +-
>  drivers/video/fbdev/mxsfb.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)

Looks fine to me, queued for 3.19.

 Tomi



--5sUhAa15k7hfsV94X7foAL36iF9DQb804
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUW4JQAAoJEPo9qoy8lh71x5UP/2kI8HiBhv9AMM1SpEslZGPF
Er4i079/LdkiTPevtRdNWWCPovLQpzgyZ5K1/M+0tUi/6X/Jo2d937WId+uR03VO
hJSKtkqa/IO/Z21h0jSlHA/6UTNHawPfE8a2qtehCc3Kz2UnqHoEGp/+R7E1zJ1D
Xgrv9Ux1r1Tp0nshr8//voSA4ouoZN/s/3o1Fk7xmFIeJFOnDMTNd2bFpLqhllwA
W5BGoOQi2F+IfFDBzU8qS8y4VgfBFi32e2gKrvxFtvoxlStkSHdvYRkY/V3s2XGR
K5U2axUjzN7lxuVpdocJgt9Darhl4xyi8LRRi5oMl6Bp0xPevWMF/5P8YeFK0GAq
p1uN4GcRCSV358agsPnSx4XsPseEjX/aqnjo+8IGX+nqKu7qWJh0sgbS44fmCEhe
TC/K0yVicOu7gIli5IIlmmLz73jE9hiXvF73OY1XkY5/YhObW/s2PXUoqlBjQurj
ANDRzW+Fh5tpo225BlWFqfcfdZvfRu+Wl21JZlDxDtc6OrG/jnQ0JXtz5Vy/iF+f
RTQ+uaN2MdCwPD5us1NfSDYKVVS+cUBSrpguqME1oNQSxl80BpP4h+wdt4PK2HGT
LtIwqBCtgV6vBj440ZMk9MPzuqCSUaPpGMMRK2dnBKsjEdk3WOat7XSDrD7+glsA
vpNxEo1rkiL4TJP6RWho
=pDYB
-----END PGP SIGNATURE-----

--5sUhAa15k7hfsV94X7foAL36iF9DQb804--
