From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH] video: SuperH Mobile LCDC Driver
Date: Fri, 30 May 2008 06:26:26 +0200
Message-ID: <20080530062626.2834df6e.krzysztof.h1@poczta.fm>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	<20080529200951.434093d3.krzysztof.h1@poczta.fm>
	<20080529210736.GA13663@linux-sh.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080529210736.GA13663@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, linux-sh@vger.kernel.org

On Fri, 30 May 2008 06:07:36 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Thu, May 29, 2008 at 08:09:51PM +0200, Krzysztof Helt wrote:
> > > --- /dev/null
> > > +++ work/drivers/video/sh_mobile_lcdcfb.c	2008-05-29 17:21:48.000000000 +0900
> > > @@ -0,0 +1,742 @@
> > > +/*
> > > + * SuperH Mobile LCDC Framebuffer
> > > + *
> > > + * Copyright (c) 2008 Magnus Damm
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License as published by
> > > + * the Free Software Foundation; either version 2 of the License
> > > + *
> > 
> > English is not my native language but the last line sounds suspicious (either what?)
> > 
> Yes, there's overzealous trimming here. This should be amended to refer
> to GPLv2 only, though as the MODULE_LICENSE() its already get this right,
> it's mostly a cosmetic change.
> 

I am not a lawyer and I simply afraid errors in the legal statements.
I just pointed a mistake here.

> > put lcdc_priv and channel number (or base address and and channel pointer) 
> > as arguments to break the circular link. 
> > You can make these functions inline as well.
> > 
> As the 'circular' link is being used in a pre-defined way, it's not clear
> that there's a problem with it existing in the first place. It's
> obviously a matter of convenience.
> 

It is not that big problem so if it is required to simplify the driver it is fine.
It seems it is  access to only the lcdc_priv->base field is needed
from the channel structure. Just take a second look at it if it can be done
differently without adding to much complexity to the driver.

> > > +static void lcdc_write(struct sh_mobile_lcdc_priv *priv,
> > > +		       int reg_offs, unsigned long data)
> > > +{
> > > +	iowrite32(data, priv->base + reg_offs);
> > > +}
> > > +
> > > +static unsigned long lcdc_read(struct sh_mobile_lcdc_priv *priv,
> > > +			       unsigned long reg_offs)
> > > +{
> > > +	return ioread32(priv->base + reg_offs);
> > > +}
> > > +
> > 
> > These two functions can be inline.
> > 
> The compiler will do this automatically, there's no need to mark it
> explicity.
> 

I don't know the SuperH compiler but I saw things like not inlined functions
like this on PC (checked by disassembling the module object):

static void t_outb(struct tridentfb_par *p, u8 val, u16 reg)
{
        fb_writeb(val, p->io_virt + reg);
}

I didn't know why, so safer was just to mark it inline then 
the function was inlined. That was x86 gcc 3.4.6 compiler.
Before the check I believed that compiler did the right thing all the time.
You can check the objdump of the compiled module.

> > > +static void lcdc_sys_write_index(void *handle, unsigned long data)
> > > +{
> > > +	struct sh_mobile_lcdc_chan *ch = handle;
> > > +
> > > +	lcdc_write(ch->lcdc, _LDDWD0R, data | 0x10000000);
> > > +
> > > +	while (lcdc_read(ch->lcdc, _LDSR) & 2)
> > > +	  ;
> > > +
> > 
> > As Andrew Morton put it it would be better to put
> > cpu_relax() inside this loop (or do some other
> > cpu releasing). There are more busy loops
> > in the driver's code.
> > 
> cpu_relax() doesn't really matter here. It's good to include for general
> coherency, since we don't have the same barriers in the ioread() path,
> but it's hardly critical.
> 

No, it is not critical. It is improvement.

The driver code is very clean. All above are just hints for possible 
improvements.

Regards,
Krzysztof


----------------------------------------------------------------------
Mucha powraca!
Sprawdz >>> http://link.interia.pl/f1e0d

