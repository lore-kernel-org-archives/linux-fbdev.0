From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 07:39:00 +0000
Subject: Re: [PATCH] fbdev: udlfb: remove unneeded initialization in few places
Message-Id: <55D58414.9010209@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FKKMWK7bWeVvp3LOhgWCFFgOlxRTuQEMC"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--FKKMWK7bWeVvp3LOhgWCFFgOlxRTuQEMC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 08/06/15 02:02, Alexey Klimov wrote:
> Small minor cleanup.
> This patch removes unneeded initializations of variables
> in few places in different functions and one empty line.
>=20
> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
> ---
>  drivers/video/fbdev/udlfb.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Thanks, queued for 4.3.

 Tomi


--FKKMWK7bWeVvp3LOhgWCFFgOlxRTuQEMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1YQUAAoJEPo9qoy8lh71U3YP/jRzOfWXF3iSPrt8zmD0M6Ui
Q8nDzrGd53+X15aAesbIGMwDw12bZm7M0J+XtF/30W2eW8RkHDa2oSwk2JOvLct7
dFErutTHIjUfyzzL1lP4u1i5DuO+mr2TLuXgfRaxZK4oMq7ZXOwXItvmSpN8tBA1
3kXpltcHkT9avV4OH1qa6bqBN682osip3wZojf2bA05kgDFhhWyCCeGHwNKtwrDq
zMxjkazkrcpce4Z/x53/RV3VNllEL3c01xc5GqYfiGZ4g4KVIHQ0Z54X2+Ic8KvD
Dz8AQg3OSYliHN9G5TiA2T+QPWpz6IcfgPIUQlwDjDlulgVTx07IihOdXRR+DXna
cPrC+FjZNeuCYjAImncSXrbyi+DUCKXfk/xrgEz6FJTXCGl2cFS3HAPI4bqqw8sF
J9W04i4mPilSPaOQEq06CHA8FqKRaWeWcdmcq5tqq7OCy0+mEHWDjBz6iNKZws0Z
azHjRu4rgDOhB2SDMmDAV+PeAH3Q0vnAbWrD3pkeBixU+WoiEn4rVgqh2kX/RxNY
7mez/gc7zx/EoGFO8lcIbsaKydYOyQItrkWtVG5Z2qaTU8532XFjTQ1fvIaC6AkR
eLMTy3QznxdMzsl86XMukloqw0eiOgZh4/xkFAx+eP09ugry9cjcKlkkp6hhrlnx
O5zPeX9HiWUFRd0Fc86L
=CpHe
-----END PGP SIGNATURE-----

--FKKMWK7bWeVvp3LOhgWCFFgOlxRTuQEMC--
