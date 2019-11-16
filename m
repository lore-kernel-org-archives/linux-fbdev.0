From: Chuhong Yuan <hslester96@gmail.com>
Date: Sat, 16 Nov 2019 15:44:16 +0000
Subject: [PATCH] video: fbdev: arcfb: add missed free_irq
Message-Id: <20191116154416.19390-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jaya Kumar <jayalk@intworks.biz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>

The driver forgets to free irq in remove which is requested in
probe.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/arcfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index a48741aab240..7aed01f001a4 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -590,8 +590,11 @@ static int arcfb_probe(struct platform_device *dev)
 static int arcfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
+	struct arcfb_par *par = info->par;
 
 	if (info) {
+		if (irq)
+			free_irq(par->irq, info);
 		unregister_framebuffer(info);
 		vfree((void __force *)info->screen_base);
 		framebuffer_release(info);
-- 
2.24.0
