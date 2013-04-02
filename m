From: Tony Prisk <linux@prisktech.co.nz>
Date: Tue, 02 Apr 2013 04:49:57 +0000
Subject: [PATCHv2 3/6] video: vt8500: Correct descriptions in video/Kconfig
Message-Id: <1364878200-26343-4-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364878200-26343-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1364878200-26343-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch corrects the descriptions for the VIA VT8500 and
Wondermedia WM8xxx-series framebuffer drivers to correctly reflect
which hardware they support.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Reviewed-by: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 drivers/video/Kconfig |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 661aa54..ad762ed 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1789,7 +1789,7 @@ config FB_AU1200
 	  option au1200fb:panel=<name>.
 
 config FB_VT8500
-	bool "VT8500 LCD Driver"
+	bool "VIA VT8500 framebuffer support"
 	depends on (FB = y) && ARM && ARCH_VT8500
 	select FB_SYS_FILLRECT if (!FB_WMT_GE_ROPS)
 	select FB_SYS_COPYAREA if (!FB_WMT_GE_ROPS)
@@ -1799,17 +1799,18 @@ config FB_VT8500
 	  controller.
 
 config FB_WM8505
-	bool "WM8505 frame buffer support"
+	bool "Wondermedia WM8xxx-series frame buffer support"
 	depends on (FB = y) && ARM && ARCH_VT8500
 	select FB_SYS_FILLRECT if (!FB_WMT_GE_ROPS)
 	select FB_SYS_COPYAREA if (!FB_WMT_GE_ROPS)
 	select FB_SYS_IMAGEBLIT
 	help
-	  This is the framebuffer driver for WonderMedia WM8505/WM8650
-	  integrated LCD controller.
+	  This is the framebuffer driver for WonderMedia WM8xxx-series
+	  integrated LCD controller. This driver covers the WM8505, WM8650
+	  and WM8850 SoCs.
 
 config FB_WMT_GE_ROPS
-	bool "VT8500/WM85xx accelerated raster ops support"
+	bool "VT8500/WM8xxx accelerated raster ops support"
 	depends on (FB = y) && (FB_VT8500 || FB_WM8505)
 	default n
 	help
-- 
1.7.9.5

