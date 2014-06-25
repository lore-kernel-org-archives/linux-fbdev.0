From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Jun 2014 09:18:18 +0000
Subject: [PATCH] pwm-backlight: use devm_gpiod_get_optional()
Message-Id: <1403687898-26881-1-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>

Make use of the new devm_gpiod_get_optional() to simplify the probe
code.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 38ca88bc5c3e..d1e0a7c6cac7 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -245,13 +245,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->dev = &pdev->dev;
 	pb->enabled = false;
 
-	pb->enable_gpio = devm_gpiod_get(&pdev->dev, "enable");
+	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
 	if (IS_ERR(pb->enable_gpio)) {
 		ret = PTR_ERR(pb->enable_gpio);
-		if (ret = -ENOENT)
-			pb->enable_gpio = NULL;
-		else
-			goto err_alloc;
+		goto err_alloc;
 	}
 
 	/*
-- 
2.0.0

