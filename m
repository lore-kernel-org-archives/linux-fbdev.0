From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:33 +0000
Subject: [PATCH 38/57] fbdev: sh_mobile_lcdc: Pass channel pointer to sh_mobile_wait_for_vsync
Message-Id: <1323784972-24205-39-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The sh_mobile_wait_for_vsync() function isn't related to the fbdev API,
make it generic by passing a channel pointer instead of an fb_info
pointer.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   47 ++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 8e85b3c..453fc92 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -583,6 +583,26 @@ static irqreturn_t sh_mobile_lcdc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int sh_mobile_wait_for_vsync(struct sh_mobile_lcdc_chan *ch)
+{
+	unsigned long ldintr;
+	int ret;
+
+	/* Enable VSync End interrupt and be careful not to acknowledge any
+	 * pending interrupt.
+	 */
+	ldintr = lcdc_read(ch->lcdc, _LDINTR);
+	ldintr |= LDINTR_VEE | LDINTR_STATUS_MASK;
+	lcdc_write(ch->lcdc, _LDINTR, ldintr);
+
+	ret = wait_for_completion_interruptible_timeout(&ch->vsync_completion,
+							msecs_to_jiffies(100));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static void sh_mobile_lcdc_start_stop(struct sh_mobile_lcdc_priv *priv,
 				      int start)
 {
@@ -1081,27 +1101,6 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-static int sh_mobile_wait_for_vsync(struct fb_info *info)
-{
-	struct sh_mobile_lcdc_chan *ch = info->par;
-	unsigned long ldintr;
-	int ret;
-
-	/* Enable VSync End interrupt and be careful not to acknowledge any
-	 * pending interrupt.
-	 */
-	ldintr = lcdc_read(ch->lcdc, _LDINTR);
-	ldintr |= LDINTR_VEE | LDINTR_STATUS_MASK;
-	lcdc_write(ch->lcdc, _LDINTR, ldintr);
-
-	ret = wait_for_completion_interruptible_timeout(&ch->vsync_completion,
-							msecs_to_jiffies(100));
-	if (!ret)
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
 static int sh_mobile_ioctl(struct fb_info *info, unsigned int cmd,
 		       unsigned long arg)
 {
@@ -1109,7 +1108,7 @@ static int sh_mobile_ioctl(struct fb_info *info, unsigned int cmd,
 
 	switch (cmd) {
 	case FBIO_WAITFORVSYNC:
-		retval = sh_mobile_wait_for_vsync(info);
+		retval = sh_mobile_wait_for_vsync(info->par);
 		break;
 
 	default:
@@ -1385,8 +1384,8 @@ static int sh_mobile_lcdc_blank(int blank, struct fb_info *info)
 		 * mode will reenable the clocks and update the screen in time,
 		 * so it does not need this. */
 		if (!info->fbdefio) {
-			sh_mobile_wait_for_vsync(info);
-			sh_mobile_wait_for_vsync(info);
+			sh_mobile_wait_for_vsync(ch);
+			sh_mobile_wait_for_vsync(ch);
 		}
 		sh_mobile_lcdc_clk_off(p);
 	}
-- 
1.7.3.4

