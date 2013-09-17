From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:03:53 +0000
Subject: [PATCH 10/19] video: amba-clcd: use dev_get_platdata()
Message-Id: <000f01ceb363$4e389bb0$eaa9d310$%han@samsung.com>
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
 drivers/video/amba-clcd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 0a2cce7..b7aa68b 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -544,7 +544,7 @@ static int clcdfb_register(struct clcd_fb *fb)
 
 static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 {
-	struct clcd_board *board = dev->dev.platform_data;
+	struct clcd_board *board = dev_get_platdata(&dev->dev);
 	struct clcd_fb *fb;
 	int ret;
 
-- 
1.7.10.4


