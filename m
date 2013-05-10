From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 10 May 2013 12:07:08 +0000
Subject: [PATCH 1/1] video: imxfb: Make local symbols static
Message-Id: <1368186908-16982-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

These symbols are used only in this file.
Make them static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/imxfb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 0abf2bf..0a16d82 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -960,7 +960,7 @@ static int imxfb_remove(struct platform_device *pdev)
 	return 0;
 }
 
-void  imxfb_shutdown(struct platform_device * dev)
+static void imxfb_shutdown(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 	struct imxfb_info *fbi = info->par;
@@ -999,7 +999,7 @@ static int imxfb_setup(void)
 	return 0;
 }
 
-int __init imxfb_init(void)
+static int __init imxfb_init(void)
 {
 	int ret = imxfb_setup();
 
-- 
1.7.9.5

