From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 05 Feb 2015 14:23:59 +0000
Subject: [PATCH] fbdev: via: remove unused variable
Message-Id: <1423145519-30862-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

the mode_crt_table was only assigned some data, but that was never
again reused. It will be safe to remove that.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/fbdev/via/lcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/via/lcd.c b/drivers/video/fbdev/via/lcd.c
index 5d21ff4..51ac3f3 100644
--- a/drivers/video/fbdev/via/lcd.c
+++ b/drivers/video/fbdev/via/lcd.c
@@ -551,11 +551,9 @@ void viafb_lcd_set_mode(const struct fb_var_screeninfo *var, u16 cxres,
 	u32 clock;
 	struct via_display_timing timing;
 	struct fb_var_screeninfo panel_var;
-	const struct fb_videomode *mode_crt_table, *panel_crt_table;
+	const struct fb_videomode *panel_crt_table;
 
 	DEBUG_MSG(KERN_INFO "viafb_lcd_set_mode!!\n");
-	/* Get mode table */
-	mode_crt_table = viafb_get_best_mode(set_hres, set_vres, 60);
 	/* Get panel table Pointer */
 	panel_crt_table = viafb_get_best_mode(panel_hres, panel_vres, 60);
 	viafb_fill_var_timing_info(&panel_var, panel_crt_table);
-- 
1.8.1.2

