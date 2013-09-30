From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Sep 2013 08:57:31 +0000
Subject: [PATCH 1/3] video: ssd1307fb: Remove redundant of_match_ptr
Message-Id: <1380530733-9070-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/ssd1307fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/ssd1307fb.c b/drivers/video/ssd1307fb.c
index 44967c8..f4daa59 100644
--- a/drivers/video/ssd1307fb.c
+++ b/drivers/video/ssd1307fb.c
@@ -569,7 +569,7 @@ static struct i2c_driver ssd1307fb_driver = {
 	.id_table = ssd1307fb_i2c_id,
 	.driver = {
 		.name = "ssd1307fb",
-		.of_match_table = of_match_ptr(ssd1307fb_of_match),
+		.of_match_table = ssd1307fb_of_match,
 		.owner = THIS_MODULE,
 	},
 };
-- 
1.7.9.5

