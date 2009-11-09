From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] mx3fb: adds LCD backlight driver
Date: Mon,  9 Nov 2009 12:13:16 +0100
Message-ID: <1257765196-32124-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <agust@denx.de>) id 1N7SBf-0003Rb-PZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Nov 2009 11:13:31 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N7SBY-0002qX-3e for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Nov 2009 11:13:31 +0000
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 1C76A1C15524
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  9 Nov 2009 12:13:17 +0100 (CET)
Received: from localhost (p57931F06.dip.t-dialin.net [87.147.31.6])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTP id B2D8B90275
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  9 Nov 2009 12:13:16 +0100 (CET)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

To activate this driver select CONFIG_BACKLIGHT_LCD_SUPPORT
in the kernel configuration. Backlight control interface
will be available under /sys/class/backlight/mx3fb/.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mx3fb.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 99 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 86312dd..f8f9338 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -30,6 +30,7 @@
 #include <mach/hardware.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
+#include <linux/backlight.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -60,6 +61,12 @@
 #define SDC_COM_BG_EN		0x00000200UL
 #define SDC_COM_SHARP		0x00001000UL
 
+#define SDC_PWM_SRC_HSYNC_CLK	0x00000000UL
+#define SDC_PWM_SRC_PXL_CLK	0x02000000UL
+#define SDC_PWM_SRC_HSP_CLK	0x04000000UL
+#define SDC_PWM_CC_EN		0x01000000UL
+#define SDC_PWM_PWM_MSK		0x00FF0000UL
+
 #define SDC_V_SYNC_WIDTH_L	0x00000001UL
 
 /* Display Interface registers */
@@ -238,6 +245,7 @@ static const struct fb_videomode mx3fb_modedb[] = {
 struct mx3fb_data {
 	struct fb_info		*fbi;
 	int			backlight_level;
+	int			pwm_clk_src;	/* clock source for PWM */
 	void __iomem		*reg_base;
 	spinlock_t		lock;
 	struct device		*dev;
@@ -268,6 +276,7 @@ struct mx3fb_info {
 	struct scatterlist		sg[2];
 
 	u32				sync;	/* preserve var->sync flags */
+	struct backlight_device		*backlight;
 };
 
 static void mx3fb_dma_done(void *);
@@ -647,7 +656,9 @@ static int sdc_set_global_alpha(struct mx3fb_data *mx3fb, bool enable, uint8_t a
 static void sdc_set_brightness(struct mx3fb_data *mx3fb, uint8_t value)
 {
 	/* This might be board-specific */
-	mx3fb_write_reg(mx3fb, 0x03000000UL | value << 16, SDC_PWM_CTRL);
+	u32 reg = mx3fb->pwm_clk_src | SDC_PWM_CC_EN | value << 16;
+
+	mx3fb_write_reg(mx3fb, reg, SDC_PWM_CTRL);
 	return;
 }
 
@@ -1207,6 +1218,88 @@ static int mx3fb_resume(struct platform_device *pdev)
 #define mx3fb_resume    NULL
 #endif
 
+#ifdef CONFIG_BACKLIGHT_LCD_SUPPORT
+/*
+ * Backlight device
+ */
+static int mx3fb_bl_update_status(struct backlight_device *bl)
+{
+	struct mx3fb_info *fbi = bl_get_data(bl);
+	struct mx3fb_data *mx3fb = fbi->mx3fb;
+	int brightness;
+
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.fb_blank != FB_BLANK_UNBLANK)
+		brightness = 0;
+	else
+		brightness = bl->props.brightness;
+
+	mx3fb->backlight_level = brightness;
+	sdc_set_brightness(mx3fb, mx3fb->backlight_level);
+	return 0;
+}
+
+static int mx3fb_bl_get_brightness(struct backlight_device *bl)
+{
+	struct mx3fb_info *fbi = bl_get_data(bl);
+	struct mx3fb_data *mx3fb = fbi->mx3fb;
+	uint32_t reg;
+
+	reg = mx3fb_read_reg(mx3fb, SDC_PWM_CTRL);
+
+	return (reg & SDC_PWM_PWM_MSK) >> 16;
+}
+
+static struct backlight_ops mx3fb_bl_ops = {
+	.update_status = mx3fb_bl_update_status,
+	.get_brightness = mx3fb_bl_get_brightness,
+};
+
+static void mx3fb_init_backlight(struct mx3fb_info *fbi)
+{
+	struct backlight_device	*bl;
+	struct mx3fb_data *mx3fb = fbi->mx3fb;
+
+	/*
+	 * COM57H5M10XRC supports max. 300Hz for PDM, so
+	 * we use HSYNC as clock source.
+	 */
+	if (fb_mode && !strncmp(fb_mode, "COM57H5M10XRC", 13))
+		mx3fb->pwm_clk_src = SDC_PWM_SRC_HSYNC_CLK;
+
+	if (fbi->backlight)
+		return;
+
+	bl = backlight_device_register("mx3fb", mx3fb->dev,
+				       fbi, &mx3fb_bl_ops);
+	if (IS_ERR(bl)) {
+		dev_err(mx3fb->dev, "register backlight failed: %ld\n",
+			PTR_ERR(bl));
+		return;
+	}
+	fbi->backlight = bl;
+
+	bl->props.power = FB_BLANK_UNBLANK;
+	bl->props.fb_blank = FB_BLANK_UNBLANK;
+	bl->props.max_brightness = 0xff;
+	bl->props.brightness = 0xff;
+}
+
+static void mx3fb_exit_backlight(struct mx3fb_info *fbi)
+{
+	if (fbi->backlight)
+		backlight_device_unregister(fbi->backlight);
+}
+#else
+static inline void mx3fb_init_backlight(struct mx3fb_info *fbi)
+{
+}
+
+static inline void mx3fb_exit_backlight(struct mx3fb_info *fbi)
+{
+}
+#endif
+
 /*
  * Main framebuffer functions
  */
@@ -1390,6 +1483,8 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	if (ret < 0)
 		goto esetpar;
 
+	mx3fb_init_backlight(mx3fbi);
+
 	__blank(FB_BLANK_UNBLANK, fbi);
 
 	dev_info(dev, "registered, using mode %s\n", fb_mode);
@@ -1401,6 +1496,7 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	return 0;
 
 erfb:
+	mx3fb_exit_backlight(mx3fbi);
 esetpar:
 emode:
 	fb_dealloc_cmap(&fbi->cmap);
@@ -1487,6 +1583,7 @@ static int mx3fb_probe(struct platform_device *pdev)
 	}
 
 	mx3fb->backlight_level = 255;
+	mx3fb->pwm_clk_src = SDC_PWM_SRC_PXL_CLK;
 
 	ret = init_fb_chan(mx3fb, to_idmac_chan(chan));
 	if (ret < 0)
@@ -1513,6 +1610,7 @@ static int mx3fb_remove(struct platform_device *dev)
 	struct dma_chan *chan;
 
 	chan = &mx3_fbi->idmac_channel->dma_chan;
+	mx3fb_exit_backlight(mx3_fbi);
 	release_fbi(fbi);
 
 	dma_release_channel(chan);
-- 
1.5.6.3


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
