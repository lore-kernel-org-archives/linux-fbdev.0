From: Andrew Morton <akpm@linux-foundation.org>
Date: Sat, 30 Jan 2010 00:27:55 +0000
Subject: Re: [PATCH]NUC900 LCD Controller Driver
Message-Id: <20100129162755.b591a2fb.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <ae11f36b1001110005k410620datb5444ffa795b27f3@mail.gmail.com>
In-Reply-To: <ae11f36b1001110005k410620datb5444ffa795b27f3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 11 Jan 2010 17:05:44 +0900
Wang Qiang <rurality.linux@gmail.com> wrote:

> hi, Dear Wan
> 
> There is the patch of LCD controller driver for nuc900s.
> The Linux LOGO is just fine and the FB-Test application was ok, too.
> 
> best regards
> wangqiang
> 
>
> ...
>
> @@ -380,6 +381,48 @@ struct platform_device nuc900_device_kpi = {
>  	.resource	= nuc900_kpi_resource,
>  };
> 
> +#ifdef CONFIG_FB_NUC900
> +
> +static struct resource nuc900_lcd_resource[] = {
> +	[0] = {
> +		.start = W90X900_PA_LCD,
> +		.end   = W90X900_PA_LCD + W90X900_SZ_LCD - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_LCD,
> +		.end   = IRQ_LCD,
> +		.flags = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static u64 nuc900_device_lcd_dmamask = 0xffffffffUL;

I suspect this should have type `dma_addr_t', but `struct device' uses
open-coded u64 too.  Odd.

It makes no sense to initialise a u64 with an unsigned long value -
it's wrong on a 32-bit machine.

this:

	static u64 nuc900_device_lcd_dmamask = -1;

will work.

> +struct platform_device nuc900_device_lcd = {
> +	.name             = "nuc900-lcd",
> +	.id               = -1,
> +	.num_resources    = ARRAY_SIZE(nuc900_lcd_resource),
> +	.resource         = nuc900_lcd_resource,
> +	.dev              = {
> +		.dma_mask               = &nuc900_device_lcd_dmamask,
> +		.coherent_dma_mask      = 0xffffffffUL

And this gets initialised to 0x00000000ffffffff also.  Using -1 will fix.

> +	}
> +};
> +
>
> ...
>
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/mm.h>
> +#include <linux/tty.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/fb.h>
> +#include <linux/init.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/workqueue.h>
> +#include <linux/wait.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h>
> +#include <linux/io.h>
> +
> +#ifdef CONFIG_PM

Is this ifdef needed?

> +#include <linux/pm.h>
> +#endif
> +
> +#include <mach/map.h>
> +#include <mach/regs-clock.h>
> +#include <mach/regs-ldm.h>
> +#include <mach/fb.h>
> +#include <mach/clkdev.h>
> +
> +#include "nuc900fb.h"
> +
> +/* Debugging stuff */
> +#ifdef CONFIG_FB_NUC900_DEBUG
> +static int debug	= 1;
> +#define dprintk(msg...)	{ printk(KERN_DEBUG "nuc900 lcd: " msg); }
> +#else
> +static int debug;
> +#define dprintk(msg...)
> +#endif

Would be better to use the standard pr_debug(), rather than inventing
private infrastructure.  That way you get to enjoy the facilities which
lib/dynamic_debug.c offers.

> +
> +/*
> + *  Initialize the nuc900 video (dual) buffer address
> + */
> +static void nuc900fb_set_lcdaddr(struct fb_info *info)
> +{
> +	struct nuc900fb_info *fbi = info->par;
> +	void __iomem *regs = fbi->io;
> +	unsigned long vbaddr1, vbaddr2;
> +	vbaddr1  = info->fix.smem_start;

It's conventional to put a blank line beterrn end-of-locals and start-of-code.

> +	vbaddr2  = info->fix.smem_start;
> +	vbaddr2 += info->fix.line_length * info->var.yres;
> +	/*set frambuffer start phy addr*/

Like this:

	/* set frambuffer start phy addr */

> +	writel(vbaddr1, regs + REG_LCM_VA_BADDR0);
> +	writel(vbaddr2, regs + REG_LCM_VA_BADDR1);
> +
> +	writel(fbi->regs.lcd_va_fbctrl, regs + REG_LCM_VA_FBCTRL);
> +	writel(fbi->regs.lcd_va_scale, regs + REG_LCM_VA_SCALE);
> +}
> +
> +//static void nuc900fb_clk_select(struct fb_info *info, unsigned long pixclk)
> +//{
> +//	struct nuc900fb_info *fbi = info->par;
> +//	int div;
> +//	if (clk <= 15 * 1000 * 1000) {
> +//		div = (15 * 1000 * 1000)/
> +//		nuc900_driver_clksrc_div(fbi->dev, "ext", 0x2);
> +//	}
> +//
> +//}

Please feed the patch through scrupts/checkpatch.pl.

> +/*
> + *	calculate divider for lcd div
> + */
> +static unsigned int nuc900fb_calc_pixclk(struct nuc900fb_info *fbi,
> +					 unsigned long pixclk)
> +{
> +	unsigned long clk = fbi->clk_rate;
> +	unsigned long long div;
> +
> +	/* pixclk is in picseconds. our clock is in Hz*/
> +	/* div = (clk * pixclk)/10^12 */
> +	div = (unsigned long long)clk * pixclk;
> +	div >>= 12;
> +	do_div(div, 625 * 625UL * 625);
> +
> +	dprintk("pixclk %ld, divisor is %ld\n", pixclk, (long)div);

Perhaps use %lld and remove the cast.

> +	return div;
> +}
> +
> +/*
> + *	Check the video params of 'var'.
> + */
> +static int nuc900fb_check_var(struct fb_var_screeninfo *var,
> +			       struct fb_info *info)
> +{
> +	struct nuc900fb_info *fbi = info->par;
> +	struct nuc900fb_mach_info *mach_info = fbi->dev->platform_data;
> +	struct nuc900fb_display *display = NULL;
> +	struct nuc900fb_display *default_display = mach_info->displays +
> +						   mach_info->default_display;
> +	int i;
> +
> +	dprintk("check_var(var=%p, info=%p)\n", var, info);
> +
> +	/* validate x/y resolution */
> +	/* choose default mode if possible */
> +	if (var->xres = default_display->xres &&
> +	    var->yres = default_display->yres &&
> +	    var->bits_per_pixel = default_display->bpp)
> +		display = default_display;
> +	else
> +		for (i = 0; i < mach_info->num_displays; i++)
> +			if (var->xres = mach_info->displays[i].xres &&
> +			    var->yres = mach_info->displays[i].yres &&
> +			    var->bits_per_pixel = mach_info->displays[i].bpp) {
> +				display = mach_info->displays + i;
> +				break;
> +			}
> +
> +	if (display = NULL) {
> +		dprintk("wrong resolution or depth %dx%d at %d bit per pixel\n",
> +			var->xres, var->yres, var->bits_per_pixel);

Some of the printks in here really should be printks, not the
compile-time-suppressible dprintk().  Please review them all and
convert the ones which will be useful to end-users into printk().

> +		return -EINVAL;
> +	}
> +
> +	/* it should be the same size as the display */
> +	var->xres_virtual	= display->xres;
> +	var->yres_virtual	= display->yres;
> +	var->height		= display->height;
> +	var->width		= display->width;
> +
> +	/* copy lcd settings */
> +	var->pixclock		= display->pixclock;
> +	var->left_margin	= display->left_margin;
> +	var->right_margin	= display->right_margin;
> +	var->upper_margin	= display->upper_margin;
> +	var->lower_margin	= display->lower_margin;
> +	var->vsync_len		= display->vsync_len;
> +	var->hsync_len		= display->hsync_len;
> +
> +	var->transp.offset	= 0;
> +	var->transp.length	= 0;
> +
> +	fbi->regs.lcd_dccs = display->dccs;
> +	fbi->regs.lcd_device_ctrl = display->devctl;
> +	fbi->regs.lcd_va_fbctrl = display->fbctrl;
> +	fbi->regs.lcd_va_scale = display->scale;
> +
> +	/* set R/G/B possions */
> +	switch (var->bits_per_pixel) {
> +	case 1:
> +	case 2:
> +	case 4:
> +	case 8:

The above four lines are unneeded, but it's OK keeping them for
documentation purposes.

> +	default:
> +		var->red.offset 	= 0;
> +		var->red.length 	= var->bits_per_pixel;
> +		var->green 		= var->red;
> +		var->blue		= var->red;
> +		break;
> +	case 12:
> +		var->red.length		= 4;
> +		var->green.length	= 4;
> +		var->blue.length	= 4;
> +		var->red.offset		= 8;
> +		var->green.offset	= 4;
> +		var->blue.offset	= 0;
> +		break;
> +	case 16:
> +		var->red.length		= 5;
> +		var->green.length	= 6;
> +		var->blue.length	= 5;
> +		var->red.offset		= 11;
> +		var->green.offset	= 5;
> +		var->blue.offset	= 0;
> +		break;
> +	case 18:
> +		var->red.length		= 6;
> +		var->green.length	= 6;
> +		var->blue.length	= 6;
> +		var->red.offset		= 12;
> +		var->green.offset	= 6;
> +		var->blue.offset	= 0;
> +		break;
> +	case 32:
> +		var->red.length		= 8;
> +		var->green.length	= 8;
> +		var->blue.length	= 8;
> +		var->red.offset		= 16;
> +		var->green.offset	= 8;
> +		var->blue.offset	= 0;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + *	Calculate lcd register values from var setting & save into hw
> + */
> +static void nuc900fb_calculate_lcd_regs(const struct fb_info *info,
> +					struct nuc900fb_hw *regs)
> +{
> +	const struct fb_var_screeninfo *var = &info->var;
> +	int vtt = var->height + var->upper_margin + var->lower_margin;
> +	int htt = var->width + var->left_margin + var->right_margin;
> +	int hsync = var->width + var->right_margin;
> +	int vsync = var->height + var->lower_margin;

newline here, please.

> +	regs->lcd_crtc_size = LCM_CRTC_SIZE_VTTVAL(vtt) |
> +			      LCM_CRTC_SIZE_HTTVAL(htt);
> +	regs->lcd_crtc_dend = LCM_CRTC_DEND_VDENDVAL(var->height) |
> +			      LCM_CRTC_DEND_HDENDVAL(var->width);
> +	regs->lcd_crtc_hr = LCM_CRTC_HR_EVAL(var->width + 5) |
> +			    LCM_CRTC_HR_SVAL(var->width + 1);
> +	regs->lcd_crtc_hsync = LCM_CRTC_HSYNC_EVAL(hsync + var->hsync_len) |
> +			       LCM_CRTC_HSYNC_SVAL(hsync);
> +	regs->lcd_crtc_vr = LCM_CRTC_VR_EVAL(vsync + var->vsync_len) |
> +			    LCM_CRTC_VR_SVAL(vsync);
> +
> +}
> +
>
> ...
>
> +static int nuc900fb_debug_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	if (len < 1)
> +		return -EINVAL;
> +
> +	if (strnicmp(buf, "on", 2) = 0 ||
> +	    strnicmp(buf, "1", 1) = 0) {
> +		debug = 1;
> +	} else if (strnicmp(buf, "off", 3) = 0 ||
> +		   strnicmp(buf, "0", 1) = 0) {
> +		debug = 0;
> +
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return len;
> +}

Duplicates the above-mentioned dynamic-debug facility.

> +static DEVICE_ATTR(debug, 0666, nuc900fb_debug_show, nuc900fb_debug_store);
> +
>
> ...
>
> +static int __init nuc900fb_map_video_memory(struct fb_info *info)
> +{
> +	struct nuc900fb_info *fbi = info->par;
> +	dma_addr_t map_dma;
> +	unsigned long map_size = PAGE_ALIGN(info->fix.smem_len);
> +
> +	dprintk("nuc900fb_map_video_memory(fbi=%p) map_size %lu\n",
> +		fbi, map_size);
> +
> +	info->screen_base = dma_alloc_writecombine(fbi->dev, map_size,
> +							&map_dma, GFP_KERNEL);

Here, do

	if (!info->screen_base)
		return -ENOMEM;

and the rest of the function gets neater.


> +	if (info->screen_base != NULL) {
> +		dprintk("nuc900fb_map_video_memory: clear %p:%08lx\n",
> +			info->screen_base, map_size);
> +		memset(info->screen_base, 0x00, map_size);
> +
> +		info->fix.smem_start = map_dma;
> +		dprintk("nuc900fb_map_video_memory: "
> +			"dma=%08lx cpu=%p size=%08lx\n",
> +			info->fix.smem_start, info->screen_base, map_size);
> +	}
> +	return (info->screen_base) ? 0 : -ENOMEM;
> +}
> +
>
> ...
>
> +static char driver_name[] = "nuc900fb";
> +
> +static int __init nuc900fb_probe(struct platform_device *pdev)

Should this be __devinit?

> +{
> +	struct nuc900fb_info *fbi;
> +	struct nuc900fb_display *display;
> +	struct fb_info	   *fbinfo;
> +	struct nuc900fb_mach_info *mach_info;
> +	struct resource *res;
> +	int ret;
> +	int irq;
> +	int i;
> +	int size;
> +
> +	dprintk("devinit\n");
> +	mach_info = pdev->dev.platform_data;
> +	if (mach_info = NULL) {
> +		dev_err(&pdev->dev,
> +			"no platform data for lcd, cannot attach\n");
> +		return -EINVAL;
> +	}
> +
> +	if (mach_info->default_display > mach_info->num_displays) {
> +		dev_err(&pdev->dev,
> +			"default display No. is %d but only %d displays \n",
> +			mach_info->default_display, mach_info->num_displays);
> +		return -EINVAL;
> +	}
> +
> +
> +	display = mach_info->displays + mach_info->default_display;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no irq for device\n");
> +		return -ENOENT;
> +	}
> +
> +	fbinfo = framebuffer_alloc(sizeof(struct nuc900fb_info), &pdev->dev);
> +	if (!fbinfo)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, fbinfo);
> +
> +	fbi = fbinfo->par;
> +	fbi->dev = &pdev->dev;
> +
> +#ifdef CONFIG_CPU_NUC950
> +	fbi->drv_type = LCDDRV_NUC950;
> +#endif
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
>
> ...
>
> +static void nuc900fb_stop_lcd(struct fb_info *info)
> +{
> +	struct nuc900fb_info *fbi = info->par;
> +	void __iomem *regs = fbi->io;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	writel((~LCM_DCCS_DISP_INT_EN) | (~LCM_DCCS_VA_EN) | (~LCM_DCCS_OSD_EN),
> +		regs + REG_LCM_DCCS);
> +	local_irq_restore(flags);
> +}

The local_irq_save() is a worry.  What's it doing here?  It does
nothing to prevent an interrupt on another CPU!

> +/*
> + *  Cleanup
> + */
> +static int nuc900fb_remove(struct platform_device *pdev)
> +{
> +	struct fb_info *fbinfo = platform_get_drvdata(pdev);
> +	struct nuc900fb_info *fbi = fbinfo->par;
> +	int irq;
> +
> +	nuc900fb_stop_lcd(fbinfo);
> +	msleep(1);
> +
> +	nuc900fb_unmap_video_memory(fbinfo);
> +
> +	iounmap(fbi->io);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	free_irq(irq, fbi);
> +
> +	release_resource(fbi->mem);
> +	kfree(fbi->mem);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	framebuffer_release(fbinfo);
> +
> +	return 0;
> +}
> +
>
> ...
>

The driver generally looks OK to me.  Please cc me on any updates.
