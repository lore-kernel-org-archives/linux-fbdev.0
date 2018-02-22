From: Claudiu Beznea <claudiu.beznea@microchip.com>
Date: Thu, 22 Feb 2018 12:01:15 +0000
Subject: [PATCH v3 04/10] pwm: pxa: populate PWM mode in of_xlate function
Message-Id: <1519300881-8136-5-git-send-email-claudiu.beznea@microchip.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thierry.reding@gmail.com, shc_work@mail.ru, kgene@kernel.org, krzk@kernel.org, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, kamil@wypas.org, b.zolnierkie@samsung.com, jdelvare@suse.com, linux@roeck-us.net, dmitry.torokhov@gmail.com, rpurdie@rpsys.net, jacek.anaszewski@gmail.com, pavel@ucw.cz, mchehab@kernel.org, sean@mess.org, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, milo.kim@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

Populate PWM mode in of_xlate function to avoid pwm_apply_state() failure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-pxa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 4143a46684d2..7a035716e054 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -155,12 +155,16 @@ static struct pwm_device *
 pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
+	struct pwm_caps caps;
 
 	pwm = pwm_request_from_chip(pc, 0, NULL);
 	if (IS_ERR(pwm))
 		return pwm;
 
+	pwm_get_caps(pc, pwm, &caps);
+
 	pwm->args.period = args->args[0];
+	pwm->args.mode = BIT(ffs(caps.modes) - 1);
 
 	return pwm;
 }
-- 
2.7.4

