From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] nvidia: fix sparse warnings
Date: Fri, 28 Nov 2008 17:15:26 +0100
Message-ID: <4930502e.06e2660a.7d1e.ffffb800@mx.google.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753535AbYK1UKh@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org

Fix this sparse warnings:

  drivers/video/nvidia/nv_accel.c:304:3: warning: returning void-valued expression
  drivers/video/nvidia/nv_accel.c:323:3: warning: returning void-valued expression

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
 drivers/video/nvidia/nv_accel.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/nvidia/nv_accel.c b/drivers/video/nvidia/nv_accel.c
index fa4821c..ad6472a 100644
--- a/drivers/video/nvidia/nv_accel.c
+++ b/drivers/video/nvidia/nv_accel.c
@@ -300,8 +300,10 @@ void nvidiafb_copyarea(struct fb_info *info, const struct fb_copyarea *region)
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
 
-	if (par->lockup)
-		return cfb_copyarea(info, region);
+	if (par->lockup) {
+		cfb_copyarea(info, region);
+		return;
+	}
 
 	NVDmaStart(info, par, BLIT_POINT_SRC, 3);
 	NVDmaNext(par, (region->sy << 16) | region->sx);
@@ -319,8 +321,10 @@ void nvidiafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
 
-	if (par->lockup)
-		return cfb_fillrect(info, rect);
+	if (par->lockup) {
+		cfb_fillrect(info, rect);
+		return;
+	}
 
 	if (info->var.bits_per_pixel == 8)
 		color = rect->color;
-- 
1.5.6.3
