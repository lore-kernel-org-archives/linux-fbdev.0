From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 12:59:40 +0000
Subject: Re: [PATCH] video: of_display_timing.h: Include <video/display_timing.h>
Message-Id: <51CAE5BC.9020406@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2RXEUPIOJTHHJMXKSBTWV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371476589-4660-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1371476589-4660-1-git-send-email-fabio.estevam@freescale.com>
To: linux-fbdev@vger.kernel.org

------enig2RXEUPIOJTHHJMXKSBTWV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/06/13 16:43, Fabio Estevam wrote:
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
> As 'struct display_timing' is defined at <video/display_timing.h>, let'=
s include
> this header to avoid the warning.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  include/video/of_display_timing.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/video/of_display_timing.h b/include/video/of_displ=
ay_timing.h
> index 6562ad9..a136f58 100644
> --- a/include/video/of_display_timing.h
> +++ b/include/video/of_display_timing.h
> @@ -8,6 +8,7 @@
> =20
>  #ifndef __LINUX_OF_DISPLAY_TIMING_H
>  #define __LINUX_OF_DISPLAY_TIMING_H
> +#include <video/display_timing.h>
> =20
>  struct device_node;
>  struct display_timings;
>=20

We don't need to include display_timing.h, we can just add:

struct display_timing;

 Tomi



------enig2RXEUPIOJTHHJMXKSBTWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyuW8AAoJEPo9qoy8lh71eLMP/jIHnO9v1aDgDHOrAg1uFWgx
uttNAycZMzNuSJ1CkJrttmdfemJmUfquA61cIatNsDAcY530HUYl7XTz5oyWYvyc
bq3dAHZvJ35ky8wJGWjtAK7zqiuvSQQfsRbqQf4bguHSNs/rFPu9Q9LwQ2Q7ftIk
ZsYfzt0o3Ac4dg/Kv2jfH2Q5QzGayAWwPoIL6Psvp3qjRWBhV9JZQf3mAkIrvFwj
1BquQQE9ZjZTIcdAasgpKbnAK2HmE4j7HwqNwY7e8fva2BCGwgzom8my8kziSGwG
+9zw7jgEerq4qSAxu0PEZNnm+NUwa5qgzT0pwDnt7Xn/3LSd7Kx1WBkDW0gmLU+w
zPpqiJjAk6+vJ4N6VlZXeW0JOz1S5EExKukBk8bJQv/xTcwgu3tuTUPNMITOEE7h
WAvsfTM+QGfsn12oWSF97Wlxv8osviYQXcqU5A3IhhAfgKNsYDWVTLzYSuSj6q9i
mbkq8eKXFjiIcddmzpYXyrL6UreWYpWoKzgz8kKbMHLpATPWaHpHKZ2o4aH3ELhz
pCcFeY47WApP/Z+uaVe2ZMAMgeKG1cGbFtX3yDGnjrAYWeoymCOTZr64wH3XYKl9
MRPEzOMk6m2Dh+yLyhnioFPkDiPs/VKd1JH/OSp8gGhd7cvsmZoaP8fB+tiHQrwL
YjQBO963rWW0MnHJxqsW
=aPsF
-----END PGP SIGNATURE-----

------enig2RXEUPIOJTHHJMXKSBTWV--
