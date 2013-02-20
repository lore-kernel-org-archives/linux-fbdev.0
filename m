From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Feb 2013 17:25:01 +0000
Subject: [PATCH] video: mx3fb: Use NULL for pointer
Message-Id: <1361381101-21325-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following sparse error:

drivers/video/mx3fb.c:1309:28: warning: Using plain integer as NULL pointer

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/video/mx3fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 7368872..cfdb380 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1306,7 +1306,7 @@ static int mx3fb_unmap_video_memory(struct fb_info *fbi)
 	dma_free_writecombine(fbi->device, fbi->fix.smem_len,
 			      fbi->screen_base, fbi->fix.smem_start);
 
-	fbi->screen_base = 0;
+	fbi->screen_base = NULL;
 	mutex_lock(&fbi->mm_lock);
 	fbi->fix.smem_start = 0;
 	fbi->fix.smem_len = 0;
-- 
1.7.9.5

