From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Thu, 23 Dec 2010 17:17:51 +0000
Subject: [PATCH] video: imxfb: Fix the maximum value for yres
Message-Id: <1293124671-29426-1-git-send-email-fabio.estevam@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

MX27 and MX25 have 10 bits in the YMAX field of LCDC Size Register.

Fix the maximum value for yres.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/video/imxfb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 5c363d0..5d2d337 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -55,8 +55,10 @@
 
 #ifdef CONFIG_ARCH_MX1
 #define SIZE_YMAX(y)	((y) & 0x1ff)
+#define YMAX_MASK	0x1ff
 #else
 #define SIZE_YMAX(y)	((y) & 0x3ff)
+#define YMAX_MASK	0x3ff
 #endif
 
 #define LCDC_VPW	0x08
@@ -623,7 +625,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->right_margin > 255)
 		printk(KERN_ERR "%s: invalid right_margin %d\n",
 			info->fix.id, var->right_margin);
-	if (var->yres < 1 || var->yres > 511)
+	if (var->yres < 1 || var->yres > YMAX_MASK)
 		printk(KERN_ERR "%s: invalid yres %d\n",
 			info->fix.id, var->yres);
 	if (var->vsync_len > 100)
-- 
1.6.0.4


