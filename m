From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:33 +0000
Subject: [PATCH v4 10/24] backlight: pwm: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <1447664207-24370-11-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

pwm_set/get_default_xxx() helpers have been introduced to differentiate
the default PWM states (those retrieved through DT, PWM lookup table or
statically assigned by the driver) and the current ones.
Make use of those helpers where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/lm3630a_bl.c | 4 ++--
 drivers/video/backlight/pwm_bl.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 35fe482..449ebc3 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -162,7 +162,7 @@ static int lm3630a_intr_config(struct lm3630a_chip *pchip)
 
 static void lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int br_max)
 {
-	unsigned int period = pwm_get_period(pchip->pwmd);
+	unsigned int period = pwm_get_default_period(pchip->pwmd);
 	unsigned int duty = br * period / br_max;
 
 	pwm_config(pchip->pwmd, duty, period);
@@ -425,7 +425,7 @@ static int lm3630a_probe(struct i2c_client *client,
 			return PTR_ERR(pchip->pwmd);
 		}
 	}
-	pchip->pwmd->period = pdata->pwm_period;
+	pwm_set_default_period(pchip->pwmd, pdata->pwm_period);
 
 	/* interrupt enable  : irq 0 is not allowed */
 	pchip->irq = client->irq;
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index ae3c6b6..54d5a03 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -293,7 +293,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	 * set the period from platform data if it has not already been set
 	 * via the PWM lookup table.
 	 */
-	pb->period = pwm_get_period(pb->pwm);
+	pb->period = pwm_get_default_period(pb->pwm);
 	if (!pb->period && (data->pwm_period_ns > 0)) {
 		pb->period = data->pwm_period_ns;
 		pwm_set_period(pb->pwm, data->pwm_period_ns);
-- 
2.1.4

