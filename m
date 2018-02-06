From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 06 Feb 2018 22:55:15 +0000
Subject: [PATCH] spi: kconfig: Remove AVR32 dep. from SPI_ATMEL
Message-Id: <20180206225519.20248-1-ulfalizer@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180206120825.GF5681@sirena.org.uk>
In-Reply-To: <20180206120825.GF5681@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: broonie@kernel.org, linux-kernel@vger.kernel.org
Cc: clabbe.montjoie@gmail.com, viresh.kumar@linaro.org, matthias.bgg@gmail.com, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, christophe.leroy@c-s.fr, seanpaul@chromium.org, linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>

The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
support for AVR32 architecture").

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 603783976b81..c1e455d46c7f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -72,7 +72,7 @@ config SPI_ARMADA_3700
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
 	depends on HAS_DMA
-	depends on (ARCH_AT91 || AVR32 || COMPILE_TEST)
+	depends on (ARCH_AT91 || COMPILE_TEST)
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT32 (AVR32) and AT91 (ARM) chips.
-- 
2.14.1

