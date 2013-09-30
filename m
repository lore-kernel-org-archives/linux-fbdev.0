From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Sep 2013 08:57:33 +0000
Subject: [PATCH 3/3] video: wmt_ge_rops: Remove redundant of_match_ptr
Message-Id: <1380530733-9070-3-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Alexey Charkov <alchark@gmail.com>
---
 drivers/video/wmt_ge_rops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
index 4aaeb18..d4ef841 100644
--- a/drivers/video/wmt_ge_rops.c
+++ b/drivers/video/wmt_ge_rops.c
@@ -169,7 +169,7 @@ static struct platform_driver wmt_ge_rops_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "wmt_ge_rops",
-		.of_match_table = of_match_ptr(wmt_dt_ids),
+		.of_match_table = wmt_dt_ids,
 	},
 };
 
-- 
1.7.9.5

