From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 21 May 2019 10:49:59 +0000
Subject: [PATCH v2] video: fbdev: pxa168fb: add COMPILE_TEST support
Message-Id: <1059f924-7bbb-37b1-42ee-52cad878f572@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190521104959eucas1p14de9d183967e7f50bfede732d3fd8764@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Add COMPILE_TEST support to pxa168fb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2: add missing HAVE_CLK && HAS IOMEM dependencies

 drivers/video/fbdev/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1729,7 +1729,8 @@ config FB_68328
 
 config FB_PXA168
 	tristate "PXA168/910 LCD framebuffer support"
-	depends on FB && (CPU_PXA168 || CPU_PXA910)
+	depends on FB && HAVE_CLK && HAS_IOMEM
+	depends on CPU_PXA168 || CPU_PXA910 || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
