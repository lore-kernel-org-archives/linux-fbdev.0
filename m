From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Tue, 20 Nov 2012 09:19:05 +0000
Subject: [PATCH 1/1] video: softcursor: Remove redundant NULL check before kfree
Message-Id: <1353402425-23120-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

kfree on a NULL pointer is a no-op.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/console/softcursor.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/softcursor.c b/drivers/video/console/softcursor.c
index 25f835b..46dd8f5 100644
--- a/drivers/video/console/softcursor.c
+++ b/drivers/video/console/softcursor.c
@@ -35,8 +35,7 @@ int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	dsize = s_pitch * cursor->image.height;
 
 	if (dsize + sizeof(struct fb_image) != ops->cursor_size) {
-		if (ops->cursor_src != NULL)
-			kfree(ops->cursor_src);
+		kfree(ops->cursor_src);
 		ops->cursor_size = dsize + sizeof(struct fb_image);
 
 		ops->cursor_src = kmalloc(ops->cursor_size, GFP_ATOMIC);
-- 
1.7.4.1

