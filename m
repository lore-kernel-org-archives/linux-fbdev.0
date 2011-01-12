From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 12 Jan 2011 22:14:44 +0000
Subject: [PATCH] fbdev: Implement simple blanking in pseudocolor modes for
Message-Id: <20110112221443.GA574@alchark-u3s>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, vt8500-wm8505-linux-kernel@googlegroups.com

Implement simple blanking in pseudocolor modes for vt8500lcdfb

This follows the style of some other in-tree drivers by just setting
the hardware palette colors to all black. True Color modes are not
affected, but this at least allows to run xf86-video-fbdev without
errors due to blanking being unimplemented.

Signed-off-by: Alexey Charkov <alchark@gmail.com>

diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
index 7617f12..0e120d6 100644
--- a/drivers/video/vt8500lcdfb.c
+++ b/drivers/video/vt8500lcdfb.c
@@ -215,6 +215,33 @@ static int vt8500lcd_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
+/*
+ * vt8500lcd_blank():
+ *	Blank the display by setting all palette values to zero.  Note,
+ * 	True Color modes do not really use the palette, so this will not
+ *      blank the display in all modes.
+ */
+static int vt8500lcd_blank(int blank, struct fb_info *info)
+{
+	int i;
+
+	switch (blank) {
+	case FB_BLANK_POWERDOWN:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_NORMAL:
+		if (info->fix.visual = FB_VISUAL_PSEUDOCOLOR ||
+		    info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR)
+			for (i = 0; i < 256; i++)
+				vt8500lcd_setcolreg(i, 0, 0, 0, 0, info);
+	case FB_BLANK_UNBLANK:
+		if (info->fix.visual = FB_VISUAL_PSEUDOCOLOR ||
+		    info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR)
+			fb_set_cmap(&info->cmap, info);
+	}
+	return 0;
+}
+
 static struct fb_ops vt8500lcd_ops = {
 	.owner		= THIS_MODULE,
 	.fb_set_par	= vt8500lcd_set_par,
@@ -225,6 +252,7 @@ static struct fb_ops vt8500lcd_ops = {
 	.fb_sync	= wmt_ge_sync,
 	.fb_ioctl	= vt8500lcd_ioctl,
 	.fb_pan_display	= vt8500lcd_pan_display,
+	.fb_blank	= vt8500lcd_blank,
 };
 
 static irqreturn_t vt8500lcd_handle_irq(int irq, void *dev_id)
