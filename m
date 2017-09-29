From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Fri, 29 Sep 2017 10:51:17 +0000
Subject: [PATCH 5/8] video: sa1100fb: use devm_gpio_request_one()
Message-Id: <E1dxst3-0006jG-JT@rmk-PC.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170929105004.GY20805@n2100.armlinux.org.uk>
In-Reply-To: <20170929105004.GY20805@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Switch to using devm_gpio_request_one() to request the shannon gpio
and move the request before the video memory allocation, so we request
all device managed resources before this large allocation attempt.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/video/fbdev/sa1100fb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index a48fdb676f3e..7fa6c8f74ec6 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1246,18 +1246,18 @@ static int sa1100fb_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
-	/* Initialize video memory */
-	ret = sa1100fb_map_video_memory(fbi);
-	if (ret)
-		goto failed;
-
 	if (machine_is_shannon()) {
-		ret = gpio_request_one(SHANNON_GPIO_DISP_EN,
+		ret = devm_gpio_request_one(&pdev->dev, SHANNON_GPIO_DISP_EN,
 			GPIOF_OUT_INIT_LOW, "display enable");
 		if (ret)
 			goto failed;
 	}
 
+	/* Initialize video memory */
+	ret = sa1100fb_map_video_memory(fbi);
+	if (ret)
+		goto failed;
+
 	/*
 	 * This makes sure that our colour bitfield
 	 * descriptors are correctly initialised.
@@ -1268,7 +1268,7 @@ static int sa1100fb_probe(struct platform_device *pdev)
 
 	ret = register_framebuffer(&fbi->fb);
 	if (ret < 0)
-		goto err_reg_fb;
+		goto failed;
 
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = sa1100fb_freq_transition;
@@ -1280,9 +1280,6 @@ static int sa1100fb_probe(struct platform_device *pdev)
 	/* This driver cannot be unloaded at the moment */
 	return 0;
 
- err_reg_fb:
-	if (machine_is_shannon())
-		gpio_free(SHANNON_GPIO_DISP_EN);
  failed:
 	return ret;
 }
-- 
2.7.4

