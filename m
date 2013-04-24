From: Markus Pargmann <mpa@pengutronix.de>
Date: Wed, 24 Apr 2013 08:08:13 +0000
Subject: [PATCH 1/2] drivers/video: Kconfig, fix mxsfb build
Message-Id: <1366790894-20426-2-git-send-email-mpa@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366790894-20426-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1366790894-20426-1-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Markus Pargmann <mpargmann@allfex.org>

Kernel build fails with commit 669406534b4abb827d1bdc39bb5e2d5255818ae2

This patch replaces OF_VIDEOMODE symbol by VIDEOMODE_HELPERS.

Signed-off-by: Markus Pargmann <mpargmann@allfex.org>
---
 drivers/video/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index d8ecc52..6246056 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2429,7 +2429,7 @@ config FB_MXS
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_MODE_HELPERS
-	select OF_VIDEOMODE
+	select VIDEOMODE_HELPERS
 	help
 	  Framebuffer support for the MXS SoC.
 
-- 
1.8.1.5

