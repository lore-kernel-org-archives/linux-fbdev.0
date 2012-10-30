From: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Tue, 30 Oct 2012 18:14:54 +0000
Subject: [PATCH] pwm-backlight: Pinctrl-fy
Message-Id: <1351699047-4487-1-git-send-email-panto@antoniou-consulting.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org

Enable pinctrl for pwm-backlight.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 drivers/video/backlight/pwm_bl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 0c91023..f3b6194 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -20,6 +20,8 @@
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/slab.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/err.h>
 
 struct pwm_bl_data {
 	struct pwm_device	*pwm;
@@ -180,9 +182,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct pwm_bl_data *pb;
+	struct pinctrl *pinctrl;
 	unsigned int max;
 	int ret;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "unable to select pin group\n");
+
 	if (!data) {
 		ret = pwm_backlight_parse_dt(&pdev->dev, &defdata);
 		if (ret < 0) {
-- 
1.7.12

