From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 27 Jun 2019 14:07:43 +0000
Subject: [PATCH 2/3] video: fbdev: mmp: add COMPILE_TEST support
Message-Id: <d21a19ea-8c18-80df-ae79-76de7c5ee67c@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Add COMPILE_TEST support to mmp display subsystem for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/mmp/Kconfig    |    2 +-
 drivers/video/fbdev/mmp/hw/Kconfig |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: b/drivers/video/fbdev/mmp/Kconfig
=================================--- a/drivers/video/fbdev/mmp/Kconfig
+++ b/drivers/video/fbdev/mmp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig MMP_DISP
 	tristate "Marvell MMP Display Subsystem support"
-	depends on CPU_PXA910 || CPU_MMP2
+	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
 	help
 	  Marvell Display Subsystem support.
 
Index: b/drivers/video/fbdev/mmp/hw/Kconfig
=================================--- a/drivers/video/fbdev/mmp/hw/Kconfig
+++ b/drivers/video/fbdev/mmp/hw/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MMP_DISP_CONTROLLER
 	bool "mmp display controller hw support"
-	depends on CPU_PXA910 || CPU_MMP2
+	depends on HAVE_CLK && HAS_IOMEM
+	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
 	help
 		Marvell MMP display hw controller support
 		this controller is used on Marvell PXA910 and
