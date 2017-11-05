From: Colin King <colin.king@canonical.com>
Date: Sun, 05 Nov 2017 11:53:26 +0000
Subject: [PATCH] backlight: ili922x: remove redundant variable len
Message-Id: <20171105115326.5276-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable len is assigned but never read, therefore it is redundant
and can be removed. Cleans up clang warning:

drivers/video/backlight/ili922x.c:276:2: warning: Value stored to 'len'
is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/backlight/ili922x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
index a9e9cef..2b6c6aa 100644
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -251,7 +251,7 @@ static int ili922x_write(struct spi_device *spi, u8 reg, u16 value)
 	struct spi_transfer xfer_regindex, xfer_regvalue;
 	unsigned char tbuf[CMD_BUFSIZE];
 	unsigned char rbuf[CMD_BUFSIZE];
-	int ret, len = 0;
+	int ret;
 
 	memset(&xfer_regindex, 0, sizeof(struct spi_transfer));
 	memset(&xfer_regvalue, 0, sizeof(struct spi_transfer));
@@ -273,7 +273,6 @@ static int ili922x_write(struct spi_device *spi, u8 reg, u16 value)
 	ret = spi_sync(spi, &msg);
 
 	spi_message_init(&msg);
-	len = 0;
 	tbuf[0] = set_tx_byte(START_BYTE(ili922x_id, START_RS_REG,
 					 START_RW_WRITE));
 	tbuf[1] = set_tx_byte((value & 0xFF00) >> 8);
-- 
2.7.4

