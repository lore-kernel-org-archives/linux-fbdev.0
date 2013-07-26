From: Michal Simek <monstr@monstr.eu>
Date: Fri, 26 Jul 2013 08:27:07 +0000
Subject: Re: [PATCH v3] video: xilinxfb: Fix compilation warning
Message-Id: <51F232DB.6020806@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PtkCQBRmbRFU5dS4wP2l7J8eTPOka7bev"
List-Id: <linux-fbdev.vger.kernel.org>
References: <b8701d73538d37495b41ef465440a6d5f3018870.1374759923.git.michal.simek@xilinx.com> <51F2262F.1020203@ti.com> <51F226C2.9000206@ti.com>
In-Reply-To: <51F226C2.9000206@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PtkCQBRmbRFU5dS4wP2l7J8eTPOka7bev
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/26/2013 09:35 AM, Tomi Valkeinen wrote:
> On 26/07/13 10:33, Tomi Valkeinen wrote:
>> On 25/07/13 16:45, Michal Simek wrote:
>>> regs_phys is phys_addr_t (u32 or u64).
>>> Lets use %pa printk format specifier.
>>>
>>> Fixes compilation warning introduced by:
>>> video: xilinxfb: Use drvdata->regs_phys instead of physaddr
>>> (sha1: c88fafef0135e1e1c3e23c3e32ccbeeabc587f81)
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>=20
>> Thanks, I've applied this into my 3.12/fbdev branch.
>=20
> Actually, let's put this into 3.11-fixes/fbdev branch.
>=20

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--PtkCQBRmbRFU5dS4wP2l7J8eTPOka7bev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHyMtsACgkQykllyylKDCHOGQCgnNJvhpUK1gbxSUMFi8+BJ6EU
wUoAn1sNszpqcgQl+2bLvT0Pu9SkGLaD
=rolO
-----END PGP SIGNATURE-----

--PtkCQBRmbRFU5dS4wP2l7J8eTPOka7bev--
