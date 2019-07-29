From: Vinod Koul <vkoul@kernel.org>
Date: Mon, 29 Jul 2019 06:56:02 +0000
Subject: Re: [PATCH 06/11] dma: Drop JZ4740 driver
Message-Id: <20190729064402.GG12733@vkoul-mobl.Dlink>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-7-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, James Hogan <jhogan@kernel.org>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, od@zcrc.me, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Artur Rojek <contact@artur-rojek.eu>, Richard Weinberger <richard@nod.at>, linux-pm@vger.kernel.org, linux-mips@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org

On 25-07-19, 18:02, Paul Cercueil wrote:
> The newer and better JZ4780 driver is now used to provide DMA
> functionality on the JZ4740.

Please change subjetc to dmaengine: xxx

After that

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
