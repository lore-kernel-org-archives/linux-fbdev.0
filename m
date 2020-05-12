From: Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Date: Tue, 12 May 2020 20:52:49 +0000
Subject: [PATCH 3/3] video: fbdev: ssd1307fb: Switch to atomic PWM API
Message-Id: <1589316769-13277-3-git-send-email-alencar.fmce@imbel.gov.br>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com, alencar.fmce@imbel.gov.br

Signed-off-by: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
---
 drivers/video/fbdev/ssd1307fb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 748c21c0567b..b1cac4a3722f 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -303,7 +303,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 {
 	int ret;
 	u32 precharge, dclk, com_invdir, compins;
-	struct pwm_args pargs;
+	struct pwm_state pstate;
 
 	if (par->device_info->need_pwm) {
 		par->pwm = pwm_get(&par->client->dev, NULL);
@@ -312,18 +312,18 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 			return PTR_ERR(par->pwm);
 		}
 
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(par->pwm);
+		pwm_init_state(par->pwm, &pstate);
+		par->pwm_period = pstate.period;
 
-		pwm_get_args(par->pwm, &pargs);
-
-		par->pwm_period = pargs.period;
 		/* Enable the PWM */
-		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
-		pwm_enable(par->pwm);
+		pstate.enabled = true;
+		pstate.duty_cycle = pstate.period / 2;
+
+		ret = pwm_apply_state(par->pwm, &pstate);
+		if (ret) {
+			dev_err(&par->client->dev, "Failed to apply PWM state: %d\n", ret);
+			return ret;
+		}
 
 		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
 			par->pwm->pwm, par->pwm_period);
-- 
2.23.0.rc1
