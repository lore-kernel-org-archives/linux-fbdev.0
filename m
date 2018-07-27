From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Fri, 27 Jul 2018 08:12:57 +0000
Subject: [PATCH] video: fbdev: add the dependency of broadsheetfb in Kconfig
Message-Id: <20180727081257.3571-1-baijiaju1990@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>

broadsheetfb is a platform driver and it should not be used on x86.
It should be used only by single ARM PXA board, so adding the 
dependency in Kconfig.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index d94254263ea5..ec91d7a2d8b8 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2241,7 +2241,7 @@ config FB_MX3
 
 config FB_BROADSHEET
 	tristate "E-Ink Broadsheet/Epson S1D13521 controller support"
-	depends on FB
+	depends on FB && (ARCH_PXA || COMPILE_TEST)
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
-- 
2.17.0

