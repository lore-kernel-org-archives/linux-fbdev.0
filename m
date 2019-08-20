From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 20 Aug 2019 15:34:39 +0000
Subject: [PATCH] video: backlight: tosa_lcd: drop check because i2c_unregister_device() is NULL safe
Message-Id: <20190820153439.7638-1-wsa+renesas@sang-engineering.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only, buildbot is happy, too.

Please apply to your tree.

 drivers/video/backlight/tosa_lcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index 65cb7578776f..29af8e27b6e5 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -222,8 +222,7 @@ static int tosa_lcd_remove(struct spi_device *spi)
 {
 	struct tosa_lcd_data *data = spi_get_drvdata(spi);
 
-	if (data->i2c)
-		i2c_unregister_device(data->i2c);
+	i2c_unregister_device(data->i2c);
 
 	tosa_lcd_tg_off(data);
 
-- 
2.20.1
