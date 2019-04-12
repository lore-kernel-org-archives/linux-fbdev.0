From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 12 Apr 2019 11:58:54 +0000
Subject: [PATCH] video: fbdev: da8xx-fb: add COMPILE_TEST support
Message-Id: <5eba3c36-bc65-74ae-cc7c-cc45ee06ccfe@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190412115855eucas1p13b364b5e815ccd338ceb74577d116b14@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Add COMPILE_TEST support to da8xx-fb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig	2019-04-12 13:40:48.246274115 +0200
+++ b/drivers/video/fbdev/Kconfig	2019-04-12 13:55:50.694296842 +0200
@@ -2058,7 +2058,7 @@ config FB_SH7760
 
 config FB_DA8XX
 	tristate "DA8xx/OMAP-L1xx/AM335x Framebuffer support"
-	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX)
+	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
