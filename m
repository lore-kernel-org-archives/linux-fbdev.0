From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] davinci: fb: Frame Buffer driver for TI DA8xx/OMAP-L1xx
Date: Fri, 10 Jul 2009 12:38:47 +0530
Message-ID: <48156.6011011184$1247209863@news.gmane.org>
References: <1247203174-11474-1-git-send-email-sudhakar.raj@ti.com>
	<20090710063123.GA15969@centrinvest.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090710063123.GA15969-+M9eRqoy/hSsnK5SQ2Astg@public.gmane.org>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Content-Type: text/plain; charset="us-ascii"
To: 'Andrey Panin' <pazke-+M9eRqoy/hSsnK5SQ2Astg@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Pavel Kiryukhin' <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org

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
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> > Signed-off-by: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> > Acked-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
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
