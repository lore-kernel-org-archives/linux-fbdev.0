From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 19 Nov 2012 10:34:28 +0000
Subject: Re: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
Message-Id: <50AA0B34.2000009@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig25A25C51371CF3F245EA3D2D"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
 <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
 <50A9C1C4.5070907@ti.com> <20121119091504.GB3290@n2100.arm.linux.org.uk>
 <50A9FD98.1060105@ti.com> <20121119094606.GF3290@n2100.arm.linux.org.uk>
In-Reply-To: <20121119094606.GF3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--------------enig25A25C51371CF3F245EA3D2D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-19 11:46, Russell King - ARM Linux wrote:
> On Mon, Nov 19, 2012 at 11:36:24AM +0200, Tomi Valkeinen wrote:
>> Probably not. I can't say anything to that matter, but I wonder if thi=
s
>> patch is just going around the problem that we get sparse warnings whe=
n
>> falling into the else ifdef block in fb.h.
>>
>> The macros in the else block are defined as:
>>
>> #define fb_readb(addr) (*(volatile u8 *) (addr))                      =
          =20
>>
>> And fb code passes a pointer to __iomem. So shouldn't the cast be to
>> (volatile u8 __iomem *)?
>=20
> No, because sparse won't let you directly dereference an __iomem pointe=
r.
>=20
> Directly dereferencing an __iomem pointer is wrong, always has been.  I=
t's
> marked with __iomem _because_ it's a separate cookied address space fro=
m
> the virtual address space.
>=20
> This is one of the situations which has been left because the warning i=
s
> correct - and this is one of those situations where silencing them via
> casts et.al. is the wrong thing to do.  The right thing to do is to lea=
ve
> the warning in place.
>=20
> This is one of the hardest things that I seem to get people to understa=
nd:
> if the code is wrong then we _should_ get a warning for it and we shoul=
d
> definitely not paper over the warning.

Yes, you're right. Well, I'm not very experienced with handling
different endiannesses, but my analysis:

fb.h uses either __raw_read/write functions or (*(volatile u32 *)
(addr)) and (*(volatile u32 *) (addr) =3D (b)) for read/write.

__raw_read/write are defined in arch/arm/include/asm/io.h and are the
same for BE and LE. I made a test c-file with two functions, one using
raw_read style assembly, other using pointer dereference. I compiled it
with -mlittle-endian and -mbig-endian, and the resulting assembly was
identical for both, and the assembly for both functions were the same.

So if I didn't make any mistakes above, using __raw_read/write instead
of the direct pointer dereference results in identical operation for
both big and little endian arms. So if big-endian fb reads/writes is
correct now, it should be correct with raw_read/write also.

 Tomi



--------------enig25A25C51371CF3F245EA3D2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQqgs0AAoJEPo9qoy8lh71LfgQAJC0GbaUqvD3XG2+KQaIGNJK
Nt2dmyj1IRZHXcSr9MdbjeACPZ+9/J6AZTym3QeDDxvxBf9ahPNrmErYYPUWvd8X
0fblnpgPhCzFLVwzrhUIkgRrNS7pgfpFY7B+XQcNsfQwB4P72G0MFD9dQVQsTnzB
stTYAGHF4AahAMDGQm1FvS/iXW62c87eMdDwHCM2W/0KbXZkg99uLlKVP8UHvkLg
PRbaJHTcwUyjtUjbCmNhZndeMXNuj5HtPdfpHLnMHUqpJZlLpdy3sveNn/aENIAS
lxntla5uEmC+ChVRaSt2qONhBUwf3YGbLlj1iFEwkDAh0m0SQ6UXm+5kS7UCUSzK
fpzSxS3rPCjj/KN1X4d23EBM1K2zatoeDecR66BJLgOss0qQgm5yqCD8M3LKLOTO
Gn8TerIcDjQScLqpZVV5y93vtX5EC94rdZxoWTe+ND0ElCIVgVaOWkB6asYX2MOI
5o2zdRoIk3zgxcfeQXwWUIUfmjXhBt04oDEFySvUBP6wqC0Bnjqp78CAf8dPIptM
Vm4i6TqsRikgFdDfkVfIWiDdn0XOTrH8b84J+PsKIAPnZg8okS0qr+5MFpDdM+6i
8TTZAoDtNEA7/MXifAQpWbPTujLF70/zfmpWgc6vw5CKHEe8J85SiJ/dc/VHAILB
VYEhGmKovrTEIfJosEzY
=hCrh
-----END PGP SIGNATURE-----

--------------enig25A25C51371CF3F245EA3D2D--
