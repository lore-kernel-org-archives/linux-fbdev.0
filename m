From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 14 Mar 2013 13:11:24 +0000
Subject: [PATCH 03/10] drivers: char: use module_platform_driver_probe()
Message-Id: <1363266691-15757-5-git-send-email-fabio.porcedda@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch converts the drivers to use the
module_platform_driver_probe() macro which makes the code smaller and
a bit simpler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/char/hw_random/mxc-rnga.c   | 13 +------------
 drivers/char/hw_random/tx4939-rng.c | 13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/char/hw_random/mxc-rnga.c b/drivers/char/hw_random/mxc-rnga.c
index f05d857..895d0b8 100644
--- a/drivers/char/hw_random/mxc-rnga.c
+++ b/drivers/char/hw_random/mxc-rnga.c
@@ -228,18 +228,7 @@ static struct platform_driver mxc_rnga_driver = {
 	.remove = __exit_p(mxc_rnga_remove),
 };
 
-static int __init mod_init(void)
-{
-	return platform_driver_probe(&mxc_rnga_driver, mxc_rnga_probe);
-}
-
-static void __exit mod_exit(void)
-{
-	platform_driver_unregister(&mxc_rnga_driver);
-}
-
-module_init(mod_init);
-module_exit(mod_exit);
+module_platform_driver_probe(mxc_rnga_driver, mxc_rnga_probe);
 
 MODULE_AUTHOR("Freescale Semiconductor, Inc.");
 MODULE_DESCRIPTION("H/W RNGA driver for i.MX");
diff --git a/drivers/char/hw_random/tx4939-rng.c b/drivers/char/hw_random/tx4939-rng.c
index 3099198..d34a24a 100644
--- a/drivers/char/hw_random/tx4939-rng.c
+++ b/drivers/char/hw_random/tx4939-rng.c
@@ -166,18 +166,7 @@ static struct platform_driver tx4939_rng_driver = {
 	.remove = tx4939_rng_remove,
 };
 
-static int __init tx4939rng_init(void)
-{
-	return platform_driver_probe(&tx4939_rng_driver, tx4939_rng_probe);
-}
-
-static void __exit tx4939rng_exit(void)
-{
-	platform_driver_unregister(&tx4939_rng_driver);
-}
-
-module_init(tx4939rng_init);
-module_exit(tx4939rng_exit);
+module_platform_driver_probe(tx4939_rng_driver, tx4939_rng_probe);
 
 MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver for TX4939");
 MODULE_LICENSE("GPL");
-- 
1.8.1.5

