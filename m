From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 19 Jan 2017 11:24:54 +0000
Subject: Re: [PATCH 13/13] MIPS: jz4740: Remove custom GPIO code
Message-Id: <b88d4818b42ae6b0853e5c01d4121c47@mail.crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170117231421.16310-14-paul@crapouillou.net>
 <20170118072751.GC18989@ulmo.ba.sec>
In-Reply-To: <20170118072751.GC18989@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com

Le 2017-01-18 08:27, Thierry Reding a =C3=A9crit :

> On Wed, Jan 18, 2017 at 12:14:21AM +0100, Paul Cercueil wrote:
>=20
>> All the drivers for the various hardware elements of the jz4740 SoC=20
>> have been modified to use the pinctrl framework for their pin=20
>> configuration needs. As such, this platform code is now unused and can=20
>> be deleted. Signed-off-by: Paul Cercueil <paul@crapouillou.net> ---=20
>> arch/mips/include/asm/mach-jz4740/gpio.h | 371 ----------------------=20
>> arch/mips/jz4740/Makefile | 2 - arch/mips/jz4740/gpio.c | 519=20
>> ------------------------------- 3 files changed, 892 deletions(-)=20
>> delete mode 100644 arch/mips/jz4740/gpio.c
>=20
> Have you considered how this could best be merged? It's probably=20
> easiest
> to take all of this through the MIPS tree because we have an addition=20
> of
> the pinctrl that would be a replacement for the GPIO code, while at the
> same time a bunch of drivers rely on the JZ4740 GPIO code for=20
> successful
> compilation.
>=20
> That's slightly complicated by the number of drivers, so needs a lot of
> coordination, but it's not the worst I've seen.
>=20
> Maybe one other solution that would make the transition easier would be
> to stub out the GPIO functions if the pinctrl driver is enabled, and do
> the removal of the mach-jz4740/gpio.h after all drivers have been=20
> merged
> through their corresponding subsystem trees. That way all drivers=20
> should
> remain compilable and functional at runtime, while still having the
> possibility to merge through the subsystem trees.
>=20
> That said, the whole series is fairly simple, so merging everything
> through the MIPS tree sounds like the easiest way to go.
>=20
> Thierry

I think it would make sense to merge it through the MIPS tree, yes,
considering that the patches for the drivers in the other subsystems are
quite small, and that they just remove code (well, except the pinctrl
driver itself). Besides, the files modified are not touched very often
so the chances of breakage are pretty low.

-Paul
