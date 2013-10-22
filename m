From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 22 Oct 2013 17:26:56 +0000
Subject: [PATCH 6/9] backlight: atmel-pwm-bl: remove unused include
Message-Id: <1382462819-28576-7-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Remove unused include of clk.h.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/video/backlight/atmel-pwm-bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
index 504061c..db68cab 100644
--- a/drivers/video/backlight/atmel-pwm-bl.c
+++ b/drivers/video/backlight/atmel-pwm-bl.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/fb.h>
-#include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/backlight.h>
 #include <linux/atmel_pwm.h>
-- 
1.8.4

