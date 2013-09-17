From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:02:24 +0000
Subject: [PATCH 08/19] video: sa1100fb: use dev_get_platdata()
Message-Id: <000d01ceb363$191e6680$4b5b3380$%han@samsung.com>
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
 drivers/video/sa1100fb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index de76da0..580c444e 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1116,7 +1116,7 @@ static struct fb_monspecs monspecs = {
 
 static struct sa1100fb_info *sa1100fb_init_fbinfo(struct device *dev)
 {
-	struct sa1100fb_mach_info *inf = dev->platform_data;
+	struct sa1100fb_mach_info *inf = dev_get_platdata(dev);
 	struct sa1100fb_info *fbi;
 	unsigned i;
 
@@ -1201,7 +1201,7 @@ static int sa1100fb_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq;
 
-	if (!pdev->dev.platform_data) {
+	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform LCD data\n");
 		return -EINVAL;
 	}
-- 
1.7.10.4


