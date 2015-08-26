From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 26 Aug 2015 11:32:50 +0000
Subject: [PATCH -next] drivers/video/fbdev: Add dependencies on !S390
Message-Id: <1440588770-17774-1-git-send-email-linux@roeck-us.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Luis R. Rodriguez" <mcgrof@suse.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>

s390:allmodconfig fails to build with:

ERROR: "pci_iomap_wc" [drivers/video/fbdev/vt8623fb.ko] undefined!
ERROR: "pci_iomap_wc" [drivers/video/fbdev/s3fb.ko] undefined!
ERROR: "pci_iomap_wc" [drivers/video/fbdev/arkfb.ko] undefined!

Those functions are currently only available in generic PCI iomap code,
which is not used on S390.

Fixes: 81bdef04d3bc ("drivers/video/fbdev/vt8623fb: Use arch_phys_wc_add() and pci_iomap_wc()")
Fixes: 4edcd2ab1255 ("drivers/video/fbdev/s3fb: Use arch_phys_wc_add() and pci_iomap_wc()")
Fixes: c823a48ac47f ("drivers/video/fbdev/arkfb.c: Use arch_phys_wc_add() and pci_iomap_wc()")
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/video/fbdev/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 8b1d371b5404..6b1893e5c769 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1442,6 +1442,7 @@ config FB_ATY_BACKLIGHT
 config FB_S3
 	tristate "S3 Trio/Virge support"
 	depends on FB && PCI
+	depends on !S390
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1649,6 +1650,7 @@ config FB_VOODOO1
 config FB_VT8623
 	tristate "VIA VT8623 support"
 	depends on FB && PCI
+	depends on !S390
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1683,6 +1685,7 @@ config FB_TRIDENT
 config FB_ARK
 	tristate "ARK 2000PV support"
 	depends on FB && PCI
+	depends on !S390
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.1.4

