From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 11:41:50 +0000
Subject: [PATCH 2/6] video: smscufx: Use NULL instead of 0
Message-Id: <1380108594-19090-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'info' is a pointer. Use NULL instead of 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Steve Glendinning <steve.glendinning@shawell.net>
---
 drivers/video/smscufx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
index e188ada..d513ed6 100644
--- a/drivers/video/smscufx.c
+++ b/drivers/video/smscufx.c
@@ -1147,7 +1147,7 @@ static void ufx_free_framebuffer_work(struct work_struct *work)
 
 	fb_destroy_modelist(&info->modelist);
 
-	dev->info = 0;
+	dev->info = NULL;
 
 	/* Assume info structure is freed after this point */
 	framebuffer_release(info);
-- 
1.7.9.5

