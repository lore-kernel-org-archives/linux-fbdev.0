From: Michal Simek <monstr@monstr.eu>
Date: Thu, 25 Jul 2013 13:43:45 +0000
Subject: Re: [PATCH v2] video: xilinxfb: Fix compilation warning
Message-Id: <51F12B91.4010303@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bsbIoiPehSIJfpXVhMAsAXBxEA7NUSamd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <204d93f8a9dffef6ff00d961f91be0b465f21841.1374751310.git.michal.simek@xilinx.com> <CAMuHMdX2mKANduZO9HaBHRZ13V0PztOc-uYxTymUsH8-NE5FEQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX2mKANduZO9HaBHRZ13V0PztOc-uYxTymUsH8-NE5FEQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bsbIoiPehSIJfpXVhMAsAXBxEA7NUSamd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2013 03:36 PM, Geert Uytterhoeven wrote:
> On Thu, Jul 25, 2013 at 1:21 PM, Michal Simek <michal.simek@xilinx.com>=
 wrote:
>> regs_phys is phys_addr_t (u32 or u64).
>> Lets retype it to u64.
>=20
> This no longer matches the actual patch?

I need some holidays.

Will send v3.

Sorry,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--bsbIoiPehSIJfpXVhMAsAXBxEA7NUSamd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHxK5EACgkQykllyylKDCGxoACfW6HQQri8K3P6jDKV1FFi6pcM
nf4An0c1VDuj8xgxuCAADXigcHtMoS0S
=P5d8
-----END PGP SIGNATURE-----

--bsbIoiPehSIJfpXVhMAsAXBxEA7NUSamd--
