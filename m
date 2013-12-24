From: Paul Fertser <fercerpav@gmail.com>
Date: Tue, 24 Dec 2013 09:43:49 +0000
Subject: [PATCH] video/imxfb: add more range-checking for right and left margin values
Message-Id: <1387878229-16516-1-git-send-email-fercerpav@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

A user not familiar with this LCD controller might assume it's
possible to use arbitrary short horizontal margins if the display
allows that. Make it clear it's not.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 drivers/video/imxfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 44ee678..103e175 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -671,10 +671,10 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
-	if (var->left_margin > 255)
+	if (var->left_margin > 255 || var->left_margin < 3)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
-	if (var->right_margin > 255)
+	if (var->right_margin > 255 || var->right_margin < 1)
 		printk(KERN_ERR "%s: invalid right_margin %d\n",
 			info->fix.id, var->right_margin);
 	if (var->yres < 1 || var->yres > ymax_mask)
-- 
1.7.3.4

