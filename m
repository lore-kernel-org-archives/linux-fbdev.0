From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 14 Mar 2013 17:09:35 +0000
Subject: [PATCH v2 5/8] drivers: memory: use module_platform_driver_probe()
Message-Id: <1363280978-24051-6-git-send-email-fabio.porcedda@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch converts the drivers to use the
module_platform_driver_probe() macro which makes the code smaller and
a bit simpler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Aneesh V <aneesh@ti.com>
---
 drivers/memory/emif.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index df08736..ecbc1a9 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1841,18 +1841,8 @@ static struct platform_driver emif_driver = {
 	},
 };
 
-static int __init_or_module emif_register(void)
-{
-	return platform_driver_probe(&emif_driver, emif_probe);
-}
-
-static void __exit emif_unregister(void)
-{
-	platform_driver_unregister(&emif_driver);
-}
+module_platform_driver_probe(emif_driver, emif_probe);
 
-module_init(emif_register);
-module_exit(emif_unregister);
 MODULE_DESCRIPTION("TI EMIF SDRAM Controller Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:emif");
-- 
1.8.1.5

