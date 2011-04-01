From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 01 Apr 2011 07:17:27 +0000
Subject: [PATCH] video: s3c-fb: fix checkpatch errors and warning
Message-Id: <1301642247-20926-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes the checkpatch errors listed below:

ERROR: space required before the open parenthesis '('
ERROR: need consistent spacing around '+' (ctx:WxV)
ERROR: space prohibited before that close parenthesis ')'

Also, following warning is fixed by adding 'platid' variable
which can reduce number of lines exceeding 80 characters.

WARNING: line over 80 characters

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 6817d18..3b6cdca 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -48,7 +48,7 @@
 #undef writel
 #define writel(v, r) do { \
 	printk(KERN_DEBUG "%s: %08x => %p\n", __func__, (unsigned int)v, r); \
-	__raw_writel(v, r); } while(0)
+	__raw_writel(v, r); } while (0)
 #endif /* FB_S3C_DEBUG_REGWRITE */
 
 /* irq_flags bits */
@@ -518,7 +518,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 		data = VIDTCON2_LINEVAL(var->yres - 1) |
 		       VIDTCON2_HOZVAL(var->xres - 1);
-		writel(data, regs +sfb->variant.vidtcon + 8 );
+		writel(data, regs + sfb->variant.vidtcon + 8);
 	}
 
 	/* write the buffer address */
@@ -1304,6 +1304,7 @@ static void s3c_fb_clear_win(struct s3c_fb *sfb, int win)
 
 static int __devinit s3c_fb_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *platid;
 	struct s3c_fb_driverdata *fbdrv;
 	struct device *dev = &pdev->dev;
 	struct s3c_fb_platdata *pd;
@@ -1312,7 +1313,8 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	int win;
 	int ret = 0;
 
-	fbdrv = (struct s3c_fb_driverdata *)platform_get_device_id(pdev)->driver_data;
+	platid = platform_get_device_id(pdev);
+	fbdrv = (struct s3c_fb_driverdata *)platid->driver_data;
 
 	if (fbdrv->variant.nr_windows > S3C_FB_MAX_WIN) {
 		dev_err(dev, "too many windows, cannot attach\n");
-- 
1.7.1

