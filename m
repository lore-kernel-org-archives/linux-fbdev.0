From: Paul Burton <paul.burton@mips.com>
Date: Tue, 30 Jul 2019 17:43:43 +0000
Subject: Re: [PATCH 02/11] MIPS: qi_lb60: Migrate to devicetree
Message-Id: <MWHPR2201MB127750BFB9E4A64236710A6FC1DC0@MWHPR2201MB1277.namprd22.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-3-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "od@zcrc.me" <od@zcrc.me>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,

Paul Cercueil wrote:
> Move all the platform data to devicetree.
> 
> The only bit dropped is the PWM beeper, which requires the PWM driver
> to be updated. I figured it's okay to remove it here since it's really
> a non-critical device, and it'll be re-introduced soon enough.
> 
> The other change is the CS line of the SPI is now set as active low. The
> SPI core would have forced "active low" anyway, unless the 'spi-cs-high'
> property is set.
> 
> In the process of moving to devicetree, we also switched to new drivers:
> - We use the simple-audio-card and simple-amplifier drivers instead of
> the custom ASoC code;
> - We use the new Ingenic DRM driver coupled with the GiantPlus GPM940B0
> DRM panel driver instead of the old framebuffer driver;
> - We use the new jz4780-dma driver instead of the old jz4740-dma one;
> - We use the ingenic-nand and jz4740-ecc drivers instead of the old
> jz4740-nand driver;
> - We use ingenic-battery instead of jz4740-battery;
> - We use iio-hwmon instead of jz4740-hwmon;
> - We use ingenic-iio instead of the old jz4740-adc MFD driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
