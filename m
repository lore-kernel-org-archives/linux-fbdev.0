From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Jan 2016 11:43:35 +0000
Subject: Re: [PATCH] fbdev: mmp: print IRQ resource using %pR format string
Message-Id: <56AB5067.4010405@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x2jQHTsdhc2Hxf0BtGcO0f8Df9bG9lTK0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453734191-1958245-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1453734191-1958245-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org

--x2jQHTsdhc2Hxf0BtGcO0f8Df9bG9lTK0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/01/16 17:03, Arnd Bergmann wrote:
> resource_size_t cannot be printed using the %x format string
> when we it is defined as u64:
>=20
> drivers/video/fbdev/mmp/hw/mmp_ctrl.c: In function 'mmphw_probe':
> drivers/video/fbdev/mmp/hw/mmp_ctrl.c:506:22: error: format '%x' expect=
s argument of type 'unsigned int', but argument 4 has type 'resource_size=
_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>    dev_err(ctrl->dev, "%s: res %x - %x map failed\n", __func__,
>                       ^
> drivers/video/fbdev/mmp/hw/mmp_ctrl.c:506:22: error: format '%x' expect=
s argument of type 'unsigned int', but argument 5 has type 'resource_size=
_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>=20
> This changes the format string to %pR, which is interpreted
> by the printk implementation to pretty-print a resource
> structure.

Thanks, queued for 4.5 fixes.

 Tomi


--x2jQHTsdhc2Hxf0BtGcO0f8Df9bG9lTK0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWq1BnAAoJEPo9qoy8lh71Vg8P/jFXyTyoXg/BJnnanquugr0u
7JxD0e7oHj33FZ+HOznsy41f8kAeFxWLsM7SoTPSuz1RFDgmjoMFaD1WkMbRGwDp
8ReQnNb42abVt68VPsa1FaMIvWIoW+2z7nHlGR0SzUdeXdeA2xS/HlCWsLEzSLyR
EBny+sMvaqVW1m1EIlLqT7CYsg7Ph8Puuyr3M/U2dsUL5gZe29zHPisRdmnSTNuK
Kxi068TpnNA2EMFgkE0oosXwgB9wFF4iJhH0jLgEI5HS4xEX1VvI/z+5MT1IYgBG
8i0HEoIRdVFlykZ3x+BkCZOslIuAKlE+dJfr+V76ZbuJBXo/+QZ+PU4crZfUGIPl
gyHF79BmE1odOSBbIGXVpnHvZkNOnUFN0WtbDie2aO4ZhKSxrFtY1Rvn3FtEEeU7
Iqp/tIyqL8V3AQ68K83FEseH2BvC4LKY6PXZl6OpP2sZDtLDNAjBtVc915ueJddB
z2fYYmnIEBLek33uG0JpbtKe0HQCjhjHIGe3mcK4pyw7GM7lRKQNcI4GCEuu/3rU
fGQjTrStWb6Pq2bqIe22UEOFj6/gCRzLhLSYc1hOPzWDUoEvwS3Ti/4TlbOOXued
pEl1RE2qey7S56DTTWgR/a9HsV/VtLjvsTqFMt/5xWj+78cIsIaL3V64iddCD/54
2khgq42tviubfNTyE6mK
=Jr6u
-----END PGP SIGNATURE-----

--x2jQHTsdhc2Hxf0BtGcO0f8Df9bG9lTK0--
