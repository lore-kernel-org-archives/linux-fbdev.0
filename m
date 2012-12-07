From: Afzal Mohammed <afzal@ti.com>
Date: Fri, 07 Dec 2012 11:55:32 +0000
Subject: [PATCH 02/10] video: da8xx-fb: simplify lcd_reset
Message-Id: <7ed35e8379d5c8d0224867cff2f8aa6d57a4335b.1354874432.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1354874432.git.afzal@ti.com>
In-Reply-To: <cover.1354874432.git.afzal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

lcd_reset function doesn't require any arguement, remove it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 89446aa..c8e97de 100644
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
1.7.12

