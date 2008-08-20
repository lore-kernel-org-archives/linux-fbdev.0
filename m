From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] i.MX Framebuffer:
	Use	iowrite/ioread instead of direct pointer deref
Date: Wed, 20 Aug 2008 18:31:09 +0200
Message-ID: <20080820163109.GU4713@pengutronix.de>
References: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
	<1219158403-5180-3-git-send-email-s.hauer@pengutronix.de>
	<20080820173159.4bc56e34.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVqTl-0006aD-8V for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 09:24:13 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVqTj-0003CJ-Ua
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 09:24:13 -0700
Content-Disposition: inline
In-Reply-To: <20080820173159.4bc56e34.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Juergen Beisert <j.beisert@pengutronix.de>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Aug 20, 2008 at 05:31:59PM +0200, Krzysztof Helt wrote:
> On Tue, 19 Aug 2008 17:06:41 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > From: Juergen Beisert <j.beisert@pengutronix.de>
> > 
> > This patch prepares the current i.MX1 framebuffer driver for usage in the
> > whole i.MX family. It switches to iowrite/ioread for register accesses.
> > Also it moves the register definitions to the driver where they belong.
> > 
> > Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>
> > ---
> >  drivers/video/imxfb.c |  208 ++++++++++++++++++++++++++++++++++++++++---------
> >  drivers/video/imxfb.h |    4 +-
> >  2 files changed, 173 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> > index a990d43..0622589 100644
> > --- a/drivers/video/imxfb.c
> > +++ b/drivers/video/imxfb.c
> > @@ -16,7 +16,6 @@
> >   *	linux-arm-kernel@lists.arm.linux.org.uk
> >   */
> >  
> > -//#define DEBUG 1
> >  
> >  #include <linux/module.h>
> >  #include <linux/kernel.h>
> > @@ -33,7 +32,6 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/dma-mapping.h>
> >  
> > -#include <mach/hardware.h>
> >  #include <asm/io.h>
> >  #include <mach/imxfb.h>
> >  
> > @@ -44,6 +42,124 @@
> >  
> >  #include "imxfb.h"
> >  
> > +#define DRIVER_NAME "imx-fb"
> > +
> 
> All constants below should really be put into the imxfb.h. There is already such a file.

AFAIK the-new-beautiful-way is not to have these header files next to
the .c files at all and put this stuff into the .c file. So maybe it's
better to move the rest of imxfb.h here aswell.


> 
> > +#define LCDC_SSA	0x00
> > +
> > +#define LCDC_SIZE	0x04
> > +#define SIZE_XMAX(x)	((((x) >> 4) & 0x3f) << 20)
> > +#ifdef CONFIG_ARCH_IMX
> 
> Is it possible to use this driver without CONFIG_ARCH_IMX defined?

Oops, not yet. These are the differences between IMX and MX2, the
architecture I'm currently preparing this driver for. This shouldn't
show up in this patch of course.


 >  
> > -#define LCDC_PALETTE(x) __REG2(IMX_LCDC_BASE+0x800, (x)<<2)
> >  static int
> >  imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
> >  		       u_int trans, struct fb_info *info)
> > @@ -81,7 +196,7 @@ imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
> >  		      (CNVT_TOHW(green,4) << 4) |
> >  		      CNVT_TOHW(blue,  4);
> >  
> > -		LCDC_PALETTE(regno) = val;
> > +		iowrite32(val, fbi->regs + 0x800 + (regno << 2));
> 
> One may define an inline function imxfb_write(fbi, val, reg) :
> 
>  imxfb_iowrite(fbi, val, reg) 
> {
> 	iowrite32(val, fbi->regs + reg);
> }
> 
> It would make the code more readable. The imxfb_ioread() could be used as well.
>

Well, I think this is a matter of taste, I prefer not using wrappers
around the access functions.



>  	strlcpy(info->fix.id, IMX_NAME, sizeof(info->fix.id));
> >  
> > @@ -465,7 +588,7 @@ static int __init imxfb_map_video_memory(struct fb_info *info)
> >  	struct imxfb_info *fbi = info->par;
> >  
> >  	fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
> > -	fbi->map_cpu = dma_alloc_writecombine(fbi->dev, fbi->map_size,
> > +	fbi->map_cpu = dma_alloc_writecombine(&fbi->pdev->dev, fbi->map_size,
> 
> Use &pdev->dev instead &fbi->pdev->dev

ok

> 
> >  					&fbi->map_dma,GFP_KERNEL);
> >  
> >  	if (fbi->map_cpu) {
> > @@ -506,14 +629,21 @@ static int __init imxfb_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, info);
> >  
> > -	ret = imxfb_init_fbinfo(&pdev->dev);
> > +	ret = imxfb_init_fbinfo(pdev);
> >  	if( ret < 0 )
> >  		goto failed_init;
> >  
> > -	res = request_mem_region(res->start, res->end - res->start + 1, "IMXFB");
> > +	res = request_mem_region(res->start, res->end - res->start + 1,
> > +				DRIVER_NAME);
> 
> There is a function resource_size(res) which does (res->end - res->start + 1).
> It seems useful here and at few places below.

ok, haven't seen it so far, thanks

 >  
> > -static int imxfb_remove(struct platform_device *pdev)
> > +static int __devexit imxfb_remove(struct platform_device *pdev)
> >  {
> >  	struct fb_info *info = platform_get_drvdata(pdev);
> >  	struct imxfb_info *fbi = info->par;
> > @@ -586,6 +718,7 @@ static int imxfb_remove(struct platform_device *pdev)
> >  	kfree(info->pseudo_palette);
> >  	framebuffer_release(info);
> >  
> > +	iounmap(fbi->regs);
> 
> The fbi pointed does not exist here (after framebuffer_release(info)).

Ack

 >  
> >  struct imxfb_info {
> > -	struct device		*dev;
> > +	struct platform_device  *pdev;
> 
> Is this field really useful? It can be dropped.

ok

-- 
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
