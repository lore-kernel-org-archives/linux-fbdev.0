From: mathieu.poirier@linaro.org
Date: Tue, 15 May 2012 21:02:58 +0000
Subject: [PATCH 2/5] video/ili9320: do not mark exported functions __devexit
Message-Id: <1337115781-27979-3-git-send-email-mathieu.poirier@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337115781-27979-1-git-send-email-mathieu.poirier@linaro.org>
In-Reply-To: <1337115781-27979-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, mathieu.poirier@linaro.org

From: Arnd Bergmann <arnd@arndb.de>

No symbol can be exported when the section is discarded - the only
solution I could think of is not to mark symbols as __devexit
when they are exported.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/video/backlight/ili9320.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/backlight/ili9320.c b/drivers/video/backlight/ili9320.c
index 5118a9f..b67485a 100644
--- a/drivers/video/backlight/ili9320.c
+++ b/drivers/video/backlight/ili9320.c
@@ -267,7 +267,7 @@ int __devinit ili9320_probe_spi(struct spi_device *spi,
 
 EXPORT_SYMBOL_GPL(ili9320_probe_spi);
 
-int __devexit ili9320_remove(struct ili9320 *ili)
+int ili9320_remove(struct ili9320 *ili)
 {
 	ili9320_power(ili, FB_BLANK_POWERDOWN);
 
-- 
1.7.5.4

