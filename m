From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 29 Oct 2013 16:27:37 +0000
Subject: [PATCH v2 2/9] backlight: atmel-pwm-bl: fix gpio polarity in remove
Message-Id: <1383064064-4983-3-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382522143-32072-1-git-send-email-jhovold@gmail.com>
 <1383064064-4983-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1383064064-4983-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>, stable@vger.kernel.org

Make sure to honour gpio polarity also at remove so that the backlight
is actually disabled on boards with active-low enable pin.

Cc: stable@vger.kernel.org
Acked-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/video/backlight/atmel-pwm-bl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
index 0971a8e..e21beb6 100644
--- a/drivers/video/backlight/atmel-pwm-bl.c
+++ b/drivers/video/backlight/atmel-pwm-bl.c
@@ -205,8 +205,10 @@ static int atmel_pwm_bl_remove(struct platform_device *pdev)
 {
 	struct atmel_pwm_bl *pwmbl = platform_get_drvdata(pdev);
 
-	if (pwmbl->gpio_on != -1)
-		gpio_set_value(pwmbl->gpio_on, 0);
+	if (pwmbl->gpio_on != -1) {
+		gpio_set_value(pwmbl->gpio_on,
+					0 ^ pwmbl->pdata->on_active_low);
+	}
 	pwm_channel_disable(&pwmbl->pwmc);
 	pwm_channel_free(&pwmbl->pwmc);
 
-- 
1.8.4.2

