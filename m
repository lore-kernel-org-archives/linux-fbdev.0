From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Aug 2016 09:29:31 +0000
Subject: [PATCH] video: ARM CLCD: fix up Integrator support
Message-Id: <1472462971-8935-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

We need to mask all registers of the Integrator/CP core module
control register, and actually write the calculated value to the
control register, not the mask.

Tested on the Integrator/CP with RGB5551 VGA and works like a
charm after this patch.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/fbdev/amba-clcd-versatile.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
index 9a90817b1550..5c1e03928d7f 100644
--- a/drivers/video/fbdev/amba-clcd-versatile.c
+++ b/drivers/video/fbdev/amba-clcd-versatile.c
@@ -262,7 +262,10 @@ static const struct of_device_id versatile_clcd_of_match[] = {
 /* 0 = 24bit VGA, 1 = 18bit VGA */
 #define INTEGRATOR_CLCD_LCD_N24BITEN	BIT(19)
 
-#define INTEGRATOR_CLCD_MASK		(INTEGRATOR_CLCD_LCDMUX_MASK | \
+#define INTEGRATOR_CLCD_MASK		(INTEGRATOR_CLCD_LCDBIASEN | \
+					 INTEGRATOR_CLCD_LCDBIASUP | \
+					 INTEGRATOR_CLCD_LCDBIASDN | \
+					 INTEGRATOR_CLCD_LCDMUX_MASK | \
 					 INTEGRATOR_CLCD_LCD0_EN | \
 					 INTEGRATOR_CLCD_LCD1_EN | \
 					 INTEGRATOR_CLCD_LCD_STATIC1 | \
@@ -277,6 +280,7 @@ static void integrator_clcd_enable(struct clcd_fb *fb)
 
 	dev_info(&fb->dev->dev, "enable Integrator CLCD connectors\n");
 
+	/* FIXME: really needed? */
 	val = INTEGRATOR_CLCD_LCD_STATIC1 | INTEGRATOR_CLCD_LCD_STATIC2 |
 		INTEGRATOR_CLCD_LCD0_EN | INTEGRATOR_CLCD_LCD1_EN;
 	if (var->bits_per_pixel <= 8 ||
@@ -291,8 +295,8 @@ static void integrator_clcd_enable(struct clcd_fb *fb)
 
 	regmap_update_bits(versatile_syscon_map,
 			   INTEGRATOR_HDR_CTRL_OFFSET,
-			   0,
-			   INTEGRATOR_CLCD_MASK);
+			   INTEGRATOR_CLCD_MASK,
+			   val);
 }
 
 /*
-- 
2.7.4

