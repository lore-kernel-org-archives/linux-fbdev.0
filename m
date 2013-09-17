From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 04:58:33 +0000
Subject: [PATCH 03/19] video: nuc900fb: use dev_get_platdata()
Message-Id: <000801ceb362$8fa427f0$aeec77d0$%han@samsung.com>
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
 drivers/video/nuc900fb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
index 796e511..ec32f67 100644
--- a/drivers/video/nuc900fb.c
+++ b/drivers/video/nuc900fb.c
@@ -91,7 +91,7 @@ static int nuc900fb_check_var(struct fb_var_screeninfo *var,
 			       struct fb_info *info)
 {
 	struct nuc900fb_info *fbi = info->par;
-	struct nuc900fb_mach_info *mach_info = fbi->dev->platform_data;
+	struct nuc900fb_mach_info *mach_info = dev_get_platdata(fbi->dev);
 	struct nuc900fb_display *display = NULL;
 	struct nuc900fb_display *default_display = mach_info->displays +
 						   mach_info->default_display;
@@ -358,7 +358,7 @@ static inline void modify_gpio(void __iomem *reg,
 static int nuc900fb_init_registers(struct fb_info *info)
 {
 	struct nuc900fb_info *fbi = info->par;
-	struct nuc900fb_mach_info *mach_info = fbi->dev->platform_data;
+	struct nuc900fb_mach_info *mach_info = dev_get_platdata(fbi->dev);
 	void __iomem *regs = fbi->io;
 
 	/*reset the display engine*/
@@ -512,7 +512,7 @@ static int nuc900fb_probe(struct platform_device *pdev)
 	int size;
 
 	dev_dbg(&pdev->dev, "devinit\n");
-	mach_info = pdev->dev.platform_data;
+	mach_info = dev_get_platdata(&pdev->dev);
 	if (mach_info = NULL) {
 		dev_err(&pdev->dev,
 			"no platform data for lcd, cannot attach\n");
-- 
1.7.10.4


