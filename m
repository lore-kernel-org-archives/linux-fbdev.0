From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:08:14 +0000
Subject: [PATCH 12/19] video: ep93xx-fb: use dev_get_platdata()
Message-Id: <001201ceb363$e9b28c90$bd17a5b0$%han@samsung.com>
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
 drivers/video/ep93xx-fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index 28a837d..35a0f53 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -487,7 +487,7 @@ static void ep93xxfb_dealloc_videomem(struct fb_info *info)
 
 static int ep93xxfb_probe(struct platform_device *pdev)
 {
-	struct ep93xxfb_mach_info *mach_info = pdev->dev.platform_data;
+	struct ep93xxfb_mach_info *mach_info = dev_get_platdata(&pdev->dev);
 	struct fb_info *info;
 	struct ep93xx_fbi *fbi;
 	struct resource *res;
-- 
1.7.10.4


