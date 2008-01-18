From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] atmel_lcdfb: backlight control
Date: Fri, 18 Jan 2008 15:44:35 +0100
Message-ID: <4790BB53.3080407@atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFsTT-0003GB-Fs for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 06:45:39 -0800
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JFsTQ-0008W9-Ic
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 06:45:39 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: David Brownell <david-b@pacbell.net>, Andrew Victor <linux@maxim.org.za>, ARM Linux Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>

From: David Brownell <dbrownell@users.sourceforge.net>

On the sam9 EK boards, the LCD backlight is hooked up to a PWM output
from the LCD controller.  It's controlled by "contrast" registers though.

This patch lets boards declare that they have that kind of backlight
control.  The driver can then export this control, letting screenblank
and other operations actually take effect ... reducing the typically
substantial power drain from the backlight.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Note that it's not fully cooked
  - doesn't force backlight off during system suspend
  - the "power" and "blank" events may not be done right

This should be easily added in the future.

 arch/arm/mach-at91/board-sam9261ek.c |    1 
 arch/arm/mach-at91/board-sam9263ek.c |    1 
 drivers/video/atmel_lcdfb.c          |  114 +++++++++++++++++++++++++++++++++--
 drivers/video/backlight/Kconfig      |   13 +++
 include/video/atmel_lcdc.h           |   11 ++-
 5 files changed, 134 insertions(+), 6 deletions(-)

--- linux-2.6-snapshot.orig/arch/arm/mach-at91/board-sam9261ek.c
+++ linux-2.6-snapshot/arch/arm/mach-at91/board-sam9261ek.c
@@ -322,6 +322,7 @@ static void at91_lcdc_power_control(int 
 
 /* Driver datas */
 static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
+	.lcdcon_is_backlight		= true,
 	.default_bpp			= 16,
 	.default_dmacon			= ATMEL_LCDC_DMAEN,
 	.default_lcdcon2		= AT91SAM9261_DEFAULT_LCDCON2,
--- linux-2.6-snapshot.orig/arch/arm/mach-at91/board-sam9263ek.c
+++ linux-2.6-snapshot/arch/arm/mach-at91/board-sam9263ek.c
@@ -250,6 +250,7 @@ static void at91_lcdc_power_control(int 
 
 /* Driver datas */
 static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
+	.lcdcon_is_backlight		= true,
 	.default_bpp			= 16,
 	.default_dmacon			= ATMEL_LCDC_DMAEN,
 	.default_lcdcon2		= AT91SAM9263_DEFAULT_LCDCON2,
--- linux-2.6-snapshot.orig/drivers/video/atmel_lcdfb.c
+++ linux-2.6-snapshot/drivers/video/atmel_lcdfb.c
@@ -16,6 +16,7 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/backlight.h>
 
 #include <asm/arch/board.h>
 #include <asm/arch/cpu.h>
@@ -69,6 +70,107 @@ static void atmel_lcdfb_update_dma2d(str
 }
 #endif
 
+static const u32 contrast_ctr = ATMEL_LCDC_PS_DIV8
+		| ATMEL_LCDC_POL_POSITIVE
+		| ATMEL_LCDC_ENA_PWMENABLE;
+
+#ifdef CONFIG_BACKLIGHT_ATMEL_LCDC
+
+/* some bl->props field just changed */
+static int atmel_bl_update_status(struct backlight_device *bl)
+{
+	struct atmel_lcdfb_info *sinfo = bl_get_data(bl);
+	int			power = sinfo->bl_power;
+	int			brightness = bl->props.brightness;
+
+	/* REVISIT there may be a meaningful difference between
+	 * fb_blank and power ... there seem to be some cases
+	 * this doesn't handle correctly.
+	 */
+	if (bl->props.fb_blank != sinfo->bl_power)
+		power = bl->props.fb_blank;
+	else if (bl->props.power != sinfo->bl_power)
+		power = bl->props.power;
+
+	if (brightness < 0 && power == FB_BLANK_UNBLANK)
+		brightness = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
+	else if (power != FB_BLANK_UNBLANK)
+		brightness = 0;
+
+	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, brightness);
+	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR,
+			brightness ? contrast_ctr : 0);
+
+	bl->props.fb_blank = bl->props.power = sinfo->bl_power = power;
+
+	return 0;
+}
+
+static int atmel_bl_get_brightness(struct backlight_device *bl)
+{
+	struct atmel_lcdfb_info *sinfo = bl_get_data(bl);
+
+	return lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
+}
+
+static struct backlight_ops atmel_lcdc_bl_ops = {
+	.update_status = atmel_bl_update_status,
+	.get_brightness = atmel_bl_get_brightness,
+};
+
+static inline void init_backlight(struct atmel_lcdfb_info *sinfo)
+{
+	struct backlight_device	*bl;
+
+	sinfo->bl_power = FB_BLANK_UNBLANK;
+
+	if (sinfo->backlight)
+		return;
+
+	bl = backlight_device_register("backlight", &sinfo->pdev->dev,
+			sinfo, &atmel_lcdc_bl_ops);
+	if (IS_ERR(sinfo->backlight)) {
+		dev_err(&sinfo->pdev->dev, "error %ld on backlight register\n",
+				PTR_ERR(bl));
+		return;
+	}
+	sinfo->backlight = bl;
+
+	bl->props.power = FB_BLANK_UNBLANK;
+	bl->props.fb_blank = FB_BLANK_UNBLANK;
+	bl->props.max_brightness = 0xff;
+	bl->props.brightness = atmel_bl_get_brightness(bl);
+}
+
+static inline void exit_contrast(struct atmel_lcdfb_info *sinfo)
+{
+	if (sinfo->backlight)
+		backlight_device_unregister(sinfo->backlight);
+}
+
+#else
+
+static inline void init_backlight(struct atmel_lcdfb_info *sinfo)
+{
+	dev_warn(&sinfo->pdev->dev, "backlight control is not available\n");
+}
+
+static inline void exit_contrast(struct atmel_lcdfb_info *sinfo)
+{
+}
+
+#endif
+
+static inline void init_contrast(struct atmel_lcdfb_info *sinfo)
+{
+	/* have some default contrast/backlight settings */
+	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
+	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, ATMEL_LCDC_CVAL_DEFAULT);
+
+	if (sinfo->lcdcon_is_backlight)
+		init_backlight(sinfo);
+}
+
 
 static struct fb_fix_screeninfo atmel_lcdfb_fix __initdata = {
 	.type		= FB_TYPE_PACKED_PIXELS,
@@ -370,10 +472,6 @@ static int atmel_lcdfb_set_par(struct fb
 	/* Disable all interrupts */
 	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
 
-	/* Set contrast */
-	value = ATMEL_LCDC_PS_DIV8 | ATMEL_LCDC_POL_POSITIVE | ATMEL_LCDC_ENA_PWMENABLE;
-	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, value);
-	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, ATMEL_LCDC_CVAL_DEFAULT);
 	/* ...wait for DMA engine to become idle... */
 	while (lcdc_readl(sinfo, ATMEL_LCDC_DMACON) & ATMEL_LCDC_DMABUSY)
 		msleep(10);
