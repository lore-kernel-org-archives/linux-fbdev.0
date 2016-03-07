From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Mar 2016 18:26:11 +0000
Subject: Re: [PATCH 0/5] goldfish: bring the framebuffer in sync with upstream
Message-Id: <56DDC7C3.4070107@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="iUrKslSeb730oL17XqX13Njb9l2HHhInI"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--iUrKslSeb730oL17XqX13Njb9l2HHhInI
Content-Type: multipart/mixed; boundary="bmpmfv4MBBLB7Chehj6uNCKxbf7boWrco"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Alan <alan@linux.intel.com>, linux-fbdev@vger.kernel.org,
 plagnioj@jcrosoft.com
Message-ID: <56DDC7C3.4070107@ti.com>
Subject: Re: [PATCH 0/5] goldfish: bring the framebuffer in sync with upstream
References: <20160226183940.2731.42083.stgit@localhost.localdomain>
In-Reply-To: <20160226183940.2731.42083.stgit@localhost.localdomain>

--bmpmfv4MBBLB7Chehj6uNCKxbf7boWrco
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/02/16 20:41, Alan wrote:
> The Android tree has changes to support Goldfish (Android virtual platf=
orm
> emulator) improvements. Pull those into upstream as part of the goal of=

> making upstream run out of the box on Goldfish.
>=20
> ---
>=20
> Christoffer Dall (1):
>       Subject: goldfish_fb: Set pixclock =3D 0
>=20
> Greg Hackmann (1):
>       Subject: video: goldfishfb: add devicetree bindings
>=20
> Nicolas Capens (1):
>       Subject: goldfishfb: simplify framebuffer format selection.
>=20
> Yu Ning (1):
>       Subject: goldfish: Enable ACPI-based enumeration for goldfish fra=
mebuffer
>=20
> bohu (1):
>       Subject: goldfish: 32 bit framebuffer support

"bohu" doesn't look like a real name. The emails should use the standard
format.

All the patches have "Subject: " in the subject... We know it's the
subject without saying that in the subject =3D).

 Tomi


--bmpmfv4MBBLB7Chehj6uNCKxbf7boWrco--

--iUrKslSeb730oL17XqX13Njb9l2HHhInI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW3cfDAAoJEPo9qoy8lh71ib4P/2Bt7qK5AxroOChOWzUPze4r
67lQKrqUBfeU8eISivto9ZvVEN9d4hIEM8l/wYrgn2NSiJ5lwDmv+edHRsPoA67m
GHL8kpfjLWZgjLr2PZZKof9Rmv69wsWC5AVhYwzOh9QaZJ3ESdGXICgb6cjcIL3g
A5vWZfKAkhwXDOYN0KuY0x4f4jkFA9yq88ux+4ooehBX/xvQza5GJQvxeW14Zj8n
Xzch0+aKrRMdH/mMnTMhOo1XWrgiz5C6R0idKxzHO1pWhhKpQquS+bHJmq9nZd56
YRciG+l0wW5IUx9tSb0JzVnoDO4SZJONodYgfuy9Ofg2oYzg4ID2JTb/NxqlBe3g
uyyw7WJ1p3xYLwlPvmiTwwYMU4523hPxwJQJDyjc3789XGXXvJZzUByFu3KWAsyo
W531IEknsVgZKRCeQWiX9XMAv8m3FFLzic9jDf5DOlZCQgopvchMLaOxboFAvx1i
/sPx5WoczFS/FSkWwW1zpFUi+zT37zLr25j7fI+WCzjqgmAZuDRAvinjJu8uSGXQ
fbsIcuflSaMLzm6RKjflQfPra6T69Uoi1EvvEV8wdkf/hQXt2LWd45pkzOLHrnzM
16kraaSmP6aRCA3UZDmsRU2/jZfBxDK4ycQUVoF7qXFXMIaUcSTAW5PHUpmZEsfr
ntnAetOXZSA/TS7MuBmk
=JYLD
-----END PGP SIGNATURE-----

--iUrKslSeb730oL17XqX13Njb9l2HHhInI--
