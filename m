From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH] pxafb: add support for overlay1 and
	overlay2 as framebuffer devices
Date: Tue, 23 Dec 2008 18:47:32 +0800
Message-ID: <f17812d70812230247l78bd6010v4fd6c94e49523175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LF4na-0002Cj-2B
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 10:47:38 +0000
Received: from rv-out-0708.google.com ([209.85.198.248])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LF4nW-0004Xf-HX for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 10:47:38 +0000
Received: by rv-out-0708.google.com with SMTP id f25so2253771rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 23 Dec 2008 02:47:33 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

PXA27x and later processors support overlay1 and overlay2 on-top of the
base framebuffer (although under-neath the base is also possible). They
support palette and no-palette RGB formats, as well as YUV formats (only
available on overlay2). These overlays have dedicated DMA channels and
behave in a similar way as a framebuffer.

This heavily simplified and re-structured work is based on the original
pxafb_overlay.c (which is pending for mainline merge for a long time).

The major problems with this pxafb_overlay.c are (if you are interested
in the history):

  1. heavily redundant (the control logics for overlay1 and overlay2 are
     actually identical except for some small operations,  which are now
     abstracted into a 'pxafb_layer_ops' structure)

  2. a lot of useless and un-tested code (two workarounds which are now
     fixed on mature silicons)

  3. cursorfb is actually useless, hardware cursor should not be used
     this way, and the code was actually un-tested for a long time.

The code in this patch should be self-explanatory, I tried to add minimum
comments. As said, this is basically simplified, there are several things
still on the pending list:

  1. palette mode is un-supported and un-tested (although re-using the
     palette code of the base framebuffer is actually very easy now with
     previous clean-up patches)

  2. fb_pan_display for overlay(s) is un-supported

  3. the base framebuffer can actually be abstracted by 'pxafb_layer' as
     well, which will help further re-use of the code and keep a better
     and consistent structure. (This is the reason I named it 'pxafb_layer'
     instead of 'pxafb_overlay' or something alike)

See Documentation/fb/pxafb.txt for additional usage information.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
Cc: Rodolfo Giometti <giometti@linux.it>
---
 Documentation/fb/pxafb.txt                |   84 +++++++
 arch/arm/mach-pxa/include/mach/regs-lcd.h |   34 ++-
 drivers/video/Kconfig                     |    5 +
 drivers/video/pxafb.c                     |  364 ++++++++++++++++++++++++++++-
 drivers/video/pxafb.h                     |   45 ++++
 5 files changed, 516 insertions(+), 16 deletions(-)

diff --git a/Documentation/fb/pxafb.txt b/Documentation/fb/pxafb.txt
index ad94b5c..0916140 100644
--- a/Documentation/fb/pxafb.txt
+++ b/Documentation/fb/pxafb.txt
@@ -56,3 +56,87 @@ outputen:POLARITY
 pixclockpol:POLARITY
 	pixel clock polarity
 	0 => falling edge, 1 => rising edge
