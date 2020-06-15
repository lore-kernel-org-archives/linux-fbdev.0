From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 15 Jun 2020 14:16:05 +0000
Subject: [PATCH 1/2] video: ssd1307fb: Print PWM period using 64-bit format specifier
Message-Id: <20200615141606.2814208-2-thierry.reding@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
In-Reply-To: <20200615141606.2814208-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The PWM core will soon change the duty cycle and period of PWMs to 64
bits to allow for a broader range of values. Use a 64-bit format
specifier to avoid a warning when that change is made.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 8e06ba912d60..09425ec317ba 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -312,7 +312,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		/* Enable the PWM */
 		pwm_enable(par->pwm);
 
-		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
+		dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.\n",
 			par->pwm->pwm, pwm_get_period(par->pwm));
 	}
 
-- 
2.24.1
