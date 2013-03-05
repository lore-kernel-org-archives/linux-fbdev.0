From: Syam Sidhardhan <syamsidhardh@gmail.com>
Date: Tue, 05 Mar 2013 19:50:37 +0000
Subject: [PATCH] video: uvesafb: Remove redundant NULL check before kfree
Message-Id: <1362512317-3880-1-git-send-email-s.syam@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

kfree on NULL pointer is a no-op.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 drivers/video/uvesafb.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index b75db01..7ac0ce6 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -236,8 +236,7 @@ out:
 static void uvesafb_free(struct uvesafb_ktask *task)
 {
 	if (task) {
-		if (task->done)
-			kfree(task->done);
+		kfree(task->done);
 		kfree(task);
 	}
 }
@@ -1335,8 +1334,8 @@ setmode:
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 	info->fix.line_length = mode->bytes_per_scan_line;
 
-out:	if (crtc != NULL)
-		kfree(crtc);
+out:
+	kfree(crtc);
 	uvesafb_free(task);
 
 	return err;
@@ -1833,8 +1832,7 @@ out_mode:
 	fb_destroy_modedb(info->monspecs.modedb);
 	fb_dealloc_cmap(&info->cmap);
 out:
-	if (par->vbe_modes)
-		kfree(par->vbe_modes);
+	kfree(par->vbe_modes);
 
 	framebuffer_release(info);
 	return err;
@@ -1856,12 +1854,9 @@ static int uvesafb_remove(struct platform_device *dev)
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

