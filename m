From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/5] s1d13xxxfb: Add support for Epson S1D13806 FB
Date: Tue, 15 Mar 2005 07:06:27 +0800
Message-ID: <200503150706.27357.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAyfh-0007vA-0W
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 15:08:25 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAyfd-0003oU-Cd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 15:08:24 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6A903FB0904
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 23:08:04 +0000 (UTC)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Thibaut VARENE <varenet@esiee.fr>

  Attached to that mail is a patch adding support for Epson S1D13806
  framebuffer device.

  That driver is intended to be easily used with other S1D13xxx devices,
  hopefully by splitting the header file and changing a few defines. Since
  I haven't got the hardware to test that, though, I can only assert that
  it works with S1D13806.

  This driver has been succesfully tested on ARM embedded boards and
  reported working on SH architecture as well.

  Since this is my first framebuffer driver, I would welcome any
  suggestion/comment about it :)

  This driver has been built on top of some preliminary ARM specific work
  by Ben Dooks, and adapted from existing code (as stated in the header of
  s1d13xxxfb.c).

Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig      |   12
 drivers/video/Makefile     |    1
 drivers/video/s1d13xxxfb.c |  772 +++++++++++++++++++++++++++++++++++++++++++++
 include/video/s1d13xxxfb.h |  166 +++++++++
 4 files changed, 951 insertions(+)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-03-14 06:50:28 +08:00
+++ b/drivers/video/Kconfig	2005-03-14 21:33:42 +08:00
@@ -1448,6 +1448,18 @@
 
 	  <file:Documentation/fb/pxafb.txt> describes the available parameters.
 
+config FB_S1D13XXX
+	tristate "Epson S1D13XXX framebuffer support"
+	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	help
+	  Support for S1D13XXX framebuffer device family (currently only
+	  working with S1D13806). Product specs at
+	  <http://www.erd.epson.com/vdc/html/legacy_13xxx.htm>
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-03-14 06:55:07 +08:00
+++ b/drivers/video/Makefile	2005-03-14 21:20:02 +08:00
@@ -89,6 +89,7 @@
 obj-$(CONFIG_FB_PMAGB_B)	  += pmagb-b-fb.o
 obj-$(CONFIG_FB_MAXINE)		  += maxinefb.o
 obj-$(CONFIG_FB_TX3912)		  += tx3912fb.o
