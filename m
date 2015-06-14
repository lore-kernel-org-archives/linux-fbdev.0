From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date: Sun, 14 Jun 2015 14:32:14 +0000
Subject: [PATCH] backlight: pwm: free pwm requested by legacy API on error path
Message-Id: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

If pwm is requested by legacy pwm_request() and if the following
backlight_device_register() call fails, add pwm_free() clean-up.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/video/backlight/pwm_bl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9991cdb..a691247 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -307,6 +307,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	if (IS_ERR(bl)) {
 		dev_err(&pdev->dev, "failed to register backlight\n");
 		ret = PTR_ERR(bl);
+		if (pb->legacy)
+			pwm_free(pb->pwm);
 		goto err_alloc;
 	}
 
-- 
2.1.4

