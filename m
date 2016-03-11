From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 11 Mar 2016 11:33:02 +0000
Subject: Re: [PATCH] video: AMBA CLCD: Remove duplicated include in amba-clcd.c
Message-Id: <56E2ACEE.3060205@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KjMbKwj8gui71Sx1cnbrmMpRnUdnk5dUk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457057406-4069-1-git-send-email-annie.wang@amd.com>
In-Reply-To: <1457057406-4069-1-git-send-email-annie.wang@amd.com>
To: Wang Hongcheng <annie.wang@amd.com>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>

--KjMbKwj8gui71Sx1cnbrmMpRnUdnk5dUk
Content-Type: multipart/mixed; boundary="t8lOAP0d1DR89Am0Est3dq04MwUesgVHa"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Wang Hongcheng <annie.wang@amd.com>, Russell King
 <linux@arm.linux.org.uk>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Borislav Petkov <bp@suse.de>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
Message-ID: <56E2ACEE.3060205@ti.com>
Subject: Re: [PATCH] video: AMBA CLCD: Remove duplicated include in
 amba-clcd.c
References: <1457057406-4069-1-git-send-email-annie.wang@amd.com>
In-Reply-To: <1457057406-4069-1-git-send-email-annie.wang@amd.com>

--t8lOAP0d1DR89Am0Est3dq04MwUesgVHa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/16 04:10, Wang Hongcheng wrote:
> The header file asm/sizes.h is unnecessary.
> And it can also be compiled under X86 arch after the removal.

The subject says the include is duplicate, but the description says it's
not needed.

 Tomi


--t8lOAP0d1DR89Am0Est3dq04MwUesgVHa--

--KjMbKwj8gui71Sx1cnbrmMpRnUdnk5dUk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4qzuAAoJEPo9qoy8lh71uckP/3l1LP9LzqiM5xjb+ZA2ZawY
Q3ofokdm45gfjhggSslWwcKcjGZGyp3oakzgz5+Dy28ph6qYQMYOiI7R9QzxduHH
jcUps1V018Oh0iXVu7eJ2lGytRzVDRLE7bowff4Yy6hNwTCDfrJ/6B+7VHwREmnM
ph5+QHmhzoF4P/PRtdNgo/H9H6vkiahLRGff/xZ5f1WaPPqaIjEMIupUCnSYDwTB
ck4sk1PcbeRAiaAyUWnrU9ovOZ1+p9FRhxyDKMyVYoyDFKdmAGWDdTqbpy87jzRk
Ud6ZzRwGDVl9mU2pixfDW043SsHw8c9fo8cZvawnxyh60RRNMElfyESnF024lS5T
2kZjN8FsgJvMkkyuEKWz0XzYfygvRO5K+AeJ0LdKCCBddJGO0h2XljqAV5THaM/s
auK7Po1wMv/9xAYciAFpV75touG1UY8j5g34Jenxf17jm+8BOwZP3cBBYWIfzOkQ
uPOkFClFSJyoVKS7/sTunRsvVIs6WayRwb7+vGuh9VePmtSpxy5c6V7zioSQsVjb
D2IenPbvwTg5g6EUgK4qdhVCgGFVR2u5yLaxRFdGySAldn7uxf3YR1pQmVgVVgJd
lhdhMHhsGp1OvWd/bLToJJbOFW7COzgPzIc/EXBm/p5CoxkFEjqtRHQvuzEvMKjy
wwBzCpa3jA6mbxWEB7FY
=TL8L
-----END PGP SIGNATURE-----

--KjMbKwj8gui71Sx1cnbrmMpRnUdnk5dUk--
