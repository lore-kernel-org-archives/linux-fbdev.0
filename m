From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 26 Jul 2019 18:45:22 +0000
Subject: Re: [PATCH 05/11] video/fbdev: Drop JZ4740 driver
Message-Id: <20190726184522.GB14981@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-6-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, James Hogan <jhogan@kernel.org>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Liam Girdwood <lgirdwood@gmail.com>, od@zcrc.me, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Artur Rojek <contact@artur-rojek.eu>, Richard Weinberger <richard@nod.at>, linux-pm@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, dmaengine@vger.ker

Hi Paul.

On Thu, Jul 25, 2019 at 06:02:09PM -0400, Paul Cercueil wrote:
> The JZ4740 fbdev driver has been replaced with the ingenic-drm driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  drivers/video/fbdev/Kconfig     |   9 -
>  drivers/video/fbdev/Makefile    |   1 -
>  drivers/video/fbdev/jz4740_fb.c | 690 --------------------------------
>  3 files changed, 700 deletions(-)
>  delete mode 100644 drivers/video/fbdev/jz4740_fb.c
Nice work of you and others involved.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
