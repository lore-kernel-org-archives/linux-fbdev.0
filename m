From: Jun Nie <niej0001@gmail.com>
Date: Tue, 10 Nov 2009 08:12:09 +0000
Subject: [PATCH 2/8] pxa: support PXA168 LCD platform dependent power on
Message-Id: <7c34ac520911100012y4b52659eid46c241111c34032@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From 7a497795dfd6f314e52b015b85031a0498a70a03 Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 09:21:19 +0800
Subject: [PATCH] pxa: support PXA168 LCD platform dependent power on

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index e1f1c5f..50f72e9 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -845,6 +845,20 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	}

 	platform_set_drvdata(pdev, fbi);
+	if (mi->pxa168fb_lcd_power){
+		if (gpio_is_valid(mi->spi_gpio_cs)) {
+			ret = gpio_request(mi->spi_gpio_cs, "LCD_SPI_CS");
+			if (ret) {
+				dev_err(&pdev->dev, "failed to request GPIO for LCD CS\n");
+				return -EIO;
+			}
+		}
+		if(mi->pxa168fb_lcd_power(fbi, mi->spi_gpio_cs, mi->spi_gpio_reset, 1)){
+			dev_err(&pdev->dev, "Failed to power up pxa168-fb\n");
+			goto failed_free_irq;
+		}
+	}
+	dev_info(fbi->dev, "frame buffer detected\n");
 	return 0;

 failed_free_irq:
-- 
1.5.4.3
