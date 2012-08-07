From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 07 Aug 2012 14:32:28 +0000
Subject: Re: [RFC 00/17] OMAPDSS: Change way of passing timings from panel driver to interface
Message-Id: <1344349948.7216.82.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-BLbb1azVCGc+UOvDAKSV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com


--=-BLbb1azVCGc+UOvDAKSV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-01 at 16:01 +0530, Archit Taneja wrote:
> This series tries to make interface drivers less dependent on omap_dss_de=
vice
> which represents a panel/device connected to that interface. The current =
way of
> configuring an interface is to populate the panel's omap_dss_device insta=
nce
> with parameters common to the panel and the interface, they are either po=
pulated
> in the board file, or in the panel driver. Panel timings, number of lanes
> connected to interface, and pixel format are examples of such parameters,=
 these
> are then extracted by the interface driver to configure itself.

The series looks good. I had only a few comments to make, but obviously
this needs quite a bit of testing. I'll try it out.

 Tomi


--=-BLbb1azVCGc+UOvDAKSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQISb8AAoJEPo9qoy8lh71SZgP/j5mhk+ElMJ2ZaWpB9Cbyp1W
Zva/r5GHqbBXf7+dIAwBPxEfPYxVAg3VU5yX/T0GxvFa597EqBiIqTZlZGYS38WC
fHjJhcaN2hZPFwDLBq/bI4t+VqFZQNy8KIN2JgmqmwZA4RYje+Muy1ZpBOD7x9KD
/aC3tpk0GfYFdUtxqhX6XqQxMZJ0o/bFqinY8tlQ5XN0RYl35iXQdRApdJazZldY
oIJLjqZyqg0HgginMoPONH95p0VfL/tPYF9PPexUN6HbwuSc2OQ06044mhd7I+js
4m1y26n/Oe+Nqak46JC1ZIcusZHZjpGo5NcsUFlifTvHVP0elB22fN3smo1ntdfR
2K/u7KHIu4kBo8bOU8cR7FeDGoY3pBmb4oiUMM/P4C7VK8P4UkmPQ6dE7fIGSafA
oq4bztcVJtRhxlbM8ow6G2VBrvQYcOAtNxs4kwV9yAKg4FtVE+8F3cbInJXwpn9A
zWaUHjlE865ddyTTIJ0AmDac08k+eOFFPuPCOH20r7AXiWF5IBRen5XkJUpLt9v+
codqHSJiAr9anyiEpDkfnUlc2xLX1jTrcQuRRSxSuTWSjE0I4MC2VEa6js3jIl9V
S/EPBICMv1ssjJ9syQY6saGG2upb4aCdMm0o5/zYYUfdJeG6QWU0lrepN86CZ9j7
P5CkmAHj9cuCEtOcwTOi
=tKnl
-----END PGP SIGNATURE-----

--=-BLbb1azVCGc+UOvDAKSV--

