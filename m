From: dromede@gmail.com
Date: Wed, 28 Nov 2012 21:46:41 +0000
Subject: [PATCH] backlight: corgi_lcd: Fix WARN_ON() when calling corgi_bl_set_intensity.
Message-Id: <1354139201-12834-1-git-send-email-dromede@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Marko Katic <dromede.gmail.com>


Signed-off-by: Marko Katic <dromede@gmail.com>
---
 drivers/video/backlight/corgi_lcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index c781768..8b002d7 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -409,10 +409,10 @@ static int corgi_bl_set_intensity(struct corgi_lcd *lcd, int intensity)
 	cont = !!(intensity & 0x20) ^ lcd->gpio_backlight_cont_inverted;
 
 	if (gpio_is_valid(lcd->gpio_backlight_cont))
-		gpio_set_value(lcd->gpio_backlight_cont, cont);
+		gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
 
 	if (gpio_is_valid(lcd->gpio_backlight_on))
-		gpio_set_value(lcd->gpio_backlight_on, intensity);
+		gpio_set_value_cansleep(lcd->gpio_backlight_on, intensity);
 
 	if (lcd->kick_battery)
 		lcd->kick_battery();
-- 
1.7.4.1

