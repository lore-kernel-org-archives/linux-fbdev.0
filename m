From: Timur Tabi <timur@freescale.com>
Date: Mon, 19 Dec 2011 22:26:15 +0000
Subject: [PATCH 2/5] drivers/video: fsl-diu-fb: set correct framebuffer flags
Message-Id: <1324333578-23992-2-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The DIU uses system RAM for the framebuffer, so FBINFO_VIRTFB should be set.

Since the framebuffer is in system RAM, it can be read from more quickly
than written to, so FBINFO_READS_FAST should be set.

We can also set FBINFO_PARTIAL_PAN_OK for the same reasons.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 411a7b3..231752e 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1231,7 +1231,8 @@ static int __devinit install_fb(struct fb_info *info)
 
 	info->var.activate = FB_ACTIVATE_NOW;
 	info->fbops = &fsl_diu_ops;
-	info->flags = FBINFO_DEFAULT;
+	info->flags = FBINFO_DEFAULT | FBINFO_VIRTFB | FBINFO_PARTIAL_PAN_OK |
+		FBINFO_READS_FAST;
 	info->pseudo_palette = mfbi->pseudo_palette;
 
 	rc = fb_alloc_cmap(&info->cmap, 16, 0);
-- 
1.7.3.4


