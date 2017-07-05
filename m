From: Lynn Lei <lynnl.yet@gmail.com>
Date: Wed, 05 Jul 2017 15:44:08 +0000
Subject: [PATCH] video: backlight: gpio_backlight.c: make of_device_id structure const
Message-Id: <20170705153838.GA31888@lynnl.yet>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fixed a of_device_id structure normally be const warning issue checked by
scripts/checkpatch.pl:
  WARNING: struct of_device_id should normally be const

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/video/backlight/gpio_backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 18134416b154..97d976f433c4 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -146,7 +146,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id gpio_backlight_of_match[] = {
+static const struct of_device_id gpio_backlight_of_match[] = {
 	{ .compatible = "gpio-backlight" },
 	{ /* sentinel */ }
 };
-- 
2.13.2

