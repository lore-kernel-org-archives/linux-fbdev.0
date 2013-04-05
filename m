From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 05 Apr 2013 10:31:15 +0000
Subject: [PATCH v3 1/2] imxfb: Set alpha value of the framebuffer
Message-Id: <1365157876-1757-2-git-send-email-mpa@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365157876-1757-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1365157876-1757-1-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Christian Hemp <c.hemp@phytec.de>

Based on Sascha Hauer's patch i.MX27 clock: Do not disable lcd clocks during
startup.
This patch gives a interface to chance the alphavalue of the framebuffer.

Signed-off-by: Christian Hemp <c.hemp@phytec.de>

rebased to 3.7
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/video/imxfb.c                     | 35 +++++++++++++++++++++++++++++++
 include/linux/platform_data/video-imxfb.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 0abf2bf..ef2b587 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -31,6 +31,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/math64.h>
+#include <linux/uaccess.h>
 
 #include <linux/platform_data/video-imxfb.h>
 
@@ -112,6 +113,10 @@
 #define LCDISR_EOF	(1<<1)
 #define LCDISR_BOF	(1<<0)
 
+#define LCDC_LGWCR	0x64
+#define LGWCR_GWAV(alpha)	(((alpha) & 0xff) << 24)
+#define LGWCR_GWE	(1 << 22)
+
 /* Used fb-mode. Can be set on kernel command line, therefore file-static. */
 static const char *fb_mode;
 
@@ -610,6 +615,35 @@ static int imxfb_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
+static int imxfb_ioctl(struct fb_info *info, unsigned int cmd,
+			unsigned long arg)
+{
+	struct imxfb_info *fbi = info->par;
+	int alpha, ret = 0;
+	unsigned int tmp;
+
+	switch (cmd) {
+	case IMXFB_ALPHA:
+		if (get_user(alpha, (int __user *)arg)) {
+			ret = -EFAULT;
+		} else {
+			tmp = readl(fbi->regs + LCDC_LGWCR);
+			tmp &= ~LGWCR_GWAV(0xff);
+			tmp |= LGWCR_GWAV(alpha);
+			if (!alpha)
+				tmp &= ~LGWCR_GWE;
+			else
+				tmp |= LGWCR_GWE;
+			writel(tmp , fbi->regs + LCDC_LGWCR);
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static struct fb_ops imxfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= imxfb_check_var,
@@ -619,6 +653,7 @@ static struct fb_ops imxfb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_blank	= imxfb_blank,
+	.fb_ioctl	= imxfb_ioctl,
 };
 
 /*
diff --git a/include/linux/platform_data/video-imxfb.h b/include/linux/platform_data/video-imxfb.h
index 9de8f06..ce3875f 100644
--- a/include/linux/platform_data/video-imxfb.h
+++ b/include/linux/platform_data/video-imxfb.h
@@ -51,6 +51,9 @@
 #define DMACR_HM(x)	(((x) & 0xf) << 16)
 #define DMACR_TM(x)	((x) & 0xf)
 
+#define IMXFB_IOW(num, dtype)	_IOW('I', num, dtype)
+#define IMXFB_ALPHA		IMXFB_IOW(31, int)
+
 struct imx_fb_videomode {
 	struct fb_videomode mode;
 	u32 pcr;
-- 
1.8.1.5

