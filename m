From: Mark Brown <broonie@kernel.org>
Date: Fri, 01 Aug 2014 15:53:50 +0000
Subject: [PATCH] video: amba-clcd: Select FB_MODE_HELPERS
Message-Id: <1406908430-18487-1-git-send-email-broonie@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Mark Brown <broonie@linaro.org>

The AMBA CLCD driver uses fb_videomode_from_videomode() so it needs to
select DB_MODE_HELPERS as well as VIDEOMODE_HELPERS.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/video/fbdev/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 37d473f..e222048 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -280,6 +280,7 @@ config FB_ARMCLCD
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_MODE_HELPERS
 	select VIDEOMODE_HELPERS if OF
 	help
 	  This framebuffer device driver is for the ARM PrimeCell PL110
-- 
2.0.0

