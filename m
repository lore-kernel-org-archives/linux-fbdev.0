From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:09:37 +0000
Subject: [PATCH 14/19] video: mbxfb: use dev_get_platdata()
Message-Id: <001401ceb364$1b387770$51a96650$%han@samsung.com>
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
 drivers/video/mbx/mbxfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 0c1a874..f87c4ef 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -890,7 +890,7 @@ static int mbxfb_probe(struct platform_device *dev)
 
 	dev_dbg(&dev->dev, "mbxfb_probe\n");
 
-	pdata = dev->dev.platform_data;
+	pdata = dev_get_platdata(&dev->dev);
 	if (!pdata) {
 		dev_err(&dev->dev, "platform data is required\n");
 		return -EINVAL;
-- 
1.7.10.4


