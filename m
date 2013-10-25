From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 25 Oct 2013 12:11:33 +0000
Subject: [PATCH 1/1] backlight: hx8357: Remove redundant of_match_ptr
Message-Id: <1382702373-19573-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'hx8357_dt_ids' is always compiled in. Hence of_match_ptr is
not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/backlight/hx8357.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index c7af8c4..5a4dd33 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -685,7 +685,7 @@ static struct spi_driver hx8357_driver = {
 	.remove = hx8357_remove,
 	.driver = {
 		.name = "hx8357",
-		.of_match_table = of_match_ptr(hx8357_dt_ids),
+		.of_match_table = hx8357_dt_ids,
 	},
 };
 
-- 
1.7.9.5

