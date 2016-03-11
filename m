From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Mar 2016 02:28:18 +0000
Subject: [PATCH 2/2] fbdev: sh_mobile_meram: depend on COMPILE_TEST
Message-Id: <1457663298-31973-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Increase compilation coverage by allowing it to be selected if
COMPILE_TEST is selected.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 71294f595f61..99da988b39be 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2450,7 +2450,7 @@ source "drivers/video/fbdev/mmp/Kconfig"
 
 config FB_SH_MOBILE_MERAM
 	tristate "SuperH Mobile MERAM read ahead support"
-	depends on SUPERH || ARCH_RENESAS
+	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select GENERIC_ALLOCATOR
 	---help---
 	  Enable MERAM support for the SuperH controller.
-- 
2.7.0.rc3.207.g0ac5344

