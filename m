From: Arun Bharadwaj <arun@gumstix.com>
Date: Thu, 16 Apr 2015 00:21:24 +0000
Subject: [PATCH] gpio-backlight: Discover driver during boot time
Message-Id: <1429143684-3371-1-git-send-email-arun@gumstix.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ash Charles <ashcharles@gmail.com>

The gpio-backlight driver seems to be missing the
MODULE_DEVICE_TABLE line which is preventing it from
being modprobed during boot time even if the
gpio-backlight device exists.

This seems to be a bug and this patch attempts to
fix that.

Signed-off-by: Arun Bharadwaj <arun@gumstix.com>
Signed-off-by: Ash Charles <ashcharles@gmail.com>
---
 drivers/video/backlight/gpio_backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 439feb2..5fbbc2e 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -146,6 +146,8 @@ static struct of_device_id gpio_backlight_of_match[] = {
 	{ .compatible = "gpio-backlight" },
 	{ /* sentinel */ }
 };
+
+MODULE_DEVICE_TABLE(of, gpio_backlight_of_match);
 #endif
 
 static struct platform_driver gpio_backlight_driver = {
-- 
1.9.1

