From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 23 May 2014 10:45:04 +0000
Subject: Re: [PATCH] matroxfb: perform a dummy read of M_STATUS
Message-Id: <537F26B0.4070608@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nUSsJWXB7VPQrKhmNK6aiKRpipHgntrUo"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1405150652270.19101@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1405150652270.19101@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-fbdev@vger.kernel.org

--nUSsJWXB7VPQrKhmNK6aiKRpipHgntrUo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15/05/14 13:58, Mikulas Patocka wrote:
> I had occasional screen corruption with the matrox framebuffer driver a=
nd
> I found out that the reason for the corruption is that the hardware
> blitter accesses the videoram while it is being written to.
>=20
> The matrox driver has a macro WaitTillIdle() that should wait until the=

> blitter is idle, but it sometimes doesn't work. I added a dummy read
> mga_inl(M_STATUS) to WaitTillIdle() to fix the problem. The dummy read
> will flush the write buffer in the PCI chipset, and the next read of
> M_STATUS will return the hardware status.
>=20
> Since applying this patch, I had no screen corruption at all.
>=20
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
>=20

Queued for 3.16.

 Tomi




--nUSsJWXB7VPQrKhmNK6aiKRpipHgntrUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfya3AAoJEPo9qoy8lh71aMQP/jsSxByzcDT+uWYUal2YH4l0
gGRKNiai0LB+Euq7483IZ+e/KsCekWw3QPSYsXFQcy89kLyOSyJU1N5+hsdRLBi3
ER205uKYu6Ifb1ekBR0YY/XITVyI0PXqYiVS49+wUbJ1hVAPSDpIrHRgOuoLm3/A
fzmmmJRkoH5aMs5G5k2/vHHynjtHw6X/IVmVoyFT+LsIk7ao6myKa4kfHIl8p7qy
YwpKwvw75ckfo9eQFeq95VHjYZaa03v4Ug+3MqucFC9+wm7z80MTdfEQV6t75IxS
B9S0h2p55Lj2UjtHmTmPb5+GDn2LnNvrZjcLXy9WS+LOe/BAUlnFFP2YVolhlO25
GNkHFDUsEjcUZ5vKYiWoM3+peXMhBGU83BWsawutGK3zOmIRjDPeMeeO8dFYTcmo
iHS/XR2jD2eVzP93jkk0KjTpMxTiSmB+WsaMcS2IfPQlsLIbu0+p5ra2lLt4VGrl
nSJlNU+HYq9p2+teMK5TzcgOBf+cLAQbVZJluU0yShzv0dcBhtlcHzC3OOtouQ2I
1DDsV2HgvmFsb0ecbBvoWkz8criXDrRQEODtZ6SLSciOzkZm6D3A2l1pGCJ4lIZs
3aYTafy8tiuEajKNdWSBQeVjDyMTMMPbrr7EYh8TJypbZw7LtkALaJ3d8LyzXqkY
/+CF4wmysdxHHdMACBHs
=ceKr
-----END PGP SIGNATURE-----

--nUSsJWXB7VPQrKhmNK6aiKRpipHgntrUo--
