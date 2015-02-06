From: niederp@physik.uni-kl.de
Date: Fri, 06 Feb 2015 22:28:13 +0000
Subject: [PATCH 7/8] fbdev: ssd1307fb: Add sysfs handles to expose contrast and dim setting to userspace.
Message-Id: <1423261694-5939-8-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

From: Thomas Niederprüm <niederp@physik.uni-kl.de>

This patch adds sysfs handles to enable userspace control over the display
contrast as well as the dim mode. The handles are available as "contrast"
and "dim" in the framebuffers sysfs domain.

Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 88 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index b38315d..02931c7 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -33,6 +33,7 @@
 #define SSD1307FB_CONTRAST		0x81
 #define	SSD1307FB_CHARGE_PUMP		0x8d
 #define SSD1307FB_SEG_REMAP_ON		0xa1
+#define SSD1307FB_DISPLAY_DIM		0xac
 #define SSD1307FB_DISPLAY_OFF		0xae
 #define SSD1307FB_SET_MULTIPLEX_RATIO	0xa8
 #define SSD1307FB_DISPLAY_ON		0xaf
@@ -43,6 +44,9 @@
 #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
 #define	SSD1307FB_SET_VCOMH		0xdb
 
+#define MIN_CONTRAST 0
+#define MAX_CONTRAST 255
+
 #define BITSPERPIXEL 1
 #define DELAYDIVIDER 20
 
@@ -69,6 +73,7 @@ struct ssd1307fb_par {
 	u32 dclk_div;
 	u32 dclk_frq;
 	struct ssd1307fb_deviceinfo *device_info;
+	u32 dim;
 	struct i2c_client *client;
 	u32 height;
 	struct fb_info *info;
@@ -515,6 +520,79 @@ static const struct of_device_id ssd1307fb_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
 
+static ssize_t show_contrast(struct device *device,
+			   struct device_attribute *attr, char *buf)
+{
+	struct fb_info *info = dev_get_drvdata(device);
+	struct ssd1307fb_par *par = info->par;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", par->contrast);
+}
+
+static ssize_t store_contrast(struct device *device,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fb_info *info = dev_get_drvdata(device);
+	struct ssd1307fb_par *par = info->par;
+	unsigned long contrastval;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &contrastval);
+	if (ret < 0)
+		return ret;
+
+	par->contrast = max(min(contrastval,
+		(ulong)MAX_CONTRAST), (ulong)MIN_CONTRAST);
+
+	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
+	ret = ret & ssd1307fb_write_cmd(par->client, par->contrast);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+
+static ssize_t show_dim(struct device *device,
+			   struct device_attribute *attr, char *buf)
+{
+	struct fb_info *info = dev_get_drvdata(device);
+	struct ssd1307fb_par *par = info->par;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", par->dim);
+}
+
+static ssize_t store_dim(struct device *device,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fb_info *info = dev_get_drvdata(device);
+	struct ssd1307fb_par *par = info->par;
+	unsigned long dimval;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &dimval);
+	if (ret < 0)
+		return ret;
+
+	par->dim = max(min(dimval, (ulong)1), (ulong)0);
+	if (par->dim)
+		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_DIM);
+	else
+		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static struct device_attribute device_attrs[] = {
+	__ATTR(contrast, S_IRUGO|S_IWUSR, show_contrast, store_contrast),
+	__ATTR(dim, S_IRUGO|S_IWUSR, show_dim, store_dim),
+
+};
+
 static int ssd1307fb_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -523,7 +601,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	u32 vmem_size;
 	struct ssd1307fb_par *par;
 	u8 *vmem;
-	int ret;
+	int ret, i;
 
 	if (!node) {
 		dev_err(&client->dev, "No device tree data found!\n");
@@ -650,6 +728,14 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		goto reset_oled_error;
 
 	ret = register_framebuffer(info);
+
+	for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
+		ret = device_create_file(info->dev, &device_attrs[i]);
+
+	if (ret) {
+		dev_err(&client->dev, "Couldn't register sysfs nodes\n");
+	}
+
 	if (ret) {
 		dev_err(&client->dev, "Couldn't register the framebuffer\n");
 		goto panel_init_error;
-- 
2.1.1

