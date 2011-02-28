From: Donghwa Lee <dh09.lee@samsung.com>
Date: Mon, 28 Feb 2011 06:14:48 +0000
Subject: [PATCH] backlight/platform_lcd: change set power function parameter in
Message-Id: <1298873688-17118-1-git-send-email-dh09.lee@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In drivers/video/backlight/platform_lcd.c driver, to use lcd power
control function in platdata, it is used
set_power(struct plat_lcd_data *, unsigned int power) callback function.
set_power() function is consists of two parameters,
(struct plat_lcd_data *, unsigned int power).

But actually, there is no one to use (struct plat_lcd_data *), only use
second (unsigned int power) value to control lcd power on/off.

I don't know why (struct plat_lcd_data*) parameter is used in set_power()
callback function. Maybe I think it is unessesntial or changeable to another
meaningful variable. For example, struct lcd_device *, it can be used to
control regulator_get() function.

In mach-nuri.c, it has been patching by Minku Kang, (struct lcd_device*) can be
used to regulator lcd power on/off, and many other machines uses regulator
control to on/off lcd power.

So I think more meaningful variable that (struct lcd_device* ) can be
substituted for unessential variable that (struct plat_lcd_data *).

Thank you,
Donghwa Lee


Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---
 drivers/video/backlight/platform_lcd.c |    2 +-
 include/video/platform_lcd.h           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
index 302330a..cf23a3f 100644
--- a/drivers/video/backlight/platform_lcd.c
+++ b/drivers/video/backlight/platform_lcd.c
@@ -49,7 +49,7 @@ static int platform_lcd_set_power(struct lcd_device *lcd, int power)
 	if (power = FB_BLANK_POWERDOWN || plcd->suspended)
 		lcd_power = 0;
 
-	plcd->pdata->set_power(plcd->pdata, lcd_power);
+	plcd->pdata->set_power(lcd, lcd_power);
 	plcd->power = power;
 
 	return 0;
diff --git a/include/video/platform_lcd.h b/include/video/platform_lcd.h
index ad3bdfe..e92a039 100644
--- a/include/video/platform_lcd.h
+++ b/include/video/platform_lcd.h
@@ -15,7 +15,7 @@ struct plat_lcd_data;
 struct fb_info;
 
 struct plat_lcd_data {
-	void	(*set_power)(struct plat_lcd_data *, unsigned int power);
+	void	(*set_power)(struct lcd_device *, unsigned int power);
 	int	(*match_fb)(struct plat_lcd_data *, struct fb_info *);
 };
 
-- 
1.6.0.4

