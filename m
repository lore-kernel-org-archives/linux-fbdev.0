From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Subject: [PATCH v2 4/4] video: sh7760fb: SH7760/SH7763
 LCDC framebuffer driver's document
Date: Thu, 26 Jun 2008 14:44:26 +0900
Message-ID: <48632CBA.8000707@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KBkHc-0003iF-AT for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jun 2008 22:44:36 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail04.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KBkHZ-0002X0-OA
	for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jun 2008 22:44:36 -0700
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
To: linuc-fbdev <Linux-fbdev-devel@lists.sourceforge.net>
Cc: Paul Mundt <lethal@linux-sh.org>, Linux-sh <linux-sh@vger.kernel.org>

Document for the LCDC interface on the SH7760 and SH7763 SoCs.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 Documentation/fb/sh7760fb.txt |  129 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/fb/sh7760fb.txt

diff --git a/Documentation/fb/sh7760fb.txt b/Documentation/fb/sh7760fb.txt
new file mode 100644
index 0000000..b8bf844
--- /dev/null
+++ b/Documentation/fb/sh7760fb.txt
@@ -0,0 +1,129 @@
+SH7760 integrated LCDC Framebuffer driver
+=========================================
+
+0. Overwiew
+-----------
+The SH7760/SH7763 have an integrated LCD Display controller (LCDC) which
+supports (in theory) resolutions ranging from 1x1 to 1024x1024,
+with color depths ranging from 1 to 16 bit.
+Supports STN, DSTN and TFT Panels.
+
+* Framebuffer memory must be a large chunk allocated at the top
+  of Area3 (HW requirement). Because of this requirement you should NOT
+  make the driver a module since at runtime it may become impossible to
+  get a large enough contiguous chunk of memory.
+
+* The driver does not support changing resolution while loaded
+  (LCD's aren't hotpluggable anyway)
+
+* Heavy flickering may be observed
+  a) if you're using 15/16bit color modes at >= 640x480 px resolutions,
+  b) during PCMCIA (or any other slow bus) activity.
+
+* Rotation works only 90degress clockwise, and only if horizontal
+  resolution is <= 320 pixels.
+
+files:   drivers/video/sh7760fb.c
+	 include/asm-sh/sh7760fb.h
+	 Documentation/fb/sh7760fb.txt
+
+1. Platform setup
+-----------------
+Video data is fetched via the DMABRG DMA engine, so you have to
+configure the SH DMAC for DMABRG mode (write 0x94808080 to the
+DMARSRA register somewhere at boot).
+
+PFC registers PCCR and PCDR must be set to peripheral mode.
+(write zeros to both).
+
+The driver does NOT do the above for you (since board setup is, well, job
+of the board setup code).
+
+2. Panel definitions
+--------------------
+The LCDC must explicitly be told about the type of LCD panel
+attached. Data must be wrapped in a "struct sh7760fb_platdata" and
+passed to the driver as platform_data.
+
+Suggest you take a closer look at the SH7760 Manual, Section 30.
+(http://documentation.renesas.com/eng/products/mpumcu/e602291_sh7760.pdf)
+
+The following code illustrates what needs to be done to
+get the framebuffer working on a 640x480 TFT:
+
+====================== cut here ======================================
+
+#include <linux/fb.h>
+#include <asm/sh7760fb.h>
+
+/*
+ * NEC NL6440bc26-01 640x480 TFT
+ * dotclock 25175 kHz
+ * Xres		640	Yres		480
+ * Htotal	800	Vtotal		525
+ * HsynStart	656	VsynStart	490
+ * HsynLenn	30	VsynLenn	2
+ *
+ * The linux framebuffer layer does not use the syncstart/synclen
+ * values but right/left/upper/lower margin values. The comments
+ * for the x_margin explain how to calculate those from given
+ * panel sync timings.
+ */
+static struct fb_videomode nl6448bc26 = {
+/*	.name		= "NL6448BC26",*/
+/*	.refresh	= 60,	*/
+	.xres		= 640,
+	.yres		= 480,
+	.pixclock	= 39683,	/* in picoseconds! */
+	.hsync_len	= 30,
+	.vsync_len	= 2,
+	.left_margin	= 114,	/* HTOT - (HSYNSLEN + HSYNSTART) */
+	.right_margin	= 16,	/* HSYNSTART - XRES */
+	.upper_margin	= 33,	/* VTOT - (VSYNLEN + VSYNSTART) */
+	.lower_margin	= 10,	/* VSYNSTART - YRES */
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	.vmode		= FB_VMODE_NONINTERLACED,
+	.flag		= 0,
+};
+
+static struct sh7760fb_platdata sh7760fb_nl6448 = {
+	.def_mode	= &nl6448bc26,
+	.ldmtr		= LDMTR_TFT_COLOR_16,	/* 16bit TFT panel */
+	.lddfr		= LDDFR_8BPP,		/* we want 8bit output */
+	.ldpmmr		= 0x0070,
+	.ldpspr		= 0x0500,
+	.ldaclnr	= 0,
+	.ldickr		= LDICKR_CLKSRC(LCDC_CLKSRC_EXTERNAL) |
+			  LDICKR_CLKDIV(1),
+	.rotate		= 0,
+	.novsync	= 1,
+	.blank		= NULL,
+};
+
+/* 0xFE300800: 256 * 4byte xRGB palette ram
+ * 0xFE300C00: 42 bytes ctrl registers
+ */
+static struct resource sh7760_lcdc_res[] = {
+	[0] = {
+		.start	= 0xFE300800,
+		.end	= 0xFE300CFF,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 65,
+		.end	= 65,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sh7760_lcdc_dev = {
+	.dev	= {
+		.platform_data = &sh7760fb_nl6448,
+	},
+	.name		= "sh7760-lcdc",
+	.id		= -1,
+	.resource	= sh7760_lcdc_res,
+	.num_resources	= ARRAY_SIZE(sh7760_lcdc_res),
+};
+
+====================== cut here ======================================
-- 
1.5.5.1


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
