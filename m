From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 17 Apr 2013 15:17:17 +0000
Subject: [RFC 05/10] fbmon: Add extra video helper
Message-Id: <1366211842-21497-6-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>

This function converts the fb_var_screeninfo to the videomode
structure, to be used in fbdev drivers working with the
Common Display Framework.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/video/fbmon.c |   29 +++++++++++++++++++++++++++++
 include/linux/fb.h    |    3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 7f67099..f0ff2bf 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1424,6 +1424,35 @@ int fb_videomode_from_videomode(const struct videomode *vm,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fb_videomode_from_videomode);
+
+void videomode_from_fb_var_screeninfo(const struct fb_var_screeninfo *var,
+				      struct videomode *vm)
+{
+	vm->pixelclock = PICOS2KHZ(var->pixclock) * 1000;
+
+	vm->hactive = var->xres;
+	vm->hfront_porch = var->right_margin;
+	vm->hback_porch = var->left_margin;
+	vm->hsync_len = var->hsync_len;
+
+	vm->vactive = var->yres;
+	vm->vfront_porch = var->lower_margin;
+	vm->vback_porch = var->upper_margin;
+	vm->vsync_len = var->vsync_len;
+
+	vm->dmt_flags = 0;
+	if (var->sync & FB_SYNC_HOR_HIGH_ACT)
+		vm->dmt_flags |= VESA_DMT_HSYNC_HIGH;
+	if (var->sync & FB_SYNC_VERT_HIGH_ACT)
+		vm->dmt_flags |= VESA_DMT_VSYNC_HIGH;
+
+	vm->data_flags = 0;
+	if (var->vmode & FB_VMODE_INTERLACED)
+		vm->data_flags |= DISPLAY_FLAGS_INTERLACED;
+	if (var->vmode & FB_VMODE_DOUBLE)
+		vm->data_flags |= DISPLAY_FLAGS_DOUBLESCAN;
+}
+EXPORT_SYMBOL_GPL(videomode_from_fb_var_screeninfo);
 #endif
 
 #if IS_ENABLED(CONFIG_OF_VIDEOMODE)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 58b9860..aae2ed3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -721,6 +721,9 @@ extern int of_get_fb_videomode(struct device_node *np,
 			       int index);
 extern int fb_videomode_from_videomode(const struct videomode *vm,
 				       struct fb_videomode *fbmode);
+extern void videomode_from_fb_var_screeninfo(
+				const struct fb_var_screeninfo *var,
+				struct videomode *vm);
 
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 34
-- 
1.7.10.4


