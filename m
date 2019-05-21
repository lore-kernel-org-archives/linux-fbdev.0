From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 21 May 2019 13:44:40 +0000
Subject: [PATCH] video: fbdev: cyber2000fb: remove superfluous CONFIG_PCI ifdef
Message-Id: <214f05e0-a448-b1cf-7475-4fa7eeaa9949@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190521134442eucas1p2bf6236c3af24bb023f11f8d119a822be@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is a PCI driver and FB_CYBER2000 depends on PCI in Kconfig so
there is no need to check for PCI inside the driver code.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/cyber2000fb.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/video/fbdev/cyber2000fb.c
=================================--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1642,10 +1642,6 @@ static void cyberpro_common_resume(struc
 }
 
 /*
- * PCI specific support.
- */
-#ifdef CONFIG_PCI
-/*
  * We need to wake up the CyberPro, and make sure its in linear memory
  * mode.  Unfortunately, this is specific to the platform and card that
  * we are running on.
@@ -1861,7 +1857,6 @@ static struct pci_driver cyberpro_driver
 	.resume		= cyberpro_pci_resume,
 	.id_table	= cyberpro_pci_table
 };
-#endif
 
 /*
  * I don't think we can use the "module_init" stuff here because
