From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 05 Feb 2013 13:35:14 +0000
Subject: [PATCH 4/5] atmel_lcdfb: move lcdcon2 register access to compute_hozval
Message-Id: <1360071315-4032-5-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130129135435.GN7360@game.jcrosoft.org>
 <1360071315-4032-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1360071315-4032-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Pass atmel_lcd_info structure to compute_hozval and only do the register
access on SOCs that actually use it.

This will also simplify the removal of the cpu_is macros.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/video/atmel_lcdfb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 93910e3..347bab2 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -193,14 +193,17 @@ static struct fb_fix_screeninfo atmel_lcdfb_fix __initdata = {
 	.accel		= FB_ACCEL_NONE,
 };
 
-static unsigned long compute_hozval(unsigned long xres, unsigned long lcdcon2)
+static unsigned long compute_hozval(struct atmel_lcdfb_info *sinfo,
+							unsigned long xres)
 {
+	unsigned long lcdcon2;
 	unsigned long value;
 
 	if (!(cpu_is_at91sam9261() || cpu_is_at91sam9g10()
 		|| cpu_is_at32ap7000()))
 		return xres;
 
+	lcdcon2 = lcdc_readl(sinfo, ATMEL_LCDC_LCDCON2);
 	value = xres;
 	if ((lcdcon2 & ATMEL_LCDC_DISTYPE) != ATMEL_LCDC_DISTYPE_TFT) {
 		/* STN display */
@@ -590,8 +593,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 	lcdc_writel(sinfo, ATMEL_LCDC_TIM2, value);
 
 	/* Horizontal value (aka line size) */
-	hozval_linesz = compute_hozval(info->var.xres,
-					lcdc_readl(sinfo, ATMEL_LCDC_LCDCON2));
+	hozval_linesz = compute_hozval(sinfo, info->var.xres);
 
 	/* Display size */
 	value = (hozval_linesz - 1) << ATMEL_LCDC_HOZVAL_OFFSET;
-- 
1.8.1.1

