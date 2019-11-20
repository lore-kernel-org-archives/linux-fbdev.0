From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 20 Nov 2019 09:57:16 +0000
Subject: [PATCH v1 5/5] fbtft: Drop OF dependency
Message-Id: <20191120095716.26628-5-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, linux-fbdev@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Now, since driver became OF independent, no need to keep OF dependency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/Kconfig | 2 +-
 drivers/staging/fbtft/fbtft.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index cb61c2a772bd..54751d9fc0ff 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig FB_TFT
 	tristate "Support for small TFT LCD display modules"
-	depends on FB && SPI && OF
+	depends on FB && SPI
 	depends on GPIOLIB || COMPILE_TEST
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 9b6bdb62093d..5f782da51959 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -309,7 +309,7 @@ MODULE_DEVICE_TABLE(of, dt_ids);                                           \
 static struct spi_driver fbtft_driver_spi_driver = {                       \
 	.driver = {                                                        \
 		.name   = _name,                                           \
-		.of_match_table = of_match_ptr(dt_ids),                    \
+		.of_match_table = dt_ids,                                  \
 	},                                                                 \
 	.probe  = fbtft_driver_probe_spi,                                  \
 	.remove = fbtft_driver_remove_spi,                                 \
@@ -319,7 +319,7 @@ static struct platform_driver fbtft_driver_platform_driver = {             \
 	.driver = {                                                        \
 		.name   = _name,                                           \
 		.owner  = THIS_MODULE,                                     \
-		.of_match_table = of_match_ptr(dt_ids),                    \
+		.of_match_table = dt_ids,                                  \
 	},                                                                 \
 	.probe  = fbtft_driver_probe_pdev,                                 \
 	.remove = fbtft_driver_remove_pdev,                                \
-- 
2.24.0
