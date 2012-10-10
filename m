From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:38:51 +0000
Subject: [PATCH 3.6.0- 08/13] video/da8xx_fb: use module_platform_driver macro
Message-Id: <1349894331-9461-1-git-send-email-srinivas.kandagatla@st.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 drivers/video/da8xx-fb.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 113d43a..40b8d9a 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1449,19 +1449,7 @@ static struct platform_driver da8xx_fb_driver = {
 		   .owner = THIS_MODULE,
 		   },
 };
-
-static int __init da8xx_fb_init(void)
-{
-	return platform_driver_register(&da8xx_fb_driver);
-}
-
-static void __exit da8xx_fb_cleanup(void)
-{
-	platform_driver_unregister(&da8xx_fb_driver);
-}
-
-module_init(da8xx_fb_init);
-module_exit(da8xx_fb_cleanup);
+module_platform_driver(da8xx_fb_driver);
 
 MODULE_DESCRIPTION("Framebuffer driver for TI da8xx/omap-l1xx");
 MODULE_AUTHOR("Texas Instruments");
-- 
1.7.0.4

