From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:37:50 +0000
Subject: [PATCH 3.6.0- 01/13] video/au1100fb: use module_platform_driver macro
Message-Id: <1349894270-9224-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/au1100fb.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index fe3b6ec..04e6529 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -677,19 +677,7 @@ static struct platform_driver au1100fb_driver = {
 	.suspend	= au1100fb_drv_suspend,
         .resume		= au1100fb_drv_resume,
 };
-
-static int __init au1100fb_load(void)
-{
-	return platform_driver_register(&au1100fb_driver);
-}
-
-static void __exit au1100fb_unload(void)
-{
-	platform_driver_unregister(&au1100fb_driver);
-}
-
-module_init(au1100fb_load);
-module_exit(au1100fb_unload);
+module_platform_driver(au1100fb_driver);
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-- 
1.7.0.4

