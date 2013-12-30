From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Dec 2013 06:34:10 +0000
Subject: [PATCH 1/4] video: ep93xx: Cleanup video-ep93xx.h header
Message-Id: <1388384533-20458-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit a3b2924547a7 ("ARM: ep93xx: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/video-ep93xx.h |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/platform_data/video-ep93xx.h b/include/linux/platform_data/video-ep93xx.h
index d5ae11d7c453..92fc2b2232e7 100644
--- a/include/linux/platform_data/video-ep93xx.h
+++ b/include/linux/platform_data/video-ep93xx.h
@@ -1,9 +1,5 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/fb.h
- */
-
-#ifndef __ASM_ARCH_EP93XXFB_H
-#define __ASM_ARCH_EP93XXFB_H
+#ifndef __VIDEO_EP93XX_H
+#define __VIDEO_EP93XX_H
 
 struct platform_device;
 struct fb_videomode;
@@ -53,4 +49,4 @@ struct ep93xxfb_mach_info {
 	void	(*blank)(int blank_mode, struct fb_info *info);
 };
 
-#endif /* __ASM_ARCH_EP93XXFB_H */
+#endif /* __VIDEO_EP93XX_H */
-- 
1.7.9.5

