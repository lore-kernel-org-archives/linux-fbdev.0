From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:04:50 +0000
Subject: [PATCH 11/19] video: da8xx-fb: use dev_get_platdata()
Message-Id: <001001ceb363$703f1680$50bd4380$%han@samsung.com>
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
 drivers/video/da8xx-fb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index e030e17..70fc8e8 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1314,7 +1314,7 @@ static struct fb_ops da8xx_fb_ops = {
 
 static struct fb_videomode *da8xx_fb_get_videomode(struct platform_device *dev)
 {
-	struct da8xx_lcdc_platform_data *fb_pdata = dev->dev.platform_data;
+	struct da8xx_lcdc_platform_data *fb_pdata = dev_get_platdata(&dev->dev);
 	struct fb_videomode *lcdc_info;
 	int i;
 
@@ -1336,7 +1336,7 @@ static struct fb_videomode *da8xx_fb_get_videomode(struct platform_device *dev)
 static int fb_probe(struct platform_device *device)
 {
 	struct da8xx_lcdc_platform_data *fb_pdata -						device->dev.platform_data;
+						dev_get_platdata(&device->dev);
 	static struct resource *lcdc_regs;
 	struct lcd_ctrl_config *lcd_cfg;
 	struct fb_videomode *lcdc_info;
-- 
1.7.10.4


