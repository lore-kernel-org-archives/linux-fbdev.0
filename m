From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Subject: [PATCH] atmel_lcdfb: Fix STN LCD support
Date: Fri, 15 Jun 2007 10:50:12 +0200
Message-ID: <467252C4.50203@rfo.atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hz7WU-0004hx-Jl for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 01:51:17 -0700
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hz7WT-0003nI-O2
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 01:51:14 -0700
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: Patrice Vilchez <patrice.vilchez@rfo.atmel.com>, Andrew Victor <andrew@sanpeople.com>, Linux Kernel list <linux-kernel@vger.kernel.org>

From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>

Fixes STN LCD support for the atmel_lcdfb framebuffer driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
---

This patch is the result of a work from Jan Altenberg and has 
been tested on a Hitachi SP06Q002 on at91sam9261ek.

It adds a Kconfig switch that enables the proper LCD in the 
board configuration file (STN or TFT).

This patch includes the "Fix wrong line_length calculation" 
little one from Jan and Haavard (submitted earlier).

AT91 platform informations are directly submitted trough
the at91 maintainer and follow in a [RFC] message.

drivers/video/Kconfig       |   10 +++++
drivers/video/atmel_lcdfb.c |   62 +++++++++++++++++++++++++++++-----
2 files changed, 64 insertions(+), 8 deletions(-)

Index: b/drivers/video/atmel_lcdfb.c
===================================================================
--- a/drivers/video/atmel_lcdfb.c	2007-06-13 10:55:42.000000000 +0200
+++ b/drivers/video/atmel_lcdfb.c	2007-06-15 10:25:06.000000000 +0200
@@ -79,6 +79,29 @@
 	.accel		= FB_ACCEL_NONE,
 };
 
+static unsigned long compute_hozval(unsigned long xres, unsigned long lcdcon2)
+{
+	unsigned long value;
+
+	if (!(cpu_is_at91sam9261() || cpu_is_at32ap7000()))
+		return xres;
+
+	value = xres;
+	if ((lcdcon2 & ATMEL_LCDC_DISTYPE) != ATMEL_LCDC_DISTYPE_TFT) {
+		/* STN display */
+		if ((lcdcon2 & ATMEL_LCDC_DISTYPE) == ATMEL_LCDC_DISTYPE_STNCOLOR) {
+			value *= 3;
+		}
+		if ( (lcdcon2 & ATMEL_LCDC_IFWIDTH) == ATMEL_LCDC_IFWIDTH_4
+		   || ( (lcdcon2 & ATMEL_LCDC_IFWIDTH) == ATMEL_LCDC_IFWIDTH_8
+		      && (lcdcon2 & ATMEL_LCDC_SCANMOD) == ATMEL_LCDC_SCANMOD_DUAL ))
+			value = DIV_ROUND_UP(value, 4);
+		else
+			value = DIV_ROUND_UP(value, 8);
+	}
+
+	return value;
+}
 
 static void atmel_lcdfb_update_dma(struct fb_info *info,
 			       struct fb_var_screeninfo *var)
