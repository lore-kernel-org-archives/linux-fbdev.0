From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 16:28:49 +0000
Subject: Re: [PATCH v5 2/2] video: fbdev: pxafb: initial devicetree conversion
Message-Id: <5665B3C1.1080005@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="STMlCbxDcL00kB19v1T4VnVUbRrnjJ0RN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447792337-13876-1-git-send-email-robert.jarzmik@free.fr>
 <1447792337-13876-2-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1447792337-13876-2-git-send-email-robert.jarzmik@free.fr>
To: Robert Jarzmik <robert.jarzmik@free.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--STMlCbxDcL00kB19v1T4VnVUbRrnjJ0RN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 17/11/15 22:32, Robert Jarzmik wrote:
> This patch brings a first support of pxa framebuffer devices to a
> devicetree pxa platform, as was before platform data.
>=20
> There are restrictions with this port, the biggest one being the lack o=
f
> support of smart panels. Moreover the conversion doesn't provide a way
> to declare multiple framebuffer configurations with different bits per
> pixel, only the LCD hardware bus width is used.
>=20
> The patch was tested on both pxa25x, pxa27x and pxa3xx platform (namely=

> lubbock, mainstone and zylonite).
>=20
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: Philipp's review: of_graph usage
> Since v3: of_device_id sentinel, and all compatible ids added
> Since v4: fixed of_device_id table : rebase error on my side, with
>           braces which were incorrectly added
> ---
>  drivers/video/fbdev/Kconfig |   2 +
>  drivers/video/fbdev/pxafb.c | 163 ++++++++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 162 insertions(+), 3 deletions(-)

I see we already have
Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt in the
mainline. I think the patch adding the binding doc should have been kept
in this series.

It seems that at least "depth" is missing from the binding document.

 Tomi


--STMlCbxDcL00kB19v1T4VnVUbRrnjJ0RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZbPCAAoJEPo9qoy8lh71FeUQAI8qPBlnc4nBmJCfFfzTHRrp
uu4cp0QrDGz3YfkdeI6xI3fPKzT1J67C1cXsO22PcmIbHU2tqMrUBVyGPmSIwIaW
iaEeEEScRmOmtwQq1lVCaqwikFJkCNRbEdKuxgqFFQ78wH3dDPjKXDvNcwpHyj3F
PNuBzUFYQ4Z9cyz1zqKwEXNLwKGfmW6cCKtPjjrgT0a3NljEKmvh8cgcWsXQ0SbP
s5fjGur2mAuPeAnRtRe74L7JiqZWuvsdLdkqWZPkKrTDpC3dBdUXnIuivsw9vm5N
DNKct6old17/PvMeOlhc7+4kI8qku86nEQa/yLp+kzwiAXWTbRdmXWF3D8HBjOgE
4eQBjZz4yLAlrFf0TcenRne72uQUop9XD5jLcX2ZLacR7+ODvis8e7OmLfdTUXGG
tXGeZ5WaY6JwtQ4OHzpnSL8zHWh0Tt97CRggYs9yj6Y4JyI6xGwafbk2W/is7sYR
mr0ZMkQ6uHAohUNF8HdD1Rkdp1oQT1Acm/AumlDJhQM/DeqpO4X4XciTZZsC4fRX
VhONWdaPvh+eSU7yXYqqG1+ccnHcuzQ3+mlRlH9Wjeo7kDaG/6hmz6/vIasb9m89
HRJatWm427Ye15M2hEIbXsNssz9dDn9lJhZ9FQYaQGPDdS8dSsR5azxLp1DeVOp+
9OvbgSYGaF9xFk68tJ+I
=uvMZ
-----END PGP SIGNATURE-----

--STMlCbxDcL00kB19v1T4VnVUbRrnjJ0RN--
