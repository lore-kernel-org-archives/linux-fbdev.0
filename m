From: Johan Hovold <jhovold@gmail.com>
Date: Wed, 23 Oct 2013 09:55:37 +0000
Subject: [PATCH 3/9] backlight: atmel-pwm-bl: fix module autoload
Message-Id: <1382522143-32072-4-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382522143-32072-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382522143-32072-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Add missing module alias which is needed for module autoloading.

Acked-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/video/backlight/atmel-pwm-bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
index 3cb0094..cc5a5ed 100644
--- a/drivers/video/backlight/atmel-pwm-bl.c
+++ b/drivers/video/backlight/atmel-pwm-bl.c
@@ -229,3 +229,4 @@ module_platform_driver(atmel_pwm_bl_driver);
 MODULE_AUTHOR("Hans-Christian egtvedt <hans-christian.egtvedt@atmel.com>");
 MODULE_DESCRIPTION("Atmel PWM backlight driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:atmel-pwm-bl");
-- 
1.8.4

