From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] video: SuperH Mobile LCDC Driver
Date: Fri, 30 May 2008 11:50:05 +0900
Message-ID: <aec7e5c30805291950ud5355d8ud1cf147b3913a76@mail.gmail.com>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	 <20080529200951.434093d3.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080529200951.434093d3.krzysztof.h1@poczta.fm>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

Hi Krzysztof,

On Fri, May 30, 2008 at 3:09 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> Hi Magnus,
>
> Thank you for a new driver. I have reviewed your driver.
> It is quite clean. Please resolve issues below and I will ACK it.
>
> On Thu, 29 May 2008 18:24:51 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> --- /dev/null
>> +++ work/drivers/video/sh_mobile_lcdcfb.c     2008-05-29 17:21:48.000000000 +0900
>> @@ -0,0 +1,742 @@
>> +/*
>> + * SuperH Mobile LCDC Framebuffer
>> + *
>> + * Copyright (c) 2008 Magnus Damm
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License
>> + *
>
> English is not my native language but the last line sounds suspicious (either what?)

Yep, same here and I agree.

> You have created a circular link here
> lcdc_priv -> lcdc_chan -> lcdc_priv
>
> you can easily break it by removing the lcdc
> field from the lcdc_chan structure.

Sure, but the field is there for convenience.

>> +static void lcdc_write_chan(struct sh_mobile_lcdc_chan *chan,
>> +                         int reg_nr, unsigned long data)
>> +{
>> +     iowrite32(data, chan->lcdc->base + chan->reg_offs[reg_nr]);
>> +}
>> +
>> +static unsigned long lcdc_read_chan(struct sh_mobile_lcdc_chan *chan,
>> +                                 int reg_nr)
>> +{
>> +     return ioread32(chan->lcdc->base + chan->reg_offs[reg_nr]);
>> +}
>> +
>
> put lcdc_priv and channel number (or base address and and channel pointer)
> as arguments to break the circular link.

That's possible, and maybe it makes sense. It didn't when I originally
wrote the code - quite some time ago - abstracting the LCDs into
channels and passing around a single pointer just seemed more natural
to me.

I'll have a second look at the code though. Maybe it makes sense to
shuffle things around a bit.

> That's it. A few things for a whole new driver.

Excellent. Thanks for your review!

/ magnus
