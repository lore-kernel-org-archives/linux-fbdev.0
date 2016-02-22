From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 22 Feb 2016 01:59:51 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdc: Use ARCH_RENESAS
Message-Id: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Based on v4.5-rc1

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 8ea45a5cd806..936ebd4bcf73 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1985,7 +1985,7 @@ config FB_W100
 
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
-	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+	depends on FB && (SUPERH || ARCH_RENESAS) && HAVE_CLK
 	depends on FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
-- 
2.1.4

