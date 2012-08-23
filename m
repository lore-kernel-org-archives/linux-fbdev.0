From: Devendra Naga <develkernel412222@gmail.com>
Date: Thu, 23 Aug 2012 21:55:34 +0000
Subject: [PATCH] video: bfin-lq035q1: use module_platform_driver
Message-Id: <1345758922-10626-1-git-send-email-develkernel412222@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

the driver's module init and exit functions are calling
platform_driver_register and platform_driver_unregister and doing nothing
else.

This same as that of the module_platform_driver,
remove this init and exit functions and use the module_platform_driver instead

Signed-off-by: Devendra Naga <develkernel412222@gmail.com>
---
 drivers/video/bfin-lq035q1-fb.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index 353c02f..1b21519 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -853,17 +853,7 @@ static struct platform_driver bfin_lq035q1_driver = {
 	},
 };
 
-static int __init bfin_lq035q1_driver_init(void)
-{
-	return platform_driver_register(&bfin_lq035q1_driver);
-}
-module_init(bfin_lq035q1_driver_init);
-
-static void __exit bfin_lq035q1_driver_cleanup(void)
-{
-	platform_driver_unregister(&bfin_lq035q1_driver);
-}
-module_exit(bfin_lq035q1_driver_cleanup);
+module_platform_driver(bfin_lq035q1_driver);
 
 MODULE_DESCRIPTION("Blackfin TFT LCD Driver");
 MODULE_LICENSE("GPL");
-- 
1.7.9.5

