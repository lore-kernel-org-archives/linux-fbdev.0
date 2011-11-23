From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Nov 2011 07:32:43 +0000
Subject: Re: [PATCH 09/65] OMAPDSS: pass ovl manager to dss_start_update
Message-Id: <1322033563.3015.4.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-STdWqOCvpm0sGvDx3WXr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-10-git-send-email-tomi.valkeinen@ti.com>
	 <4ECC8A6D.5050000@ti.com>
In-Reply-To: <4ECC8A6D.5050000@ti.com>
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-STdWqOCvpm0sGvDx3WXr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-11-23 at 11:23 +0530, Archit Taneja wrote:
> On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:
> > dss_start_update() takes currently the dss device as a parameter. Chang=
e
> > the parameter to ovl manager, as that is what the dss_start_update()
> > actually needs.
>=20
> Minor comment: We could rename dss_start_update() to=20
> dss_mgr_start_update() to stick to the new way of telling if this=20
> function is meant for an overlay or a manager.

Good point, I'll make the change.

 Tomi


--=-STdWqOCvpm0sGvDx3WXr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOzKGbAAoJEPo9qoy8lh71DSsP/3dwZL/iktG7e7NMwMAVvqmZ
XtJhLyoqo0Qmes2KxiTxTiCTaQogl8P89dQ+9jjAtlmQ82V+L8ZdYLYp0m7peXtN
ZRXNy8ROlsgG4fDZgKzob0WvoICj2lIQ0vWEvQ95B2VOaTsqnqSKxqNS0vcSPq38
DE3Bp51MluB6jXFBUzz19BuJSi1FQSOA/CS4rT/7ELldHrHvH+rN/j7oobaD0rTq
pXjG3VvQCDZ8rKft04HHB8deuddE/soEWQJ2CBPBRfVgO3PWohOsXcFu6CZZGsNW
ytRCGwFl4Rl8XL5byXElJ8WVxsErHTn+1CVawI5e32RvOdubEAqt7sMBDu5Hsx15
IN6TelHQhGh+uu3AAqQFT37sHA6zsGFZBBZFrmxJpDn5PP7Ux7629v3MBQsslfXF
TilHmy8oRuctlnFj+QaTgpHZ0SaxdrCFohgofo9BbGlWQkHGBRc4pVcyQQpaC6vX
/QXbNvGMiuLAFXvBQ469MM+BQrUwwnznDQtEx0nxlhlEl8SdfV3qS0AQY9727r56
KA7kMVVYx6a97sUfWrFfjtH4VwZKIXKqb0QsYyhpBli+tGtMeXzBd7kJQpI2w8dV
upw8F6CKba9HIlqx7v2+rcHV9aNe7TbFrCpPgOwSv8tZbv9O4JX717tTzSz7vUV6
4m7lHdmzgo5jUWxcO3zv
=ZTN5
-----END PGP SIGNATURE-----

--=-STdWqOCvpm0sGvDx3WXr--