+
+
+Overlay Support for PXA27x and later LCD controllers
+====================================================
+
+  PXA27x and later processors support overlay1 and overlay2 on-top of the
+  base framebuffer (although under-neath the base is also possible). They
+  support palette and no-palette RGB formats, as well as YUV formats (only
+  available on overlay2). These overlays have dedicated DMA channels and
+  behave in a similar way as a framebuffer.
+
+  However, there are some differences between these overlay framebuffers
+  and normal framebuffers, as listed below:
+
+  1. overlay can start at a 32-bit word aligned position within the base
+     framebuffer, which means they have a start (x, y). This information
+     is encoded into var->nonstd (no, var->xoffset and var->yoffset are
+     not for such purpose).
+
+  2. overlay framebuffer is allocated dynamically according to specified
+     'struct fb_var_screeninfo', the amount is decided by:
+
+        var->xres_virtual * var->yres_virtual * bpp
+
+     bpp = 16 -- for RGB565 or RGBT555
+         = 24 -- for YUV444 packed
+         = 24 -- for YUV444 planar
+	 = 16 -- for YUV422 planar (1 pixel = 1 Y + 1/2 Cb + 1/2 Cr)
+	 = 12 -- for YUV420 planar (1 pixel = 1 Y + 1/4 Cb + 1/4 Cr)
+
+     NOTE:
+
+     a. overlay does not support panning in x-direction, thus
+        var->xres_virtual will always be equal to var->xres
+
+     b. line length of overlay(s) must be on a 32-bit word boundary,
+        for YUV planar modes, it is a requirement for the component
+	with minimum bits per pixel,  e.g. for YUV420, Cr component
+	for one pixel is actually 2-bits, it means the line length
+	should be a multiple of 16-pixels
+
+     c. starting horizontal position (XPOS) should start on a 32-bit
+        word boundary, otherwise the fb_check_var() will just fail.
+
+     d. the rectangle of the overlay should be within the base plane,
+        otherwise fail
+
+     Applications should follow the sequence below to operate an overlay
+     framebuffer:
+
+         a. open("/dev/fb[1-2]", ...)
+	 b. ioctl(fd, FBIOGET_VSCREENINFO, ...)
+	 c. modify 'var' with desired parameters:
+	    1) var->xres and var->yres
+	    2) larger var->yres_virtual if more memory is required,
+	       usually for double-buffering
+	    3) var->nonstd for starting (x, y) and color format
+	    4) var->{red, green, blue, transp} if RGB mode is to be used
+	 d. ioctl(fd, FBIOPUT_VSCREENINFO, ...)
+	 e. ioctl(fd, FBIOGET_FSCREENINFO, ...)
+	 f. mmap
+	 g. ...
+
+  3. for YUV planar formats, these are actually not supported within the
+     framebuffer framework, application has to take care of the offsets
+     and lengths of each component within the framebuffer.
+
+  4. var->nonstd is used to pass starting (x, y) position and color format,
+     the detailed bit fields are shown below:
+
+    31                23  20         10          0
+     +-----------------+---+----------+----------+
+     |  ... unused ... |FOR|   XPOS   |   YPOS   |
+     +-----------------+---+----------+----------+
+
+     FOR  - color format, as defined by OVERLAY_FORMAT_* in pxafb.h
+            0 - RGB
+	    1 - YUV444 PACKED
+	    2 - YUV444 PLANAR
+	    3 - YUV422 PLANAR
+	    4 - YUR420 PLANAR
+
+     XPOS - starting horizontal position
+     YPOS - starting vertical position
diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h
b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index aff3b87..f82dcea 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -12,7 +12,8 @@
 #define LCCR3		(0x00C)	/* LCD Controller Control Register 3 */
 #define LCCR4		(0x010)	/* LCD Controller Control Register 4 */
 #define LCCR5		(0x014)	/* LCD Controller Control Register 5 */
-#define LCSR		(0x038)	/* LCD Controller Status Register */
+#define LCSR		(0x038)	/* LCD Controller Status Register 0 */
+#define LCSR1		(0x034)	/* LCD Controller Status Register 1 */
 #define LIIDR		(0x03C)	/* LCD Controller Interrupt ID Register */
 #define TMEDRGBR	(0x040)	/* TMED RGB Seed Register */
 #define TMEDCR		(0x044)	/* TMED Control Register */
@@ -25,6 +26,11 @@
 #define FBR5		(0x110) /* DMA Channel 2 Frame Branch Register */
 #define FBR6		(0x114) /* DMA Channel 2 Frame Branch Register */

+#define OVL1C1		(0x050)	/* Overlay 1 Control Register 1 */
+#define OVL1C2		(0x060)	/* Overlay 1 Control Register 2 */
+#define OVL2C1		(0x070)	/* Overlay 2 Control Register 1 */
+#define OVL2C2		(0x080)	/* Overlay 2 Control Register 2 */
+
 #define CMDCR		(0x100)	/* Command Control Register */
 #define PRSR		(0x104)	/* Panel Read Status Register */

@@ -42,16 +48,12 @@
 #define LCCR4_PAL_FOR_MASK	(3 << 15)

 #define FDADR0		(0x200)	/* DMA Channel 0 Frame Descriptor Address Register */
-#define FSADR0		(0x204)	/* DMA Channel 0 Frame Source Address Register */
-#define FIDR0		(0x208)	/* DMA Channel 0 Frame ID Register */
-#define LDCMD0		(0x20C)	/* DMA Channel 0 Command Register */
 #define FDADR1		(0x210)	/* DMA Channel 1 Frame Descriptor Address Register */
