From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:39:07 +0000
Subject: [PATCH 3.6.0- 10/13] video/grvga: use module_platform_driver macro
Message-Id: <1349894347-9544-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/grvga.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/drivers/video/grvga.c b/drivers/video/grvga.c
index 5245f9a..95dee4a 100644
--- a/drivers/video/grvga.c
+++ b/drivers/video/grvga.c
@@ -556,20 +556,7 @@ static struct platform_driver grvga_driver = {
 	.probe		= grvga_probe,
 	.remove		= __devexit_p(grvga_remove),
 };
-
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
1.7.0.4

