From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 27 Jun 2019 14:07:03 +0000
Subject: [PATCH 1/3] video: fbdev: mmp: remove duplicated MMP_DISP dependency
Message-Id: <eb28587c-4f8f-f044-1b8b-317a8d7967aa@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

This dependency is already present in higher level Kconfig file
(drivers/video/fbdev/mmp/Kconfig).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/mmp/fb/Kconfig |    4 ----
 drivers/video/fbdev/mmp/hw/Kconfig |    4 ----
 2 files changed, 8 deletions(-)

Index: b/drivers/video/fbdev/mmp/fb/Kconfig
=================================--- a/drivers/video/fbdev/mmp/fb/Kconfig
+++ b/drivers/video/fbdev/mmp/fb/Kconfig
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-if MMP_DISP
-
 config MMP_FB
 	tristate "fb driver for Marvell MMP Display Subsystem"
 	depends on FB
@@ -10,5 +8,3 @@ config MMP_FB
 	default y
 	help
 		fb driver for Marvell MMP Display Subsystem
-
-endif
Index: b/drivers/video/fbdev/mmp/hw/Kconfig
=================================--- a/drivers/video/fbdev/mmp/hw/Kconfig
+++ b/drivers/video/fbdev/mmp/hw/Kconfig
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-if MMP_DISP
-
 config MMP_DISP_CONTROLLER
 	bool "mmp display controller hw support"
 	depends on CPU_PXA910 || CPU_MMP2
@@ -16,5 +14,3 @@ config MMP_DISP_SPI
 	help
 		Marvell MMP display hw controller spi port support
 		will register as a spi master for panel usage
-
-endif