@@ -181,6 +204,7 @@
 	var->xoffset = var->yoffset = 0;
 
 	switch (var->bits_per_pixel) {
+	case 1:
 	case 2:
 	case 4:
 	case 8:
@@ -228,8 +252,10 @@
 static int atmel_lcdfb_set_par(struct fb_info *info)
 {
 	struct atmel_lcdfb_info *sinfo = info->par;
+	unsigned long hozval_linesz;
 	unsigned long value;
 	unsigned long clk_value_khz;
+	unsigned long bits_per_line;
 
 	dev_dbg(info->device, "%s:\n", __func__);
 	dev_dbg(info->device, "  * resolution: %ux%u (%ux%u virtual)\n",
@@ -241,12 +267,15 @@
 
 	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, 0);
 
-	if (info->var.bits_per_pixel <= 8)
+	if (info->var.bits_per_pixel == 1)
+		info->fix.visual = FB_VISUAL_MONO01;
+	else if (info->var.bits_per_pixel <= 8)
 		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 	else
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
 
-	info->fix.line_length = info->var.xres_virtual * (info->var.bits_per_pixel / 8);
+	bits_per_line = info->var.xres_virtual * info->var.bits_per_pixel;
+	info->fix.line_length = DIV_ROUND_UP(bits_per_line, 8);
 
 	/* Re-initialize the DMA engine... */
 	dev_dbg(info->device, "  * update DMA engine\n");
@@ -262,18 +291,21 @@
 	/* Set pixel clock */
 	clk_value_khz = clk_get_rate(sinfo->lcdc_clk) / 1000;
 
-	value = clk_value_khz / PICOS2KHZ(info->var.pixclock);
-
-	if (clk_value_khz % PICOS2KHZ(info->var.pixclock))
-		value++;
+	value = DIV_ROUND_UP(clk_value_khz, PICOS2KHZ(info->var.pixclock));
 
 	value = (value / 2) - 1;
+	dev_dbg(info->device, "  * programming CLKVAL = 0x%08lx\n", value);
 
 	if (value <= 0) {
 		dev_notice(info->device, "Bypassing pixel clock divider\n");
 		lcdc_writel(sinfo, ATMEL_LCDC_LCDCON1, ATMEL_LCDC_BYPASS);
-	} else
+	} else {
 		lcdc_writel(sinfo, ATMEL_LCDC_LCDCON1, value << ATMEL_LCDC_CLKVAL_OFFSET);
+		info->var.pixclock = KHZ2PICOS(clk_value_khz / (2 * (value + 1)));
+		dev_dbg(info->device, "  updated pixclk:     %lu KHz\n",
+					PICOS2KHZ(info->var.pixclock));
+	}
+
 
 	/* Initialize control register 2 */
 	value = sinfo->default_lcdcon2;
@@ -311,9 +343,14 @@
 	dev_dbg(info->device, "  * LCDTIM2 = %08lx\n", value);
 	lcdc_writel(sinfo, ATMEL_LCDC_TIM2, value);
 
+	/* Horizontal value (aka line size) */
+	hozval_linesz = compute_hozval(info->var.xres,
+					lcdc_readl(sinfo, ATMEL_LCDC_LCDCON2));
+
 	/* Display size */
-	value = (info->var.xres - 1) << ATMEL_LCDC_HOZVAL_OFFSET;
+	value = (hozval_linesz - 1) << ATMEL_LCDC_HOZVAL_OFFSET;
 	value |= info->var.yres - 1;
+	dev_dbg(info->device, "  * LCDFRMCFG = %08lx\n", value);
 	lcdc_writel(sinfo, ATMEL_LCDC_LCDFRMCFG, value);
 
 	/* FIFO Threshold: Use formula from data sheet */
@@ -421,6 +458,15 @@
 			ret = 0;
 		}
 		break;
+
+	case FB_VISUAL_MONO01:
+		if (regno < 2) {
+			val = (regno == 0) ? 0x00 : 0x1F;
+			lcdc_writel(sinfo, ATMEL_LCDC_LUT(regno), val);
+			ret = 0;
+		}
+		break;
+
 	}
 
 	return ret;
Index: b/drivers/video/Kconfig
===================================================================
--- a/drivers/video/Kconfig	2007-05-14 11:02:16.000000000 +0200
+++ b/drivers/video/Kconfig	2007-06-13 11:04:10.000000000 +0200
@@ -701,6 +701,16 @@
 	  Say Y if you want to map Frame Buffer in internal SRAM. Say N if you want
 	  to let frame buffer in external SDRAM.
 
+config FB_ATMEL_STN
+	bool "Use a STN display with AT91/AT32 LCD Controller"
+	depends on FB_ATMEL && ARCH_AT91SAM9261
+	default n
+	help
+	  Say Y if you want to connect a STN LCD display to the AT91/AT32 LCD
+	  Controller. Say N if you want to connect a TFT.
+
+	  If unsure, say N.
+
 config FB_NVIDIA
 	tristate "nVidia Framebuffer Support"
 	depends on FB && PCI

-- 
Nicolas Ferre



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
