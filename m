From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 05 Jan 2015 12:53:22 +0000
Subject: Re: [PATCH] atyfb: mark DMI system id table as __initconst
Message-Id: <54AA8942.1060906@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x52HnufK6BDjmxf0XLIxQfn6tJJbqX1dj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420380274-8015-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <1420380274-8015-1-git-send-email-minipli@googlemail.com>
To: linux-fbdev@vger.kernel.org

--x52HnufK6BDjmxf0XLIxQfn6tJJbqX1dj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/01/15 16:04, Mathias Krause wrote:
> We can mark the DMI system id table as __initconst by using a helper
> variable that'll tell us if we need to unregister the reboot notifier i=
n
> atyfb_exit() instead of matching the DMI system id again.
>=20
> This frees up ~680 bytes of runtime memory, the DMI table occupies.
>=20
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> ---
>  drivers/video/fbdev/aty/atyfb_base.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks, queued for 3.20.

 Tomi



--x52HnufK6BDjmxf0XLIxQfn6tJJbqX1dj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqolCAAoJEPo9qoy8lh71YRMP/0h8RWoHM1CPU7crT+r2Nms3
ASFr1+7rP+T+W4YzH7CVFbGt5GB+WOxu5IytV84iNdKkZ9S4/UhGNBBedirtO/qC
K5G1hOa9Z+5GVMrqxaoXYXr69qec6Bt+nFcAxmFsD0y7JiQdqPoArZxwupDm/UAu
Ga6K9Qw3M8z6i/dIE3PYjwlsYO4Sfvqjj3g4fidWwHAuUNFJtI2QZcarxG5b37mA
2thKMWS5lfnwjk7kg6Bxg+hDTK02TiXBP7KLXEur3K3DhFx7bWEBdNPeDpM944El
vFkEq/mM1lNi+7cEjhNMdbfPMRRP6W6z2U5XZ2pmWuabIUlkm1vt/Jua5sxnefD6
Wt/UjHu3FkQ/bsmRG4pm260v9O/oePy+IjNgC+MWfac64boOcBQ3mY2HMHYxUURZ
WIAJMVM1e+nqzupXzpVm3geZ/SivOc5VAvZ3FRt5YpluLgf4laf5FM5ORPDZzUn2
QIU54O7Nuooq9gFtSjSF6EQX4uWEyQqKQq+4jEGTl8MD9TMYtSDEc1H0lmp/Uz31
J66Qvu+6js928swpgMSv24rN1/mWYUlW7lS3LbmfHFJu/Aqk2OJTmaz/r0sPXHwv
18plq8ZEqBSssFNkM1A5qBhmKT5rGGXwGzn6e2KBSgioMH+cEBKziqfE+Ma/wEWN
FP/UGL6NQ40tn+mQ0KrA
=VB5O
-----END PGP SIGNATURE-----

--x52HnufK6BDjmxf0XLIxQfn6tJJbqX1dj--
