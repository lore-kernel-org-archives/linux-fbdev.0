From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Sun, 01 Mar 2015 22:28:02 +0000
Subject: [PATCHv2 09/10] fbdev: ssd1307fb: Add sysfs handles to expose contrast and dim setting to userspace.
Message-Id: <1425248883-25367-10-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch adds sysfs handles to enable userspace control over the display
contrast as well as the dim mode. The handles are available as "contrast"
and "dim" in the brightness group of the framebuffers sysfs domain.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 90 +++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 5bf570b..2a2e7c3 100644
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
=20
+#define MIN_CONTRAST 0
+#define MAX_CONTRAST 255
+
 #define REFRASHRATE 1
 #define BITSPERPIXEL 1
=20
@@ -73,6 +77,7 @@ struct ssd1307fb_par {
 	u32 dclk_div;
 	u32 dclk_frq;
 	struct ssd1307fb_deviceinfo *device_info;
+	u32 dim;
 	struct i2c_client *client;
 	u32 height;
 	struct fb_info *info;
@@ -476,6 +481,87 @@ static const struct of_device_id ssd1307fb_of_match[] =
=3D {
 };
 MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
=20
+static ssize_t show_contrast(struct device *device,
+			   struct device_attribute *attr, char *buf)
+{
+	struct fb_info *info =3D dev_get_drvdata(device);
+	struct ssd1307fb_par *par =3D info->par;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", par->contrast);
+}
+
+static ssize_t store_contrast(struct device *device,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fb_info *info =3D dev_get_drvdata(device);
+	struct ssd1307fb_par *par =3D info->par;
+	unsigned long contrastval;
+	int ret;
+
+	ret =3D kstrtoul(buf, 0, &contrastval);
+	if (ret < 0)
+		return ret;
+
+	par->contrast =3D max_t(ulong, min_t(ulong, contrastval,
+		(ulong)MAX_CONTRAST), (ulong)MIN_CONTRAST);
+
+	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
+	ret =3D ret & ssd1307fb_write_cmd(par->client, par->contrast);
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
+	struct fb_info *info =3D dev_get_drvdata(device);
+	struct ssd1307fb_par *par =3D info->par;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", par->dim);
+}
+
+static ssize_t store_dim(struct device *device,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fb_info *info =3D dev_get_drvdata(device);
+	struct ssd1307fb_par *par =3D info->par;
+	unsigned long dimval;
+	int ret;
+
+	ret =3D kstrtoul(buf, 0, &dimval);
+	if (ret < 0)
+		return ret;
+
+	par->dim =3D max_t(ulong, min_t(ulong, dimval, (ulong)1), (ulong)0);
+	if (par->dim)
+		ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_DIM);
+	else
+		ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(contrast, S_IRUGO|S_IWUSR, show_contrast, store_contras=
t);
+static DEVICE_ATTR(dim, S_IRUGO|S_IWUSR, show_dim, store_dim);
+
+static struct attribute *panel_attrs[] =3D {
+		&dev_attr_contrast.attr,
+		&dev_attr_dim.attr,
+		NULL,
+};
+
+static struct attribute_group brightness_attr_grp =3D {
+		.name  =3D "brightness",
+		.attrs =3D panel_attrs,
+};
+
 static int ssd1307fb_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -614,6 +700,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		goto panel_init_error;
 	}
=20
+	ret =3D sysfs_create_group(&info->dev->kobj, &brightness_attr_grp);
+	if (ret)
+		dev_err(&client->dev, "Couldn't register sysfs nodes\n");
+
 	dev_info(&client->dev, "fb%d: %s framebuffer device registered, using %d =
bytes of video memory\n", info->node, info->fix.id, vmem_size);
=20
 	return 0;
--=20
2.3.0

