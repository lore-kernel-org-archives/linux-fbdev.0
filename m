From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Fri, 29 Sep 2017 10:51:12 +0000
Subject: [PATCH 4/8] video: sa1100fb: use devm_request_irq()
Message-Id: <E1dxssy-0006j9-86@rmk-PC.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170929105004.GY20805@n2100.armlinux.org.uk>
In-Reply-To: <20170929105004.GY20805@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use devm_request_irq() to request the interrupt (a little earlier too)
so we can avoid having to manually clean this up.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/video/fbdev/sa1100fb.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index ab83970dbfd9..a48fdb676f3e 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1239,22 +1239,23 @@ static int sa1100fb_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
-	/* Initialize video memory */
-	ret = sa1100fb_map_video_memory(fbi);
-	if (ret)
-		goto failed;
-
-	ret = request_irq(irq, sa1100fb_handle_irq, 0, "LCD", fbi);
+	ret = devm_request_irq(&pdev->dev, irq, sa1100fb_handle_irq, 0,
+			       "LCD", fbi);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed: %d\n", ret);
 		goto failed;
 	}
 
+	/* Initialize video memory */
+	ret = sa1100fb_map_video_memory(fbi);
+	if (ret)
+		goto failed;
+
 	if (machine_is_shannon()) {
 		ret = gpio_request_one(SHANNON_GPIO_DISP_EN,
 			GPIOF_OUT_INIT_LOW, "display enable");
 		if (ret)
-			goto err_free_irq;
+			goto failed;
 	}
 
 	/*
@@ -1282,8 +1283,6 @@ static int sa1100fb_probe(struct platform_device *pdev)
  err_reg_fb:
 	if (machine_is_shannon())
 		gpio_free(SHANNON_GPIO_DISP_EN);
- err_free_irq:
-	free_irq(irq, fbi);
  failed:
 	return ret;
 }
-- 
2.7.4

