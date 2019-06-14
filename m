From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 14 Jun 2019 14:46:33 +0000
Subject: [PATCH] video: fbdev: s3c-fb: add COMPILE_TEST support
Message-Id: <e771b89b-0e38-a712-b635-8d53cbf95a8e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>

Add COMPILE_TEST support to s3c-fb driver for better compile
testing coverage.

Cc: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1877,7 +1877,8 @@ config FB_TMIO_ACCELL
 
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
-	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX)
+	depends on FB && HAVE_CLK && HAS_IOMEM
+	depends on (CPU_S3C2416 || ARCH_S3C64XX) || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
