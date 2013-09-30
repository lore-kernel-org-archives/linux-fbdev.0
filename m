From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Sep 2013 08:57:32 +0000
Subject: [PATCH 2/3] video: wm8505fb: Remove redundant of_match_ptr
Message-Id: <1380530733-9070-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Ed Spiridonov <edo.rus@gmail.com>
---
 drivers/video/wm8505fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index 3072f30..2bf6180 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -411,7 +411,7 @@ static struct platform_driver wm8505fb_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= DRIVER_NAME,
-		.of_match_table = of_match_ptr(wmt_dt_ids),
+		.of_match_table = wmt_dt_ids,
 	},
 };
 
-- 
1.7.9.5

