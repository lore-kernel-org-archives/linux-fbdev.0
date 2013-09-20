From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:47:38 +0000
Subject: [PATCH 1/1] video: grvga: Use module_platform_driver
Message-Id: <1379658938-18080-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

module_platform_driver removes some boilerplate code and makes
it simple.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kristoffer Glembo <kristoffer@gaisler.com>
---
 drivers/video/grvga.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/video/grvga.c b/drivers/video/grvga.c
index 01fbcaf..c078701 100644
--- a/drivers/video/grvga.c
+++ b/drivers/video/grvga.c
@@ -555,19 +555,7 @@ static struct platform_driver grvga_driver = {
 	.remove		= grvga_remove,
 };
 
-
-static int __init grvga_init(void)
-{
-	return platform_driver_register(&grvga_driver);
-}
-
-static void __exit grvga_exit(void)
-{
-	platform_driver_unregister(&grvga_driver);
-}
-
-module_init(grvga_init);
-module_exit(grvga_exit);
+module_platform_driver(grvga_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Aeroflex Gaisler");
-- 
1.7.9.5

