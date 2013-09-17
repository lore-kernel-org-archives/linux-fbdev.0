From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 04:59:59 +0000
Subject: [PATCH 05/19] video: pxa168fb: use dev_get_platdata()
Message-Id: <000a01ceb362$c29d51e0$47d7f5a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/pxa168fb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index aa9bd1f..c95b9e4 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -364,7 +364,7 @@ static void set_graphics_start(struct fb_info *info, int xoffset, int yoffset)
 static void set_dumb_panel_control(struct fb_info *info)
 {
 	struct pxa168fb_info *fbi = info->par;
-	struct pxa168fb_mach_info *mi = fbi->dev->platform_data;
+	struct pxa168fb_mach_info *mi = dev_get_platdata(fbi->dev);
 	u32 x;
 
 	/*
@@ -407,7 +407,7 @@ static int pxa168fb_set_par(struct fb_info *info)
 	u32 x;
 	struct pxa168fb_mach_info *mi;
 
-	mi = fbi->dev->platform_data;
+	mi = dev_get_platdata(fbi->dev);
 
 	/*
 	 * Set additional mode info.
@@ -609,7 +609,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int irq, ret;
 
-	mi = pdev->dev.platform_data;
+	mi = dev_get_platdata(&pdev->dev);
 	if (mi = NULL) {
 		dev_err(&pdev->dev, "no platform data defined\n");
 		return -EINVAL;
-- 
1.7.10.4


