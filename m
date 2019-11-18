From: Chuhong Yuan <hslester96@gmail.com>
Date: Mon, 18 Nov 2019 08:09:00 +0000
Subject: [PATCH] fbdev: s1d13xxxfb: add missed unregister_framebuffer in remove
Message-Id: <20191118080900.30634-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>

The driver calls register_framebuffer in probe but does not call
unregister_framebuffer in remove.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/s1d13xxxfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index e04efb567b5c..162003ea6b79 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -729,6 +729,7 @@ s1d13xxxfb_remove(struct platform_device *pdev)
 	struct s1d13xxxfb_par *par = NULL;
 
 	if (info) {
+		unregister_framebuffer(info);
 		par = info->par;
 		if (par && par->regs) {
 			/* disable output & enable powersave */
-- 
2.24.0
