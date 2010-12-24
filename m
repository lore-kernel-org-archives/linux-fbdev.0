From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Fri, 24 Dec 2010 12:28:24 +0000
Subject: [PATCH v3] video: imxfb: Fix the maximum value for yres
Message-Id: <1293193704-2855-1-git-send-email-fabio.estevam@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

MX27 and MX25 have 10 bits in the YMAX field of LCDC Size Register.

Fix the maximum value for yres.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Perform run-time detection of CPU time

Changes since v1:
- factor out SIZE_YMAX definition
 drivers/video/imxfb.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 5c363d0..1ab2c25 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -53,11 +53,8 @@
 #define LCDC_SIZE	0x04
 #define SIZE_XMAX(x)	((((x) >> 4) & 0x3f) << 20)
 
-#ifdef CONFIG_ARCH_MX1
-#define SIZE_YMAX(y)	((y) & 0x1ff)
-#else
-#define SIZE_YMAX(y)	((y) & 0x3ff)
-#endif
+#define YMAX_MASK       (cpu_is_mx1() ? 0x1ff : 0x3ff)
+#define SIZE_YMAX(y)	((y) & YMAX_MASK)
 
 #define LCDC_VPW	0x08
 #define VPW_VPW(x)	((x) & 0x3ff)
@@ -623,7 +620,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
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


