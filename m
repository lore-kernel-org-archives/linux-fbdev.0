From: Paul Cercueil <paul@crapouillou.net>
Date: Tue, 13 Aug 2019 10:01:48 +0000
Subject: Re: [PATCH 10/11] mfd: Drop obsolete JZ4740 driver
Message-Id: <1565690508.1856.0@crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
        <20190725220215.460-11-paul@crapouillou.net> <20190812081640.GA26727@dell>
        <4b48e597-951e-45fd-dfb2-4a1292a8b067@amsat.org>
In-Reply-To: <4b48e597-951e-45fd-dfb2-4a1292a8b067@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Philippe =?iso-8859-1?q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Lee Jones <lee.jones@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pm@vger.ke

Hi Philippe,


Le mar. 13 ao=FBt 2019 =E0 10:44, Philippe=20
=3D?iso-8859-1?q?Mathieu-Daud=3DE9?=3D <f4bug@amsat.org> a =E9crit :
> Hi Lee,
>=20
> On 8/12/19 10:16 AM, Lee Jones wrote:
>>  On Thu, 25 Jul 2019, Paul Cercueil wrote:
>>=20
>>>  It has been replaced with the ingenic-iio driver for the ADC.
>>>=20
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>>  ---
>>>   drivers/mfd/Kconfig      |   9 --
>>>   drivers/mfd/Makefile     |   1 -
>>>   drivers/mfd/jz4740-adc.c | 324=20
>>> ---------------------------------------
>>>   3 files changed, 334 deletions(-)
>>>   delete mode 100644 drivers/mfd/jz4740-adc.c
>>=20
>>  Applied, thanks.
>=20
> It seems the replacement is done in "MIPS: qi_lb60: Migrate to
> devicetree" which is not yet merged.

It's merged in the MIPS tree, though, so it'll blend together just
fine in linux-next.

>=20
> Probably easier if this patch goes thru the MIPS tree as part of the
> "JZ4740 SoC cleanup" series.
>=20
> Regards,
>=20
> Phil.
