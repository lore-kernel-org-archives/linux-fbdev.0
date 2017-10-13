From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 13 Oct 2017 19:42:47 +0000
Subject: [PATCH v2 1/3] backlight: tdo24m: fix the spi cs between transfers
Message-Id: <20171013194250.9001-1-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

Currently the LCD display (TD035S) on the cm-x300 platform is broken and
remains blank.

The TD0245S specification requires that the chipselect is toggled
between commands sent to the panel. This was also the purpose of the
former patch of commit f64dcac0b124 ("backlight: tdo24m: ensure chip
select changes between transfers").

Unfortunately, the "cs_change" field of a SPI transfer is
misleading. Its true meaning is that for a SPI message holding multiple
transfers, the chip select is toggled between each transfer, but for the
last transfer it remains asserted.

In this driver, all the SPI messages contain exactly one transfer, which
means that each transfer is the last of its message, and as a
consequence the chip select is never toggled.

Actually, there was a second bug hidding the first one, hence the
problem was not seen until v4.6. This problem was fixed by commit
a52db659c79c ("spi: pxa2xx: Fix cs_change management") for PXA based
boards.

This fix makes the TD035S work again on a cm-x300 board. The same
applies to other PXA boards, ie. corgi and tosa.

Fixes: a52db659c79c ("spi: pxa2xx: Fix cs_change management")
Reported-by: Andrea Adami <andrea.adami@gmail.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: added 2 other panels
---
 drivers/video/backlight/corgi_lcd.c | 2 +-
 drivers/video/backlight/tdo24m.c    | 2 +-
 drivers/video/backlight/tosa_lcd.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index d7c239ea3d09..f5574060f9c8 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -177,7 +177,7 @@ static int corgi_ssp_lcdtg_send(struct corgi_lcd *lcd, int adrs, uint8_t data)
 	struct spi_message msg;
 	struct spi_transfer xfer = {
 		.len		= 1,
-		.cs_change	= 1,
+		.cs_change	= 0,
 		.tx_buf		= lcd->buf,
 	};
 
diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
index eab1f842f9c0..e4bd63e9db6b 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -369,7 +369,7 @@ static int tdo24m_probe(struct spi_device *spi)
 
 	spi_message_init(m);
 
-	x->cs_change = 1;
+	x->cs_change = 0;
 	x->tx_buf = &lcd->buf[0];
 	spi_message_add_tail(x, m);
 
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index 6a41ea92737a..4dc5ee8debeb 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -49,7 +49,7 @@ static int tosa_tg_send(struct spi_device *spi, int adrs, uint8_t data)
 	struct spi_message msg;
 	struct spi_transfer xfer = {
 		.len		= 1,
-		.cs_change	= 1,
+		.cs_change	= 0,
 		.tx_buf		= buf,
 	};
 
-- 
2.11.0

