From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Wed, 30 Mar 2016 20:04:07 +0000
Subject: [PATCH v5 44/46] video: ssd1307fb: switch to the atomic PWM API
Message-Id: <1459368249-13241-45-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

pwm_config/enable/disable() have been deprecated and should be replaced
by pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/fbdev/ssd1307fb.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index df9c63a..ed9a115 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -289,6 +289,8 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	struct pwm_args pargs = { };
 
 	if (par->device_info->need_pwm) {
+		struct pwm_state pstate;
+
 		par->pwm = pwm_get(&par->client->dev, NULL);
 		if (IS_ERR(par->pwm)) {
 			dev_err(&par->client->dev, "Could not get PWM from device tree!\n");
@@ -296,10 +298,14 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		}
 
 		pwm_get_args(par->pwm, &pargs);
+		pwm_get_state(par->pwm, &pstate);
 		par->pwm_period = pargs.period;
+
 		/* Enable the PWM */
-		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
-		pwm_enable(par->pwm);
+		pstate.period = pargs.period;
+		pstate.duty_cycle = pstate.period / 2;
+		pstate.enabled = true;
+		pwm_apply_state(par->pwm, &pstate);
 
 		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
 			par->pwm->pwm, par->pwm_period);
@@ -685,8 +691,12 @@ static int ssd1307fb_probe(struct i2c_client *client,
 bl_init_error:
 	unregister_framebuffer(info);
 panel_init_error:
-	if (par->device_info->need_pwm) {
-		pwm_disable(par->pwm);
+	if (par->device_info->need_pwm && par->pwm) {
+		struct pwm_state pstate;
+
+		pwm_get_state(par->pwm, &pstate);
+		pstate.enabled = false;
+		pwm_apply_state(par->pwm, &pstate);
 		pwm_put(par->pwm);
 	};
 reset_oled_error:
@@ -707,7 +717,11 @@ static int ssd1307fb_remove(struct i2c_client *client)
 
 	unregister_framebuffer(info);
 	if (par->device_info->need_pwm) {
-		pwm_disable(par->pwm);
+		struct pwm_state pstate;
+
+		pwm_get_state(par->pwm, &pstate);
+		pstate.enabled = false;
+		pwm_apply_state(par->pwm, &pstate);
 		pwm_put(par->pwm);
 	};
 	fb_deferred_io_cleanup(info);
-- 
2.5.0

