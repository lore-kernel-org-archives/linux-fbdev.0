From: Darren Etheridge <detheridge@ti.com>
Date: Mon, 05 Aug 2013 22:02:21 +0000
Subject: [PATCH v3 02/20] video: da8xx-fb: simplify lcd_reset
Message-Id: <1375740159-1045-3-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

lcd_reset function doesn't require any arguement, remove it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index d00dd17..52977b1 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -681,7 +681,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 }
 #undef CNVT_TOHW
 
-static void lcd_reset(struct da8xx_fb_par *par)
+static void da8xx_fb_lcd_reset(void)
 {
 	/* Disable the Raster if previously Enabled */
 	lcd_disable_raster(false);
@@ -721,7 +721,7 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
 	u32 bpp;
 	int ret = 0;
 
-	lcd_reset(par);
+	da8xx_fb_lcd_reset();
 
 	/* Calculate the divider */
 	lcd_calc_clk_divider(par);
-- 
1.7.0.4

