From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 17 Jul 2011 00:34:03 +0000
Subject: [PATCH 2/2] viafb: improve pitch handling
Message-Id: <1310862843-4526-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, stable@kernel.org

This patch adds checks for minimum and maximum pitch size to prevent
invalid settings which could otherwise crash the machine. Also the
alignment is done in a slightly more readable way.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: stable@kernel.org
---
 drivers/video/via/via_modesetting.h |    5 +++++
 drivers/video/via/viafbdev.c        |   11 ++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/via_modesetting.h b/drivers/video/via/via_modesetting.h
index ae35cfd..0138845 100644
--- a/drivers/video/via/via_modesetting.h
+++ b/drivers/video/via/via_modesetting.h
@@ -28,6 +28,11 @@
 
 #include <linux/types.h>
 
+
+#define VIA_PITCH_SIZE	(1<<3)
+#define VIA_PITCH_MAX	0x3FF8
+
+
 void via_set_primary_address(u32 addr);
 void via_set_secondary_address(u32 addr);
 void via_set_primary_pitch(u32 pitch);
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index aa87529..bddae58 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -151,7 +151,8 @@ static void viafb_update_fix(struct fb_info *info)
 
 	info->fix.visual  		bpp = 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
-	info->fix.line_length = (info->var.xres_virtual * bpp / 8 + 7) & ~7;
+	info->fix.line_length = ALIGN(info->var.xres_virtual * bpp / 8,
+		VIA_PITCH_SIZE);
 }
 
 static void viafb_setup_fixinfo(struct fb_fix_screeninfo *fix,
@@ -238,8 +239,12 @@ static int viafb_check_var(struct fb_var_screeninfo *var,
 		depth = 24;
 
 	viafb_fill_var_color_info(var, depth);
-	line = (var->xres_virtual * var->bits_per_pixel / 8 + 7) & ~7;
-	if (line * var->yres_virtual > ppar->memsize)
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
+
+	line = ALIGN(var->xres_virtual * var->bits_per_pixel / 8,
+		VIA_PITCH_SIZE);
+	if (line > VIA_PITCH_MAX || line * var->yres_virtual > ppar->memsize)
 		return -EINVAL;
 
 	/* Based on var passed in to calculate the refresh,
-- 
1.6.3.2

