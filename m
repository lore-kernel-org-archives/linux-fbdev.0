From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Date: Tue, 13 Aug 2019 08:44:30 +0000
Subject: Re: [PATCH 10/11] mfd: Drop obsolete JZ4740 driver
Message-Id: <4b48e597-951e-45fd-dfb2-4a1292a8b067@amsat.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-11-paul@crapouillou.net> <20190812081640.GA26727@dell>
In-Reply-To: <20190812081640.GA26727@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Lee,

On 8/12/19 10:16 AM, Lee Jones wrote:
> On Thu, 25 Jul 2019, Paul Cercueil wrote:
> 
>> It has been replaced with the ingenic-iio driver for the ADC.
>>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> Tested-by: Artur Rojek <contact@artur-rojek.eu>
>> ---
>>  drivers/mfd/Kconfig      |   9 --
>>  drivers/mfd/Makefile     |   1 -
>>  drivers/mfd/jz4740-adc.c | 324 ---------------------------------------
>>  3 files changed, 334 deletions(-)
>>  delete mode 100644 drivers/mfd/jz4740-adc.c
> 
> Applied, thanks.

It seems the replacement is done in "MIPS: qi_lb60: Migrate to
devicetree" which is not yet merged.

Probably easier if this patch goes thru the MIPS tree as part of the
"JZ4740 SoC cleanup" series.

Regards,

Phil.
