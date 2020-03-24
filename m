From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 24 Mar 2020 17:05:31 +0000
Subject: [PATCH v1 4/5] video: ssd1307fb: Convert to atomic PWM API
Message-Id: <20200324170532.44384-4-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the atomic API wherever appropriate and get rid of pwm_apply_args()
call (the reference period and polarity are now explicitly set when
calling pwm_apply_state()).

We also make use of the pwm_set_relative_duty_cycle() helper to ease
relative to absolute duty_cycle conversion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/ssd1307fb.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 7a6a44a0b7a6..6e543396002a 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -79,7 +79,6 @@ struct ssd1307fb_par {
 	u32 prechargep1;
 	u32 prechargep2;
 	struct pwm_device *pwm;
-	u32 pwm_period;
 	struct gpio_desc *reset;
 	struct regulator *vbat_reg;
 	u32 vcomh;
@@ -297,9 +296,9 @@ static void ssd1307fb_deferred_io(struct fb_info *info,
 
 static int ssd1307fb_init(struct ssd1307fb_par *par)
 {
+	struct pwm_state pwmstate;
 	int ret;
 	u32 precharge, dclk, com_invdir, compins;
-	struct pwm_args pargs;
 
 	if (par->device_info->need_pwm) {
 		par->pwm = pwm_get(&par->client->dev, NULL);
@@ -308,21 +307,15 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 			return PTR_ERR(par->pwm);
 		}
 
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(par->pwm);
+		pwm_init_state(par->pwm, &pwmstate);
+		pwm_set_relative_duty_cycle(&pwmstate, 50, 100);
+		pwm_apply_state(par->pwm, &pwmstate);
 
-		pwm_get_args(par->pwm, &pargs);
-
-		par->pwm_period = pargs.period;
 		/* Enable the PWM */
-		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
 		pwm_enable(par->pwm);
 
 		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
-			par->pwm->pwm, par->pwm_period);
+			par->pwm->pwm, pwm_get_period(par->pwm));
 	}
 
 	/* Set initial contrast */
-- 
2.25.1
