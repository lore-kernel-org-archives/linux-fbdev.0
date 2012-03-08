From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 08 Mar 2012 17:56:48 +0000
Subject: [PATCH 2/2] viafb: avoid refresh and mode lookup in set_par
Message-Id: <a1c4d39ec862e09acd93247200cd6b9e5cc5701d.1331229163.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1331229163.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1331229163.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

As check_var already ensures that the mode is valid there is no need
to do those expensive lookups here again. The only thing that might
change is that the deprecated interface could report slightly
different refresh rates due to rounding errors.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/viafbdev.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 7529340..0c88375 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -287,26 +287,22 @@ static int viafb_set_par(struct fb_info *info)
 			viafb_second_yres, viafb_bpp1, 1);
 	}
 
-	refresh = viafb_get_refresh(info->var.xres, info->var.yres,
-		get_var_refresh(&info->var));
-	if (viafb_get_best_mode(viafbinfo->var.xres, viafbinfo->var.yres,
-		refresh)) {
-		if (viafb_dual_fb && viapar->iga_path = IGA2) {
-			viafb_bpp1 = info->var.bits_per_pixel;
-			viafb_refresh1 = refresh;
-		} else {
-			viafb_bpp = info->var.bits_per_pixel;
-			viafb_refresh = refresh;
-		}
-
-		if (info->var.accel_flags & FB_ACCELF_TEXT)
-			info->flags &= ~FBINFO_HWACCEL_DISABLED;
-		else
-			info->flags |= FBINFO_HWACCEL_DISABLED;
-		viafb_setmode();
-		viafb_pan_display(&info->var, info);
+	refresh = get_var_refresh(&info->var);
+	if (viafb_dual_fb && viapar->iga_path = IGA2) {
+		viafb_bpp1 = info->var.bits_per_pixel;
+		viafb_refresh1 = refresh;
+	} else {
+		viafb_bpp = info->var.bits_per_pixel;
+		viafb_refresh = refresh;
 	}
 
+	if (info->var.accel_flags & FB_ACCELF_TEXT)
+		info->flags &= ~FBINFO_HWACCEL_DISABLED;
+	else
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+	viafb_setmode();
+	viafb_pan_display(&info->var, info);
+
 	return 0;
 }
 
-- 
1.7.9