@@ -577,6 +675,7 @@ static int __init atmel_lcdfb_probe(stru
 		sinfo->default_monspecs = pdata_sinfo->default_monspecs;
 		sinfo->atmel_lcdfb_power_control = pdata_sinfo->atmel_lcdfb_power_control;
 		sinfo->guard_time = pdata_sinfo->guard_time;
+		sinfo->lcdcon_is_backlight = pdata_sinfo->lcdcon_is_backlight;
 	} else {
 		dev_err(dev, "cannot get default configuration\n");
 		goto free_info;
@@ -670,6 +769,9 @@ static int __init atmel_lcdfb_probe(stru
 		goto release_mem;
 	}
 
+	/* Initialize PWM for contrast or backlight ("off") */
+	init_contrast(sinfo);
+
 	/* interrupt */
 	ret = request_irq(sinfo->irq_base, atmel_lcdfb_interrupt, 0, pdev->name, info);
 	if (ret) {
@@ -755,6 +857,7 @@ static int __exit atmel_lcdfb_remove(str
 	if (!sinfo)
 		return 0;
 
+	exit_contrast(sinfo);
 	if (sinfo->atmel_lcdfb_power_control)
 		sinfo->atmel_lcdfb_power_control(0);
 	unregister_framebuffer(info);
@@ -781,6 +884,9 @@ static int __exit atmel_lcdfb_remove(str
 
 static struct platform_driver atmel_lcdfb_driver = {
 	.remove		= __exit_p(atmel_lcdfb_remove),
+
+// FIXME need suspend, resume
+
 	.driver		= {
 		.name	= "atmel_lcdfb",
 		.owner	= THIS_MODULE,
--- linux-2.6-snapshot.orig/drivers/video/backlight/Kconfig
+++ linux-2.6-snapshot/drivers/video/backlight/Kconfig
@@ -50,6 +50,19 @@ config BACKLIGHT_CLASS_DEVICE
 	  To have support for your specific LCD panel you will have to
 	  select the proper drivers which depend on this option.
 
+config BACKLIGHT_ATMEL_LCDC
+	bool "Atmel LCDC Contrast-as-Backlight control"
+	depends on BACKLIGHT_CLASS_DEVICE && FB_ATMEL
+	default y if MACH_SAM9261EK || MACH_SAM9263EK
+	help
+	  This provides a backlight control internal to the Atmel LCDC
+	  driver.  If the LCD "contrast control" on your board is wired
+	  so it controls the backlight brightness, select this option to
+	  export this as a PWM-based backlight control.
+
+	  If in doubt, it's safe to enable this option; it doesn't kick
+	  in unless the board's description says it's wired that way.
+
 config BACKLIGHT_CORGI
 	tristate "Generic (aka Sharp Corgi) Backlight Driver"
 	depends on BACKLIGHT_CLASS_DEVICE
--- linux-2.6-snapshot.orig/include/video/atmel_lcdc.h
+++ linux-2.6-snapshot/include/video/atmel_lcdc.h
@@ -22,7 +22,7 @@
 #ifndef __ATMEL_LCDC_H__
 #define __ATMEL_LCDC_H__
 
- /* LCD Controller info data structure */
+ /* LCD Controller info data structure, stored in device platform_data */
 struct atmel_lcdfb_info {
 	spinlock_t		lock;
 	struct fb_info		*info;
@@ -33,7 +33,14 @@ struct atmel_lcdfb_info {
 	struct platform_device	*pdev;
 	struct clk		*bus_clk;
 	struct clk		*lcdc_clk;
-	unsigned int		default_bpp;
+
+#ifdef CONFIG_BACKLIGHT_ATMEL_LCDC
+	struct backlight_device	*backlight;
+	u8			bl_power;
+#endif
+	bool			lcdcon_is_backlight;
+
+	u8			default_bpp;
 	unsigned int		default_lcdcon2;
 	unsigned int		default_dmacon;
 	void (*atmel_lcdfb_power_control)(int on);



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
