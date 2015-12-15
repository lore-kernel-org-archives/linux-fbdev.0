From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 15 Dec 2015 13:22:56 +0000
Subject: Re: [PATCH v6 1/2] video: fbdev: pxafb: loosen the platform data bond
Message-Id: <56701430.9050100@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PHCirkJbdhdk0RFwidJf9TH25H3kVUJ7H"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449955631-14955-1-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1449955631-14955-1-git-send-email-robert.jarzmik@free.fr>
To: Robert Jarzmik <robert.jarzmik@free.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--PHCirkJbdhdk0RFwidJf9TH25H3kVUJ7H
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/15 23:27, Robert Jarzmik wrote:
> In order to prepare the transition to a mixed platform data and
> device-tree initialization, remove all the platform data references all=

> over the driver.
>=20
> Copy the platform data into the internal structure of the pxafb, and
> only use this afterward.
>=20
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/video/fbdev/pxafb.c | 54 ++++++++++++++++++++++++++++---------=
--------
>  drivers/video/fbdev/pxafb.h |  2 ++
>  2 files changed, 36 insertions(+), 20 deletions(-)

Thanks, I've queued this and the second patch for 4.5.

 Tomi


--PHCirkJbdhdk0RFwidJf9TH25H3kVUJ7H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcBQwAAoJEPo9qoy8lh71BkQP/3KasR0JSAxDNI1iqUHxzQiA
8btB5+E0iNHXcLBszRuVA7xQFwpdMzx+iYNP0rSoNs/W5Q7ZgXDqpaypoi8sBq08
wZuTRZKsFSdtPJ3qMarr9WQbIrSmYKITqfv3QY3Dv+ZmbsJhyoi/4OO5876lxJjD
RyF6Z/oLogcF0+2p6aPH3lFVCGuIxPSfkcOlxOaeMobcO/XlbgjFsGz0NOP5FuYm
PdRkewuUC0C5U1g4GenUKYVkmTE2TvTrm2uxThS0W6aQHi+fmbYFQWxPmVxLe/Vv
FeR0NYr4jQcJXM2aTIT9FROMYmc5ea6CUbKGfFK/mb7leNo22Dxxt6XAW644Hkff
eCPpYMo3XtlFQO3s0QihOF1nwzD1EnZvioSRsE4G7vpMaRkTkRLD/dq4xt/VxnN7
6VhO7QxAAbD9ybc5bDt1Oy6FSTebPmn3vO7S3pmvp1bc7c3c4XyZE8t7dmbTNTGZ
6qt9wA0DA5tiNt5QlBrV/q/jPoVW8xDb4Wk0l91nlun7nt14DF01gz5vyAM66Q5z
9hXeASJ1pibGQ8xVqTYwm7C3dq+3luHfCDZsVO7D0TkwMJVVfWUNnJREW7W5OzLw
2aLPipFTroCEk+Ea0aq07MqEgyD0AG/1tfpc3A9ol1cLJkhnzq5S1FTQxNAJTPVA
0UfTqnYncYjM3R1SLyzf
=jVgC
-----END PGP SIGNATURE-----

--PHCirkJbdhdk0RFwidJf9TH25H3kVUJ7H--
