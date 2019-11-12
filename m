From: Colin King <colin.king@canonical.com>
Date: Tue, 12 Nov 2019 09:30:25 +0000
Subject: [PATCH][next] backlight: qcom-wled: fix spelling mistake "trigged" -> "triggered"
Message-Id: <20191112093025.98638-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/backlight/qcom-wled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 33b6007c5e55..d46052d8ff41 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -322,7 +322,7 @@ static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
 		wled->short_count = 1;
 
 	if (wled->short_count > WLED_SHORT_CNT_MAX) {
-		dev_err(wled->dev, "Short trigged %d times, disabling WLED forever!\n",
+		dev_err(wled->dev, "Short triggered %d times, disabling WLED forever!\n",
 			wled->short_count);
 		wled->disabled_by_short = true;
 		goto unlock_mutex;
-- 
2.20.1
