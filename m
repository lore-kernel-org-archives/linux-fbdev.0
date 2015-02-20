From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Feb 2015 12:26:43 +0000
Subject: Re: [PATCH] fbdev: via/via_clock: fix sparse warning
Message-Id: <54E72803.5080204@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Kjxw2pUwNbL6l1u3n1o32dsUe2SubOKpP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423140848-5989-1-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1423140848-5989-1-git-send-email-prabhakar.csengg@gmail.com>
To: Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--Kjxw2pUwNbL6l1u3n1o32dsUe2SubOKpP
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/02/15 14:54, Lad Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>=20
> this patch fixes following sparse warning:
>=20
> via_clock.c:33:12: warning: symbol 'via_slap' was not declared. Should =
it be static?
>=20
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  Found this issue on linux-next (gcc  version 4.9.2,
>  sparse version  0.4.5-rc1)and applies on top linux-next.
>=20
>  drivers/video/fbdev/via/via_clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/via/via_clock.c b/drivers/video/fbdev/=
via/via_clock.c
> index db1e392..bf269fa 100644
> --- a/drivers/video/fbdev/via/via_clock.c
> +++ b/drivers/video/fbdev/via/via_clock.c
> @@ -30,7 +30,7 @@
>  #include "global.h"
>  #include "debug.h"
> =20
> -const char *via_slap =3D "Please slap VIA Technologies to motivate the=
m "
> +static const char *via_slap =3D "Please slap VIA Technologies to motiv=
ate them "
>  	"releasing full documentation for your platform!\n";
> =20
>  static inline u32 cle266_encode_pll(struct via_pll_config pll)
>=20

Thanks, queued for 3.21.

 Tomi



--Kjxw2pUwNbL6l1u3n1o32dsUe2SubOKpP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5ygDAAoJEPo9qoy8lh71CDIP/2bvJDHkRuzDwor8TLOm/l34
KAMeiFjJJ8bbihkq09bSeKvmQk5HXwd9aTXNeMcrCLXHH/r8lJVt0YwlwGNAM7p7
bmPgmk3hYbw3pTD6m9SRc71cWd+tlKORnS4oYe0KMUI9WORfNmbOtY8PvEl452E3
emQHlNnB3g7ynk0B8ik46MQfv45Shalc/bwSWbZroGPTBaqPZpBHhemUofcAvG/m
zXUazRNKPpl0BVGadoW880Qfe8TrDttYq3v9+uLctfY1pvl5qL6U0wknWAI2s0Qh
bPL/2hEW3Ti7yR0lHKZgCgRc6S7vgk57ollSZRsogtlGXbfHEm9pADZxv2G9xqbl
+QCgDOuhN5uZETgUbTcQHlV/vuAIZLax089/TJFSgHoIjuXFufL7swvXDQH9mgVY
AtEMobt6ik1e6/MilCX7J9QtgGVgeY4Kx0Y31HIO1gpivRMoSLIelG0d0A5uuhhb
gy3tz/itGt0NPCgSEkQO6717Bio0XuamWhI8ChAv4eSomKVobpYXxrAF63NzHIPJ
JzPDsIqacteJFOJsAgzt1ZtWca6DuA7iERagbZuMsnYA7bSlgEfvy4CIf4rYh4c5
/0XGY3bHFP3ad4SkVXSlTANedcMW05YXbWPy4S9+VFErdjK71PuUoesUEpUILavj
zr8roc1QSyr4p8WPVrwV
=AUDW
-----END PGP SIGNATURE-----

--Kjxw2pUwNbL6l1u3n1o32dsUe2SubOKpP--
