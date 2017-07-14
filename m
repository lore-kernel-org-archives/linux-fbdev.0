From: Bhumika Goyal <bhumirks@gmail.com>
Date: Fri, 14 Jul 2017 09:26:06 +0000
Subject: [PATCH] drivers/video/fbdev/omap/lcd_mipid.c: add const to lcd_panel structure
Message-Id: <1500023646-8846-1-git-send-email-bhumirks@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make lcd_panel structure const as it is only copied to some object.
As the only usage of this structure is a copy operation, so it can be
made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/video/fbdev/omap/lcd_mipid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index df9e6eb..e3a8543 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -496,7 +496,7 @@ static void mipid_cleanup(struct lcd_panel *panel)
 		mipid_esd_stop_check(md);
 }
 
-static struct lcd_panel mipid_panel = {
+static const struct lcd_panel mipid_panel = {
 	.config		= OMAP_LCDC_PANEL_TFT,
 
 	.bpp		= 16,
-- 
1.9.1

