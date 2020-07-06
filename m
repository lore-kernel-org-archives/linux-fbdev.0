From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 06 Jul 2020 07:13:22 +0000
Subject: Re: [PATCH 5/8] backlight: ili922x: Add missing kerneldoc description for ili922x_reg_dump()'s arg
Message-Id: <20200706071322.GB2821869@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-6-lee.jones@linaro.org>
 <20200625094318.h6t22gkgi5d7wbv4@holly.lan>
In-Reply-To: <20200625094318.h6t22gkgi5d7wbv4@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, dri-devel@lists.freedesktop.org, Software Engineering <sbabic@denx.de>, linux-arm-kernel@lists.infradead.org

On Thu, 25 Jun 2020, Daniel Thompson wrote:

> On Wed, Jun 24, 2020 at 03:57:18PM +0100, Lee Jones wrote:
> > Kerneldoc syntax is used, but not complete.  Descriptions required.
> > 
> > Prevents warnings like:
> > 
> >  drivers/video/backlight/ili922x.c:298: warning: Function parameter or member 'spi' not described in 'ili922x_reg_dump'
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Software Engineering <sbabic@denx.de>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/video/backlight/ili922x.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
> > index cd41433b87aeb..26193f38234e7 100644
> > --- a/drivers/video/backlight/ili922x.c
> > +++ b/drivers/video/backlight/ili922x.c
> > @@ -295,6 +295,8 @@ static int ili922x_write(struct spi_device *spi, u8 reg, u16 value)
> >  #ifdef DEBUG
> >  /**
> >   * ili922x_reg_dump - dump all registers
> > + *
> > + * @spi: pointer to the controller side proxy for an SPI slave device
> 
> Similar to previous... and I also noticed that there are several other
> existing @spi descriptions in this file and it would be good to make
> them consistent.

I've fixed this and applied the patch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
