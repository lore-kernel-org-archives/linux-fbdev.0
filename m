From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 15 Mar 2018 08:18:54 +0000
Subject: Re: [PATCH v2] backlight: otm3225a: add support for ORISE OTM3225A LCD SoC
Message-Id: <20180315081854.lsp5gmvqkgrgniln@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1514388007-2248-1-git-send-email-fb@ltec.ch>
 <caedb4f3-c508-5ebf-8873-af095fecf03e@ltec.ch>
In-Reply-To: <caedb4f3-c508-5ebf-8873-af095fecf03e@ltec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Felix Brack <fb@ltec.ch>
Cc: linux-fbdev@vger.kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Felix Brack wrote:
> On 27.12.2017 16:20, Felix Brack wrote:
> > This patch adds a LCD driver supporting the OTM3225A LCD SoC
> > from ORISE Technology. This device can drive TFT LC panels having a
> > resolution of 240x320 pixels. After initializing the OTM3225A using
> > it's SPI interface it switches to use 16-bib RGB as external
> > display interface.
> > 
> > Signed-off-by: Felix Brack <fb@ltec.ch>
> > 
> > Changes in v2:
> > - use descriptive names for registers instead of hard coding them
> > - remove unnecessary registers in initialization sequence
> > - make use of resource-managed functions like devm_kzalloc()
> >   instead of kzalloc() which simplifies and shortens the code
> > - replace mdelay() by msleep()
> > - use module_spi_init() since we do not do anything special
> >   in init/exit
> > - use dev_name() instead of hard coding driver name multiple times
> > - use static storage class for structure otm3225a_ops
> > - sort include files alphabetically
> > - use standardized licensing header
> > - modify Makefile respecting alphabetical sort order
> > ---
> >  drivers/video/backlight/Kconfig    |   7 ++
> >  drivers/video/backlight/Makefile   |   1 +
> >  drivers/video/backlight/otm3225a.c | 251 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 259 insertions(+)
> >  create mode 100644 drivers/video/backlight/otm3225a.c

[...]

> Just a gentle echo request: This patch was sent and Acked more then two
> months ago. Is there anything preventing it from being queued for a
> future kernel release?

Please take care to snip unnecessarily long quotes when replying to
patches.

This patch still needs Daniel Thompson's Acked-by/Reviewed-by. 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
