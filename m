From: Tony Prisk <linux@prisktech.co.nz>
Date: Wed, 02 Jan 2013 20:23:04 +0000
Subject: [PATCH 4/4] video: vt8500: Update descriptions in video/Kconfig
Message-Id: <1357158184-18213-4-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1357158184-18213-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1357158184-18213-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch updates the descriptions for the VIA VT8500 and
Wondermedia WM8xxx-series framebuffer drivers to correctly reflect
which hardware they support.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/video/Kconfig |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6678daf..3bbb3c1 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1767,7 +1767,7 @@ config FB_AU1200
 	  option au1200fb:panel=<name>.
 
 config FB_VT8500
-	bool "VT8500 LCD Driver"
+	bool "VIA VT8500 Framebuffer Driver"
 	depends on (FB = y) && ARM && ARCH_VT8500
 	select FB_SYS_FILLRECT if (!FB_WMT_GE_ROPS)
 	select FB_SYS_COPYAREA if (!FB_WMT_GE_ROPS)
@@ -1777,14 +1777,15 @@ config FB_VT8500
 	  controller.
 
 config FB_WM8505
-	bool "WM8505 frame buffer support"
+	bool "Wondermedia WM8xxx-series framebuffer support"
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
 	bool "VT8500/WM8xxx accelerated raster ops support"
-- 
1.7.9.5

