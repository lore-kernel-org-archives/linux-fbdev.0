From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 16 Feb 2011 14:10:47 +0000
Subject: [PATCH 2/7] fb: export fb mode db table
Message-Id: <1297865452-32181-3-git-send-email-s.hauer@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The different modes can be useful for drivers. Currently there is
no way to expose the modes to sysfs, so export them.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>
---
 drivers/video/modedb.c |    8 ++++++--
 include/linux/fb.h     |    3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 48c3ea8..942b44d 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -36,8 +36,7 @@ EXPORT_SYMBOL_GPL(fb_mode_option);
  *  Standard video mode definitions (taken from XFree86)
  */
 
-static const struct fb_videomode modedb[] = {
-
+const struct fb_videomode modedb[] = {
 	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
 	{ NULL, 70, 640, 400, 39721, 40, 24, 39, 9, 96, 2, 0,
 		FB_VMODE_NONINTERLACED },
@@ -291,6 +290,11 @@ static const struct fb_videomode modedb[] = {
 		0, FB_VMODE_NONINTERLACED },
 };
 
+const struct fb_videomode *fb_modes = modedb;
+EXPORT_SYMBOL(fb_modes);
+const int num_fb_modes = ARRAY_SIZE(modedb);
+EXPORT_SYMBOL(num_fb_modes);
+
 #ifdef CONFIG_FB_MODE_HELPERS
 const struct fb_videomode cea_modes[64] = {
 	/* #1: 640x480p@59.94/60Hz */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 68ba85a..41b0ce1 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1154,6 +1154,9 @@ extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
 extern const struct fb_videomode cea_modes[64];
 
+extern const struct fb_videomode *fb_modes;
+extern const int num_fb_modes;
+
 struct fb_modelist {
 	struct list_head list;
 	struct fb_videomode mode;
-- 
1.7.2.3

