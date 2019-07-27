From: Paul Cercueil <paul@crapouillou.net>
Date: Sat, 27 Jul 2019 03:19:45 +0000
Subject: Re: [PATCH 00/11] JZ4740 SoC cleanup
Message-Id: <1564197585.6472.0@crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
        <20190726184649.GC14981@ravnborg.org>
In-Reply-To: <20190726184649.GC14981@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org



Le ven. 26 juil. 2019 =E0 14:46, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> Hi Paul.
>=20
> On Thu, Jul 25, 2019 at 06:02:04PM -0400, Paul Cercueil wrote:
>>  Hi,
>>=20
>>  This patchset converts the Qi LB60 MIPS board to devicetree and=20
>> makes it
>>  use all the shiny new drivers that have been developed or updated
>>  recently.
>>=20
>>  All the crappy old drivers and custom code can be dropped since they
>>  have been replaced by better alternatives.
>=20
> The overall diffstat is missing.
> Just for curiosity it would be nice to see what was dropped with this
> patch.
>=20
> 	Sam

Diffstat:

 arch/mips/boot/dts/ingenic/jz4740.dtsi         |  84 ++++++++++++
 arch/mips/boot/dts/ingenic/qi_lb60.dts         | 295=20
++++++++++++++++++++++++++++++++++++++++-
 arch/mips/configs/qi_lb60_defconfig            |  44 +++---
 arch/mips/include/asm/mach-jz4740/gpio.h       |  15 ---
 arch/mips/include/asm/mach-jz4740/jz4740_fb.h  |  58 --------
 arch/mips/include/asm/mach-jz4740/jz4740_mmc.h |  12 --
 arch/mips/include/asm/mach-jz4740/platform.h   |  26 ----
 arch/mips/jz4740/Makefile                      |   7 +-
 arch/mips/jz4740/board-qi_lb60.c               | 491=20
-------------------------------------------------------------------
 arch/mips/jz4740/platform.c                    | 250=20
-----------------------------------
 arch/mips/jz4740/prom.c                        |   5 -
 arch/mips/jz4740/setup.c                       |   3 +-
 drivers/dma/Kconfig                            |   6 -
 drivers/dma/Makefile                           |   1 -
 drivers/dma/dma-jz4740.c                       | 623=20
---------------------------------------------------------------------------=
----------
 drivers/hwmon/Kconfig                          |  10 --
 drivers/hwmon/Makefile                         |   1 -
 drivers/hwmon/jz4740-hwmon.c                   | 135=20
-------------------
 drivers/mfd/Kconfig                            |   9 --
 drivers/mfd/Makefile                           |   1 -
 drivers/mfd/jz4740-adc.c                       | 324=20
---------------------------------------------
 drivers/mtd/nand/raw/ingenic/Kconfig           |   7 -
 drivers/mtd/nand/raw/ingenic/Makefile          |   1 -
 drivers/mtd/nand/raw/ingenic/jz4740_nand.c     | 536=20
--------------------------------------------------------------------------
 drivers/power/supply/Kconfig                   |  11 --
 drivers/power/supply/Makefile                  |   1 -
 drivers/power/supply/jz4740-battery.c          | 421=20
----------------------------------------------------------
 drivers/video/fbdev/Kconfig                    |   9 --
 drivers/video/fbdev/Makefile                   |   1 -
 drivers/video/fbdev/jz4740_fb.c                | 690=20
---------------------------------------------------------------------------=
--------------------
 sound/soc/jz4740/Kconfig                       |  25 +---
 sound/soc/jz4740/Makefile                      |   5 -
 sound/soc/jz4740/qi_lb60.c                     | 106 ---------------
 33 files changed, 404 insertions(+), 3809 deletions(-)
