From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v2 1/4] video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver part 1/3
Date: Thu, 26 Jun 2008 16:45:55 +0900
Message-ID: <20080626074555.GA408@linux-sh.org>
References: <48632CAF.3090703@renesas.com>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <48632CAF.3090703@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: linuc-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Manuel Lauss <mano@roarinelk.homelinux.net>

On Thu, Jun 26, 2008 at 02:44:15PM +0900, Nobuhiro Iwamatsu wrote:
> Main source code of Driver for the LCDC interface on the SH7760 and SH7763 SoCs.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> ---
>  drivers/video/sh7760fb.c |  671 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 671 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/sh7760fb.c
> 
It really doesn't make any sense to split this patch up in to parts, as
none of the parts is useful or insular without the rest. The whole point
of splitting a patch out in to a series is to isolate changes logically
and in an incremental fashion, which obviously doesn't apply here.

> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/fb.h>
> +#include <linux/gfp.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/io.h>
> +#include <asm/sh7760fb.h>
> +
> +#define fb_msg(args...)        \
> +       do { printk(KERN_ALERT "sh7760fb: " args); } while (0)
> +#if 0
> +#define dbg(args...) fb_msg(args)
> +#else
> +#define dbg(fmt, args...) do { } while (0)
> +#endif
> +
Use dev_dbg() instead, then you get the pretty printing with the driver
name from the struct device.

> +/*
> + * some bits of the colormap registers should be written as zero.
> + * create a mask for that.
> + */
> +#define SH7760FB_PALETTE_MASK    0x00f8fcf8
> +
> +/* The LCDC dma engine always sets bits 27-26 to 1: this is Area3 */
> +#define SH7760FB_DMA_MASK      0x0C000000
> +
These should probably be in the header with all of the other related
bits.

> +static inline void OUT16(struct sh7760fb_par *par, int reg, unsigned short v)
> +{
> +	iowrite16(v, par->base + reg);
> +}
> +
> +static inline unsigned short IN16(struct sh7760fb_par *par, int reg)
> +{
> +	return ioread16(par->base + reg);
> +}
> +
> +static inline void OUT32(struct sh7760fb_par *par, int reg, unsigned long v)
> +{
> +	iowrite32(v, par->base + reg);
> +}
> +
> +static inline unsigned long IN32(struct sh7760fb_par *par, int reg)
> +{
> +	return ioread32(par->base + reg);
> +}
> +
There is effectively no point in using wrappers here, just use the
ioreadX() routines directly.

> +static void sh7760fb_wait_vsync(struct fb_info *info)
> +{
> +	struct sh7760fb_par *par = info->par;
> +
> +	if (par->pd->novsync)
> +		return;
> +/*
> +	while (IN16(par, LDINTR) & 1)
> +		OUT16(par, LDINTR, 0x1100);
> +*/
> +}
> +
This function doesn't actually do anything, so just kill it off.

> +
> +/*
> + * wait_for_lps - wait until power supply has reached a certain state.
> + * @val:       bitmask to wait for.
> + */
> +static void wait_for_lps(struct sh7760fb_par *par, int val)
> +{
> +	int i = 100;
> +	while (--i && ((IN16(par, LDPMMR) & 3) != val))
> +		msleep(1);
> +}
> +
You don't check for a timeout here, which you can easily check for and
hand down an error value for sh7760fb_blank() to return.

> +	if (!tmo) {
> +		ret = 1;
> +		pr_debug("sh7760fb: no palette access!\n");
> +		goto out;
> +	}
> +
Here also, switch to dev_dbg() so you can get rid of the sh7760fb:
prefixing and be consistent with the other debug messages.

> +	par->ioarea = request_mem_region(res->start,
> +			(res->end - res->start), pdev->name);
> +	if (!par->ioarea) {
> +		dev_err(&pdev->dev, "mmio area busy\n");
> +		ret = -EBUSY;
> +		goto out_fb;
> +	}
> +
> +	par->base = ioremap_nocache(res->start, (res->end - res->start));
> +	if (!par->base) {
> +		dev_err(&pdev->dev, "cannot remap\n");
> +		ret = -ENODEV;
> +		goto out_res;
> +	}
> +
You have an off-by-1 error here, ioremap() needs (res->end - res->start) + 1,
while request_mem_region() wants (res->end - res->start).

> +	fb_msg("memory at phys 0x%08lx-0x%08lx, size %ld KiB\n",
> +	       (unsigned long)par->fbdma,
> +	       (unsigned long)(par->fbdma + info->screen_size - 1),
> +		   info->screen_size >> 10);
> +
This is probably useful to have as a dev_info() or so instead of a debug
message..

> +#ifdef CONFIG_PM
> +static int sh7760fb_suspend(struct platform_device *dev, u32 level)
> +{
> +	dbg("sh7760fb_suspend()\n");
> +	return 0;
> +}
> +
> +static int sh7760fb_resume(struct platform_device *dev, u32 level)
> +{
> +	dbg("sh7760fb_resume()\n");
> +	return 0;
> +}

Fascinating messages. Please kill them.

> +MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
> +MODULE_DESCRIPTION("FBdev for SH7760/63 integrated LCD Controller");
> +MODULE_LICENSE("GPL");

Despite the fact that Manuel wrote the initial version, you seem to be
the one hacking on it and posting it for submission. MODULE_AUTHOR()
should reflect the active maintainer or at least point to a neutral place
where users can get help, as this is the first thing users will see with
modinfo and such. If you are going to maintain this together, also add
your name in to MODULE_AUTHOR().
