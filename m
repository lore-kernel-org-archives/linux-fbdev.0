From: Michael Welling <mwelling@ieee.org>
Date: Fri, 04 Jul 2014 02:26:36 +0000
Subject: [PATCH] drivers: video: fbdev: atmel_lcdfb.c: Add ability to inverted backlight PWM.
Message-Id: <1404440796-11090-1-git-send-email-mwelling@ieee.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>

The code has a variable to change the polarity of the PWM backlight control but
it was not being initialized. This patch adds a devicetree entry to set the
variable if required.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 .../devicetree/bindings/video/atmel,lcdc.txt       |    1 +
 drivers/video/fbdev/atmel_lcdfb.c                  |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/video/atmel,lcdc.txt b/Documentation/devicetree/bindings/video/atmel,lcdc.txt
index 1ec175e..b75af94 100644
--- a/Documentation/devicetree/bindings/video/atmel,lcdc.txt
+++ b/Documentation/devicetree/bindings/video/atmel,lcdc.txt
@@ -46,6 +46,7 @@ Required properties (as per of_videomode_helper):
 
 Optional properties (as per of_videomode_helper):
  - atmel,lcdcon-backlight: enable backlight
+ - atmel,lcdcon-backlight-inverted: invert backlight PWM polarity
  - atmel,lcd-wiring-mode: lcd wiring mode "RGB" or "BRG"
  - atmel,power-control-gpio: gpio to power on or off the LCD (as many as needed)
 
diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index d36e830..92640d4 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -290,7 +290,7 @@ static void init_contrast(struct atmel_lcdfb_info *sinfo)
 
 	/* contrast pwm can be 'inverted' */
 	if (pdata->lcdcon_pol_negative)
-			contrast_ctr &= ~(ATMEL_LCDC_POL_POSITIVE);
+		contrast_ctr &= ~(ATMEL_LCDC_POL_POSITIVE);
 
 	/* have some default contrast/backlight settings */
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
@@ -1097,6 +1097,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	pdata->lcd_wiring_mode = ret;
 
 	pdata->lcdcon_is_backlight = of_property_read_bool(display_np, "atmel,lcdcon-backlight");
+	pdata->lcdcon_pol_negative = of_property_read_bool(display_np, "atmel,lcdcon-backlight-inverted");
 
 	timings = of_get_display_timings(display_np);
 	if (!timings) {
-- 
1.7.9.5

