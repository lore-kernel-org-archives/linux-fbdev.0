From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 12 Apr 2019 11:02:28 +0000
Subject: [PATCH] video: fbdev: pxa168fb: add COMPILE_TEST support
Message-Id: <8512f2b0-48c3-6a73-7002-966292f66985@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190412110229eucas1p198d9c4ac3ecd5e41b11aa39f7ec44523@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Add COMPILE_TEST support to pxa168fb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig	2019-04-12 12:35:09.038174913 +0200
+++ b/drivers/video/fbdev/Kconfig	2019-04-12 12:35:09.034174912 +0200
@@ -1732,7 +1732,7 @@ config FB_68328
 
 config FB_PXA168
 	tristate "PXA168/910 LCD framebuffer support"
-	depends on FB && (CPU_PXA168 || CPU_PXA910)
+	depends on FB && (CPU_PXA168 || CPU_PXA910 || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
