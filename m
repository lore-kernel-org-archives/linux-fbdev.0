From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 16 Oct 2017 19:04:52 +0000
Subject: [PATCH 6/8] video: fbdev: au1200fb: Remove some dead code
Message-Id: <d4ef5b40a6ba8b468bd22cc8e429260c42b2fb7f.1508179264.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

There is no need to shut gcc up. It should not complain.
Axe 'fbdev', it is never used in this function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/au1200fb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index e531543bc707..970ce761ff89 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1667,10 +1667,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 	printk(DRIVER_NAME ": Panel %d %s\n", panel_index, panel->name);
 	printk(DRIVER_NAME ": Win %d %s\n", window_index, win->name);
 
-	/* shut gcc up */
-	ret = 0;
-	fbdev = NULL;
-
 	for (plane = 0; plane < device_count; ++plane) {
 		bpp = winbpp(win->w[plane].mode_winctrl1);
 		if (win->w[plane].xres = 0)
@@ -1780,7 +1776,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 static int au1200fb_drv_remove(struct platform_device *dev)
 {
 	struct au1200fb_platdata *pd = platform_get_drvdata(dev);
-	struct au1200fb_device *fbdev;
 	struct fb_info *fbi;
 	int plane;
 
@@ -1789,7 +1784,6 @@ static int au1200fb_drv_remove(struct platform_device *dev)
 
 	for (plane = 0; plane < device_count; ++plane)	{
 		fbi = _au1200fb_infos[plane];
-		fbdev = fbi->par;
 
 		/* Clean up all probe data */
 		unregister_framebuffer(fbi);
-- 
2.11.0

