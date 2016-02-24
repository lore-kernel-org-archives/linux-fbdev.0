From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Feb 2016 12:06:21 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56CD9CBD.5010106@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wXpvOkmhSpCdcksQXGons5PjwM7EfDlHb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com>
 <CAFEAcA-Y7rE_9CiOphgmae3FDApRznoBS7vsVN_+9hBqvAzEEA@mail.gmail.com>
In-Reply-To: <CAFEAcA-Y7rE_9CiOphgmae3FDApRznoBS7vsVN_+9hBqvAzEEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--wXpvOkmhSpCdcksQXGons5PjwM7EfDlHb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/02/16 15:49, Peter Maydell wrote:
> On 23 February 2016 at 12:45, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:
>> So, true, there's probing going on, but it's all board specific,
>> requiring a board specific driver to support it in the kernel. And I
>> think that makes the bootloader much better place for supporting it.
>=20
> This doesn't seem to me like a reason to put the requirement
> in the bootloader. A huge part of the purpose of the kernel
> is to support the hardware (whether that's completely generic
> and probeable, like PCI, or generic but not probeable, or
> completely specific to a particular board). The kernel has to
> support the hardware, and just because it happens to be board
> specific hardware rather than generic hardware doesn't seem to
> me to imply that the kernel gets to drop part of its core purpose.

The thing here is, the kernel doesn't have to support the hardware (the
probing method). The kernel _has_ to support the display controller and
the panels, but the probing could as well be done in the bootloader. It
would work fine, and it would be a cleaner solution that what's being
proposed so far.

>> I think one of the core questions here is: do we want to start adding
>> board specific drivers to the kernel, instead of dealing with it in th=
e
>> bootloader when possible? My understanding is that we've been trying t=
o
>> reduce board specific code from the kernel.
>=20
> I think there's a difference between "reduce board specific code
> in the kernel by replacing it with the combination of generic
> or parameterisable code in the kernel plus a kernel data structure
> (DT) that supplies the parameterisation needed", and "reduce
> board specific code in the kernel by forcing the bootloader to
> do the kernel's job for it".

Perhaps my phone background affects here, but I see the vendor provided
bootloader as the place for board specific custom solutions, and then
the kernel doesn't have to deal with those if at all possible.

With an open source generic bootloader like u-boot that doesn't exactly
hold, though, as the custom solutions will still pile up in a common
project.

Anyway, as discussed in the thread, I'm fine with having a kernel driver
for this, as the display boards for Versatile are an external device.

 Tomi


--wXpvOkmhSpCdcksQXGons5PjwM7EfDlHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzZy9AAoJEPo9qoy8lh712Q0P/0FAECC4IFXVhXVGfARdyBSS
W35cqBKFFtheUl6QL1WUqlKGEr+8gDeV4kMyowGQtABaE2t7huTUbOrPKBXcDyIE
sapI/ebdJII9oFcIehV8e7m90k71A2iknl2pDo1g5vdYnoD81D8jdjH3XQ68hWva
lgou7//75+oq6rlwk8hMoY+8MRzSHVWSO3WXUrZMY+yQTKcKXMWKvqitIjHKFusj
0qkoXis+NkuOQg3QvwklaLc/e6wu3T2RQ6xtbbdj9OdT5hwSSKjPwJjnw9JwAUYY
mkj1yk/tmb7FoekjQfDdeeZVhBTOvfonU0YC8qSJ7E7IM0faYDPx/mk295RgSEod
O9xSdPuPYXJrlZ3J9HV395pPn4KJmZ21gdV3xXEYfTjelE7BjslEaiMbyoFwIxKg
OCr8AlVyfZvy18AVFzP8TaZyZOl7c0xA9SccbrAuetgfHLRSFenRT9NEoSbC5kHY
YNMU8B3SfGshVKKSWQmUqNGj0ztSaHOmPh4QmRvQaKmJSajPqE1yJy5/eeN+eTt9
999VRAy57XMrMYgZYnbf7YXprdD/60rhxaae2U0i+fSPjOw8bhZ1ToHd0jfVYPQ0
6642ATO6gNOcC/5/uIHQCT/vGdQOuAUCBlkZwpj43STmm+cBXHC7bRjPnxZJCgFh
8zY5W7iAmfnGJRTIB4np
=KUxH
-----END PGP SIGNATURE-----

--wXpvOkmhSpCdcksQXGons5PjwM7EfDlHb--
