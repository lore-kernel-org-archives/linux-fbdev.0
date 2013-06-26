From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 13:36:27 +0000
Subject: Re: [PATCH v2] video: of_display_timing.h: Declare 'display_timing'
Message-Id: <51CAEE5B.4020108@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2QGIFDDPFPDKVXJUWNGOC"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372253665-23148-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1372253665-23148-1-git-send-email-fabio.estevam@freescale.com>
To: linux-fbdev@vger.kernel.org

------enig2QGIFDDPFPDKVXJUWNGOC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/06/13 16:34, Fabio Estevam wrote:
> Commit ffa3fd21de ("videomode: implement public of_get_display_timing()=
") causes
> the following build warning:
>=20
> include/video/of_display_timing.h:18:10: warning: 'struct display_timin=
g' declared inside parameter list [enabled by default]
> include/video/of_display_timing.h:18:10: warning: its scope is only thi=
s definition or declaration, which is probably not what you want [enabled=
 by default]
>=20
> Declare 'display_timing' to avoid the build warning.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Add 'struct display_timing;' instead of '#include <video/display_timi=
ng.h>'
>  include/video/of_display_timing.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/video/of_display_timing.h b/include/video/of_displ=
ay_timing.h
> index 6562ad9..79e6697 100644
> --- a/include/video/of_display_timing.h
> +++ b/include/video/of_display_timing.h
> @@ -10,6 +10,7 @@
>  #define __LINUX_OF_DISPLAY_TIMING_H
> =20
>  struct device_node;
> +struct display_timing;
>  struct display_timings;
> =20
>  #define OF_USE_NATIVE_MODE -1
>=20

Thanks. I've added this to fbdev-3.11 branch.

 Tomi



------enig2QGIFDDPFPDKVXJUWNGOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyu5bAAoJEPo9qoy8lh71KJAQAJQyinNP9lslPrjvfjXtk3Xp
Akiq4dSTwVGs3gaC+skzDkjHo6WRQZwY7sOA+x9sMZyAMUmK1sbvr25uuO53e7V2
PrUBPtyIjwGlvTQ5mDR0QdHGTGqW7Wb7+69NzXVBnUCzGSHTtS9lSywahMlz1LKK
X+BxOZzhR8yhPQsvta3M6ue2ySdxqQViF+Kk3aO2f2iEsXCnFjXA+cbo6Hjk+qbG
hC+SFJQCy9Qfq7nbQojV8mN5bLwHJWBhGcbQS1Uv1NAxXgpCI43z1kIIEL4ASRDa
OzMVGwgL+3LobM5Jm5hr9MavVw5R23FG33+yk4Vtcq3niBwF6ruHy5tGlnUwfjL9
smvbZzCLANucXEqXTd1Ji2aedDxSvyidXiXhFDfVYWF+G9oV+i24q1PiVgmYdSvE
EF7/khKfAvzv0KAdR6ecZaeNfXzkdzXcJj7LG/6CB4znQeiI1PVM6NFYg9NPcRWW
ShDMX8vp7VkqAuzGSsRMrwYGU6+LTtmKwJrI4izW9Jihb+mV/eR4yHL3HjXoZOqY
ii4FWS5pgLa/mMnq/3dTd6ziHxE4OQkptdvKuQRmoUUQLcGicMzFzF1EAlgH6iiH
px/UJUbdN6krzlC0+x+wactchUVnJWG+meUhcIhUA21Pn+3wFP9kNcd2zrsNOC+d
rFvtM+5OwgF0JSkaJ/IE
=QWjv
-----END PGP SIGNATURE-----

------enig2QGIFDDPFPDKVXJUWNGOC--
