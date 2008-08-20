From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] i.MX Framebuffer: Use
 iowrite/ioread instead of direct pointer deref
Date: Wed, 20 Aug 2008 19:42:46 +0200
Message-ID: <20080820194246.0dc9a589.krzysztof.h1@poczta.fm>
References: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
	<1219158403-5180-3-git-send-email-s.hauer@pengutronix.de>
	<20080820173159.4bc56e34.krzysztof.h1@poczta.fm>
	<20080820163109.GU4713@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVrbq-0005dE-Ad for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 10:36:38 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVrbp-00066N-Kp
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 10:36:38 -0700
In-Reply-To: <20080820163109.GU4713@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Juergen Beisert <j.beisert@pengutronix.de>, linux-fbdev-devel@lists.sourceforge.net

On Wed, 20 Aug 2008 18:31:09 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Wed, Aug 20, 2008 at 05:31:59PM +0200, Krzysztof Helt wrote:
> > On Tue, 19 Aug 2008 17:06:41 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > 
> > > From: Juergen Beisert <j.beisert@pengutronix.de>
> > > 
> > > This patch prepares the current i.MX1 framebuffer driver for usage in the
> > > whole i.MX family. It switches to iowrite/ioread for register accesses.
> > > Also it moves the register definitions to the driver where they belong.
> > > 
> > > Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>
> > > ---
> > >  drivers/video/imxfb.c |  208 ++++++++++++++++++++++++++++++++++++++++---------
> > >  drivers/video/imxfb.h |    4 +-
> > >  2 files changed, 173 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> > > index a990d43..0622589 100644
> > > --- a/drivers/video/imxfb.c
> > > +++ b/drivers/video/imxfb.c
> > > @@ -16,7 +16,6 @@
> > >   *	linux-arm-kernel@lists.arm.linux.org.uk
> > >   */
> > >  
> > > -//#define DEBUG 1
> > >  
> > >  #include <linux/module.h>
> > >  #include <linux/kernel.h>
> > > @@ -33,7 +32,6 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/dma-mapping.h>
> > >  
> > > -#include <mach/hardware.h>
> > >  #include <asm/io.h>
> > >  #include <mach/imxfb.h>
> > >  
> > > @@ -44,6 +42,124 @@
> > >  
> > >  #include "imxfb.h"
> > >  
> > > +#define DRIVER_NAME "imx-fb"
> > > +
> > 
> > All constants below should really be put into the imxfb.h. There is already such a file.
> 
> AFAIK the-new-beautiful-way is not to have these header files next to
> the .c files at all and put this stuff into the .c file. So maybe it's
> better to move the rest of imxfb.h here aswell.
> 

I was not aware about "the-new-beautiful-way". I am just curious about this.
Normally, the headers for frame buffers are located at include/video. 

It can stay this way (no header) if you insist.

> 
>  >  
> > > -#define LCDC_PALETTE(x) __REG2(IMX_LCDC_BASE+0x800, (x)<<2)
> > >  static int
> > >  imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
> > >  		       u_int trans, struct fb_info *info)
> > > @@ -81,7 +196,7 @@ imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
> > >  		      (CNVT_TOHW(green,4) << 4) |
> > >  		      CNVT_TOHW(blue,  4);
> > >  
> > > -		LCDC_PALETTE(regno) = val;
> > > +		iowrite32(val, fbi->regs + 0x800 + (regno << 2));
> > 
> > One may define an inline function imxfb_write(fbi, val, reg) :
> > 
> >  imxfb_iowrite(fbi, val, reg) 
> > {
> > 	iowrite32(val, fbi->regs + reg);
> > }
> > 
> > It would make the code more readable. The imxfb_ioread() could be used as well.
> >
> 
> Well, I think this is a matter of taste, I prefer not using wrappers
> around the access functions.
> 

Ok.

Regards,
Krzysztof

---------------------------------------------------------------------- 	
Prosty kredyt na wszystkie potrzeby. 
Od 1000 zl do 120 000 zl. 
Bez poreczycieli i zabezpieczen >>> http://link.interia.pl/f1edf


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
