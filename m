From: Axel Lin <axel.lin@gmail.com>
Date: Fri, 09 Dec 2011 01:57:53 +0000
Subject: [PATCH 1/3] video: convert mbxfb to use module_platform_driver()
Message-Id: <1323395873.3740.4.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

This patch converts mbxfb to use the module_platform_driver() macro
which makes the code smaller and a bit simpler.

Cc: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/mbx/mbxfb.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 6ce3416..55bf619 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -1053,18 +1053,7 @@ static struct platform_driver mbxfb_driver = {
 	},
 };
 
-int __devinit mbxfb_init(void)
-{
-	return platform_driver_register(&mbxfb_driver);
-}
-
-static void __devexit mbxfb_exit(void)
-{
-	platform_driver_unregister(&mbxfb_driver);
-}
-
-module_init(mbxfb_init);
-module_exit(mbxfb_exit);
+module_platform_driver(mbxfb_driver);
 
 MODULE_DESCRIPTION("loadable framebuffer driver for Marathon device");
 MODULE_AUTHOR("Mike Rapoport, Compulab");
-- 
1.7.5.4



