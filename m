From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 04:58:58 +0000
Subject: [PATCH 04/19] video: omapfb: use dev_get_platdata()
Message-Id: <000901ceb362$9e6d1940$db474bc0$%han@samsung.com>
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
 drivers/video/omap/hwa742.c      |    2 +-
 drivers/video/omap/omapfb_main.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index f349ee6..a4ee65b 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -947,7 +947,7 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 	hwa742.extif = fbdev->ext_if;
 	hwa742.int_ctrl = fbdev->int_ctrl;
 
-	omapfb_conf = fbdev->dev->platform_data;
+	omapfb_conf = dev_get_platdata(fbdev->dev);
 
 	hwa742.sys_ck = clk_get(NULL, "hwa_sys_ck");
 
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index d40612c..e4fc6d9 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1602,7 +1602,7 @@ static int omapfb_find_ctrl(struct omapfb_device *fbdev)
 	char name[17];
 	int i;
 
-	conf = fbdev->dev->platform_data;
+	conf = dev_get_platdata(fbdev->dev);
 
 	fbdev->ctrl = NULL;
 
@@ -1674,7 +1674,7 @@ static int omapfb_do_probe(struct platform_device *pdev,
 		goto cleanup;
 	}
 
-	if (pdev->dev.platform_data = NULL) {
+	if (dev_get_platdata(&pdev->dev) = NULL) {
 		dev_err(&pdev->dev, "missing platform data\n");
 		r = -ENOENT;
 		goto cleanup;
-- 
1.7.10.4


