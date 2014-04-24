From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 08:39:21 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <5358CDB9.1010500@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IMM9AFx7S6rn2TghxewEL4pvUgM6c91qX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--IMM9AFx7S6rn2TghxewEL4pvUgM6c91qX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/04/14 11:10, Alexander Shiyan wrote:
> Hello.
>=20
> Thu, 24 Apr 2014 10:57:59 +0300 =D0=BE=D1=82 Tomi Valkeinen <tomi.valke=
inen@ti.com>:
>> Hi,
>>
>> On 12/04/14 09:53, Alexander Shiyan wrote:
>>> This adds support for the framebuffer available in the Cirrus
>>> Logic CLPS711X CPUs.
>>> FB features:
>>> - 1-2-4 bits per pixel.
>>> - Programmable panel size to a maximum of 1024x256 at 4 bps.
>>> - Relocatible Frame Buffer (SRAM or SDRAM).
>>> - Programmable refresh rates.
>>> - 16 gray scale values.
>>> This new driver supports usage with devicetree and as a general
>>> change it removes last user of <mach/hardware.h> for CLPS711X targets=
,
>>> so this subarch will fully prepared to switch to multiplatform.
>>> The driver have been tested with custom board equipped Cirrus Logic
>>> EP7312 in DT and non-DT mode.
>>
>> My original comment about this is still unanswered: why a totally new
>> driver? The proper way would be to gradually change the old driver wit=
h
>> a patch series. Then it's possible to review the patches and see what =
is
>> actually changed.
>=20
> I have tried to answer here:
> http://www.spinics.net/lists/linux-fbdev/msg14218.html

If your answer means "it will be very difficult to see the changes if
all the changes are in one patch, which change the old driver in one
go", then yes, very true.

But that's wrong way to do it.

The right way to do it is, as I wrote above, by gradually changing the
old driver with a patch series. And my question is, why not do it that
way? Then it would be possible to review the patches one by one, seeing
what has changed.

 Tomi



--IMM9AFx7S6rn2TghxewEL4pvUgM6c91qX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWM25AAoJEPo9qoy8lh710o8P/09ZbpDdnStSEtPFAwJLfwAP
GfuFkom20E6wKwRluMqGBrGQwxlEt5YaxYXWhuR/U9Eh9TBZWr9Kcd6+n6dnaTRz
tbTqtGQF6DSkWPJrcqAOdl8bk/XSh+zdyWaGzuCMN3fT9RZ4nCVoJos+G432NLcX
wASKC7y7by4Fc7W7smtKTQ8I17BD+PLxZp+xW3Yb87Br6/AhIBh3N9f3uYzBI3N2
Vcf/HBuUC1mXO99d0Z3K40pBPgjeXLvaXg+H6mSsLYaxs5EU1k6xgObcl/KK092i
6cMOIwH9xGkJ2T/Sdz9ozodbs5+CmSacZkscpebv+1/cH7Ofm7NRjz80fpjwzhTR
UG3DxAOrz6NrB4WINoBFT/cHgPl45jthcO54gQRumGvSBjfkthx1IsB/UF/0YNMU
zJvXXmwud29OLaCekCxZL++JvpaOe7fqhdlrtF0Yky8AOMExxN8zwotIBdXP9FOP
OXBISXkaY8E55uSww0qT9wBRaOLZmq+ryFHEq5t4wNLTR8pcEx51pvNqUL1fTC1G
0R70gVOjtj6sr9OtuLH7ubWXvPzCLu2Phcnmgui8nizcPkBPgD0jc8BA6o5Wzx/n
gKStj9eBjH5hSu2nA9ve+lcz+tYAiU0JDplyPGrV2WcVaAvq02cLvxgbz723bT2i
nMrIRj4LcFDAu4/quMQC
=5tes
-----END PGP SIGNATURE-----

--IMM9AFx7S6rn2TghxewEL4pvUgM6c91qX--
