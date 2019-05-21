From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 21 May 2019 10:53:25 +0000
Subject: [PATCH v2] video: fbdev: da8xx-fb: add COMPILE_TEST support
Message-Id: <fe534641-82b7-c3f7-4296-db4ba4ff30e6@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190521105325eucas1p2df66ee0fd67d652cc26200701e4275da@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Add COMPILE_TEST support to da8xx-fb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2: add missing HAVE_CLK && HAS IOMEM dependencies

 drivers/video/fbdev/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2057,7 +2057,8 @@ config FB_SH7760
 
 config FB_DA8XX
 	tristate "DA8xx/OMAP-L1xx/AM335x Framebuffer support"
-	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX)
+	depends on FB && HAVE_CLK && HAS_IOMEM
+	depends on ARCH_DAVINCI_DA8XX || SOC_AM33XX || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
