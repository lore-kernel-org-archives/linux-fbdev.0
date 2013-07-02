From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Jul 2013 15:07:06 +0000
Subject: Re: [PATCH] video: exynos: Ensure definitions match prototypes
Message-Id: <20130702150706.GP27646@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nJH7yO6CWCCNbGOS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372764414-9102-1-git-send-email-broonie@kernel.org>
 <008b01ce771f$f15082c0$d3f18840$%dae@samsung.com>
In-Reply-To: <008b01ce771f$f15082c0$d3f18840$%dae@samsung.com>
To: Inki Dae <inki.dae@samsung.com>
Cc: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jingoo Han' <jg1.han@samsung.com>, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org


--nJH7yO6CWCCNbGOS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 09:30:31PM +0900, Inki Dae wrote:

> > Ensure that the definitions of functions match the prototypes used by
> > other modules by including the header with the prototypes in the files
> > with the definitions.

> Is there some functions being used by other modules? And what problem can=
 be
> incurred without this patch?

Well, aside from it being basic good practice and allowing the compiler=20
to check for errors in the prototypes this is also something that sparse=20
warns about.  There do seem to be references to the functions in other
modules, in some cases this is every single function in the file.

--nJH7yO6CWCCNbGOS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0uyWAAoJELSic+t+oim9O1YP/Rvc+mOzgdHE45kkPQ6q4Sor
pq/pYMEM7xWfshYV8VHYrFN134El3meQm0vC52qecvhCKCmnR2IEASkxSu7mxB+Y
A/hxizLC+vJUn5xozWGa2d1tPoPvLmGpBsO4ffzvdb000z51A76Bf2GacN5OHbyx
kM1sxSUYieHxumBDW+I9OQbDhHwpWnV5AxsGfuCY6bkFsxEf4fFbwbdp42DyZUNo
zzSc5I6my3O5r/Zy3lsdxg+K2hg2T0WPjEx9iGyUHaPJlK+yyBP2PhDIND/0i5ch
Z8UkE6GuWNdX1af6oRwGEWuaL3DXMzP0Gc/jEUa/IrUAAVuYvGhAijZiqA4IWUDN
dMAcrIjVt0jjAXvJiOwB+Bex+FdvoOKAQjAgVpKRvEmyhmh0ZJ1hQLDFSMzEf5ez
wwCdH/QJ/Zl5hgqyWDCH/jIAaZIIqsyk29/8N2sBdk5Z8cOCu8FoS1nEOuo04KXp
+6rv4Re5M3dBCxiDqAS9R+94d8x6UKDanr9YnBwmAxuD4BlMMT+Q0CxWNyQEgiAW
TsXrpbpp3OWz0pQBoa36OjDHEjYsJb54NsosK+F+O0m90yPFQCmzd1hD+JpC25Xk
sC+IjxARO1cvFcaCgDKsuUPNO0vTHS7/JfDobup5Yxn0V5wgxRiw1lULJefYZopR
W/x+LcrEZO7kTO1AijPD
=DQ7T
-----END PGP SIGNATURE-----

--nJH7yO6CWCCNbGOS--
