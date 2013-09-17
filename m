From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:01:38 +0000
Subject: [PATCH 07/19] video: s3c2410: use dev_get_platdata()
Message-Id: <000c01ceb362$fdca3ee0$f95ebca0$%han@samsung.com>
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
 drivers/video/s3c2410fb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 21a32ad..81af5a6 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -123,7 +123,7 @@ static int s3c2410fb_check_var(struct fb_var_screeninfo *var,
 			       struct fb_info *info)
 {
 	struct s3c2410fb_info *fbi = info->par;
-	struct s3c2410fb_mach_info *mach_info = fbi->dev->platform_data;
+	struct s3c2410fb_mach_info *mach_info = dev_get_platdata(fbi->dev);
 	struct s3c2410fb_display *display = NULL;
 	struct s3c2410fb_display *default_display = mach_info->displays +
 						    mach_info->default_display;
@@ -686,7 +686,7 @@ static inline void modify_gpio(void __iomem *reg,
 static int s3c2410fb_init_registers(struct fb_info *info)
 {
 	struct s3c2410fb_info *fbi = info->par;
-	struct s3c2410fb_mach_info *mach_info = fbi->dev->platform_data;
+	struct s3c2410fb_mach_info *mach_info = dev_get_platdata(fbi->dev);
 	unsigned long flags;
 	void __iomem *regs = fbi->io;
 	void __iomem *tpal;
@@ -833,7 +833,7 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
 	int size;
 	u32 lcdcon1;
 
-	mach_info = pdev->dev.platform_data;
+	mach_info = dev_get_platdata(&pdev->dev);
 	if (mach_info = NULL) {
 		dev_err(&pdev->dev,
 			"no platform data for lcd, cannot attach\n");
-- 
1.7.10.4


