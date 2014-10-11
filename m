From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date: Sat, 11 Oct 2014 13:46:26 +0000
Subject: [PATCH 2/2] backlight: pwm: clean up pwm requested using legacy API
Message-Id: <1413035186-11771-3-git-send-email-vladimir_zapolskiy@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org

If PWM device is requested by means of legacy API pwm_request(), its
resources are not freed on module unbind, which may cause an oops on
access, e.g. by reading /sys/kernel/debug/pwm.

Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/video/backlight/pwm_bl.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index dd7aaf7..40770dd 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -34,6 +34,7 @@ struct pwm_bl_data {
 	struct regulator	*power_supply;
 	struct gpio_desc	*enable_gpio;
 	unsigned int		scale;
+	bool			legacy;
 	int			(*notify)(struct device *,
 					  int brightness);
 	void			(*notify_after)(struct device *,
@@ -274,6 +275,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm) && !pdev->dev.of_node) {
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
+		pb->legacy = true;
 		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
 	}
 
@@ -339,6 +341,8 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 
 	if (pb->exit)
 		pb->exit(&pdev->dev);
+	if (pb->legacy)
+		pwm_free(pb->pwm);
 
 	return 0;
 }
-- 
1.7.10.4

