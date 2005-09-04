From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 1/2] ARM S3C2410 framebuffer driver
Date: Sun, 04 Sep 2005 22:57:19 +0200
Message-ID: <85u0h05z68.fsf@Orfeo.duckcorp.org>
References: <8564th6srr.fsf@Orfeo.duckcorp.org> <431B17BD.4090209@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EC1YY-0006jc-LX
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 13:57:38 -0700
Received: from orfeo.duckcorp.org
	([62.4.21.229] helo=mx.duckcorp.org ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EC1YU-00051r-Oe
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 13:57:38 -0700
In-Reply-To: <431B17BD.4090209@gmail.com> (Antonino A. Daplas's message of
	"Sun, 04 Sep 2005 23:50:21 +0800")
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>

--=-=-=

"Antonino A. Daplas" <adaplas@gmail.com> writes:

> Arnaud Patard (Rtp) wrote:
>> Hi,
>> 
>> This set of two patches add support for the framebuffer of the Samsung
>> S3C2410 ARM SoC. This driver was started about one year ago and is now
>> used on iPAQ h1930/h1940, Acer n30 and probably other s3c2410-based
>> machines I'm not aware of. I've also heard yesterday that it's working also
>> on iPAQ rx3715/rx3115 (s3c2440-based machines).
>> 
>> Theses patches are against current linux-2.6 git tree.
>> The first one add the driver by itself along with Kconfig, Makefile and
>> some headers. The second one add the plateform specific stuff needed to
>> configure and use the driver.
>> 
>
> Do the ARM people know about this driver?
>

ARM People that have s3c2410 plateforms know it. Moreover, Ben Dooks, the
maintainer of this ARM architecture, helped me in writing this driver.

>> Regards,
>> Arnaud Patard
>> 
>> 
>> Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>
>> 
>
> <snip>
>
>> +
>> +static inline struct s3c2410fb_info *fb_to_s3cfb(struct fb_info *info)
>> +{
>> +	return container_of(info, struct s3c2410fb_info, fb);
>> +}
>> +
>
> Instead of the private structure containing struct fb_info,
> any reason why the private data can't be placed in fb_info->par?...
>
>> + *	s3c2410fb_check_var():
>> + *	Get the video params out of 'var'. If a value doesn't fit, round it up,
>> + *	if it's too big, return -EINVAL.
>> + *
>> + */
>> +static int s3c2410fb_check_var(struct fb_var_screeninfo *var,
>> +			       struct fb_info *info)
>> +{
>> +	struct s3c2410fb_info *fbi = fb_to_s3cfb(info);
>> +
>
> ... and do it like this instead:
>
> struct s3c2410fb_info *fbi = info->par;
>

Corrected.


>> +
>> +	if (var->bits_per_pixel == 16) {
>> +		var->red.offset		= 11;
>> +		var->green.offset	= 5;
>> +		var->blue.offset	= 0;
>> +		var->red.length		= 5;
>> +		var->green.length	= 6;
>> +		var->blue.length	= 5;
>> +		var->transp.length	= 0;
>> +	} else {
>> +		var->red.length		= 8;
>> +		var->red.offset		= 0;
>> +		var->green.length	= 0;
>> +		var->green.offset	= 8;
>
> swapped green.length and green.offset?
>
hm.. I had corrected that some time ago.. It seems I forgot to merge the
patch in my git tree. New version is with patch applied. 
 	
>> +		var->blue.length	= 8;
>> +		var->blue.offset	= 0;
>> +		var->transp.length	= 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* s3c2410fb_activate_var
>> + *
>> + * activate (set) the controller from the given framebuffer
>> + * information
>> +*/
>> +
>> +static int s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
>> +				  struct fb_var_screeninfo *var)
>> +{
>> +	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
>> +
>> +	dprintk("%s: var->xres  = %d\n", __FUNCTION__, var->xres);
>> +	dprintk("%s: var->yres  = %d\n", __FUNCTION__, var->yres);
>> +	dprintk("%s: var->bpp   = %d\n", __FUNCTION__, var->bits_per_pixel);
>> +
>> +	switch (var->bits_per_pixel) {
>> +	case 1:
>> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT1BPP;
>> +		break;
>> +	case 2:
>> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT2BPP;
>> +		break;
>> +	case 4:
>> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT4BPP;
>> +		break;
>> +	case 8:
>> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT8BPP;
>> +		break;
>> +	case 16:
>> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT16BPP;
>> +		break;
>> +
>> +	default:
>> +		/* invalid pixel depth */
>> +		dev_err(fbi->dev, "invalid bpp %d\n", var->bits_per_pixel);
>
> You won't need to have an error path here if you round up bits_per_pixel
> in the check_var(). info->var will always contain a valid var as it would
> always go through the driver's check_var().
>

This was for debugging purpose and no more really needed. Removed.

>> +static int s3c2410fb_setcolreg(unsigned regno,
>> +			       unsigned red, unsigned green, unsigned blue,
>> +			       unsigned transp, struct fb_info *info)
>> +{
>> +	struct s3c2410fb_info *fbi = (struct s3c2410fb_info *)info;
>> +	unsigned int val;
>> +
>> +	/* dprintk("setcol: regno=%d, rgb=%d,%d,%d\n", regno, red, green, blue); */
>> +
>> +	switch (fbi->fb.fix.visual) {
>> +	case FB_VISUAL_TRUECOLOR:
>> +		/* true-colour, use pseuo-palette */
>> +
>> +		if (regno < 16) {
>> +			u32 *pal = fbi->fb.pseudo_palette;
>> +
>> +			val  = chan_to_field(red,   &fbi->fb.var.red);
>> +			val |= chan_to_field(green, &fbi->fb.var.green);
>> +			val |= chan_to_field(blue,  &fbi->fb.var.blue);
>> +
>> +			pal[regno] = val;
>> +		}
>
> Missing break statement?

You're right...

>> +
>> +	case FB_VISUAL_STATIC_PSEUDOCOLOR:
>
> static pseudocolor does not have a modifiable CLUT. And I don't see
> your driver supporting static pseudocolor.
>

you're right. removed.

> Similarly, truecolor cannot have a modifiable clut, that's why you need
> the 'break' above.  If you think your driver can modify the clut at
> 16 bpp, then advertise the visual as directcolor.
>  
> The above may seem nitpicking, but it can confuse user apps if the
> driver incorrectly advertises its capability.
>
>> +	case FB_VISUAL_PSEUDOCOLOR:
>> +		if (regno < 256) {
>> +			/* currently assume RGB 5-6-5 mode */
>> +
>> +			val  = ((red   >>  0) & 0xf800);
>> +			val |= ((green >>  5) & 0x07e0);
>> +			val |= ((blue  >> 11) & 0x001f);
>> +			
>> +			writel(val, S3C2410_TFTPAL(regno));
>> +			schedule_palette_update(fbi, regno, val);
>> +		}
>> +
>> +		break;
>> +
>> +	default:
>> +		return 1;   /* unknown type */
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +/**
>> + *	s3c2410fb_pan_display
>> + *	@var: frame buffer variable screen structure
>> + *	@info: frame buffer structure that represents a single frame buffer
>> + *
>> + *	Pan (or wrap, depending on the `vmode' field) the display using the
>> + *	`xoffset' and `yoffset' fields of the `var' structure.
>> + *	If the values don't fit, return -EINVAL.
>> + *
>> + *	Returns negative errno on error, or zero on success.
>> + */
>> +static int s3c2410fb_pan_display(struct fb_var_screeninfo *var,
>> +			     struct fb_info *info)
>> +{
>> +	dprintk("pan_display(var=%p, info=%p)\n", var, info);
>> +
>> +	dprintk("pan_display: xoffset=%d\n", var->xoffset);
>> +	dprintk("pan_display: yoffset=%d\n", var->yoffset);
>> +
>> +	return 0;
>> +}
>
> Just comment out pan_display if it's not doing anything. You'll
> just confuse apps that do multi-buffering.
>

Okay. Corrected.

>> +
>> +
>> +/* Fake monspecs to fill in fbinfo structure */
>> +/* Don't know if the values are important    */
>
> The values in monspecs are important if the driver
> uses it. Otherwise, you need not fake a monspecs.
>

Thanks. I didn't know that.

>> +int __init s3c2410fb_probe(struct device *dev)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct s3c2410fb_hw *mregs;
>> +	int ret;
>> +	int irq;
>> +	int i;
>> +
>> +	mach_info = dev->platform_data;
>> +	if (mach_info == NULL) {
>> +		dev_err(dev,"no platform data for lcd, cannot attach\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mregs = &mach_info->regs;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(dev, "no irq for device\n");
>> +		return -ENOENT;
>> +	}
>> +	
>> +	s3c2410fb_init_registers(&info);
>> +	
>> +	dprintk("devinit\n");
>> +
>> +	strcpy(info.fb.fix.id, driver_name);
>> +
>> +	memcpy(&info.regs, &mach_info->regs, sizeof(info.regs));
>> +
>> +	info.mach_info		    = dev->platform_data;
>> +
>> +	info.fb.fix.type	    = FB_TYPE_PACKED_PIXELS;
>> +	info.fb.fix.type_aux	    = 0;
>> +	info.fb.fix.xpanstep	    = 0;
>> +	info.fb.fix.ypanstep	    = 0;
>> +	info.fb.fix.ywrapstep	    = 0;
>> +	info.fb.fix.accel	    = FB_ACCEL_NONE;
>> +
>> +	info.fb.var.nonstd	    = 0;
>> +	info.fb.var.activate	    = FB_ACTIVATE_NOW;
>> +	info.fb.var.height	    = mach_info->height;
>> +	info.fb.var.width	    = mach_info->width;
>> +	info.fb.var.accel_flags     = 0;
>> +	info.fb.var.vmode	    = FB_VMODE_NONINTERLACED;
>> +
>> +	info.fb.fbops		    = &s3c2410fb_ops;
>> +	info.fb.flags		    = FBINFO_FLAG_DEFAULT;
>> +	info.fb.monspecs	    = monspecs;
>> +	info.fb.pseudo_palette      = &info.pseudo_pal;
>> +
>> +	info.fb.var.xres	    = mach_info->xres.defval;
>> +	info.fb.var.xres_virtual    = mach_info->xres.defval;
>> +	info.fb.var.yres	    = mach_info->yres.defval;
>> +	info.fb.var.yres_virtual    = mach_info->yres.defval;
>> +	info.fb.var.bits_per_pixel  = mach_info->bpp.defval;
>> +
>> +	info.fb.var.upper_margin    = S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) +1;
>> +	info.fb.var.lower_margin    = S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) +1;
>> +	info.fb.var.vsync_len	    = S3C2410_LCDCON2_GET_VSPW(mregs->lcdcon2) + 1;
>> +
>> +	info.fb.var.left_margin	    = S3C2410_LCDCON3_GET_HFPD(mregs->lcdcon3) + 1;
>> +	info.fb.var.right_margin    = S3C2410_LCDCON3_GET_HBPD(mregs->lcdcon3) + 1;
>> +	info.fb.var.hsync_len	    = S3C2410_LCDCON4_GET_HSPW(mregs->lcdcon4) + 1;
>> +
>> +	info.fb.var.red.offset      = 11;
>> +	info.fb.var.green.offset    = 5;
>> +	info.fb.var.blue.offset     = 0;
>> +	info.fb.var.transp.offset   = 0;
>> +	info.fb.var.red.length      = 5;
>> +	info.fb.var.green.length    = 6;
>> +	info.fb.var.blue.length     = 5;
>> +	info.fb.var.transp.length   = 0;
>> +	info.fb.fix.smem_len        =	mach_info->xres.max *
>> +					mach_info->yres.max *
>> +					mach_info->bpp.max / 8;
>> +
>
> You may need to allocate info.fb.cmap also (with fb_alloc_cmap(),
> and check its return).
>
> And you can set info.fb.device = dev so your driver will become
> visible in sysfs.
>
> (The standard method is to use framebuffer_alloc() to allocate
> struct fb_info and framebuffer_release() to free. You may have your own
> reasons not to use them, so it's okay).
>

Okay. Rewritten to use framebuffer_alloc()

>
>> +/*
>> + *  Cleanup
>> + */
>> +static void __exit s3c2410fb_cleanup(void)
>> +{
>> +	s3c2410fb_stop_lcd();
>> +	msleep(1);
>> +
>> + 	if (info.clk) {
>> + 		clk_disable(info.clk);
>> + 		clk_unuse(info.clk);
>> + 		clk_put(info.clk);
>> + 		info.clk = NULL;
>> +	}
>> +
>
> and deallocate your info.fb.cmap here (with fb_dealloc_cmap())
>
>> +	unregister_framebuffer(&info.fb);
>> +	release_mem_region((unsigned long)S3C24XX_VA_LCD, S3C24XX_SZ_LCD);
>> +}
>> +
>
> Tony

New version attached.

Regards,
Arnaud


Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>
  ---


--=-=-=
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: inline; filename=s3c2410fb.patch
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1484,6 +1484,30 @@ config FB_S1D13XXX
 	  working with S1D13806). Product specs at
 	  <http://www.erd.epson.com/vdc/html/legacy_13xxx.htm>
=20
+config FB_S3C2410
+	tristate "S3C2410 LCD framebuffer support"
+	depends on FB && ARCH_S3C2410
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	---help---
+	  Frame buffer driver for the built-in LCD controller in the Samsung
+	  S3C2410 processor.
+
+	  This driver is also available as a module ( =3D code which can be
+	  inserted and removed from the running kernel whenever you want). The
+	  module will be called s3c2410fb. If you want to compile it as a modul=
e,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
+config FB_S3C2410_DEBUG
+	bool "S3C2410 lcd debug messages"
+	depends on FB_S3C2410
+	help
+	  Turn on debugging messages. Note that you can set/unset at run time
+	  through sysfs
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_FB_MAXINE)		  +=3D maxinefb.o
 obj-$(CONFIG_FB_TX3912)		  +=3D tx3912fb.o
 obj-$(CONFIG_FB_S1D13XXX)	  +=3D s1d13xxxfb.o
 obj-$(CONFIG_FB_IMX)              +=3D imxfb.o
+obj-$(CONFIG_FB_S3C2410)	  +=3D s3c2410fb.o
=20
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             +=3D vesafb.o
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
new file mode 100644
--- /dev/null
+++ b/drivers/video/s3c2410fb.c
@@ -0,0 +1,915 @@
+/*
+ * linux/drivers/video/s3c2410fb.c
+ *	Copyright (c) Arnaud Patard, Ben Dooks
+ *
+ * This file is subject to the terms and conditions of the GNU General P=
ublic
+ * License.  See the file COPYING in the main directory of this archive =
for
+ * more details.
+ *
+ *	    S3C2410 LCD Controller Frame Buffer Driver
+ *	    based on skeletonfb.c, sa1100fb.c and others
+ *
+ * ChangeLog
+ * 2005-04-07: Arnaud Patard <arnaud.patard@rtp-net.org>
+ *      - u32 state -> pm_message_t state
+ *      - S3C2410_{VA,SZ}_LCD -> S3C24XX
+ *
+ * 2005-03-15: Arnaud Patard <arnaud.patard@rtp-net.org>
+ *      - Removed the ioctl
+ *      - use readl/writel instead of __raw_writel/__raw_readl
+ *
+ * 2004-12-04: Arnaud Patard <arnaud.patard@rtp-net.org>
+ *      - Added the possibility to set on or off the
+ *      debugging mesaages
+ *      - Replaced 0 and 1 by on or off when reading the
+ *      /sys files
+ *
+ * 2005-03-23: Ben Dooks <ben-linux@fluff.org>
+ *	- added non 16bpp modes
+ *	- updated platform information for range of x/y/bpp
+ *	- add code to ensure palette is written correctly
+ *	- add pixel clock divisor control
+ *
+ * 2004-11-11: Arnaud Patard <arnaud.patard@rtp-net.org>
+ * 	- Removed the use of currcon as it no more exist
+ * 	- Added LCD power sysfs interface
+ *
+ * 2004-11-03: Ben Dooks <ben-linux@fluff.org>
+ *	- minor cleanups
+ *	- add suspend/resume support
+ *	- s3c2410fb_setcolreg() not valid in >8bpp modes
+ *	- removed last CONFIG_FB_S3C2410_FIXED
+ *	- ensure lcd controller stopped before cleanup
+ *	- added sysfs interface for backlight power
+ *	- added mask for gpio configuration
+ *	- ensured IRQs disabled during GPIO configuration
+ *	- disable TPAL before enabling video
+ *
+ * 2004-09-20: Arnaud Patard <arnaud.patard@rtp-net.org>
+ *      - Suppress command line options
+ *
+ * 2004-09-15: Arnaud Patard <arnaud.patard@rtp-net.org>
+ * 	- code cleanup
+ *
+ * 2004-09-07: Arnaud Patard <arnaud.patard@rtp-net.org>
+ * 	- Renamed from h1940fb.c to s3c2410fb.c
+ * 	- Add support for different devices
+ * 	- Backlight support
+ *
+ * 2004-09-05: Herbert P=C3=B6tzl <herbert@13thfloor.at>
+ *	- added clock (de-)allocation code
+ *	- added fixem fbmem option
+ *
+ * 2004-07-27: Arnaud Patard <arnaud.patard@rtp-net.org>
+ *	- code cleanup
+ *	- added a forgotten return in h1940fb_init
+ *
+ * 2004-07-19: Herbert P=C3=B6tzl <herbert@13thfloor.at>
+ *	- code cleanup and extended debugging
+ *
+ * 2004-07-15: Arnaud Patard <arnaud.patard@rtp-net.org>
+ *	- First version
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/wait.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/div64.h>
+
+#include <asm/mach/map.h>
+#include <asm/arch/regs-lcd.h>
+#include <asm/arch/regs-gpio.h>
+#include <asm/arch/fb.h>
+#include <asm/hardware/clock.h>
+
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
+
+#include "s3c2410fb.h"
+
+
+static struct s3c2410fb_mach_info *mach_info;
+
+/* Debugging stuff */
+#ifdef CONFIG_FB_S3C2410_DEBUG
+static int debug	   =3D 1;
+#else
+static int debug	   =3D 0;
+#endif
+
+#define dprintk(msg...)	if (debug) { printk(KERN_DEBUG "s3c2410fb: " msg=
); }
+
+/* useful functions */
+
+/* s3c2410fb_set_lcdaddr
+ *
+ * initialise lcd controller address pointers
+*/
+
+static void s3c2410fb_set_lcdaddr(struct s3c2410fb_info *fbi)
+{
+	struct fb_var_screeninfo *var =3D &fbi->fb->var;
+	unsigned long saddr1, saddr2, saddr3;
+
+	saddr1  =3D fbi->fb->fix.smem_start >> 1;
+	saddr2  =3D fbi->fb->fix.smem_start;
+	saddr2 +=3D (var->xres * var->yres * var->bits_per_pixel)/8;
+	saddr2>>=3D 1;
+
+	saddr3 =3D  S3C2410_OFFSIZE(0) | S3C2410_PAGEWIDTH(var->xres);
+
+	dprintk("LCDSADDR1 =3D 0x%08lx\n", saddr1);
+	dprintk("LCDSADDR2 =3D 0x%08lx\n", saddr2);
+	dprintk("LCDSADDR3 =3D 0x%08lx\n", saddr3);
+
+	writel(saddr1, S3C2410_LCDSADDR1);
+	writel(saddr2, S3C2410_LCDSADDR2);     =20
+	writel(saddr3, S3C2410_LCDSADDR3);
+}
+
+/* s3c2410fb_calc_pixclk()
+ *
+ * calculate divisor for clk->pixclk
+*/
+
+static unsigned int s3c2410fb_calc_pixclk(struct s3c2410fb_info *fbi,
+					  unsigned long pixclk)
+{
+	unsigned long clk =3D clk_get_rate(fbi->clk);
+	unsigned long long div;
+
+	/* pixclk is in picoseoncds, our clock is in Hz=20
+	 *
+	 * Hz -> picoseconds is / 10^-12
+	 */
+
+	div =3D (unsigned long long)clk * pixclk;
+	do_div(div,1000000UL);
+	do_div(div,1000000UL);
+
+	dprintk("pixclk %ld, divisor is %ld\n", pixclk, (long)div);
+	return div;
+}
+
+/*
+ *	s3c2410fb_check_var():
+ *	Get the video params out of 'var'. If a value doesn't fit, round it u=
p,
+ *	if it's too big, return -EINVAL.
+ *
+ */
+static int s3c2410fb_check_var(struct fb_var_screeninfo *var,
+			       struct fb_info *info)
+{
+	struct s3c2410fb_info *fbi =3D info->par;
+
+	dprintk("check_var(var=3D%p, info=3D%p)\n", var, info);
+
+	/* validate x/y resolution */
+
+	if (var->yres > fbi->mach_info->yres.max)
+		var->yres =3D fbi->mach_info->yres.max;
+	else if (var->yres < fbi->mach_info->yres.min)
+		var->yres =3D fbi->mach_info->yres.min;
+
+	if (var->xres > fbi->mach_info->xres.max)
+		var->yres =3D fbi->mach_info->xres.max;
+	else if (var->xres < fbi->mach_info->xres.min)
+		var->xres =3D fbi->mach_info->xres.min;
+
+	/* validate bpp */
+
+	if (var->bits_per_pixel > fbi->mach_info->bpp.max)
+		var->bits_per_pixel =3D fbi->mach_info->bpp.max;
+	else if (var->bits_per_pixel < fbi->mach_info->bpp.min)
+		var->bits_per_pixel =3D fbi->mach_info->bpp.min;
+
+	/* set r/g/b positions */
+
+	if (var->bits_per_pixel =3D=3D 16) {
+		var->red.offset		=3D 11;
+		var->green.offset	=3D 5;
+		var->blue.offset	=3D 0;
+		var->red.length		=3D 5;
+		var->green.length	=3D 6;
+		var->blue.length	=3D 5;
+		var->transp.length	=3D 0;
+	} else {
+		var->red.length		=3D 8;
+		var->red.offset		=3D 0;
+		var->green.length	=3D 8;
+		var->green.offset	=3D 0;
+		var->blue.length	=3D 8;
+		var->blue.offset	=3D 0;
+		var->transp.length	=3D 0;
+	}
+
+	return 0;
+}
+
+/* s3c2410fb_activate_var
+ *
+ * activate (set) the controller from the given framebuffer
+ * information
+*/
+
+static int s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
+				  struct fb_var_screeninfo *var)
+{
+	fbi->regs.lcdcon1 &=3D ~S3C2410_LCDCON1_MODEMASK;
+
+	dprintk("%s: var->xres  =3D %d\n", __FUNCTION__, var->xres);
+	dprintk("%s: var->yres  =3D %d\n", __FUNCTION__, var->yres);
+	dprintk("%s: var->bpp   =3D %d\n", __FUNCTION__, var->bits_per_pixel);
+
+	switch (var->bits_per_pixel) {
+	case 1:
+		fbi->regs.lcdcon1 |=3D S3C2410_LCDCON1_TFT1BPP;
+		break;
+	case 2:
+		fbi->regs.lcdcon1 |=3D S3C2410_LCDCON1_TFT2BPP;
+		break;
+	case 4:
+		fbi->regs.lcdcon1 |=3D S3C2410_LCDCON1_TFT4BPP;
+		break;
+	case 8:
+		fbi->regs.lcdcon1 |=3D S3C2410_LCDCON1_TFT8BPP;
+		break;
+	case 16:
+		fbi->regs.lcdcon1 |=3D S3C2410_LCDCON1_TFT16BPP;
+		break;
+	}
+
+	/* check to see if we need to update sync/borders */
+
+	if (!fbi->mach_info->fixed_syncs) {
+		dprintk("setting vert: up=3D%d, low=3D%d, sync=3D%d\n",
+			var->upper_margin, var->lower_margin,
+			var->vsync_len);
+
+		dprintk("setting horz: lft=3D%d, rt=3D%d, sync=3D%d\n",
+			var->left_margin, var->right_margin,
+			var->hsync_len);
+
+		fbi->regs.lcdcon2 =3D=20
+			S3C2410_LCDCON2_VBPD(var->upper_margin - 1) |
+			S3C2410_LCDCON2_VFPD(var->lower_margin - 1) |
+			S3C2410_LCDCON2_VSPW(var->vsync_len - 1);
+
+		fbi->regs.lcdcon3 =3D=20
+			S3C2410_LCDCON3_HBPD(var->right_margin - 1) |
+			S3C2410_LCDCON3_HFPD(var->left_margin - 1);
+
+		fbi->regs.lcdcon4 &=3D ~S3C2410_LCDCON4_HSPW(0xff);
+		fbi->regs.lcdcon4 |=3D  S3C2410_LCDCON4_HSPW(var->hsync_len - 1);
+	}
+
+	/* update X/Y info */
+
+	fbi->regs.lcdcon2 &=3D ~S3C2410_LCDCON2_LINEVAL(0x3ff);
+	fbi->regs.lcdcon2 |=3D  S3C2410_LCDCON2_LINEVAL(var->yres - 1);
+
+	fbi->regs.lcdcon3 &=3D ~S3C2410_LCDCON3_HOZVAL(0x7ff);
+	fbi->regs.lcdcon3 |=3D  S3C2410_LCDCON3_HOZVAL(var->xres - 1);
+
+	if (var->pixclock > 0) {
+		int clkdiv =3D s3c2410fb_calc_pixclk(fbi, var->pixclock);
+
+		clkdiv =3D (clkdiv / 2) -1;
+		if (clkdiv < 0)
+			clkdiv =3D 0;
+
+		fbi->regs.lcdcon1 &=3D ~S3C2410_LCDCON1_CLKVAL(0x3ff);
+		fbi->regs.lcdcon1 |=3D  S3C2410_LCDCON1_CLKVAL(clkdiv);
+	}
+
+	/* write new registers */
+
+	dprintk("new register set:\n");
+	dprintk("lcdcon[1] =3D 0x%08lx\n", fbi->regs.lcdcon1);
+	dprintk("lcdcon[2] =3D 0x%08lx\n", fbi->regs.lcdcon2);
+	dprintk("lcdcon[3] =3D 0x%08lx\n", fbi->regs.lcdcon3);
+	dprintk("lcdcon[4] =3D 0x%08lx\n", fbi->regs.lcdcon4);
+	dprintk("lcdcon[5] =3D 0x%08lx\n", fbi->regs.lcdcon5);
+
+	writel(fbi->regs.lcdcon1 & ~S3C2410_LCDCON1_ENVID, S3C2410_LCDCON1);
+	writel(fbi->regs.lcdcon2, S3C2410_LCDCON2);
+	writel(fbi->regs.lcdcon3, S3C2410_LCDCON3);
+	writel(fbi->regs.lcdcon4, S3C2410_LCDCON4);
+	writel(fbi->regs.lcdcon5, S3C2410_LCDCON5);
+
+	/* set lcd address pointers */
+	s3c2410fb_set_lcdaddr(fbi);
+
+	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
+}
+
+
+/*
+ *      s3c2410fb_set_par - Optional function. Alters the hardware state=
.
+ *      @info: frame buffer structure that represents a single frame buf=
fer
+ *
+ */
+static int s3c2410fb_set_par(struct fb_info *info)
+{
+	struct s3c2410fb_info *fbi =3D info->par;
+	struct fb_var_screeninfo *var =3D &info->var;
+
+	if (var->bits_per_pixel =3D=3D 16)
+		fbi->fb->fix.visual =3D FB_VISUAL_TRUECOLOR;
+	else
+		fbi->fb->fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
+
+	fbi->fb->fix.line_length     =3D (var->width*var->bits_per_pixel)/8;
+
+	/* activate this new configuration */
+
+	s3c2410fb_activate_var(fbi, var);
+	return 0;
+}
+
+static void schedule_palette_update(struct s3c2410fb_info *fbi,
+				    unsigned int regno, unsigned int val)
+{
+	unsigned long flags;
+	unsigned long irqen;
+
+	local_irq_save(flags);
+
+	fbi->palette_buffer[regno] =3D val;
+
+	if (!fbi->palette_ready) {
+		fbi->palette_ready =3D 1;
+
+		/* enable IRQ */
+		irqen =3D readl(S3C2410_LCDINTMSK);
+		irqen &=3D ~S3C2410_LCDINT_FRSYNC;
+		writel(irqen, S3C2410_LCDINTMSK);
+	}
+
+	local_irq_restore(flags);
+}
+
+/* from pxafb.c */
+static inline unsigned int chan_to_field(unsigned int chan, struct fb_bi=
tfield *bf)
+{
+	chan &=3D 0xffff;
+	chan >>=3D 16 - bf->length;
+	return chan << bf->offset;
+}
+
+static int s3c2410fb_setcolreg(unsigned regno,
+			       unsigned red, unsigned green, unsigned blue,
+			       unsigned transp, struct fb_info *info)
+{
+	struct s3c2410fb_info *fbi =3D info->par;
+	unsigned int val;
+
+	/* dprintk("setcol: regno=3D%d, rgb=3D%d,%d,%d\n", regno, red, green, b=
lue); */
+
+	switch (fbi->fb->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		/* true-colour, use pseuo-palette */
+
+		if (regno < 16) {
+			u32 *pal =3D fbi->fb->pseudo_palette;
+
+			val  =3D chan_to_field(red,   &fbi->fb->var.red);
+			val |=3D chan_to_field(green, &fbi->fb->var.green);
+			val |=3D chan_to_field(blue,  &fbi->fb->var.blue);
+
+			pal[regno] =3D val;
+		}
+		break;
+
+	case FB_VISUAL_PSEUDOCOLOR:
+		if (regno < 256) {
+			/* currently assume RGB 5-6-5 mode */
+
+			val  =3D ((red   >>  0) & 0xf800);
+			val |=3D ((green >>  5) & 0x07e0);
+			val |=3D ((blue  >> 11) & 0x001f);
+		=09
+			writel(val, S3C2410_TFTPAL(regno));
+			schedule_palette_update(fbi, regno, val);
+		}
+
+		break;
+
+	default:
+		return 1;   /* unknown type */
+	}
+
+	return 0;
+}
+
+
+/**
+ *      s3c2410fb_blank
+ *	@blank_mode: the blank mode we want.
+ *	@info: frame buffer structure that represents a single frame buffer
+ *
+ *	Blank the screen if blank_mode !=3D 0, else unblank. Return 0 if
+ *	blanking succeeded, !=3D 0 if un-/blanking failed due to e.g. a
+ *	video mode which doesn't support it. Implements VESA suspend
+ *	and powerdown modes on hardware that supports disabling hsync/vsync:
+ *	blank_mode =3D=3D 2: suspend vsync
+ *	blank_mode =3D=3D 3: suspend hsync
+ *	blank_mode =3D=3D 4: powerdown
+ *
+ *	Returns negative errno on error, or zero on success.
+ *
+ */
+static int s3c2410fb_blank(int blank_mode, struct fb_info *info)
+{
+	dprintk("blank(mode=3D%d, info=3D%p)\n", blank_mode, info);
+
+	if (mach_info =3D=3D NULL)
+		return -EINVAL;
+
+	if (blank_mode =3D=3D FB_BLANK_UNBLANK)
+		writel(0x0, S3C2410_TPAL);
+	else {
+		dprintk("setting TPAL to output 0x000000\n");
+		writel(S3C2410_TPAL_EN, S3C2410_TPAL);
+	}
+
+	return 0;
+}
+
+static int s3c2410fb_debug_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", debug ? "on" : "off");
+}
+static int s3c2410fb_debug_store(struct device *dev, struct device_attri=
bute *attr,
+					   const char *buf, size_t len)
+{
+	if (mach_info =3D=3D NULL)
+		return -EINVAL;
+
+	if (len < 1)
+		return -EINVAL;
+
+	if (strnicmp(buf, "on", 2) =3D=3D 0 ||
+	    strnicmp(buf, "1", 1) =3D=3D 0) {
+		debug =3D 1;
+		printk(KERN_DEBUG "s3c2410fb: Debug On");
+	} else if (strnicmp(buf, "off", 3) =3D=3D 0 ||
+		   strnicmp(buf, "0", 1) =3D=3D 0) {
+		debug =3D 0;
+		printk(KERN_DEBUG "s3c2410fb: Debug Off");
+	} else {
+		return -EINVAL;
+	}
+
+	return len;
+}
+
+
+static DEVICE_ATTR(debug, 0666,
+		   s3c2410fb_debug_show,
+		   s3c2410fb_debug_store);
+
+static struct fb_ops s3c2410fb_ops =3D {
+	.owner		=3D THIS_MODULE,
+	.fb_check_var	=3D s3c2410fb_check_var,
+	.fb_set_par	=3D s3c2410fb_set_par,
+	.fb_blank	=3D s3c2410fb_blank,
+	.fb_setcolreg	=3D s3c2410fb_setcolreg,
+	.fb_fillrect	=3D cfb_fillrect,
+	.fb_copyarea	=3D cfb_copyarea,
+	.fb_imageblit	=3D cfb_imageblit,
+	.fb_cursor	=3D soft_cursor,
+};
+
+
+/*
+ * s3c2410fb_map_video_memory():
+ *	Allocates the DRAM memory for the frame buffer.  This buffer is
+ *	remapped into a non-cached, non-buffered, memory region to
+ *	allow palette and pixel writes to occur without flushing the
+ *	cache.  Once this area is remapped, all virtual memory
+ *	access to the video memory should occur at the new region.
+ */
+static int __init s3c2410fb_map_video_memory(struct s3c2410fb_info *fbi)
+{
+	dprintk("map_video_memory(fbi=3D%p)\n", fbi);
+
+	fbi->map_size =3D PAGE_ALIGN(fbi->fb->fix.smem_len + PAGE_SIZE);
+	fbi->map_cpu  =3D dma_alloc_writecombine(fbi->dev, fbi->map_size,
+					       &fbi->map_dma, GFP_KERNEL);
+
+	fbi->map_size =3D fbi->fb->fix.smem_len;
+
+	if (fbi->map_cpu) {
+		/* prevent initial garbage on screen */
+		dprintk("map_video_memory: clear %p:%08x\n",
+			fbi->map_cpu, fbi->map_size);
+		memset(fbi->map_cpu, 0xf0, fbi->map_size);
+
+		fbi->screen_dma		=3D fbi->map_dma;
+		fbi->fb->screen_base	=3D fbi->map_cpu;
+		fbi->fb->fix.smem_start  =3D fbi->screen_dma;
+
+		dprintk("map_video_memory: dma=3D%08x cpu=3D%p size=3D%08x\n",
+			fbi->map_dma, fbi->map_cpu, fbi->fb->fix.smem_len);
+	}
+
+	return fbi->map_cpu ? 0 : -ENOMEM;
+}
+
+static inline void s3c2410fb_unmap_video_memory(struct s3c2410fb_info *f=
bi)
+{
+	dma_free_writecombine(fbi->dev,fbi->map_size,fbi->map_cpu, fbi->map_dma=
);
+}
+
+static inline void modify_gpio(void __iomem *reg,
+			       unsigned long set, unsigned long mask)
+{
+	unsigned long tmp;
+
+	tmp =3D readl(reg) & ~mask;
+	writel(tmp | set, reg);
+}
+
+
+/*
+ * s3c2410fb_init_registers - Initialise all LCD-related registers
+ */
+
+int s3c2410fb_init_registers(struct s3c2410fb_info *fbi)
+{
+	unsigned long flags;
+
+	/* Initialise LCD with values from haret */
+
+	local_irq_save(flags);
+
+	/* modify the gpio(s) with interrupts set (bjd) */
+
+	modify_gpio(S3C2410_GPCUP,  mach_info->gpcup,  mach_info->gpcup_mask);
+	modify_gpio(S3C2410_GPCCON, mach_info->gpccon, mach_info->gpccon_mask);
+	modify_gpio(S3C2410_GPDUP,  mach_info->gpdup,  mach_info->gpdup_mask);
+	modify_gpio(S3C2410_GPDCON, mach_info->gpdcon, mach_info->gpdcon_mask);
+
+	local_irq_restore(flags);
+
+	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
+	writel(fbi->regs.lcdcon2, S3C2410_LCDCON2);
+	writel(fbi->regs.lcdcon3, S3C2410_LCDCON3);
+	writel(fbi->regs.lcdcon4, S3C2410_LCDCON4);
+	writel(fbi->regs.lcdcon5, S3C2410_LCDCON5);
+ =20
+ 	s3c2410fb_set_lcdaddr(fbi);
+
+	dprintk("LPCSEL    =3D 0x%08lx\n", mach_info->lpcsel);
+	writel(mach_info->lpcsel, S3C2410_LPCSEL);
+
+	dprintk("replacing TPAL %08x\n", readl(S3C2410_TPAL));
+
+	/* ensure temporary palette disabled */
+	writel(0x00, S3C2410_TPAL);
+
+	/* Enable video by setting the ENVID bit to 1 */
+	fbi->regs.lcdcon1 |=3D S3C2410_LCDCON1_ENVID;
+	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
+	return 0;
+}
+
+static void s3c2410fb_write_palette(struct s3c2410fb_info *fbi)
+{
+	unsigned int i;
+	unsigned long ent;
+
+	fbi->palette_ready =3D 0;
+=09
+	for (i =3D 0; i < 256; i++) {	=09
+		if ((ent =3D fbi->palette_buffer[i]) =3D=3D PALETTE_BUFF_CLEAR)
+			continue;
+
+		writel(ent, S3C2410_TFTPAL(i));
+	=09
+		/* it seems the only way to know exactly
+		 * if the palette wrote ok, is to check
+		 * to see if the value verifies ok
+		 */
+	=09
+		if (readw(S3C2410_TFTPAL(i)) =3D=3D ent)
+			fbi->palette_buffer[i] =3D PALETTE_BUFF_CLEAR;
+		else
+			fbi->palette_ready =3D 1;   /* retry */
+	}
+}
+
+static irqreturn_t s3c2410fb_irq(int irq, void *dev_id, struct pt_regs *=
r)
+{
+	struct s3c2410fb_info *fbi =3D dev_id;
+	unsigned long lcdirq =3D readl(S3C2410_LCDINTPND);
+
+	if (lcdirq & S3C2410_LCDINT_FRSYNC) {
+		if (fbi->palette_ready)
+			s3c2410fb_write_palette(fbi);
+
+		writel(S3C2410_LCDINT_FRSYNC, S3C2410_LCDINTPND);
+		writel(S3C2410_LCDINT_FRSYNC, S3C2410_LCDSRCPND);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static char driver_name[]=3D"s3c2410fb";
+=20
+int __init s3c2410fb_probe(struct device *dev)
+{
+	struct s3c2410fb_info *info;
+	struct fb_info	   *fbinfo;
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct s3c2410fb_hw *mregs;
+	int ret;
+	int irq;
+	int i;
+
+	mach_info =3D dev->platform_data;
+	if (mach_info =3D=3D NULL) {
+		dev_err(dev,"no platform data for lcd, cannot attach\n");
+		return -EINVAL;
+	}
+
+	mregs =3D &mach_info->regs;
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "no irq for device\n");
+		return -ENOENT;
+	}
+=09
+	fbinfo =3D framebuffer_alloc(sizeof(struct s3c2410fb_info), dev);
+	if (!fbinfo) {
+		return -ENOMEM;=09
+	}
+=09
+=09
+	info =3D fbinfo->par;
+	info->fb =3D fbinfo;
+	dev_set_drvdata(dev, fbinfo);
+
+	s3c2410fb_init_registers(info);
+=09
+	dprintk("devinit\n");
+
+	strcpy(fbinfo->fix.id, driver_name);
+
+	memcpy(&info->regs, &mach_info->regs, sizeof(info->regs));
+
+	info->mach_info		    =3D dev->platform_data;
+
+	fbinfo->fix.type	    =3D FB_TYPE_PACKED_PIXELS;
+	fbinfo->fix.type_aux	    =3D 0;
+	fbinfo->fix.xpanstep	    =3D 0;
+	fbinfo->fix.ypanstep	    =3D 0;
+	fbinfo->fix.ywrapstep	    =3D 0;
+	fbinfo->fix.accel	    =3D FB_ACCEL_NONE;
+
+	fbinfo->var.nonstd	    =3D 0;
+	fbinfo->var.activate	    =3D FB_ACTIVATE_NOW;
+	fbinfo->var.height	    =3D mach_info->height;
+	fbinfo->var.width	    =3D mach_info->width;
+	fbinfo->var.accel_flags     =3D 0;
+	fbinfo->var.vmode	    =3D FB_VMODE_NONINTERLACED;
+
+	fbinfo->fbops		    =3D &s3c2410fb_ops;
+	fbinfo->flags		    =3D FBINFO_FLAG_DEFAULT;
+	fbinfo->pseudo_palette      =3D &info->pseudo_pal;
+
+	fbinfo->var.xres	    =3D mach_info->xres.defval;
+	fbinfo->var.xres_virtual    =3D mach_info->xres.defval;
+	fbinfo->var.yres	    =3D mach_info->yres.defval;
+	fbinfo->var.yres_virtual    =3D mach_info->yres.defval;
+	fbinfo->var.bits_per_pixel  =3D mach_info->bpp.defval;
+
+	fbinfo->var.upper_margin    =3D S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2=
) +1;
+	fbinfo->var.lower_margin    =3D S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2=
) +1;
+	fbinfo->var.vsync_len	    =3D S3C2410_LCDCON2_GET_VSPW(mregs->lcdcon2) =
+ 1;
+
+	fbinfo->var.left_margin	    =3D S3C2410_LCDCON3_GET_HFPD(mregs->lcdcon3=
) + 1;
+	fbinfo->var.right_margin    =3D S3C2410_LCDCON3_GET_HBPD(mregs->lcdcon3=
) + 1;
+	fbinfo->var.hsync_len	    =3D S3C2410_LCDCON4_GET_HSPW(mregs->lcdcon4) =
+ 1;
+
+	fbinfo->var.red.offset      =3D 11;
+	fbinfo->var.green.offset    =3D 5;
+	fbinfo->var.blue.offset     =3D 0;
+	fbinfo->var.transp.offset   =3D 0;
+	fbinfo->var.red.length      =3D 5;
+	fbinfo->var.green.length    =3D 6;
+	fbinfo->var.blue.length     =3D 5;
+	fbinfo->var.transp.length   =3D 0;
+	fbinfo->fix.smem_len        =3D	mach_info->xres.max *
+					mach_info->yres.max *
+					mach_info->bpp.max / 8;
+
+	for (i =3D 0; i < 256; i++)
+		info->palette_buffer[i] =3D PALETTE_BUFF_CLEAR;
+
+	if (!request_mem_region((unsigned long)S3C24XX_VA_LCD, SZ_1M, "s3c2410-=
lcd")) {
+		ret =3D -EBUSY;
+		goto dealloc_fb;
+	}
+
+
+	dprintk("got LCD region\n");
+
+	ret =3D request_irq(irq, s3c2410fb_irq, SA_INTERRUPT, pdev->name, info)=
;
+	if (ret) {
+		dev_err(dev, "cannot get irq %d - err %d\n", irq, ret);
+		ret =3D -EBUSY;
+		goto release_mem;
+	}
+=09
+	info->clk =3D clk_get(NULL, "lcd");
+	if (!info->clk || IS_ERR(info->clk)) {
+		printk(KERN_ERR "failed to get lcd clock source\n");
+		ret =3D -ENOENT;
+		goto release_irq;
+	}
+
+	clk_use(info->clk);
+	clk_enable(info->clk);
+	dprintk("got and enabled clock\n");
+
+	msleep(1);
+
+	/* Initialize video memory */
+	ret =3D s3c2410fb_map_video_memory(info);
+	if (ret) {
+		printk( KERN_ERR "Failed to allocate video RAM: %d\n", ret);
+		ret =3D -ENOMEM;
+		goto release_clock;
+	}
+	dprintk("got video memory\n");
+
+	ret =3D s3c2410fb_init_registers(info);
+
+	ret =3D s3c2410fb_check_var(&fbinfo->var, fbinfo);
+
+	ret =3D register_framebuffer(fbinfo);
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to register framebuffer device: %d\n", ret);
+		goto free_video_memory;
+	}
+
+	/* create device files */
+	device_create_file(dev, &dev_attr_debug);
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+		fbinfo->node, fbinfo->fix.id);
+
+	return 0;
+
+free_video_memory:
+	s3c2410fb_unmap_video_memory(info);
+release_clock:
+	clk_disable(info->clk);
+	clk_unuse(info->clk);
+	clk_put(info->clk);
+release_irq:
+	free_irq(irq,info);
+release_mem:
+ 	release_mem_region((unsigned long)S3C24XX_VA_LCD, S3C24XX_SZ_LCD);
+dealloc_fb:
+	framebuffer_release(fbinfo);
+	return ret;
+}
+
+/* s3c2410fb_stop_lcd
+ *
+ * shutdown the lcd controller
+*/
+
+static void s3c2410fb_stop_lcd(void)
+{
+	unsigned long flags;
+	unsigned long tmp;
+
+	local_irq_save(flags);
+
+	tmp =3D readl(S3C2410_LCDCON1);
+	writel(tmp & ~S3C2410_LCDCON1_ENVID, S3C2410_LCDCON1);
+
+	local_irq_restore(flags);
+}
+
+/*
+ *  Cleanup
+ */
+static int s3c2410fb_remove(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct fb_info	   *fbinfo =3D dev_get_drvdata(dev);
+	struct s3c2410fb_info *info =3D fbinfo->par;
+	int irq;
+
+	s3c2410fb_stop_lcd();
+	msleep(1);
+
+	s3c2410fb_unmap_video_memory(info);
+
+ 	if (info->clk) {
+ 		clk_disable(info->clk);
+ 		clk_unuse(info->clk);
+ 		clk_put(info->clk);
+ 		info->clk =3D NULL;
+	}
+
+	irq =3D platform_get_irq(pdev, 0);
+	free_irq(irq,info);
+	release_mem_region((unsigned long)S3C24XX_VA_LCD, S3C24XX_SZ_LCD);
+	unregister_framebuffer(fbinfo);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+/* suspend and resume support for the lcd controller */
+
+static int s3c2410fb_suspend(struct device *dev, pm_message_t state, u32=
 level)
+{
+	struct fb_info	   *fbinfo =3D dev_get_drvdata(dev);
+	struct s3c2410fb_info *info =3D fbinfo->par;
+
+	if (level =3D=3D SUSPEND_DISABLE || level =3D=3D SUSPEND_POWER_DOWN) {
+		s3c2410fb_stop_lcd();
+
+		/* sleep before disabling the clock, we need to ensure
+		 * the LCD DMA engine is not going to get back on the bus
+		 * before the clock goes off again (bjd) */
+
+		msleep(1);
+		clk_disable(info->clk);
+	}
+
+	return 0;
+}
+
+static int s3c2410fb_resume(struct device *dev, u32 level)
+{
+	struct fb_info	   *fbinfo =3D dev_get_drvdata(dev);
+	struct s3c2410fb_info *info =3D fbinfo->par;
+
+	if (level =3D=3D RESUME_ENABLE) {
+		clk_enable(info->clk);
+		msleep(1);
+
+		s3c2410fb_init_registers(info);
+
+	}
+
+	return 0;
+}
+
+#else
+#define s3c2410fb_suspend NULL
+#define s3c2410fb_resume  NULL
+#endif
+
+static struct device_driver s3c2410fb_driver =3D {
+	.name		=3D "s3c2410-lcd",
+	.bus		=3D &platform_bus_type,
+	.probe		=3D s3c2410fb_probe,
+	.suspend	=3D s3c2410fb_suspend,
+	.resume		=3D s3c2410fb_resume,
+	.remove		=3D s3c2410fb_remove
+};
+
+int __devinit s3c2410fb_init(void)
+{
+	return driver_register(&s3c2410fb_driver);
+}
+
+static void __exit s3c2410fb_cleanup(void)
+{
+	driver_unregister(&s3c2410fb_driver);
+}
+
+
+module_init(s3c2410fb_init);
+module_exit(s3c2410fb_cleanup);
+
+MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>, Ben Dooks <ben=
-linux@fluff.org>");
+MODULE_DESCRIPTION("Framebuffer driver for the s3c2410");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/s3c2410fb.h b/drivers/video/s3c2410fb.h
new file mode 100644
--- /dev/null
+++ b/drivers/video/s3c2410fb.h
@@ -0,0 +1,56 @@
+/*
+ * linux/drivers/s3c2410fb.h
+ * Copyright (c) Arnaud Patard
+ *
+ * This file is subject to the terms and conditions of the GNU General P=
ublic
+ * License.  See the file COPYING in the main directory of this archive =
for
+ * more details.
+ *
+ *	    S3C2410 LCD Controller Frame Buffer Driver
+ *	    based on skeletonfb.c, sa1100fb.h
+ *
+ * ChangeLog
+ *
+ * 2004-12-04: Arnaud Patard <arnaud.patard@rtp-net.org>
+ *      - Moved dprintk to s3c2410fb.c
+ *
+ * 2004-09-07: Arnaud Patard <arnaud.patard@rtp-net.org>
+ * 	- Renamed from h1940fb.h to s3c2410fb.h
+ * 	- Chenged h1940 to s3c2410
+ *
+ * 2004-07-15: Arnaud Patard <arnaud.patard@rtp-net.org>
+ *	- First version
+ */
+
+#ifndef __S3C2410FB_H
+#define __S3C2410FB_H
+
+struct s3c2410fb_info {
+	struct fb_info		*fb;
+	struct device		*dev;
+	struct clk		*clk;
+
+	struct s3c2410fb_mach_info *mach_info;
+
+	/* raw memory addresses */
+	dma_addr_t		map_dma;	/* physical */
+	u_char *		map_cpu;	/* virtual */
+	u_int			map_size;
+
+	struct s3c2410fb_hw	regs;
+
+	/* addresses of pieces placed in raw buffer */
+	u_char *		screen_cpu;	/* virtual address of buffer */
+	dma_addr_t		screen_dma;	/* physical address of buffer */
+	unsigned int		palette_ready;
+
+	/* keep these registers in case we need to re-write palette */
+	u32			palette_buffer[256];
+	u32			pseudo_pal[16];
+};
+
+#define PALETTE_BUFF_CLEAR (0x80000000)	/* entry is clear/invalid */
+
+int s3c2410fb_init(void);
+
+#endif
diff --git a/include/asm-arm/arch-s3c2410/fb.h b/include/asm-arm/arch-s3c=
2410/fb.h
new file mode 100644
--- /dev/null
+++ b/include/asm-arm/arch-s3c2410/fb.h
@@ -0,0 +1,69 @@
+/* linux/include/asm/arch-s3c2410/fb.h
+ *
+ * Copyright (c) 2004 Arnaud Patard <arnaud.patard@rtp-net.org>
+ *
+ * Inspired by pxafb.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *
+ *  Changelog:
+ *	07-Sep-2004	RTP	Created file
+ *	03-Nov-2004	BJD	Updated and minor cleanups
+ *	03-Aug-2005     RTP     Renamed to fb.h
+*/
+
+#ifndef __ASM_ARM_FB_H
+#define __ASM_ARM_FB_H
+
+#include <asm/arch/regs-lcd.h>
+
+struct s3c2410fb_val {
+	unsigned int	defval;
+	unsigned int	min;
+	unsigned int	max;
+};
+
+struct s3c2410fb_hw {
+	unsigned long	lcdcon1;
+	unsigned long	lcdcon2;
+	unsigned long	lcdcon3;
+	unsigned long	lcdcon4;
+	unsigned long	lcdcon5;
+};
+
+struct s3c2410fb_mach_info {
+	unsigned char	fixed_syncs;	/* do not update sync/border */
+
+	/* Screen size */
+	int		width;
+	int		height;
+
+	/* Screen info */
+	struct s3c2410fb_val xres;
+	struct s3c2410fb_val yres;
+	struct s3c2410fb_val bpp;
+
+	/* lcd configuration registers */
+	struct s3c2410fb_hw  regs;
+
+	/* GPIOs */
+
+	unsigned long	gpcup;
+	unsigned long	gpcup_mask;
+	unsigned long	gpccon;
+	unsigned long	gpccon_mask;
+	unsigned long	gpdup;
+	unsigned long	gpdup_mask;
+	unsigned long	gpdcon;
+	unsigned long	gpdcon_mask;
+
+	/* lpc3600 control register */
+	unsigned long	lpcsel;
+};
+
+void __init set_s3c2410fb_info(struct s3c2410fb_mach_info *hard_s3c2410f=
b_info);
+
+#endif /* __ASM_ARM_FB_H */
diff --git a/include/asm-arm/arch-s3c2410/regs-lcd.h b/include/asm-arm/ar=
ch-s3c2410/regs-lcd.h
--- a/include/asm-arm/arch-s3c2410/regs-lcd.h
+++ b/include/asm-arm/arch-s3c2410/regs-lcd.h
@@ -51,21 +51,32 @@
=20
 #define S3C2410_LCDCON1_ENVID	   (1)
=20
+#define S3C2410_LCDCON1_MODEMASK    0x1E
+
 #define S3C2410_LCDCON2_VBPD(x)	    ((x) << 24)
 #define S3C2410_LCDCON2_LINEVAL(x)  ((x) << 14)
 #define S3C2410_LCDCON2_VFPD(x)	    ((x) << 6)
 #define S3C2410_LCDCON2_VSPW(x)	    ((x) << 0)
=20
+#define S3C2410_LCDCON2_GET_VBPD(x) ( ((x) >> 24) & 0xFF)
+#define S3C2410_LCDCON2_GET_VFPD(x) ( ((x) >>  6) & 0xFF)
+#define S3C2410_LCDCON2_GET_VSPW(x) ( ((x) >>  0) & 0x3F)
+
 #define S3C2410_LCDCON3_HBPD(x)	    ((x) << 19)
 #define S3C2410_LCDCON3_WDLY(x)	    ((x) << 19)
 #define S3C2410_LCDCON3_HOZVAL(x)   ((x) << 8)
 #define S3C2410_LCDCON3_HFPD(x)	    ((x) << 0)
 #define S3C2410_LCDCON3_LINEBLANK(x)((x) << 0)
=20
+#define S3C2410_LCDCON3_GET_HBPD(x) ( ((x) >> 19) & 0x7F)
+#define S3C2410_LCDCON3_GET_HFPD(x) ( ((x) >>  0) & 0xFF)
+
 #define S3C2410_LCDCON4_MVAL(x)	    ((x) << 8)
 #define S3C2410_LCDCON4_HSPW(x)	    ((x) << 0)
 #define S3C2410_LCDCON4_WLH(x)	    ((x) << 0)
=20
+#define S3C2410_LCDCON4_GET_HSPW(x) ( ((x) >>  0) & 0xFF)
+
 #define S3C2410_LCDCON5_BPP24BL	    (1<<12)
 #define S3C2410_LCDCON5_FRM565	    (1<<11)
 #define S3C2410_LCDCON5_INVVCLK	    (1<<10)
@@ -100,10 +111,16 @@
 #define S3C2410_DITHMODE   S3C2410_LCDREG(0x4C)
 #define S3C2410_TPAL	   S3C2410_LCDREG(0x50)
=20
+#define S3C2410_TPAL_EN		(1<<24)
+
 /* interrupt info */
 #define S3C2410_LCDINTPND  S3C2410_LCDREG(0x54)
 #define S3C2410_LCDSRCPND  S3C2410_LCDREG(0x58)
 #define S3C2410_LCDINTMSK  S3C2410_LCDREG(0x5C)
+#define S3C2410_LCDINT_FIWSEL	(1<<2)
+#define	S3C2410_LCDINT_FRSYNC	(1<<1)
+#define S3C2410_LCDINT_FICNT	(1<<0)
+
 #define S3C2410_LPCSEL	   S3C2410_LCDREG(0x60)
=20
 #define S3C2410_TFTPAL(x)  S3C2410_LCDREG((0x400 + (x)*4))

--=-=-=--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
