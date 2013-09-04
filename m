From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 04 Sep 2013 10:33:21 +0000
Subject: Re: [PATCH v3 0/5] ARM: vf610: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <52270C71.7080805@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="A99GrF6iecw16WCqXRsL7q8nDpSAqAThK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376553714-25922-1-git-send-email-b18965@freescale.com>
 <81BA6E5E0BC2344391CABCEE22D1B6D83F448E@039-SN1MPN1-002.039d.mgd.msft.net>
 <81BA6E5E0BC2344391CABCEE22D1B6D8403CB3@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <81BA6E5E0BC2344391CABCEE22D1B6D8403CB3@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org

--A99GrF6iecw16WCqXRsL7q8nDpSAqAThK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/09/13 11:21, Wang Huan-B18965 wrote:
> Hi, Jean-Christophe, Tomi,
>=20
>       Could you please help to review these patches?
>       Thanks!

There seemed to be some strong opinions that there should be a drm
driver for this hardware, instead of an fb driver. So as there seems to
be disagreements about this, I'll leave this series to Jean-Christophe,
who's the primary maintainer.

 Tomi



--A99GrF6iecw16WCqXRsL7q8nDpSAqAThK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSJwxxAAoJEPo9qoy8lh71MUIP/jlSWKo7YhvJXPapdQKmcsE3
ExSHBqC/P5szoOfszB8aeHjnGcIEqQ+njWMZahdEVrBQ9lquqKURMSPHMGlMsTZ5
D974bktz2EcF/VUmU860U30MFH8Ffgmm7CoqauoVBQMqvx0bAkQILO67R2vYY934
QwpoNtkA1hoZ20TIXZjqVzyhs2rOo1wgi+GrJaqYpf7mIYcRMjqDOyLBuPG8Q3To
DbWfQ1seHBfsDv3Do0ongJvktiq0CythbjGbeuxrskktdzu4j/zv2Qwy4yeY2d3u
F689NDKSsM4nEXycJ41xn7gDs3LfCqeTbCd6Lz2hvbcTCBPE4qUEoMAsFWNkq3vu
ymMGL15vNzloGCn2kfBnXGOpzfgG7B9y36f1l2Tnt89p7NZB4N78akuFk84bMuyU
QWb1P5N2mBKUBI4qsbGdeexYQYbPz/PzY5OPuB+LX9ajXp5/DXRriMTt/dTZxEHO
9SKSK6X4vdGM6G1A9K891bkOF/dpgRlbMMLwfLxj8gwLJ3WgLWnUIzbZ/Ny4J2IN
2rWq4vCJe82+oCNSIFNiQ6ZvU/dlEiT9O2TOEwvmDmIs4kPow2H7odBQLYBM1iYu
HRJF14R2lKwPrILG0lNMScULx4OdlAkxBZSMxqtqUQTIiSNrIlS1ZIxruGIlM2Pg
r/xX3BOZy3pMd3ndcpSG
=dMrO
-----END PGP SIGNATURE-----

--A99GrF6iecw16WCqXRsL7q8nDpSAqAThK--