+obj-$(CONFIG_FB_S1D13XXX)	  += s1d13xxxfb.o
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             += vesafb.o
diff -Nru a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/s1d13xxxfb.c	2005-03-14 23:30:59 +08:00
@@ -0,0 +1,772 @@
+/* drivers/video/s1d13xxxfb.c
+ *
+ * (c) 2004 Simtec Electronics
+ * (c) 2005 Thibaut VARENE <varenet@parisc-linux.org>
+ *
+ * Driver for Epson S1D13xxx series framebuffer chips
+ *
+ * Adapted from
+ *  linux/drivers/video/skeletonfb.c
+ *  linux/drivers/video/epson1355fb.c
+ *  linux/drivers/video/epson/s1d13xxxfb.c (2.4 driver by Epson)
+ *
+ * Note, currently only tested on S1D13806 with 16bit CRT.
+ * As such, this driver might still contain some hardcoded bits relating to
+ * S1D13806.
+ * Making it work on other S1D13XXX chips should merely be a matter of adding
+ * a few switch()s, some missing glue here and there maybe, and split header
+ * files.
+ *
+ * TODO: - handle dual screen display (CRT and LCD at the same time).
+ *	 - check_var(), mode change, etc.
+ *	 - PM untested.
+ *	 - Accelerated interfaces.
+ *	 - Probably not SMP safe :)
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/fb.h>
+
+#include <asm/io.h>
+
+#include <video/s1d13xxxfb.h>
+
+#define PFX "s1d13xxxfb: "
+
+#if 0
+#define dbg(fmt, args...) do { printk(KERN_INFO fmt, ## args); } while(0)
+#else
+#define dbg(fmt, args...) do { } while (0)
+#endif
+
+/*
+ * Here we define the default struct fb_fix_screeninfo
+ */
+static struct fb_fix_screeninfo __devinitdata s1d13xxxfb_fix = {
+	.id		= S1D_FBID,
+	.type		= FB_TYPE_PACKED_PIXELS,
+	.visual		= FB_VISUAL_PSEUDOCOLOR,
+	.xpanstep	= 0,
+	.ypanstep	= 1,
+	.ywrapstep	= 0,
+	.accel		= FB_ACCEL_NONE,
+};
+
+static inline u8
+s1d13xxxfb_readreg(struct s1d13xxxfb_par *par, u16 regno)
+{
+	return readb(par->regs + regno);
+}
+
+static inline void
+s1d13xxxfb_writereg(struct s1d13xxxfb_par *par, u16 regno, u8 value)
+{
+	writeb(value, par->regs + regno);
+}
+
+static inline void
+s1d13xxxfb_runinit(struct s1d13xxxfb_par *par,
+			const struct s1d13xxxfb_regval *initregs,
+			const unsigned int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+        	if ((initregs[i].addr == S1DREG_DELAYOFF) ||
+				(initregs[i].addr == S1DREG_DELAYON))
+			mdelay((int)initregs[i].value);
+        	else {
+			s1d13xxxfb_writereg(par, initregs[i].addr, initregs[i].value);
+		}
+        }
+
+	/* make sure the hardware can cope with us */
+	mdelay(1);
+}
+
+static inline void
+lcd_enable(struct s1d13xxxfb_par *par, int enable)
+{
+	u8 mode = s1d13xxxfb_readreg(par, S1DREG_COM_DISP_MODE);
+
+	if (enable)
+		mode |= 0x01;
+	else
+		mode &= ~0x01;
+
+	s1d13xxxfb_writereg(par, S1DREG_COM_DISP_MODE, mode);
+}
+
+static inline void
+crt_enable(struct s1d13xxxfb_par *par, int enable)
+{
+	u8 mode = s1d13xxxfb_readreg(par, S1DREG_COM_DISP_MODE);
+
+	if (enable)
+		mode |= 0x02;
+	else
+		mode &= ~0x02;
+
+	s1d13xxxfb_writereg(par, S1DREG_COM_DISP_MODE, mode);
+}
+
+/* framebuffer control routines */
+
+static inline void
+s1d13xxxfb_setup_pseudocolour(struct fb_info *info)
+{
+	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+
+	info->var.red.length = 4;
+	info->var.green.length = 4;
+	info->var.blue.length = 4;
+}
+
+static inline void
+s1d13xxxfb_setup_truecolour(struct fb_info *info)
+{
+	info->fix.visual = FB_VISUAL_TRUECOLOR;
+	info->var.bits_per_pixel = 16;
+
+	info->var.red.length = 5;
+	info->var.red.offset = 11;
+
+	info->var.green.length = 6;
+	info->var.green.offset = 5;
+
+	info->var.blue.length = 5;
+	info->var.blue.offset = 0;
+}
+
+/**
+ *      s1d13xxxfb_set_par - Alters the hardware state.
+ *      @info: frame buffer structure
+ *
+ *	Using the fb_var_screeninfo in fb_info we set the depth of the
+ *	framebuffer. This function alters the par AND the
+ *	fb_fix_screeninfo stored in fb_info. It doesn't not alter var in
+ *	fb_info since we are using that data. This means we depend on the
+ *	data in var inside fb_info to be supported by the hardware.
+ *	xxxfb_check_var is always called before xxxfb_set_par to ensure this.
+ *
+ *	XXX TODO: write proper s1d13xxxfb_check_var(), without which that
+ *	function is quite useless.
+ */
+static int
+s1d13xxxfb_set_par(struct fb_info *info)
+{
+	struct s1d13xxxfb_par *s1dfb = info->par;
+	unsigned int val;
+
+	dbg("s1d13xxxfb_set_par: bpp=%d\n", info->var.bits_per_pixel);
+
+	if ((s1dfb->display & 0x01))	/* LCD */
+		val = s1d13xxxfb_readreg(s1dfb, S1DREG_LCD_DISP_MODE);   /* read colour control */
+	else	/* CRT */
+		val = s1d13xxxfb_readreg(s1dfb, S1DREG_CRT_DISP_MODE);   /* read colour control */
+
+	val &= ~0x07;
+
+	switch (info->var.bits_per_pixel) {
+		case 4:
+			dbg("pseudo colour 4\n");
+			s1d13xxxfb_setup_pseudocolour(info);
+			val |= 2;
+			break;
+		case 8:
+			dbg("pseudo colour 8\n");
+			s1d13xxxfb_setup_pseudocolour(info);
+			val |= 3;
+			break;
+		case 16:
+			dbg("true colour\n");
+			s1d13xxxfb_setup_truecolour(info);
+			val |= 5;
+			break;
+
+		default:
+			dbg("bpp not supported!\n");
+			return -EINVAL;
+	}
+
+	dbg("writing %02x to display mode register\n", val);
+
+	if ((s1dfb->display & 0x01))	/* LCD */
+		s1d13xxxfb_writereg(s1dfb, S1DREG_LCD_DISP_MODE, val);
+	else	/* CRT */
+		s1d13xxxfb_writereg(s1dfb, S1DREG_CRT_DISP_MODE, val);
+
+	info->fix.line_length  = info->var.xres * info->var.bits_per_pixel;
+	info->fix.line_length /= 8;
+
+	dbg("setting line_length to %d\n", info->fix.line_length);
+
+	dbg("done setup\n");
+
+	return 0;
+}
+
+/**
+ *  	s1d13xxxfb_setcolreg - sets a color register.
+ *      @regno: Which register in the CLUT we are programming
+ *      @red: The red value which can be up to 16 bits wide
+ *	@green: The green value which can be up to 16 bits wide
+ *	@blue:  The blue value which can be up to 16 bits wide.
+ *	@transp: If supported the alpha value which can be up to 16 bits wide.
+ *      @info: frame buffer info structure
+ *
+ *	Returns negative errno on error, or zero on success.
+ */
+static int
+s1d13xxxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+			u_int transp, struct fb_info *info)
+{
+	struct s1d13xxxfb_par *s1dfb = info->par;
+	unsigned int pseudo_val;
+
+	if (regno >= S1D_PALETTE_SIZE)
+		return -EINVAL;
+
+	dbg("s1d13xxxfb_setcolreg: %d: rgb=%d,%d,%d, tr=%d\n",
+		    regno, red, green, blue, transp);
+
+	if (info->var.grayscale)
+		red = green = blue = (19595*red + 38470*green + 7471*blue) >> 16;
+
+	switch (info->fix.visual) {
+		case FB_VISUAL_TRUECOLOR:
+			if (regno >= 16)
+				return -EINVAL;
+
+			/* deal with creating pseudo-palette entries */
+
+			pseudo_val  = (red   >> 11) << info->var.red.offset;
+			pseudo_val |= (green >> 10) << info->var.green.offset;
+			pseudo_val |= (blue  >> 11) << info->var.blue.offset;
+
+			dbg("s1d13xxxfb_setcolreg: pseudo %d, val %08x\n",
+				    regno, pseudo_val);
+
+			((u32 *)info->pseudo_palette)[regno] = pseudo_val;
+
+			break;
+		case FB_VISUAL_PSEUDOCOLOR:
+			s1d13xxxfb_writereg(s1dfb, S1DREG_LKUP_ADDR, regno);
+			s1d13xxxfb_writereg(s1dfb, S1DREG_LKUP_DATA, red);
+			s1d13xxxfb_writereg(s1dfb, S1DREG_LKUP_DATA, green);
+			s1d13xxxfb_writereg(s1dfb, S1DREG_LKUP_DATA, blue);
+
+			break;
+		default:
+			return -ENOSYS;
+	}
+
+	dbg("s1d13xxxfb_setcolreg: done\n");
+
+	return 0;
+}
+
+/**
+ *      s1d13xxxfb_blank - blanks the display.
+ *      @blank_mode: the blank mode we want.
+ *      @info: frame buffer structure that represents a single frame buffer
+ *
+ *      Blank the screen if blank_mode != 0, else unblank. Return 0 if
+ *      blanking succeeded, != 0 if un-/blanking failed due to e.g. a
+ *      video mode which doesn't support it. Implements VESA suspend
+ *      and powerdown modes on hardware that supports disabling hsync/vsync:
+ *      blank_mode == 2: suspend vsync
+ *      blank_mode == 3: suspend hsync
+ *      blank_mode == 4: powerdown
+ *
+ *      Returns negative errno on error, or zero on success.
+ */
+static int
+s1d13xxxfb_blank(int blank_mode, struct fb_info *info)
+{
+	struct s1d13xxxfb_par *par = info->par;
+
+	dbg("s1d13xxxfb_blank: blank=%d, info=%p\n", blank_mode, info);
+
+	switch (blank_mode) {
+		case FB_BLANK_UNBLANK:
+		case FB_BLANK_NORMAL:
+			if ((par->display & 0x01) != 0)
+				lcd_enable(par, 1);
+			if ((par->display & 0x02) != 0)
+				crt_enable(par, 1);
+			break;
+		case FB_BLANK_VSYNC_SUSPEND:
+		case FB_BLANK_HSYNC_SUSPEND:
+			break;
+		case FB_BLANK_POWERDOWN:
+			lcd_enable(par, 0);
+			crt_enable(par, 0);
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	/* let fbcon do a soft blank for us */
+	return ((blank_mode == FB_BLANK_NORMAL) ? 1 : 0);
+}
+
+/**
+ *      s1d13xxxfb_pan_display - Pans the display.
+ *      @var: frame buffer variable screen structure
+ *      @info: frame buffer structure that represents a single frame buffer
+ *
+ *	Pan (or wrap, depending on the `vmode' field) the display using the
+ *  	`yoffset' field of the `var' structure (`xoffset'  not yet supported).
+ *  	If the values don't fit, return -EINVAL.
+ *
+ *      Returns negative errno on error, or zero on success.
+ */
+static int
+s1d13xxxfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct s1d13xxxfb_par *par = info->par;
+	u32 start;
+
+	if (var->xoffset != 0)	/* not yet ... */
+		return -EINVAL;
+
+	if (var->yoffset + info->var.yres > info->var.yres_virtual)
+		return -EINVAL;
+
+	start = (info->fix.line_length >> 1) * var->yoffset;
+
+	if ((par->display & 0x01)) {
+		/* LCD */
+		s1d13xxxfb_writereg(par, S1DREG_LCD_DISP_START0, (start & 0xff));
+		s1d13xxxfb_writereg(par, S1DREG_LCD_DISP_START1, ((start >> 8) & 0xff));
+		s1d13xxxfb_writereg(par, S1DREG_LCD_DISP_START2, ((start >> 16) & 0x0f));
+	} else {
+		/* CRT */
+		s1d13xxxfb_writereg(par, S1DREG_CRT_DISP_START0, (start & 0xff));
+		s1d13xxxfb_writereg(par, S1DREG_CRT_DISP_START1, ((start >> 8) & 0xff));
+		s1d13xxxfb_writereg(par, S1DREG_CRT_DISP_START2, ((start >> 16) & 0x0f));
+	}
+
+	return 0;
+}
+
+
+/* framebuffer information structures */
+
+static struct fb_ops s1d13xxxfb_fbops = {
+	.owner		= THIS_MODULE,
+	.fb_set_par	= s1d13xxxfb_set_par,
+	.fb_setcolreg	= s1d13xxxfb_setcolreg,
+	.fb_blank	= s1d13xxxfb_blank,
+
+	.fb_pan_display	= s1d13xxxfb_pan_display,
+
+	/* to be replaced by any acceleration we can */
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_cursor	= soft_cursor
+};
+
+static int s1d13xxxfb_width_tab[2][4] __devinitdata = {
+	{4, 8, 16, -1},
+	{9, 12, 18, -1},
+};
+
+/**
+ *      s1d13xxxfb_fetch_hw_state - Configure the framebuffer according to
+ *	hardware setup.
+ *      @info: frame buffer structure
+ *
+ *	We setup the framebuffer structures according to the current
+ *	hardware setup. On some machines, the BIOS will have filled
+ *	the chip registers with such info, on others, these values will
+ *	have been written in some init procedure. In any case, the
+ *	software values needs to match the hardware ones. This is what
+ *	this function ensures.
+ *
+ *	Note: some of the hardcoded values here might need some love to
+ *	work on various chips, and might need to no longer be hardcoded.
+ */
+static void __devinit
+s1d13xxxfb_fetch_hw_state(struct fb_info *info)
+{
+	struct fb_var_screeninfo *var = &info->var;
+	struct fb_fix_screeninfo *fix = &info->fix;
+	struct s1d13xxxfb_par *par = info->par;
+	u8 panel, display;
+	u16 offset;
+	u32 xres, yres;
+	u32 xres_virtual, yres_virtual;
+	int bpp, lcd_bpp;
+	int is_color, is_dual, is_tft;
+	int lcd_enabled, crt_enabled;
+
+	fix->type = FB_TYPE_PACKED_PIXELS;
+
+	/* general info */
+	par->display = s1d13xxxfb_readreg(par, S1DREG_COM_DISP_MODE);
+	crt_enabled = (par->display & 0x02) != 0;
+	lcd_enabled = (par->display & 0x01) != 0;
+
+	if (lcd_enabled && crt_enabled)
+		printk(KERN_WARNING PFX "Warning: LCD and CRT detected, using LCD\n");
+
+	if (lcd_enabled)
+		display = s1d13xxxfb_readreg(par, S1DREG_LCD_DISP_MODE);
+	else	/* CRT */
+		display = s1d13xxxfb_readreg(par, S1DREG_CRT_DISP_MODE);
+
+	bpp = display & 0x07;
+
+	switch (bpp) {
+		case 2:	/* 4 bpp */
+		case 3:	/* 8 bpp */
+			var->bits_per_pixel = 8;
+			var->red.offset = var->green.offset = var->blue.offset = 0;
+			var->red.length = var->green.length = var->blue.length = 8;
+			break;
+		case 5:	/* 16 bpp */
+			s1d13xxxfb_setup_truecolour(info);
+			break;
+		default:
+			dbg("bpp: %i\n", bpp);
+	}
+	fb_alloc_cmap(&info->cmap, 256, 0);
+
+	/* LCD info */
+	panel = s1d13xxxfb_readreg(par, S1DREG_PANEL_TYPE);
+	is_color = (panel & 0x04) != 0;
+	is_dual = (panel & 0x02) != 0;
+	is_tft = (panel & 0x01) != 0;
+	lcd_bpp = s1d13xxxfb_width_tab[is_tft][(panel >> 4) & 3];
+
+	if (lcd_enabled) {
+		xres = (s1d13xxxfb_readreg(par, S1DREG_LCD_DISP_HWIDTH) + 1) * 8;
+		yres = (s1d13xxxfb_readreg(par, S1DREG_LCD_DISP_VHEIGHT0) +
+			((s1d13xxxfb_readreg(par, S1DREG_LCD_DISP_VHEIGHT1) & 0x03) << 8) + 1);
+
+		offset = (s1d13xxxfb_readreg(par, S1DREG_LCD_MEM_OFF0) +
+			((s1d13xxxfb_readreg(par, S1DREG_LCD_MEM_OFF1) & 0x7) << 8));
+	} else { /* crt */
+		xres = (s1d13xxxfb_readreg(par, S1DREG_CRT_DISP_HWIDTH) + 1) * 8;
+		yres = (s1d13xxxfb_readreg(par, S1DREG_CRT_DISP_VHEIGHT0) +
+			((s1d13xxxfb_readreg(par, S1DREG_CRT_DISP_VHEIGHT1) & 0x03) << 8) + 1);
+
+		offset = (s1d13xxxfb_readreg(par, S1DREG_CRT_MEM_OFF0) +
+			((s1d13xxxfb_readreg(par, S1DREG_CRT_MEM_OFF1) & 0x7) << 8));
+	}
+	xres_virtual = offset * 16 / var->bits_per_pixel;
+	yres_virtual = fix->smem_len / (offset * 2);
+
+	var->xres		= xres;
+	var->yres		= yres;
+	var->xres_virtual	= xres_virtual;
+	var->yres_virtual	= yres_virtual;
+	var->xoffset		= var->yoffset = 0;
+
+	fix->line_length	= offset * 2;
+
+	var->grayscale		= !is_color;
+
+	var->activate		= FB_ACTIVATE_NOW;
+
+	dbg(PFX "bpp=%d, lcd_bpp=%d, "
+		"crt_enabled=%d, lcd_enabled=%d\n",
+		var->bits_per_pixel, lcd_bpp, crt_enabled, lcd_enabled);
+	dbg(PFX "xres=%d, yres=%d, vxres=%d, vyres=%d "
+		"is_color=%d, is_dual=%d, is_tft=%d\n",
+		xres, yres, xres_virtual, yres_virtual, is_color, is_dual, is_tft);
+}
+
+
+static int __devexit
+s1d13xxxfb_remove(struct device *dev)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s1d13xxxfb_par *par = NULL;
+
+	if (info) {
+		par = info->par;
+		if (par && par->regs) {
+			/* disable output & enable powersave */
+			s1d13xxxfb_writereg(par, S1DREG_COM_DISP_MODE, 0x00);
+			s1d13xxxfb_writereg(par, S1DREG_PS_CNF, 0x11);
+			iounmap(par->regs);
+		}
+
+		fb_dealloc_cmap(&info->cmap);
+
+		if (info->screen_base)
+			iounmap(info->screen_base);
+
+		framebuffer_release(info);
+	}
+
+	release_mem_region(pdev->resource[0].start,
+			pdev->resource[0].end - pdev->resource[0].start +1);
+	release_mem_region(pdev->resource[1].start,
+			pdev->resource[1].end - pdev->resource[1].start +1);
+	return 0;
+}
+
+static int __devinit
+s1d13xxxfb_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s1d13xxxfb_par *default_par;
+	struct fb_info *info;
+	struct s1d13xxxfb_pdata *pdata = NULL;
+	int ret = 0;
+	u8 revision;
+
+	dbg("probe called: device is %p\n", dev);
+
+	printk(KERN_INFO "Epson S1D13XXX FB Driver\n");
+
+	/* enable platform-dependent hardware glue, if any */
+	if (dev->platform_data)
+		pdata = dev->platform_data;
+
+	if (pdata && pdata->platform_init_video)
+		pdata->platform_init_video();
+
+
+	if (pdev->num_resources != 2) {
+		dev_err(&pdev->dev, "invalid num_resources: %i\n",
+		       pdev->num_resources);
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	/* resource[0] is VRAM, resource[1] is registers */
+	if (pdev->resource[0].flags != IORESOURCE_MEM
+			|| pdev->resource[1].flags != IORESOURCE_MEM) {
+		dev_err(&pdev->dev, "invalid resource type\n");
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	if (!request_mem_region(pdev->resource[0].start,
+		pdev->resource[0].end - pdev->resource[0].start +1, "s1d13xxxfb mem")) {
+		dev_dbg(dev, "request_mem_region failed\n");
+		ret = -EBUSY;
+		goto bail;
+	}
+
+	if (!request_mem_region(pdev->resource[1].start,
+		pdev->resource[1].end - pdev->resource[1].start +1, "s1d13xxxfb regs")) {
+		dev_dbg(dev, "request_mem_region failed\n");
+		ret = -EBUSY;
+		goto bail;
+	}
+
+	info = framebuffer_alloc(sizeof(struct s1d13xxxfb_par) + sizeof(u32) * 256, &pdev->dev);
+	if (!info) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	default_par = info->par;
+	default_par->regs = ioremap_nocache(pdev->resource[1].start,
+			pdev->resource[1].end - pdev->resource[1].start +1);
+	if (!default_par->regs) {
+		printk(KERN_ERR PFX "unable to map registers\n");
+		ret = -ENOMEM;
+		goto bail;
+	}
+	info->pseudo_palette = default_par->pseudo_palette;
+
+	info->screen_base = ioremap_nocache(pdev->resource[0].start,
+			pdev->resource[0].end - pdev->resource[0].start +1);
+
+	if (!info->screen_base) {
+		printk(KERN_ERR PFX "unable to map framebuffer\n");
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	revision = s1d13xxxfb_readreg(default_par, S1DREG_REV_CODE);
+	if ((revision >> 2) != S1D_CHIP_REV) {
+		printk(KERN_INFO PFX "chip not found: %i\n", (revision >> 2));
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	info->fix = s1d13xxxfb_fix;
+	info->fix.mmio_start = pdev->resource[1].start;
+	info->fix.mmio_len = pdev->resource[1].end - pdev->resource[1].start +1;
+	info->fix.smem_start = pdev->resource[0].start;
+	info->fix.smem_len = pdev->resource[0].end - pdev->resource[0].start +1;
+
+	printk(KERN_INFO PFX "regs mapped at 0x%p, fb %d KiB mapped at 0x%p\n",
+	       default_par->regs, info->fix.smem_len / 1024, info->screen_base);
+
+	info->par = default_par;
+	info->fbops = &s1d13xxxfb_fbops;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+
+	/* perform "manual" chip initialization, if needed */
+	if (pdata && pdata->initregs)
+		s1d13xxxfb_runinit(info->par, pdata->initregs, pdata->initregssize);
+
+	s1d13xxxfb_fetch_hw_state(info);
+
+	if (register_framebuffer(info) < 0) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	dev_set_drvdata(&pdev->dev, info);
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+	       info->node, info->fix.id);
+
+	return 0;
+
+bail:
+	s1d13xxxfb_remove(dev);
+	return ret;
+
+}
+
+#ifdef CONFIG_PM
+static int s1d13xxxfb_suspend(struct device *dev, u32 state, u32 level)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct s1d13xxxfb_par *s1dfb = info->par;
+	struct s1d13xxxfb_pdata *pdata = NULL;
+
+	/* disable display */
+	lcd_enable(s1dfb, 0);
+	crt_enable(s1dfb, 0);
+
+	if (dev->platform_data)
+		pdata = dev->platform_data;
+
+#if 0
+	if (!s1dfb->disp_save)
+		s1dfb->disp_save = kmalloc(info->fix.smem_len, GFP_KERNEL);
+
+	if (!s1dfb->disp_save) {
+		printk(KERN_ERR PFX "no memory to save screen");
+		return -ENOMEM;
+	}
+
+	memcpy_fromio(s1dfb->disp_save, info->screen_base, info->fix.smem_len);
+#else
+	s1dfb->disp_save = NULL;
+#endif
+
+	if (!s1dfb->regs_save)
+		s1dfb->regs_save = kmalloc(info->fix.mmio_len, GFP_KERNEL);
+
+	if (!s1dfb->regs_save) {
+		printk(KERN_ERR PFX "no memory to save registers");
+		return -ENOMEM;
+	}
+
+	/* backup all registers */
+	memcpy_fromio(s1dfb->regs_save, s1dfb->regs, info->fix.mmio_len);
+
+	/* now activate power save mode */
+	s1d13xxxfb_writereg(s1dfb, S1DREG_PS_CNF, 0x11);
+
+	if (pdata && pdata->platform_suspend_video)
+		return pdata->platform_suspend_video();
+	else
+		return 0;
+}
+
+static int s1d13xxxfb_resume(struct device *dev, u32 level)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct s1d13xxxfb_par *s1dfb = info->par;
+	struct s1d13xxxfb_pdata *pdata = NULL;
+
+	if (level != RESUME_ENABLE)
+		return 0;
+
+	/* awaken the chip */
+	s1d13xxxfb_writereg(s1dfb, S1DREG_PS_CNF, 0x10);
+
+	/* do not let go until SDRAM "wakes up" */
+	while ((s1d13xxxfb_readreg(s1dfb, S1DREG_PS_STATUS) & 0x01))
+		udelay(10);
+
+	if (dev->platform_data)
+		pdata = dev->platform_data;
+
+	if (s1dfb->regs_save) {
+		/* will write RO regs, *should* get away with it :) */
+		memcpy_toio(s1dfb->regs, s1dfb->regs_save, info->fix.mmio_len);
+		kfree(s1dfb->regs_save);
+	}
+
+	if (s1dfb->disp_save) {
+		memcpy_toio(info->screen_base, s1dfb->disp_save,
+				info->fix.smem_len);
+		kfree(s1dfb->disp_save);	/* XXX kmalloc()'d when? */
+	}
+
+	if ((s1dfb->display & 0x01) != 0)
+		lcd_enable(s1dfb, 1);
+	if ((s1dfb->display & 0x02) != 0)
+		crt_enable(s1dfb, 1);
+
+	if (pdata && pdata->platform_resume_video)
+		return pdata->platform_resume_video();
+	else
+		return 0;
+}
+#endif /* CONFIG_PM */
+
+static struct device_driver s1d13xxxfb_driver = {
+	.name		= S1D_DEVICENAME,
+	.bus		= &platform_bus_type,
+	.probe		= s1d13xxxfb_probe,
+	.remove		= s1d13xxxfb_remove,
+#ifdef CONFIG_PM
+	.suspend	= s1d13xxxfb_suspend,
+	.resume		= s1d13xxxfb_resume
+#endif
+};
+
+
+static int __init
+s1d13xxxfb_init(void)
+{
+	if (fb_get_options("s1d13xxxfb", NULL))
+		return -ENODEV;
+
+	return driver_register(&s1d13xxxfb_driver);
+}
+
+
+static void __exit
+s1d13xxxfb_exit(void)
+{
+	driver_unregister(&s1d13xxxfb_driver);
+}
+
+module_init(s1d13xxxfb_init);
+module_exit(s1d13xxxfb_exit);
+
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Framebuffer driver for S1D13xxx devices");
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, Thibaut VARENE <varenet@parisc-linux.org>");
diff -Nru a/include/video/s1d13xxxfb.h b/include/video/s1d13xxxfb.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/video/s1d13xxxfb.h	2005-03-14 17:43:52 +08:00
@@ -0,0 +1,166 @@
+/* drivers/video/s1d3xxxfb.h
+ *
+ * (c) 2004 Simtec Electronics
+ * (c) 2005 Thibaut VARENE <varenet@parisc-linux.org>
+ *
+ * Header file for Epson S1D13XXX driver code
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ */
+
+#ifndef	S1D13XXXFB_H
+#define	S1D13XXXFB_H
+
+#define S1D_PALETTE_SIZE		256
+#define S1D_CHIP_REV			7	/* expected chip revision number for s1d13806 */
+#define S1D_FBID			"S1D13806"
+#define S1D_DEVICENAME			"s1d13806fb"
+
+/* register definitions (tested on s1d13896) */
+#define S1DREG_REV_CODE			0x0000	/* Revision Code Register */
+#define S1DREG_MISC			0x0001	/* Miscellaneous Register */
+#define S1DREG_GPIO_CNF0		0x0004	/* General IO Pins Configuration Register 0 */
+#define S1DREG_GPIO_CNF1		0x0005	/* General IO Pins Configuration Register 1 */
+#define S1DREG_GPIO_CTL0		0x0008	/* General IO Pins Control Register 0 */
+#define S1DREG_GPIO_CTL1		0x0009	/* General IO Pins Control Register 1 */
+#define S1DREG_CNF_STATUS		0x000C	/* Configuration Status Readback Register */
+#define S1DREG_CLK_CNF			0x0010	/* Memory Clock Configuration Register */
+#define S1DREG_LCD_CLK_CNF		0x0014	/* LCD Pixel Clock Configuration Register */
+#define S1DREG_CRT_CLK_CNF		0x0018	/* CRT/TV Pixel Clock Configuration Register */
+#define S1DREG_MPLUG_CLK_CNF		0x001C	/* MediaPlug Clock Configuration Register */
+#define S1DREG_CPU2MEM_WST_SEL		0x001E	/* CPU To Memory Wait State Select Register */
+#define S1DREG_MEM_CNF			0x0020	/* Memory Configuration Register */
+#define S1DREG_SDRAM_REF_RATE		0x0021	/* SDRAM Refresh Rate Register */
+#define S1DREG_SDRAM_TC0		0x002A	/* SDRAM Timing Control Register 0 */
+#define S1DREG_SDRAM_TC1		0x002B	/* SDRAM Timing Control Register 1 */
+#define S1DREG_PANEL_TYPE		0x0030	/* Panel Type Register */
+#define S1DREG_MOD_RATE			0x0031	/* MOD Rate Register */
+#define S1DREG_LCD_DISP_HWIDTH		0x0032	/* LCD Horizontal Display Width Register: ((val)+1)*8)=pix/line */
+#define S1DREG_LCD_NDISP_HPER		0x0034	/* LCD Horizontal Non-Display Period Register: ((val)+1)*8)=NDpix/line */
+#define S1DREG_TFT_FPLINE_START		0x0035	/* TFT FPLINE Start Position Register */
+#define S1DREG_TFT_FPLINE_PWIDTH	0x0036	/* TFT FPLINE Pulse Width Register. */
+#define S1DREG_LCD_DISP_VHEIGHT0	0x0038	/* LCD Vertical Display Height Register 0 */
+#define S1DREG_LCD_DISP_VHEIGHT1	0x0039	/* LCD Vertical Display Height Register 1 */
+#define S1DREG_LCD_NDISP_VPER		0x003A	/* LCD Vertical Non-Display Period Register: (val)+1=NDlines */
+#define S1DREG_TFT_FPFRAME_START	0x003B	/* TFT FPFRAME Start Position Register */
+#define S1DREG_TFT_FPFRAME_PWIDTH	0x003C	/* TFT FPFRAME Pulse Width Register */
+#define S1DREG_LCD_DISP_MODE		0x0040	/* LCD Display Mode Register */
+#define S1DREG_LCD_MISC			0x0041	/* LCD Miscellaneous Register */
+#define S1DREG_LCD_DISP_START0		0x0042	/* LCD Display Start Address Register 0 */
+#define S1DREG_LCD_DISP_START1		0x0043	/* LCD Display Start Address Register 1 */
+#define S1DREG_LCD_DISP_START2		0x0044	/* LCD Display Start Address Register 2 */
+#define S1DREG_LCD_MEM_OFF0		0x0046	/* LCD Memory Address Offset Register 0 */
+#define S1DREG_LCD_MEM_OFF1		0x0047	/* LCD Memory Address Offset Register 1 */
+#define S1DREG_LCD_PIX_PAN		0x0048	/* LCD Pixel Panning Register */
+#define S1DREG_LCD_DISP_FIFO_HTC	0x004A	/* LCD Display FIFO High Threshold Control Register */
+#define S1DREG_LCD_DISP_FIFO_LTC	0x004B	/* LCD Display FIFO Low Threshold Control Register */
+#define S1DREG_CRT_DISP_HWIDTH		0x0050	/* CRT/TV Horizontal Display Width Register: ((val)+1)*8)=pix/line */
+#define S1DREG_CRT_NDISP_HPER		0x0052	/* CRT/TV Horizontal Non-Display Period Register */
+#define S1DREG_CRT_HRTC_START		0x0053	/* CRT/TV HRTC Start Position Register */
+#define S1DREG_CRT_HRTC_PWIDTH		0x0054	/* CRT/TV HRTC Pulse Width Register */
+#define S1DREG_CRT_DISP_VHEIGHT0	0x0056	/* CRT/TV Vertical Display Height Register 0 */
+#define S1DREG_CRT_DISP_VHEIGHT1	0x0057	/* CRT/TV Vertical Display Height Register 1 */
+#define S1DREG_CRT_NDISP_VPER		0x0058	/* CRT/TV Vertical Non-Display Period Register */
+#define S1DREG_CRT_VRTC_START		0x0059	/* CRT/TV VRTC Start Position Register */
+#define S1DREG_CRT_VRTC_PWIDTH		0x005A	/* CRT/TV VRTC Pulse Width Register */
+#define S1DREG_TV_OUT_CTL		0x005B	/* TV Output Control Register */
+#define S1DREG_CRT_DISP_MODE		0x0060	/* CRT/TV Display Mode Register */
+#define S1DREG_CRT_DISP_START0		0x0062	/* CRT/TV Display Start Address Register 0 */
+#define S1DREG_CRT_DISP_START1		0x0063	/* CRT/TV Display Start Address Register 1 */
+#define S1DREG_CRT_DISP_START2		0x0064	/* CRT/TV Display Start Address Register 2 */
+#define S1DREG_CRT_MEM_OFF0		0x0066	/* CRT/TV Memory Address Offset Register 0 */
+#define S1DREG_CRT_MEM_OFF1		0x0067	/* CRT/TV Memory Address Offset Register 1 */
+#define S1DREG_CRT_PIX_PAN		0x0068	/* CRT/TV Pixel Panning Register */
+#define S1DREG_CRT_DISP_FIFO_HTC	0x006A	/* CRT/TV Display FIFO High Threshold Control Register */
+#define S1DREG_CRT_DISP_FIFO_LTC	0x006B	/* CRT/TV Display FIFO Low Threshold Control Register */
+#define S1DREG_LCD_CUR_CTL		0x0070	/* LCD Ink/Cursor Control Register */
+#define S1DREG_LCD_CUR_START		0x0071	/* LCD Ink/Cursor Start Address Register */
+#define S1DREG_LCD_CUR_XPOS0		0x0072	/* LCD Cursor X Position Register 0 */
+#define S1DREG_LCD_CUR_XPOS1		0x0073	/* LCD Cursor X Position Register 1 */
+#define S1DREG_LCD_CUR_YPOS0		0x0074	/* LCD Cursor Y Position Register 0 */
+#define S1DREG_LCD_CUR_YPOS1		0x0075	/* LCD Cursor Y Position Register 1 */
+#define S1DREG_LCD_CUR_BCTL0		0x0076	/* LCD Ink/Cursor Blue Color 0 Register */
+#define S1DREG_LCD_CUR_GCTL0		0x0077	/* LCD Ink/Cursor Green Color 0 Register */
+#define S1DREG_LCD_CUR_RCTL0		0x0078	/* LCD Ink/Cursor Red Color 0 Register */
+#define S1DREG_LCD_CUR_BCTL1		0x007A	/* LCD Ink/Cursor Blue Color 1 Register */
+#define S1DREG_LCD_CUR_GCTL1		0x007B	/* LCD Ink/Cursor Green Color 1 Register */
+#define S1DREG_LCD_CUR_RCTL1		0x007C	/* LCD Ink/Cursor Red Color 1 Register */
+#define S1DREG_LCD_CUR_FIFO_HTC		0x007E	/* LCD Ink/Cursor FIFO High Threshold Register */
+#define S1DREG_CRT_CUR_CTL		0x0080	/* CRT/TV Ink/Cursor Control Register */
+#define S1DREG_CRT_CUR_START		0x0081	/* CRT/TV Ink/Cursor Start Address Register */
+#define S1DREG_CRT_CUR_XPOS0		0x0082	/* CRT/TV Cursor X Position Register 0 */
+#define S1DREG_CRT_CUR_XPOS1		0x0083	/* CRT/TV Cursor X Position Register 1 */
+#define S1DREG_CRT_CUR_YPOS0		0x0084	/* CRT/TV Cursor Y Position Register 0 */
+#define S1DREG_CRT_CUR_YPOS1		0x0085	/* CRT/TV Cursor Y Position Register 1 */
+#define S1DREG_CRT_CUR_BCTL0		0x0086	/* CRT/TV Ink/Cursor Blue Color 0 Register */
+#define S1DREG_CRT_CUR_GCTL0		0x0087	/* CRT/TV Ink/Cursor Green Color 0 Register */
+#define S1DREG_CRT_CUR_RCTL0		0x0088	/* CRT/TV Ink/Cursor Red Color 0 Register */
+#define S1DREG_CRT_CUR_BCTL1		0x008A	/* CRT/TV Ink/Cursor Blue Color 1 Register */
+#define S1DREG_CRT_CUR_GCTL1		0x008B	/* CRT/TV Ink/Cursor Green Color 1 Register */
+#define S1DREG_CRT_CUR_RCTL1		0x008C	/* CRT/TV Ink/Cursor Red Color 1 Register */
+#define S1DREG_CRT_CUR_FIFO_HTC		0x008E	/* CRT/TV Ink/Cursor FIFO High Threshold Register */
+#define S1DREG_BBLT_CTL0		0x0100	/* BitBLT Control Register 0 */
+#define S1DREG_BBLT_CTL1		0x0101	/* BitBLT Control Register 1 */
+#define S1DREG_BBLT_CC_EXP		0x0102	/* BitBLT Code/Color Expansion Register */
+#define S1DREG_BBLT_OP			0x0103	/* BitBLT Operation Register */
+#define S1DREG_BBLT_SRC_START0		0x0104	/* BitBLT Source Start Address Register 0 */
+#define S1DREG_BBLT_SRC_START1		0x0105	/* BitBLT Source Start Address Register 1 */
+#define S1DREG_BBLT_SRC_START2		0x0106	/* BitBLT Source Start Address Register 2 */
+#define S1DREG_BBLT_DST_START0		0x0108	/* BitBLT Destination Start Address Register 0 */
+#define S1DREG_BBLT_DST_START1		0x0109	/* BitBLT Destination Start Address Register 1 */
+#define S1DREG_BBLT_DST_START2		0x010A	/* BitBLT Destination Start Address Register 2 */
+#define S1DREG_BBLT_MEM_OFF0		0x010C	/* BitBLT Memory Address Offset Register 0 */
+#define S1DREG_BBLT_MEM_OFF1		0x010D	/* BitBLT Memory Address Offset Register 1 */
+#define S1DREG_BBLT_WIDTH0		0x0110	/* BitBLT Width Register 0 */
+#define S1DREG_BBLT_WIDTH1		0x0111	/* BitBLT Width Register 1 */
+#define S1DREG_BBLT_HEIGHT0		0x0112	/* BitBLT Height Register 0 */
+#define S1DREG_BBLT_HEIGHT1		0x0113	/* BitBLT Height Register 1 */
+#define S1DREG_BBLT_BGC0		0x0114	/* BitBLT Background Color Register 0 */
+#define S1DREG_BBLT_BGC1		0x0115	/* BitBLT Background Color Register 1 */
+#define S1DREG_BBLT_FGC0		0x0118	/* BitBLT Foreground Color Register 0 */
+#define S1DREG_BBLT_FGC1		0x0119	/* BitBLT Foreground Color Register 1 */
+#define S1DREG_LKUP_MODE		0x01E0	/* Look-Up Table Mode Register */
+#define S1DREG_LKUP_ADDR		0x01E2	/* Look-Up Table Address Register */
+#define S1DREG_LKUP_DATA		0x01E4	/* Look-Up Table Data Register */
+#define S1DREG_PS_CNF			0x01F0	/* Power Save Configuration Register */
+#define S1DREG_PS_STATUS		0x01F1	/* Power Save Status Register */
+#define S1DREG_CPU2MEM_WDOGT		0x01F4	/* CPU-to-Memory Access Watchdog Timer Register */
+#define S1DREG_COM_DISP_MODE		0x01FC	/* Common Display Mode Register */
+
+#define S1DREG_DELAYOFF			0xFFFE
+#define S1DREG_DELAYON			0xFFFF
+
+/* Note: all above defines should go in separate header files
+   when implementing other S1D13xxx chip support. */
+
+struct s1d13xxxfb_regval {
+	u16	addr;
+	u8	value;
+};
+
+
+struct s1d13xxxfb_par {
+	void __iomem	*regs;
+	unsigned char	display;
+
+	unsigned int	pseudo_palette[16];
+#ifdef CONFIG_PM
+	void		*regs_save;	/* pm saves all registers here */
+	void		*disp_save;	/* pm saves entire screen here */
+#endif
+};
+
+struct s1d13xxxfb_pdata {
+	const struct s1d13xxxfb_regval	*initregs;
+	const unsigned int		initregssize;
+	void				(*platform_init_video)(void);
+#ifdef CONFIG_PM
+	int				(*platform_suspend_video)(void);
+	int				(*platform_resume_video)(void);
+#endif
+};
+
+#endif
+




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
