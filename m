From: Tony Lindgren <tony@atomide.com>
Date: Wed, 17 Oct 2012 18:29:26 +0000
Subject: Re: [PATCHv3 0/5] OMAP: VRFB: convert to platform device
Message-Id: <20121017182926.GW15569@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
 <507E87B7.3070707@ti.com>
In-Reply-To: <507E87B7.3070707@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121017 03:27]:
> Hi Tony,
> 
> I have pushed this vrfb series and the omapdss version series to:
> 
> git://gitorious.org/linux-omap-dss2/linux.git 3.8/dss-version

I used this branch up to commit 35f70935c64ae229ebd1fc65398ec68d4d803712,
but left out the x86 compile changes as those seem unrelated to the plat
issue.

> git://gitorious.org/linux-omap-dss2/linux.git 3.8/vrfb-conversion

And then I merged in this branch. I have the merged branch at
omap-for-v3.8/cleanup-headers-dss.
 
> If they look ok to you and we don't get any other comments, I think
> these branches can be considered stable and you can pull them.

Thanks yes let's consider those frozen and if something needs to
be fixed it should be done on top of those commits.
 
> After these are merged:
> 
> $ git grep -E "(plat/)|(mach/)" drivers/video/omap2/
> drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vram.h>
> drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vram.h>
> drivers/video/omap2/vram.c:#include <plat/vram.h>
> 
> So the vram stuff should be the only omap dependency left in omapdss and
> omapfb. I'll start working on that soon.

OK thanks a lot. Then there's also the two vout files that
you may already have patches for:

drivers/media/platform/omap/omap_vout.c
drivers/media/platform/omap/omap_voutlib.c

Regards,

Tony
