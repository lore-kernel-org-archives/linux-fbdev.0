From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:11:34 +0000
Subject: [PATCH 18/19] video: tmiofb: use dev_get_platdata()
Message-Id: <001801ceb364$611f5d30$235e1790$%han@samsung.com>
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
 drivers/video/tmiofb.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index deb8733..b5b69a6 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -250,7 +250,7 @@ static irqreturn_t tmiofb_irq(int irq, void *__info)
  */
 static int tmiofb_hw_stop(struct platform_device *dev)
 {
-	struct tmio_fb_data *data = dev->dev.platform_data;
+	struct tmio_fb_data *data = dev_get_platdata(&dev->dev);
 	struct fb_info *info = platform_get_drvdata(dev);
 	struct tmiofb_par *par = info->par;
 
@@ -311,7 +311,7 @@ static int tmiofb_hw_init(struct platform_device *dev)
  */
 static void tmiofb_hw_mode(struct platform_device *dev)
 {
-	struct tmio_fb_data *data = dev->dev.platform_data;
+	struct tmio_fb_data *data = dev_get_platdata(&dev->dev);
 	struct fb_info *info = platform_get_drvdata(dev);
 	struct fb_videomode *mode = info->mode;
 	struct tmiofb_par *par = info->par;
@@ -557,7 +557,7 @@ static int tmiofb_ioctl(struct fb_info *fbi,
 static struct fb_videomode *
 tmiofb_find_mode(struct fb_info *info, struct fb_var_screeninfo *var)
 {
-	struct tmio_fb_data *data = info->device->platform_data;
+	struct tmio_fb_data *data = dev_get_platdata(info->device);
 	struct fb_videomode *best = NULL;
 	int i;
 
@@ -577,7 +577,7 @@ static int tmiofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 
 	struct fb_videomode *mode;
-	struct tmio_fb_data *data = info->device->platform_data;
+	struct tmio_fb_data *data = dev_get_platdata(info->device);
 
 	mode = tmiofb_find_mode(info, var);
 	if (!mode || var->bits_per_pixel > 16)
@@ -678,7 +678,7 @@ static struct fb_ops tmiofb_ops = {
 static int tmiofb_probe(struct platform_device *dev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(dev);
-	struct tmio_fb_data *data = dev->dev.platform_data;
+	struct tmio_fb_data *data = dev_get_platdata(&dev->dev);
 	struct resource *ccr = platform_get_resource(dev, IORESOURCE_MEM, 1);
 	struct resource *lcr = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	struct resource *vram = platform_get_resource(dev, IORESOURCE_MEM, 2);
-- 
1.7.10.4


