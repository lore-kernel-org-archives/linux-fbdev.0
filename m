From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Mon, 12 May 2014 06:34:14 +0000
Subject: [PATCH v4] video: mx3fb: Add backlight control support
Message-Id: <1399876454-17882-1-git-send-email-alexander.stein@systec-electronic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch add backlight control support to allow dimming the backlight
using the internal PWM. Currently the brightness is set fixed to a
maximum of 255.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes in v4:
* Add backlight support unconditionally

Changes in v3:
* Add a more descriptive commit message

Changes in v2:
* rebased to v3.15-rc4

 drivers/video/fbdev/Kconfig |  1 +
 drivers/video/fbdev/mx3fb.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e1f4727..d76b4af 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2332,6 +2332,7 @@ config FB_MX3
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select BACKLIGHT_CLASS_DEVICE
 	default y
 	help
 	  This is a framebuffer device for the i.MX31 LCD Controller. So
diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index 142e860..315e285 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -27,6 +27,7 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 #include <linux/dma/ipu-dma.h>
+#include <linux/backlight.h>
 
 #include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/video-mx3fb.h>
@@ -241,6 +242,7 @@ struct mx3fb_data {
 	void __iomem		*reg_base;
 	spinlock_t		lock;
 	struct device		*dev;
+	struct backlight_device	*bl;
 
 	uint32_t		h_start_width;
 	uint32_t		v_start_width;
@@ -271,6 +273,71 @@ struct mx3fb_info {
 	struct fb_var_screeninfo	cur_var; /* current var info */
 };
 
+static void sdc_set_brightness(struct mx3fb_data *mx3fb, uint8_t value);
+static u32 sdc_get_brightness(struct mx3fb_data *mx3fb);
+
+static int mx3fb_bl_get_brightness(struct backlight_device *bl)
+{
+	struct mx3fb_data *fbd = bl_get_data(bl);
+
+	return sdc_get_brightness(fbd);
+}
+
+static int mx3fb_bl_update_status(struct backlight_device *bl)
+{
+	struct mx3fb_data *fbd = bl_get_data(bl);
+	int brightness = bl->props.brightness;
+
+	if (bl->props.power != FB_BLANK_UNBLANK)
+		brightness = 0;
+	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
+		brightness = 0;
+
+	fbd->backlight_level = (fbd->backlight_level & ~0xFF) | brightness;
+
+	sdc_set_brightness(fbd, fbd->backlight_level);
+
+	return 0;
+}
+
+static const struct backlight_ops mx3fb_lcdc_bl_ops = {
+	.update_status = mx3fb_bl_update_status,
+	.get_brightness = mx3fb_bl_get_brightness,
+};
+
+static void mx3fb_init_backlight(struct mx3fb_data *fbd)
+{
+	struct backlight_properties props;
+	struct backlight_device	*bl;
+
+	if (fbd->bl)
+		return;
+
+	memset(&props, 0, sizeof(struct backlight_properties));
+	props.max_brightness = 0xff;
+	props.type = BACKLIGHT_RAW;
+	sdc_set_brightness(fbd, fbd->backlight_level);
+
+	bl = backlight_device_register("mx3fb-bl", fbd->dev, fbd,
+				       &mx3fb_lcdc_bl_ops, &props);
+	if (IS_ERR(bl)) {
+		dev_err(fbd->dev, "error %ld on backlight register\n",
+				PTR_ERR(bl));
+		return;
+	}
+
+	fbd->bl = bl;
+	bl->props.power = FB_BLANK_UNBLANK;
+	bl->props.fb_blank = FB_BLANK_UNBLANK;
+	bl->props.brightness = mx3fb_bl_get_brightness(bl);
+}
+
+static void mx3fb_exit_backlight(struct mx3fb_data *fbd)
+{
+	if (fbd->bl)
+		backlight_device_unregister(fbd->bl);
+}
+
 static void mx3fb_dma_done(void *);
 
 /* Used fb-mode and bpp. Can be set on kernel command line, therefore file-static. */
@@ -628,6 +695,16 @@ static int sdc_set_global_alpha(struct mx3fb_data *mx3fb, bool enable, uint8_t a
 	return 0;
 }
 
+static u32 sdc_get_brightness(struct mx3fb_data *mx3fb)
+{
+	u32 brightness;
+
+	brightness = mx3fb_read_reg(mx3fb, SDC_PWM_CTRL);
+	brightness = (brightness >> 16) & 0xFF;
+
+	return brightness;
+}
+
 static void sdc_set_brightness(struct mx3fb_data *mx3fb, uint8_t value)
 {
 	dev_dbg(mx3fb->dev, "%s: value = %d\n", __func__, value);
@@ -1534,6 +1611,8 @@ static int mx3fb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto eisdc0;
 
+	mx3fb_init_backlight(mx3fb);
+
 	return 0;
 
 eisdc0:
@@ -1557,6 +1636,8 @@ static int mx3fb_remove(struct platform_device *dev)
 	chan = &mx3_fbi->idmac_channel->dma_chan;
 	release_fbi(fbi);
 
+	mx3fb_exit_backlight(mx3fb);
+
 	dma_release_channel(chan);
 	dmaengine_put();
 
-- 
1.8.5.5

