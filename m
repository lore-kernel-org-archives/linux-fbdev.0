From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 11:41:54 +0000
Subject: [PATCH 6/6] video: uvesafb: Remove redundant NULL check
Message-Id: <1380108594-19090-6-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

kfree on a NULL pointer is a no-op.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michal Januszewski <spock@gentoo.org>
---
 drivers/video/uvesafb.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 7aec6f3..676a4b9 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -233,8 +233,7 @@ out:
 static void uvesafb_free(struct uvesafb_ktask *task)
 {
 	if (task) {
-		if (task->done)
-			kfree(task->done);
+		kfree(task->done);
 		kfree(task);
 	}
 }
@@ -1332,8 +1331,8 @@ setmode:
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 	info->fix.line_length = mode->bytes_per_scan_line;
 
-out:	if (crtc != NULL)
-		kfree(crtc);
+out:
+	kfree(crtc);
 	uvesafb_free(task);
 
 	return err;
@@ -1793,8 +1792,7 @@ out_mode:
 	fb_destroy_modedb(info->monspecs.modedb);
 	fb_dealloc_cmap(&info->cmap);
 out:
-	if (par->vbe_modes)
-		kfree(par->vbe_modes);
+	kfree(par->vbe_modes);
 
 	framebuffer_release(info);
 	return err;
@@ -1817,12 +1815,9 @@ static int uvesafb_remove(struct platform_device *dev)
 		fb_dealloc_cmap(&info->cmap);
 
 		if (par) {
-			if (par->vbe_modes)
-				kfree(par->vbe_modes);
-			if (par->vbe_state_orig)
-				kfree(par->vbe_state_orig);
-			if (par->vbe_state_saved)
-				kfree(par->vbe_state_saved);
+			kfree(par->vbe_modes);
+			kfree(par->vbe_state_orig);
+			kfree(par->vbe_state_saved);
 		}
 
 		framebuffer_release(info);
-- 
1.7.9.5

