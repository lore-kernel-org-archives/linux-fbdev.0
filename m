From: Axel Lin <axel.lin@gmail.com>
Date: Fri, 09 Dec 2011 02:01:15 +0000
Subject: [PATCH 3/3] video: pnx4008: convert drivers/video/pnx4008/* to use
Message-Id: <1323396075.3740.8.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323395873.3740.4.camel@phoenix>
In-Reply-To: <1323395873.3740.4.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Grigory Tolstolytkin <gtolstolytkin@ru.mvista.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

This patch converts the drivers in drivers/video/pnx4008/* to use the
module_platform_driver() macro which makes the code smaller and a bit
simpler.

Cc: Grigory Tolstolytkin <gtolstolytkin@ru.mvista.com>
Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/pnx4008/pnxrgbfb.c |   13 +------------
 drivers/video/pnx4008/sdum.c     |   13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/video/pnx4008/pnxrgbfb.c b/drivers/video/pnx4008/pnxrgbfb.c
index b2252fe..6d30428 100644
--- a/drivers/video/pnx4008/pnxrgbfb.c
+++ b/drivers/video/pnx4008/pnxrgbfb.c
@@ -193,17 +193,6 @@ static struct platform_driver rgbfb_driver = {
 	.remove = rgbfb_remove,
 };
 
-static int __init rgbfb_init(void)
-{
-	return platform_driver_register(&rgbfb_driver);
-}
-
-static void __exit rgbfb_exit(void)
-{
-	platform_driver_unregister(&rgbfb_driver);
-}
-
-module_init(rgbfb_init);
-module_exit(rgbfb_exit);
+module_platform_driver(rgbfb_driver);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/pnx4008/sdum.c b/drivers/video/pnx4008/sdum.c
index 50e0039..c5c7414 100644
--- a/drivers/video/pnx4008/sdum.c
+++ b/drivers/video/pnx4008/sdum.c
@@ -856,17 +856,6 @@ static struct platform_driver sdum_driver = {
 	.resume = sdum_resume,
 };
 
-int __init sdum_init(void)
-{
-	return platform_driver_register(&sdum_driver);
-}
-
-static void __exit sdum_exit(void)
-{
-	platform_driver_unregister(&sdum_driver);
-};
-
-module_init(sdum_init);
-module_exit(sdum_exit);
+module_platform_driver(sdum_driver);
 
 MODULE_LICENSE("GPL");
-- 
1.7.5.4



