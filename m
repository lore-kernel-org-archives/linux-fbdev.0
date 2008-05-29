From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH] video: SuperH Mobile LCDC Driver
Date: Thu, 29 May 2008 20:09:51 +0200
Message-ID: <20080529200951.434093d3.krzysztof.h1@poczta.fm>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

Hi Magnus,

Thank you for a new driver. I have reviewed your driver.
It is quite clean. Please resolve issues below and I will ACK it.

On Thu, 29 May 2008 18:24:51 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> --- /dev/null
> +++ work/drivers/video/sh_mobile_lcdcfb.c	2008-05-29 17:21:48.000000000 +0900
> @@ -0,0 +1,742 @@
> +/*
> + * SuperH Mobile LCDC Framebuffer
> + *
> + * Copyright (c) 2008 Magnus Damm
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License
> + *

English is not my native language but the last line sounds suspicious (either what?)

(...)
> +
> +struct sh_mobile_lcdc_priv;
> +struct sh_mobile_lcdc_chan {
> +	struct sh_mobile_lcdc_priv *lcdc;
> +	unsigned long *reg_offs;
> +	unsigned long ldmt1r_value;
> +	unsigned long enabled; /* ME and SE in LDCNT2R */
> +	struct sh_mobile_lcdc_chan_cfg cfg;
> +	u32 pseudo_palette[PALETTE_NR];
> +	struct fb_info info;
> +	dma_addr_t dma_handle;
> +};
> +
> +struct sh_mobile_lcdc_priv {
> +	void __iomem *base;
> +	struct clk *clk;
> +	unsigned long lddckr;
> +	struct sh_mobile_lcdc_chan ch[2];
> +};
> +

You have created a circular link here 
lcdc_priv -> lcdc_chan -> lcdc_priv

you can easily break it by removing the lcdc
field from the lcdc_chan structure.

> +
> +static void lcdc_write_chan(struct sh_mobile_lcdc_chan *chan,
> +			    int reg_nr, unsigned long data)
> +{
> +	iowrite32(data, chan->lcdc->base + chan->reg_offs[reg_nr]);
> +}
> +
> +static unsigned long lcdc_read_chan(struct sh_mobile_lcdc_chan *chan,
> +				    int reg_nr)
> +{
> +	return ioread32(chan->lcdc->base + chan->reg_offs[reg_nr]);
> +}
> +

put lcdc_priv and channel number (or base address and and channel pointer) 
as arguments to break the circular link. 
You can make these functions inline as well.

> +static void lcdc_write(struct sh_mobile_lcdc_priv *priv,
> +		       int reg_offs, unsigned long data)
> +{
> +	iowrite32(data, priv->base + reg_offs);
> +}
> +
> +static unsigned long lcdc_read(struct sh_mobile_lcdc_priv *priv,
> +			       unsigned long reg_offs)
> +{
> +	return ioread32(priv->base + reg_offs);
> +}
> +

These two functions can be inline.

> +static void lcdc_sys_write_index(void *handle, unsigned long data)
> +{
> +	struct sh_mobile_lcdc_chan *ch = handle;
> +
> +	lcdc_write(ch->lcdc, _LDDWD0R, data | 0x10000000);
> +
> +	while (lcdc_read(ch->lcdc, _LDSR) & 2)
> +	  ;
> +

As Andrew Morton put it it would be better to put
cpu_relax() inside this loop (or do some other
cpu releasing). There are more busy loops
in the driver's code.

That's it. A few things for a whole new driver.

Regards,
Krzysztof

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e13  

