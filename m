From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 Aug 2013 17:55:28 +0000
Subject: Re: [RFC 0/1] Adding DT support to video/da8xx-fb.c
Message-Id: <52052D10.7060803@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Pe3NESsx2asuT6Jg8cL5cjrg09CFBqIMR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375992936-16755-1-git-send-email-detheridge@ti.com>
In-Reply-To: <1375992936-16755-1-git-send-email-detheridge@ti.com>
To: Darren Etheridge <detheridge@ti.com>
Cc: devicetree@vger.kernel.org, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, afzal@ti.com

--Pe3NESsx2asuT6Jg8cL5cjrg09CFBqIMR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/08/13 23:15, Darren Etheridge wrote:
> This is part of a larger series of patches to upgrade the da8xx-fb.c dr=
iver
> to support the Texas Instruments AM335x device.  As part of this upgrad=
e
> we also want to add devicetree support for both the original da8xx and =
the
> am335x.  Tomi Valkeinen has reviewed the fbdev changes but he suggested=

> that it was prudent to extract the dt pieces and run it through the
> devicetree mailing list for review.
>=20
> Thanks,
> Darren
>=20
> Darren Etheridge (1):
>   video: da8xx-fb: adding dt support
>=20
>  .../devicetree/bindings/video/fb-da8xx.txt         |   37 +++++++++++
>  drivers/video/da8xx-fb.c                           |   67 ++++++++++++=
+++++++-
>  2 files changed, 101 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/fb-da8xx.tx=
t

I just realized something. We have both drm and fb drivers for the LCDC
IP. The hardware is the same, thus, there should only be one set of DT
bindings, used by both drivers.

I don't know why this didn't occur to me earlier, as it's the same
situation with OMAP DSS.

 Tomi



--Pe3NESsx2asuT6Jg8cL5cjrg09CFBqIMR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSBS0UAAoJEPo9qoy8lh71IioP/0x2gUrlymd/h/0AjxujOIIq
kL8wKoXF4mCTcqRvpb5sw7V8sMSgq7PbuLZrgKJge6lAuV1O9L7MBYIrBHrTWC2+
u9DrkYafZFYrrYLGv/OwU1F4jTQJjU7Ag4HZtTGKbGZ5v7N+cd4swIpLY2pCfO43
jgYgRTJ2MGFnIFp7rORkKpFHe8gwxVjRsLhVhudk0dBRy/hVnIp71WXFH32NCU5R
TAAZa4/DchlQCQv7rVqkdslzjA1OAxw13+b2CBSo1V4WlBBYK/JKo2FSSBlaqyop
Q9oZyvy+u61M2ITDI3sRfsYljNqdva+zeIfBNe35ZYvLvawySFQGlO9M2ifjCwGR
VDw/zgT4g+tUMJTfrTSUnXSGqjGhta5ktr7TXSuPDf7OEIA7MxrxNc35qOberzW8
GY9mJNJ/z6yg1GBgJ61NTKfwedCDIMmBARXSLjU+PgwdFhI8bhtAeZOtjhtGPrsS
r6tVJ3X361Ezh7U0RE7W45tzXlEMNVb7fu1TLRB+sItLhgPMZJrQytuZFCTSVELz
pv7B+X1npRxq39iuNy5BT0grcw0e/+BtLPq/DQV6n8l9E0kq/ddtXkkQEcriiwov
+abHurujfnMAlfnUBjC3bPLLg5+4q2qW07ZaE00QmEJJa9fgLgLOf/2uxRi2mD1c
c4m1DS979USEp8hHjKcS
=ROle
-----END PGP SIGNATURE-----

--Pe3NESsx2asuT6Jg8cL5cjrg09CFBqIMR--
