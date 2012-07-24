From: Donghwa Lee <dh09.lee@samsung.com>
Date: Tue, 24 Jul 2012 02:19:25 +0000
Subject: [PATCH v2] video: exynos: s6e8ax0: support early fb event of fb_blank()
Message-Id: <500E062D.2020307@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch supports early fb event of fb_blank().

- In case of lcd power off : call early_set_power() interface and lcd
power is off. And then framebuffer is blanked.

- In case of lcd power on : First, framebuffer is unblanked, and then
call set_power() interface to turn lcd on.

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes of v1:
	- changes function name from s6e8aa0_early_set_power() to
	s6e8ax0_early_set_power()

 drivers/video/exynos/s6e8ax0.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/video/exynos/s6e8ax0.c b/drivers/video/exynos/s6e8ax0.c
index 05d080b..bfb1919 100644
--- a/drivers/video/exynos/s6e8ax0.c
+++ b/drivers/video/exynos/s6e8ax0.c
@@ -663,6 +663,37 @@ static int s6e8ax0_gamma_ctrl(struct s6e8ax0 *lcd, int gamma)
 	return 0;
 }
 
+static int s6e8ax0_early_set_power(struct lcd_device *ld, int power)
+{
+	struct s6e8ax0 *lcd = lcd_get_data(ld);
+	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
+	int ret = 0;
+
+	if (power != FB_BLANK_UNBLANK && power != FB_BLANK_POWERDOWN &&
+			power != FB_BLANK_NORMAL) {
+		dev_err(lcd->dev, "power value should be 0, 1 or 4.\n");
+		return -EINVAL;
+	}
+
+	if (lcd->power = power) {
+		dev_err(lcd->dev, "power mode is same as previous one.\n");
+		return -EINVAL;
+	}
+
+	if (ops->set_early_blank_mode) {
+		/* LCD power off */
+		if ((POWER_IS_OFF(power) && POWER_IS_ON(lcd->power))
+			|| (POWER_IS_ON(lcd->power) && POWER_IS_NRM(power))) {
+			ret = ops->set_early_blank_mode(lcd_to_master(lcd),
+							power);
+			if (!ret && lcd->power != power)
+				lcd->power = power;
+		}
+	}
+
+	return ret;
+}
+
 static int s6e8ax0_set_power(struct lcd_device *ld, int power)
 {
 	struct s6e8ax0 *lcd = lcd_get_data(ld);
@@ -731,6 +762,7 @@ static int s6e8ax0_set_brightness(struct backlight_device *bd)
 }
 
 static struct lcd_ops s6e8ax0_lcd_ops = {
+	.early_set_power = s6e8ax0_early_set_power,
 	.set_power = s6e8ax0_set_power,
 	.get_power = s6e8ax0_get_power,
 };
-- 
1.7.4.1
