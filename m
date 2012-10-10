From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:37:58 +0000
Subject: [PATCH 3.6.0- 02/13] video/au1200fb: use module_platform_driver macro
Message-Id: <1349894278-9258-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/au1200fb.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 7ca79f0..d1127eb 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1878,21 +1878,7 @@ static struct platform_driver au1200fb_driver = {
 	.probe		= au1200fb_drv_probe,
 	.remove		= __devexit_p(au1200fb_drv_remove),
 };
-
-/*-------------------------------------------------------------------------*/
-
-static int __init au1200fb_init(void)
-{
-	return platform_driver_register(&au1200fb_driver);
-}
-
-static void __exit au1200fb_cleanup(void)
-{
-	platform_driver_unregister(&au1200fb_driver);
-}
-
-module_init(au1200fb_init);
-module_exit(au1200fb_cleanup);
+module_platform_driver(au1200fb_driver);
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-- 
1.7.0.4

