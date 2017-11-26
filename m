From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 17:43:17 +0000
Subject: [PATCH 3/3] video: omap: Delete an error message for a failed memory allocation in mipid_spi_probe()
Message-Id: <62f8d5bb-64cd-487f-6ef4-e3aa7a8b5fd5@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
In-Reply-To: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 18:21:25 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/omap/lcd_mipid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index e3a85432f926..e71b674b47d8 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -564,10 +564,8 @@ static int mipid_spi_probe(struct spi_device *spi)
 	int r;
 
 	md = kzalloc(sizeof(*md), GFP_KERNEL);
-	if (md = NULL) {
-		dev_err(&spi->dev, "out of memory\n");
+	if (!md)
 		return -ENOMEM;
-	}
 
 	spi->mode = SPI_MODE_0;
 	md->spi = spi;
-- 
2.15.0

