From: Richard Weinberger <richard@nod.at>
Date: Sun, 09 Feb 2014 18:47:39 +0000
Subject: [PATCH 01/28] Remove CPU_MMP3
Message-Id: <1391971686-9517-2-git-send-email-richard@nod.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
In-Reply-To: <1391971686-9517-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:USB PHY LAYER" <linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>

The symbol is an orphan, get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/usb/phy/Kconfig      | 1 -
 drivers/video/mmp/Kconfig    | 2 +-
 drivers/video/mmp/hw/Kconfig | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 7d1451d..b9b1c52 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -61,7 +61,6 @@ config KEYSTONE_USB_PHY
 
 config MV_U3D_PHY
 	bool "Marvell USB 3.0 PHY controller Driver"
-	depends on CPU_MMP3
 	select USB_PHY
 	help
 	  Enable this to support Marvell USB 3.0 phy controller for Marvell
diff --git a/drivers/video/mmp/Kconfig b/drivers/video/mmp/Kconfig
index e9ea39e..969925d 100644
--- a/drivers/video/mmp/Kconfig
+++ b/drivers/video/mmp/Kconfig
@@ -1,6 +1,6 @@
 menuconfig MMP_DISP
         tristate "Marvell MMP Display Subsystem support"
-        depends on CPU_PXA910 || CPU_MMP2 || CPU_MMP3 || CPU_PXA988
+        depends on CPU_PXA910 || CPU_MMP2 || CPU_PXA988
         help
 	  Marvell Display Subsystem support.
 
diff --git a/drivers/video/mmp/hw/Kconfig b/drivers/video/mmp/hw/Kconfig
index 02f109a..57b03e2 100644
--- a/drivers/video/mmp/hw/Kconfig
+++ b/drivers/video/mmp/hw/Kconfig
@@ -2,7 +2,7 @@ if MMP_DISP
 
 config MMP_DISP_CONTROLLER
 	bool "mmp display controller hw support"
-	depends on CPU_PXA910 || CPU_MMP2 || CPU_MMP3 || CPU_PXA988
+	depends on CPU_PXA910 || CPU_MMP2 || CPU_PXA988
 	default n
 	help
 		Marvell MMP display hw controller support
-- 
1.8.4.2

