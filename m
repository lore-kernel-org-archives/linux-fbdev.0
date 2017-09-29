From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Fri, 29 Sep 2017 10:51:28 +0000
Subject: [PATCH 7/8] video: sa1100fb: fix video memory allocation leak
Message-Id: <E1dxstE-0006jU-BQ@rmk-PC.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170929105004.GY20805@n2100.armlinux.org.uk>
In-Reply-To: <20170929105004.GY20805@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Don't leak the video memory allocation if register_framebuffer() fails.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/video/fbdev/sa1100fb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 16a974471c02..56d514b5d252 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1262,8 +1262,11 @@ static int sa1100fb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fbi);
 
 	ret = register_framebuffer(&fbi->fb);
-	if (ret < 0)
-		goto failed;
+	if (ret < 0) {
+		dma_free_wc(fbi->dev, fbi->map_size, fbi->map_cpu,
+			    fbi->map_dma);
+		return ret;
+	}
 
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = sa1100fb_freq_transition;
@@ -1274,9 +1277,6 @@ static int sa1100fb_probe(struct platform_device *pdev)
 
 	/* This driver cannot be unloaded at the moment */
 	return 0;
-
- failed:
-	return ret;
 }
 
 static struct platform_driver sa1100fb_driver = {
-- 
2.7.4