-#define FSADR1		(0x214)	/* DMA Channel 1 Frame Source Address Register */
-#define FIDR1		(0x218)	/* DMA Channel 1 Frame ID Register */
-#define LDCMD1		(0x21C)	/* DMA Channel 1 Command Register */
+#define FDADR2		(0x220)	/* DMA Channel 2 Frame Descriptor Address Register */
+#define FDADR3		(0x230)	/* DMA Channel 3 Frame Descriptor Address Register */
+#define FDADR4		(0x240)	/* DMA Channel 4 Frame Descriptor Address Register */
+#define FDADR5		(0x250)	/* DMA Channel 5 Frame Descriptor Address Register */
 #define FDADR6		(0x260) /* DMA Channel 6 Frame Descriptor Address Register */
-#define FSADR6		(0x264) /* DMA Channel 6 Frame Source Address Register */
-#define FIDR6		(0x268) /* DMA Channel 6 Frame ID Register */

 #define LCCR0_ENB	(1 << 0)	/* LCD Controller enable */
 #define LCCR0_CMS	(1 << 1)	/* Color/Monochrome Display Select */
@@ -151,8 +153,22 @@
 #define LCSR_RD_ST	(1 << 11)	/* read status */
 #define LCSR_CMD_INT	(1 << 12)	/* command interrupt */

+#define LCSR1_IU(x)	(1 << ((x) + 23)) /* Input FIFO underrun */
+#define LCSR1_BS(x)	(1 << ((x) + 15)) /* Branch Status */
+#define LCSR1_EOF(x)	(1 << ((x) + 7))  /* End of Frame Status */
+#define LCSR1_SOF(x)	(1 << ((x) - 1))  /* Start of Frame Status */
+
 #define LDCMD_PAL	(1 << 26)	/* instructs DMA to load palette buffer */

+/* overlay control registers */
+#define OVLxC1_PPL(x)	((((x) - 1) & 0x3ff) << 0)	/* Pixels Per Line */
+#define OVLxC1_LPO(x)	((((x) - 1) & 0x3ff) << 10)	/* Number of Lines */
+#define OVLxC1_BPP(x)	(((x) & 0xf) << 20)	/* Bits Per Pixel */
+#define OVLxC1_OEN	(1 << 31)		/* Enable bit for Overlay */
+#define OVLxC2_XPOS(x)	(((x) & 0x3ff) << 0)	/* Horizontal Position */
+#define OVLxC2_YPOS(x)	(((x) & 0x3ff) << 10)	/* Vertical Position */
+#define OVL2C2_PFOR(x)	(((x) & 0x7) << 20)	/* Pixel Format */
+
 /* smartpanel related */
 #define PRSR_DATA(x)	((x) & 0xff)	/* Panel Data */
 #define PRSR_A0		(1 << 8)	/* Read Data Source */
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3f3ce13..486d81c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1817,6 +1817,11 @@ config FB_PXA

 	  If unsure, say N.

+config FB_PXA_OVERLAY
+	bool "Support PXA27x/PXA3xx Overlay(s) as framebuffer"
+	default n
+	depends on FB_PXA && (PXA27x || PXA3xx)
+
 config FB_PXA_SMARTPANEL
 	bool "PXA Smartpanel LCD support"
 	default n
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 7935706..3a41ea1 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -20,6 +20,16 @@
  *
  *	linux-arm-kernel@lists.arm.linux.org.uk
  *
+ * Add support for overlay1 and overlay2 based on pxafb_overlay.c:
+ *
+ *   Copyright (C) 2004, Intel Corporation
+ *
+ *     2003/08/27: <yu.tang@intel.com>
+ *     2004/03/10: <stanley.cai@intel.com>
+ *     2004/10/28: <yan.yin@intel.com>
+ *
+ *   Copyright (C) 2006-2008 Marvell International Ltd.
+ *   All Rights Reserved
  */

 #include <linux/module.h>
@@ -72,6 +82,8 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 				struct pxafb_info *);
 static void set_ctrlr_state(struct pxafb_info *fbi, u_int state);
 static void setup_base_frame(struct pxafb_info *fbi, int branch);
