From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 06 Oct 2017 19:58:23 +0000
Subject: [PATCH 1/3] backlight: tdo24m: fix the spi cs between transfers
Message-Id: <20171006195826.27500-1-robert.jarzmik@free.fr>
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

This fix makes the TD035S work again on a cm-x300 board.

Fixes: f64dcac0b124 ("backlight: tdo24m: ensure chip select changes
       between transfers")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/video/backlight/tdo24m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
2.11.0

