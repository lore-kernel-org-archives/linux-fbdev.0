From: Ian Armstrong <mail01@iarmst.co.uk>
Date: Fri, 12 Feb 2010 08:18:26 +0000
Subject: Re: [PATCH 01/02] sh: Add wait for vsync
Message-Id: <201002120818.26302.mail01@iarmst.co.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE0178367F@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE0178367F@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday 12 February 2010, Paul Mundt wrote:
> On Thu, Feb 11, 2010 at 10:23:50AM -0000, Phil Edworthy wrote:
> > Added FBIO_WAITFORVSYNC ioctl for SH-Mobile devices. Tested on MS7724
> > board against 2.6.33-rc7
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > --- a/drivers/video/sh_mobile_lcdcfb.c
> > +++ b/drivers/video/sh_mobile_lcdcfb.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/ioctl.h>
> >  #include <video/sh_mobile_lcdc.h>
> >  #include <asm/atomic.h>
> >
> > @@ -40,6 +41,10 @@
> >  #define _LDDWAR 0x900
> >  #define _LDDRAR 0x904
> >
> > +#ifndef FBIO_WAITFORVSYNC
> > +#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
> > +#endif
> > +
> >  /* shared registers and their order for context save/restore */
> >  static int lcdc_shared_regs[] = {
> >  	_LDDCKR,
> 
> The ioctl definition should be placed in include/video/sh_mobile_lcdc.h,
> and the ifndef is superfluous.
> 
> If the definition is placed in the header then that can be safely
> exported to userspace after the header has been sanitized and thrown in
> to include/video/Kbuild, which will make sure that the userspace
> applications and kernel keep in sync with regards to the ioctl numbering.

I would question the original definition for FBIO_WAITFORVSYNC. I get the 
impression that it originated with the matrox driver, but other drivers have 
since implemented the same ioctl and each has an identical define. Would the 
proper fix be to get the definition into fb.h and use it from there. It's 
already defined in multiple places (ps3fb.h, intelfb.h, atyfb_base.c, 
ivtvfb.h, matroxfb.h) and exported to userspace more than once.

-- 
Ian
