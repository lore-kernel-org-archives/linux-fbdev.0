From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Aug 2012 10:35:12 +0000
Subject: Re: [PATCH V5 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Message-Id: <1345545312.4085.46.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-r8xUcEiC5u4esPwl/ohX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <cover.1345468541.git.cmahapatra@ti.com>
	 <94a123bbc0a4ecd48fc71275fd5efbe0aac93b87.1345468541.git.cmahapatra@ti.com>
In-Reply-To: <94a123bbc0a4ecd48fc71275fd5efbe0aac93b87.1345468541.git.cmahapatra@ti.com>
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-r8xUcEiC5u4esPwl/ohX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-20 at 18:53 +0530, Chandrabhanu Mahapatra wrote:
> All the cpu_is checks have been moved to dss_init_features function provi=
ding a
> much more generic and cleaner interface. The OMAP version and revision sp=
ecific
> initializations in various functions are cleaned and the necessary data a=
re
> moved to dss_features structure which is local to dss.c.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c |  117 ++++++++++++++++++++++++++---------=
------
>  1 file changed, 76 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.=
c
> index 10566ae..f6d3d0a 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -31,6 +31,7 @@
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/gfp.h>
> =20
>  #include <video/omapdss.h>
> =20
> @@ -65,6 +66,12 @@ struct dss_reg {
>  static int dss_runtime_get(void);
>  static void dss_runtime_put(void);
> =20
> +struct dss_features {
> +	u16 fck_div_max;
> +	int dss_fck_multiplier;
> +	char *clk_name;

const char *

 Tomi


--=-r8xUcEiC5u4esPwl/ohX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQM2RgAAoJEPo9qoy8lh71uFsP/2+j+YGg290cp73m1my/pFQd
IjP+WV0DmArIpX+PZuTlGv8TcAYPcrVMFC4YnIimUYEMzw3KyUW7ySkdhtj08kxO
yyE8sRaEKgl+BVI0iNaZgI33sWcGvl4sRop+8zV5E0RAq6JXgUm7HZ+Ostdr79F3
4HGAcOgo3hKnuaO/iAqqQzghMFkB+wLZzrd7Xhg7+WrAtTmhwI0TqtUd0NSwp1vO
2V1eWL2aIo6iCDKxP+GYbhc2aVIThFeaePc1l9PAIojOY+iZfxRx/Px7ZqTPsQp9
a0ni0SDs3/ooW3V/USdZPvbFQE2UeEcJvFJcYjRLHoEcf2Aci1ua0YrDu6KwS/pz
hoH+w4lWqNWMR2c9Kq/cyc1QABdr3f8uBtS5r0IxA1AXWNJLMbL8mKG75gpeDEia
DDwKJkF+1dMMhfeozDhOdDrPqEI6GSTNFoNJCj7xYLZAgRfZpcIa+I5319qdz6JT
N52DKpgrf23X0vXPVyfI2AH8G6En/VdcjtcQ6AwOixtBIMDdF9zSYAFA1efVm9qc
PpH34RVM9bez0A4sxTHqw7V7r7cH0kqwLD8oU00Kfr0lwdxhKkOcq/5elnn9erRV
0m369CrhB5YDoYhM5+VRxq6iu3M+ck73ui3TeOSshW/HRQA0yt5i+MGtYr1OPlr5
CjHkrVJmvaDlCckn9l+t
=+JTO
-----END PGP SIGNATURE-----

--=-r8xUcEiC5u4esPwl/ohX--

