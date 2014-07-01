From: Scott Jiang <scott.jiang.linux@gmail.com>
Date: Tue, 01 Jul 2014 06:57:24 +0000
Subject: [PATCH] fb: adv7393: add missing semicolon
Message-Id: <1404284022-24866-1-git-send-email-scott.jiang.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit f8bd493456c3da372ae81ed8f6b903f6207b9d98 by Jingoo Han
introduced this problem. This makes bfin_adv7393fb.c failed to compile.

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 drivers/video/fbdev/bfin_adv7393fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/bfin_adv7393fb.c b/drivers/video/fbdev/bfin_adv7393fb.c
index a54f7f7..8fe41ca 100644
--- a/drivers/video/fbdev/bfin_adv7393fb.c
+++ b/drivers/video/fbdev/bfin_adv7393fb.c
@@ -408,7 +408,7 @@ static int bfin_adv7393_fb_probe(struct i2c_client *client,
 	/* Workaround "PPI Does Not Start Properly In Specific Mode" */
 	if (ANOMALY_05000400) {
 		ret = gpio_request_one(P_IDENT(P_PPI0_FS3), GPIOF_OUT_INIT_LOW,
-					"PPI0_FS3")
+					"PPI0_FS3");
 		if (ret) {
 			dev_err(&client->dev, "PPI0_FS3 GPIO request failed\n");
 			ret = -EBUSY;
-- 
1.7.9.5

