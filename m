From: Chuhong Yuan <hslester96@gmail.com>
Date: Sat, 16 Nov 2019 15:13:18 +0000
Subject: [PATCH] video: fbdev: vesafb: add missed release_region
Message-Id: <20191116151318.17874-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>

This driver calls request_region in probe but forgets to call
release_region in probe failure and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/vesafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index d9c08f6c2155..fbb196a8bbf6 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -468,6 +468,7 @@ static int vesafb_probe(struct platform_device *dev)
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
 err:
+	release_region(0x3c0, 32);
 	arch_phys_wc_del(par->wc_cookie);
 	if (info->screen_base)
 		iounmap(info->screen_base);
@@ -480,6 +481,7 @@ static int vesafb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
+	release_region(0x3c0, 32);
 	unregister_framebuffer(info);
 	framebuffer_release(info);
 
-- 
2.24.0
