From: "Sudhakar Rajashekhara" <sudhakar.raj@ti.com>
Subject: Re: [PATCH] davinci: fb: Frame Buffer driver
	for TI DA8xx/OMAP-L1xx
Date: Fri, 10 Jul 2009 12:38:47 +0530
Message-ID: <11848.8241256729$1247210847@news.gmane.org>
References: <1247203174-11474-1-git-send-email-sudhakar.raj@ti.com>
	<20090710063123.GA15969@centrinvest.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sudhakar.raj@ti.com>) id 1MPAUT-0003Po-KU
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Jul 2009 07:25:53 +0000
Received: from comal.ext.ti.com ([198.47.26.152])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MPAUO-0001H7-Bw
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Jul 2009 07:25:53 +0000
In-Reply-To: <20090710063123.GA15969@centrinvest.ru>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: 'Andrey Panin' <pazke@centrinvest.ru>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-fbdev-devel@lists.sourceforge.net, 'Steve Chen' <schen@mvista.com>, linux-kernel@vger.kernel.org, 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>, akpm@linux-foundation.org

On Fri, Jul 10, 2009 at 12:01:23, Andrey Panin wrote:
> On 191, 07 10, 2009 at 01:19:34AM -0400, Sudhakar Rajashekhara wrote:
> > Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx
> > architecture. LCDC specifications can be found at
> > http://www.ti.com/litv/pdf/sprufm0a.
> > 
> > LCDC on DA8xx consists of two independent controllers, the
> > Raster Controller and the LCD Interface Display Driver (LIDD)
> > controller. LIDD further supports character and graphic displays.
> > 
> > This patch adds support for the graphic display (Sharp LQ035Q3DG01)
> > found on the DA830 based EVM. The EVM details can be found at:
> > http://support.spectrumdigital.com/boards/dskda830/revc/.
> > 
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
> > Signed-off-by: Steve Chen <schen@mvista.com>
> > Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> >  This patch applies to Linus's Kernel tree.
> 
> 
> <SNIP>
> 
> > +static int __init fb_probe(struct platform_device *device)
> > +{
> > +	struct da8xx_lcdc_platform_data *fb_pdata =
> > +						device->dev.platform_data;
> > +	struct lcd_ctrl_config *lcd_cfg;
> > +	struct da8xx_panel *lcdc_info;
> > +	struct fb_info *da8xx_fb_info;
> > +	struct resource *lcdc_regs;
> > +	struct clk *fb_clk = NULL;
> > +	struct da8xx_fb_par *par;
> > +	resource_size_t len;
> > +	int ret, i;
> > +
> > +	if (fb_pdata == NULL) {
> > +		dev_err(&device->dev, "Can not get platform data\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
> > +	if (!lcdc_regs) {
> > +		dev_err(&device->dev,
> > +			"Can not get memory resource for LCD controller\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	len = lcdc_regs->end - lcdc_regs->start + 1;
> > +
> > +	lcdc_regs = request_mem_region(lcdc_regs->start, len, lcdc_regs->name);
> > +	if (!lcdc_regs)
> > +		return -EBUSY;
> > +
> > +	da8xx_fb_reg_base = (resource_size_t)ioremap(lcdc_regs->start, len);
> 
> 1. ioremap() can return NULL, so check is needed here;
> 2. ioremapped region is leaked in case of error and on module unload too.
> 

Agreed. Will add checks and submit an updated version of the patch.

Thanks,
Sudhakar



------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