+static int setup_frame_dma(struct pxafb_info *fbi, int dma, int pal,
+			   unsigned long offset, size_t size);

 static unsigned long video_mem_size = 0;

@@ -581,6 +593,330 @@ static struct fb_ops pxafb_ops = {
 	.fb_blank	= pxafb_blank,
 };

+#ifdef CONFIG_FB_PXA_OVERLAY
+static void overlay1fb_setup(struct pxafb_layer *ofb)
+{
+	int size = ofb->fb.fix.line_length * ofb->fb.var.yres_virtual;
+	unsigned long start = ofb->video_mem_phys;
+	setup_frame_dma(ofb->fbi, DMA_OV1, PAL_NONE, start, size);
+}
+
+/* Depending on the enable status of overlay1/2, the DMA should be
+ * updated from FDADRx (when disabled) or FBRx (when enabled).
+ */
+static void overlay1fb_enable(struct pxafb_layer *ofb)
+{
+	int enabled = lcd_readl(ofb->fbi, OVL1C1) & OVLxC1_OEN;
+	uint32_t fdadr1 = ofb->fbi->fdadr[DMA_OV1] | (enabled ? 0x1 : 0);
+
+	lcd_writel(ofb->fbi, enabled ? FBR1 : FDADR1, fdadr1);
+	lcd_writel(ofb->fbi, OVL1C2, ofb->control[1]);
+	lcd_writel(ofb->fbi, OVL1C1, ofb->control[0] | OVLxC1_OEN);
+}
+
+static void overlay1fb_disable(struct pxafb_layer *ofb)
+{
+	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
+
+	lcd_writel(ofb->fbi, OVL1C1, ofb->control[0] & ~OVLxC1_OEN);
+
+	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(1));
+	lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(1));
+	lcd_writel(ofb->fbi, FBR1, ofb->fbi->fdadr[DMA_OV1] | 0x3);
+
+	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) == 0)
+		pr_warning("%s: timeout disabling overlay1\n", __func__);
+
+	lcd_writel(ofb->fbi, LCCR5, lccr5);
+}
+
+static void overlay2fb_setup(struct pxafb_layer *ofb)
+{
+	int size, div = 1, pfor = NONSTD_TO_PFOR(ofb->fb.var.nonstd);
+	unsigned long start[3] = { ofb->video_mem_phys, 0, 0 };
+
+	if (pfor == OVERLAY_FORMAT_RGB || pfor == OVERLAY_FORMAT_YUV444_PACKED) {
+		size = ofb->fb.fix.line_length * ofb->fb.var.yres_virtual;
+		setup_frame_dma(ofb->fbi, DMA_OV2_Y, -1, start[0], size);
+	} else {
+		size = ofb->fb.var.xres_virtual * ofb->fb.var.yres_virtual;
+		switch (pfor) {
+		case OVERLAY_FORMAT_YUV444_PLANAR: div = 1; break;
+		case OVERLAY_FORMAT_YUV422_PLANAR: div = 2; break;
+		case OVERLAY_FORMAT_YUV420_PLANAR: div = 4; break;
+		}
+		start[1] = start[0] + size;
+		start[2] = start[1] + size / div;
+		setup_frame_dma(ofb->fbi, DMA_OV2_Y,  -1, start[0], size);
+		setup_frame_dma(ofb->fbi, DMA_OV2_Cb, -1, start[1], size / div);
+		setup_frame_dma(ofb->fbi, DMA_OV2_Cr, -1, start[2], size / div);
+	}
+}
+
+static void overlay2fb_enable(struct pxafb_layer *ofb)
+{
+	int pfor = NONSTD_TO_PFOR(ofb->fb.var.nonstd);
+	int enabled = lcd_readl(ofb->fbi, OVL2C1) & OVLxC1_OEN;
+	uint32_t fdadr2 = ofb->fbi->fdadr[DMA_OV2_Y]  | (enabled ? 0x1 : 0);
+	uint32_t fdadr3 = ofb->fbi->fdadr[DMA_OV2_Cb] | (enabled ? 0x1 : 0);
+	uint32_t fdadr4 = ofb->fbi->fdadr[DMA_OV2_Cr] | (enabled ? 0x1 : 0);
+
+	if (pfor == OVERLAY_FORMAT_RGB || pfor == OVERLAY_FORMAT_YUV444_PACKED)
+		lcd_writel(ofb->fbi, enabled ? FBR2 : FDADR2, fdadr2);
+	else {
+		lcd_writel(ofb->fbi, enabled ? FBR2 : FDADR2, fdadr2);
+		lcd_writel(ofb->fbi, enabled ? FBR3 : FDADR3, fdadr3);
+		lcd_writel(ofb->fbi, enabled ? FBR4 : FDADR4, fdadr4);
+	}
+	lcd_writel(ofb->fbi, OVL2C2, ofb->control[1]);
+	lcd_writel(ofb->fbi, OVL2C1, ofb->control[0] | OVLxC1_OEN);
+}
+
+static void overlay2fb_disable(struct pxafb_layer *ofb)
+{
+	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
+
+	lcd_writel(ofb->fbi, OVL2C1, ofb->control[0] & ~OVLxC1_OEN);
+
+	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(2));
+	lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(2));
+	lcd_writel(ofb->fbi, FBR2, ofb->fbi->fdadr[DMA_OV2_Y]  | 0x3);
+	lcd_writel(ofb->fbi, FBR3, ofb->fbi->fdadr[DMA_OV2_Cb] | 0x3);
+	lcd_writel(ofb->fbi, FBR4, ofb->fbi->fdadr[DMA_OV2_Cr] | 0x3);
+
+	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) == 0)
+		pr_warning("%s: timeout disabling overlay2\n", __func__);
+}
+
+static struct pxafb_layer_ops ofb_ops[] = {
+	[0] = {
+		.enable		= overlay1fb_enable,
+		.disable	= overlay1fb_disable,
+		.setup		= overlay1fb_setup,
+	},
+	[1] = {
+		.enable		= overlay2fb_enable,
+		.disable	= overlay2fb_disable,
+		.setup		= overlay2fb_setup,
+	},
+};
+
+static int overlayfb_open(struct fb_info *info, int user)
+{
+	struct pxafb_layer *ofb = (struct pxafb_layer *)info;
+
+	/* no support for framebuffer console on overlay */
+	if (user == 0)
+		return -ENODEV;
+
+	/* allow only one user at a time */
+	if (atomic_inc_and_test(&ofb->usage))
+		return -EBUSY;
+
+	/* unblank the base framebuffer */
+	fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
+	return 0;
+}
+
+static int overlayfb_release(struct fb_info *info, int user)
+{
+	struct pxafb_layer *ofb = (struct pxafb_layer*) info;
+
+	atomic_dec(&ofb->usage);
+	ofb->ops->disable(ofb);
+
+	free_pages_exact(ofb->video_mem, ofb->video_mem_size);
+	ofb->video_mem = NULL;
+	ofb->video_mem_size = 0;
+	return 0;
+}
+
+static int overlayfb_check_var(struct fb_var_screeninfo *var,
+			       struct fb_info *info)
+{
+	struct pxafb_layer *ofb = (struct pxafb_layer *)info;
+	struct fb_var_screeninfo *base_var = &ofb->fbi->fb.var;
+	int xpos, ypos, pfor, bpp;
+
+	xpos = NONSTD_TO_XPOS(var->nonstd);
+	ypos = NONSTD_TO_XPOS(var->nonstd);
+	pfor = NONSTD_TO_PFOR(var->nonstd);
+
+	bpp = pxafb_var_to_bpp(var);
+	if (bpp < 0)
+		return -EINVAL;
+
+	/* no support for YUV format on overlay1 */
+	if (ofb->id == OVERLAY1 && pfor != 0)
+		return -EINVAL;
+
+	/* for YUV packed formats, bpp = 'minimum bpp of YUV components' */
+	switch (pfor) {
+	case OVERLAY_FORMAT_RGB:
+		bpp = pxafb_var_to_bpp(var);
+		if (bpp < 0)
+			return -EINVAL;
+
+		pxafb_set_pixfmt(var, var_to_depth(var));
+		break;
+	case OVERLAY_FORMAT_YUV444_PACKED: bpp = 24; break;
+	case OVERLAY_FORMAT_YUV444_PLANAR: bpp = 8; break;
+	case OVERLAY_FORMAT_YUV422_PLANAR: bpp = 4; break;
+	case OVERLAY_FORMAT_YUV420_PLANAR: bpp = 2; break;
+	default:
+		return -EINVAL;
+	}
+
+	/* each line must start at a 32-bit word boundary */
+	if ((xpos * bpp) % 32)
+		return -EINVAL;
+
+	/* xres must align on 32-bit word boundary */
+	var->xres = roundup(var->xres * bpp, 32) / bpp;
+
+	if ((xpos + var->xres > base_var->xres) ||
+	    (ypos + var->yres > base_var->yres))
+		return -EINVAL;
+
+	var->xres_virtual = var->xres;
+	var->yres_virtual = max(var->yres, var->yres_virtual);
+	return 0;
+}
+
+static int overlayfb_map_video_memory(struct pxafb_layer *ofb)
+{
+	struct fb_var_screeninfo *var = &ofb->fb.var;
+	int pfor = NONSTD_TO_PFOR(var->nonstd);
+	int size, bpp = 0;
+
+	switch (pfor) {
+	case OVERLAY_FORMAT_RGB: bpp = var->bits_per_pixel; break;
+	case OVERLAY_FORMAT_YUV444_PACKED: bpp = 24; break;
+	case OVERLAY_FORMAT_YUV444_PLANAR: bpp = 24; break;
+	case OVERLAY_FORMAT_YUV422_PLANAR: bpp = 16; break;
+	case OVERLAY_FORMAT_YUV420_PLANAR: bpp = 12; break;
+	}
+
+	ofb->fb.fix.line_length = var->xres_virtual * bpp / 8;
+
+	size = PAGE_ALIGN(ofb->fb.fix.line_length * var->yres_virtual);
+
+	/* don't re-allocate if the original video memory is enough */
+	if (ofb->video_mem) {
+		if (ofb->video_mem_size >= size)
+			return 0;
+
+		free_pages_exact(ofb->video_mem, ofb->video_mem_size);
+	}
+
+	ofb->video_mem = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
+	if (ofb->video_mem == NULL)
+		return -ENOMEM;
+
+	ofb->video_mem_phys = virt_to_phys(ofb->video_mem);
+	ofb->video_mem_size = size;
+
+	ofb->fb.fix.smem_start	= ofb->video_mem_phys;
+	ofb->fb.fix.smem_len	= ofb->fb.fix.line_length * var->yres_virtual;
+	ofb->fb.screen_base	= ofb->video_mem;
+	return 0;
+}
+
+static int overlayfb_set_par(struct fb_info *info)
+{
+	struct pxafb_layer *ofb = (struct pxafb_layer *)info;
+	struct fb_var_screeninfo *var = &info->var;
+	int xpos, ypos, pfor, bpp, ret;
+
+	ret = overlayfb_map_video_memory(ofb);
+	if (ret)
+		return ret;
+
+	bpp  = pxafb_var_to_bpp(var);
+	xpos = NONSTD_TO_XPOS(var->nonstd);
+	ypos = NONSTD_TO_XPOS(var->nonstd);
+	pfor = NONSTD_TO_PFOR(var->nonstd);
+
+	ofb->control[0] = OVLxC1_PPL(var->xres) | OVLxC1_LPO(var->yres) |
+			  OVLxC1_BPP(bpp);
+	ofb->control[1] = OVLxC2_XPOS(xpos) | OVLxC2_YPOS(ypos);
+
+	if (ofb->id == OVERLAY2)
+		ofb->control[1] |= OVL2C2_PFOR(pfor);
+
+	ofb->ops->setup(ofb);
+	ofb->ops->enable(ofb);
+	return 0;
+}
+
+static struct fb_ops overlay_fb_ops = {
+	.owner			= THIS_MODULE,
+	.fb_open		= overlayfb_open,
+	.fb_release		= overlayfb_release,
+	.fb_check_var 		= overlayfb_check_var,
+	.fb_set_par		= overlayfb_set_par,
+};
+
+static void __devinit init_pxafb_overlay(struct pxafb_info *fbi,
+					 struct pxafb_layer *ofb, int id)
+{
+	sprintf(ofb->fb.fix.id, "overlay%d", id + 1);
+
+	ofb->fb.fix.type		= FB_TYPE_PACKED_PIXELS;
+	ofb->fb.fix.xpanstep		= 0;
+	ofb->fb.fix.ypanstep		= 1;
+
+	ofb->fb.var.activate		= FB_ACTIVATE_NOW;
+	ofb->fb.var.height		= -1;
+	ofb->fb.var.width		= -1;
+	ofb->fb.var.vmode		= FB_VMODE_NONINTERLACED;
+
+	ofb->fb.fbops			= &overlay_fb_ops;
+	ofb->fb.flags			= FBINFO_FLAG_DEFAULT;
+	ofb->fb.node			= -1;
+	ofb->fb.pseudo_palette		= NULL;
+
+	ofb->id = id;
+	ofb->ops = &ofb_ops[id];
+	atomic_set(&ofb->usage, 0);
+	ofb->fbi = fbi;
+	init_completion(&ofb->branch_done);
+}
+
+static int __devinit pxafb_overlay_init(struct pxafb_info *fbi)
+{
+	int i, ret;
+
+	for (i = 0; i < 2; i++) {
+		init_pxafb_overlay(fbi, &fbi->overlay[i], i);
+		ret = register_framebuffer(&fbi->overlay[i].fb);
+		if (ret) {
+			dev_err(fbi->dev, "failed to register overlay %d\n", i);
+			return ret;
+		}
+	}
+
+	/* mask all IU/BS/EOF/SOF interrupts */
+	lcd_writel(fbi, LCCR5, ~0);
+
+	/* place overlay(s) on top of base */
+	fbi->lccr0 |= LCCR0_OUC;
+	pr_info("PXA Overlay driver loaded successfully!\n");
+	return 0;
+}
+
+static void __devexit pxafb_overlay_exit(struct pxafb_info *fbi)
+{
+	int i;
+
+	for (i = 0; i < 2; i++)
+		unregister_framebuffer(&fbi->overlay[i].fb);
+}
+#else
+static inline void pxafb_overlay_init(struct pxafb_info *fbi) {}
+static inline void pxafb_overlay_exit(struct pxafb_info *fbi) {}
+#endif /* CONFIG_FB_PXA_OVERLAY */
+
 /*
  * Calculate the PCD value from the clock rate (in picoseconds).
  * We take account of the PPCR clock setting.
@@ -660,7 +996,7 @@ unsigned long pxafb_get_hsync_time(struct device *dev)
 EXPORT_SYMBOL(pxafb_get_hsync_time);

 static int setup_frame_dma(struct pxafb_info *fbi, int dma, int pal,
-		unsigned int offset, size_t size)
+			   unsigned long start, size_t size)
 {
 	struct pxafb_dma_descriptor *dma_desc, *pal_desc;
 	unsigned int dma_desc_off, pal_desc_off;
@@ -671,7 +1007,7 @@ static int setup_frame_dma(struct pxafb_info
*fbi, int dma, int pal,
 	dma_desc = &fbi->dma_buff->dma_desc[dma];
 	dma_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[dma]);

-	dma_desc->fsadr = fbi->video_mem_phys + offset;
+	dma_desc->fsadr = start;
 	dma_desc->fidr  = 0;
 	dma_desc->ldcmd = size;

@@ -705,14 +1041,14 @@ static void setup_base_frame(struct pxafb_info
*fbi, int branch)
 {
 	struct fb_var_screeninfo *var = &fbi->fb.var;
 	struct fb_fix_screeninfo *fix = &fbi->fb.fix;
-	unsigned int nbytes, offset;
-	int dma, pal, bpp = var->bits_per_pixel;
+	int nbytes, dma, pal, bpp = var->bits_per_pixel;
+	unsigned long offset;

 	dma = DMA_BASE + (branch ? DMA_MAX : 0);
 	pal = (bpp >= 16) ? PAL_NONE : PAL_BASE + (branch ? PAL_MAX : 0);

 	nbytes = fix->line_length * var->yres;
-	offset = fix->line_length * var->yoffset;
+	offset = fix->line_length * var->yoffset + fbi->video_mem_phys;

 	if (fbi->lccr0 & LCCR0_SDS) {
 		nbytes = nbytes / 2;
@@ -1090,8 +1426,9 @@ static void pxafb_disable_controller(struct
pxafb_info *fbi)
 static irqreturn_t pxafb_handle_irq(int irq, void *dev_id)
 {
 	struct pxafb_info *fbi = dev_id;
-	unsigned int lccr0, lcsr = lcd_readl(fbi, LCSR);
+	unsigned int lccr0, lcsr, lcsr1;

+	lcsr = lcd_readl(fbi, LCSR);
 	if (lcsr & LCSR_LDD) {
 		lccr0 = lcd_readl(fbi, LCCR0);
 		lcd_writel(fbi, LCCR0, lccr0 | LCCR0_LDM);
@@ -1102,8 +1439,18 @@ static irqreturn_t pxafb_handle_irq(int irq,
void *dev_id)
 	if (lcsr & LCSR_CMD_INT)
 		complete(&fbi->command_done);
 #endif
-
 	lcd_writel(fbi, LCSR, lcsr);
+
+#ifdef CONFIG_FB_PXA_OVERLAY
+	lcsr1 = lcd_readl(fbi, LCSR1);
+	if (lcsr1 & LCSR1_BS(1))
+		complete(&fbi->overlay[0].branch_done);
+
+	if (lcsr1 & LCSR1_BS(2))
+		complete(&fbi->overlay[1].branch_done);
+
+	lcd_writel(fbi, LCSR1, lcsr1);
+#endif
 	return IRQ_HANDLED;
 }

@@ -1802,6 +2149,8 @@ static int __devinit pxafb_probe(struct
platform_device *dev)
 		goto failed_free_cmap;
 	}

+	pxafb_overlay_init(fbi);
+
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = pxafb_freq_transition;
 	fbi->freq_policy.notifier_call = pxafb_freq_policy;
@@ -1852,6 +2201,7 @@ static int __devexit pxafb_remove(struct
platform_device *dev)

 	info = &fbi->fb;

+	pxafb_overlay_exit(fbi);
 	unregister_framebuffer(info);

 	pxafb_disable_controller(fbi);
diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index ae3cbc1..2353521 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -64,6 +64,47 @@ struct pxafb_dma_buff {
 	struct pxafb_dma_descriptor dma_desc[DMA_MAX * 2];
 };

+enum {
+	OVERLAY1,
+	OVERLAY2,
+};
+
+enum {
+	OVERLAY_FORMAT_RGB = 0,
+	OVERLAY_FORMAT_YUV444_PACKED,
+	OVERLAY_FORMAT_YUV444_PLANAR,
+	OVERLAY_FORMAT_YUV422_PLANAR,
+	OVERLAY_FORMAT_YUV420_PLANAR,
+};
+
+#define NONSTD_TO_XPOS(x)	(((x) >> 0)  & 0x3ff)
+#define NONSTD_TO_YPOS(x)	(((x) >> 10) & 0x3ff)
+#define NONSTD_TO_PFOR(x)	(((x) >> 20) & 0x7)
+
+struct pxafb_layer;
+
+struct pxafb_layer_ops {
+	void (*enable)(struct pxafb_layer *);
+	void (*disable)(struct pxafb_layer *);
+	void (*setup)(struct pxafb_layer *);
+};
+
+struct pxafb_layer {
+	struct fb_info		fb;
+	int			id;
+	atomic_t		usage;
+	uint32_t		control[2];
+
+	struct pxafb_layer_ops	*ops;
+
+	void __iomem		*video_mem;
+	unsigned long		video_mem_phys;
+	size_t			video_mem_size;
+	struct completion	branch_done;
+
+	struct pxafb_info	*fbi;
+};
+
 struct pxafb_info {
 	struct fb_info		fb;
 	struct device		*dev;
@@ -114,6 +155,10 @@ struct pxafb_info {
 	struct task_struct	*smart_thread;
 #endif

+#ifdef CONFIG_FB_PXA_OVERLAY
+	struct pxafb_layer	overlay[2];
+#endif
+
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 	struct notifier_block	freq_policy;
-- 
1.6.0.4

------------------------------------------------------------------------------
