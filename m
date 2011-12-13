From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:51 +0000
Subject: [PATCH 56/57] fbdev: sh_mobile_lcdc: Rename fb operation handlers with a common prefix
Message-Id: <1323784972-24205-57-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Make all fb operation handlers start with sh_mobile_lcdc_ in preparation
for the multi-plane support.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   42 +++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 357cdc1..4b4e81e 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -583,7 +583,7 @@ static irqreturn_t sh_mobile_lcdc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int sh_mobile_wait_for_vsync(struct sh_mobile_lcdc_chan *ch)
+static int sh_mobile_lcdc_wait_for_vsync(struct sh_mobile_lcdc_chan *ch)
 {
 	unsigned long ldintr;
 	int ret;
@@ -684,7 +684,7 @@ static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 }
 
 /*
- * __sh_mobile_lcdc_start - Configure and tart the LCDC
+ * __sh_mobile_lcdc_start - Configure and start the LCDC
  * @priv: LCDC device
  *
  * Configure all enabled channels and start the LCDC device. All external
@@ -1032,8 +1032,8 @@ static void sh_mobile_lcdc_imageblit(struct fb_info *info,
 	sh_mobile_lcdc_deferred_io_touch(info);
 }
 
-static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
-				     struct fb_info *info)
+static int sh_mobile_lcdc_pan(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	struct sh_mobile_lcdc_priv *priv = ch->lcdc;
@@ -1096,14 +1096,15 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-static int sh_mobile_ioctl(struct fb_info *info, unsigned int cmd,
-		       unsigned long arg)
+static int sh_mobile_lcdc_ioctl(struct fb_info *info, unsigned int cmd,
+				unsigned long arg)
 {
+	struct sh_mobile_lcdc_chan *ch = info->par;
 	int retval;
 
 	switch (cmd) {
 	case FBIO_WAITFORVSYNC:
-		retval = sh_mobile_wait_for_vsync(info->par);
+		retval = sh_mobile_lcdc_wait_for_vsync(ch);
 		break;
 
 	default:
@@ -1154,7 +1155,7 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
  * Locking: both .fb_release() and .fb_open() are called with info->lock held if
  * user = 1, or with console sem held, if user = 0.
  */
-static int sh_mobile_release(struct fb_info *info, int user)
+static int sh_mobile_lcdc_release(struct fb_info *info, int user)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 
@@ -1175,7 +1176,7 @@ static int sh_mobile_release(struct fb_info *info, int user)
 	return 0;
 }
 
-static int sh_mobile_open(struct fb_info *info, int user)
+static int sh_mobile_lcdc_open(struct fb_info *info, int user)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 
@@ -1188,7 +1189,8 @@ static int sh_mobile_open(struct fb_info *info, int user)
 	return 0;
 }
 
-static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+static int sh_mobile_lcdc_check_var(struct fb_var_screeninfo *var,
+				    struct fb_info *info)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	struct sh_mobile_lcdc_priv *p = ch->lcdc;
@@ -1309,7 +1311,7 @@ static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *in
 	return 0;
 }
 
-static int sh_mobile_set_par(struct fb_info *info)
+static int sh_mobile_lcdc_set_par(struct fb_info *info)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	int ret;
@@ -1379,8 +1381,8 @@ static int sh_mobile_lcdc_blank(int blank, struct fb_info *info)
 		 * mode will reenable the clocks and update the screen in time,
 		 * so it does not need this. */
 		if (!info->fbdefio) {
-			sh_mobile_wait_for_vsync(ch);
-			sh_mobile_wait_for_vsync(ch);
+			sh_mobile_lcdc_wait_for_vsync(ch);
+			sh_mobile_lcdc_wait_for_vsync(ch);
 		}
 		sh_mobile_lcdc_clk_off(p);
 	}
@@ -1398,12 +1400,12 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_copyarea	= sh_mobile_lcdc_copyarea,
 	.fb_imageblit	= sh_mobile_lcdc_imageblit,
 	.fb_blank	= sh_mobile_lcdc_blank,
-	.fb_pan_display = sh_mobile_fb_pan_display,
-	.fb_ioctl       = sh_mobile_ioctl,
-	.fb_open	= sh_mobile_open,
-	.fb_release	= sh_mobile_release,
-	.fb_check_var	= sh_mobile_check_var,
-	.fb_set_par	= sh_mobile_set_par,
+	.fb_pan_display = sh_mobile_lcdc_pan,
+	.fb_ioctl       = sh_mobile_lcdc_ioctl,
+	.fb_open	= sh_mobile_lcdc_open,
+	.fb_release	= sh_mobile_lcdc_release,
+	.fb_check_var	= sh_mobile_lcdc_check_var,
+	.fb_set_par	= sh_mobile_lcdc_set_par,
 };
 
 static void
@@ -1533,7 +1535,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 	else
 		var->grayscale = ch->format->fourcc;
 
-	ret = sh_mobile_check_var(var, info);
+	ret = sh_mobile_lcdc_check_var(var, info);
 	if (ret)
 		return ret;
 
-- 
1.7.3.4

