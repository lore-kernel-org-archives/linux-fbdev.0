From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Subject: [PATCH 3/4] video: sh7760fb: SH7760/SH7763 LCDC
 framebuffer driver part 3/3
Date: Wed, 25 Jun 2008 16:38:56 +0900
Message-ID: <4861F610.3060404@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KBPat-0001JS-On for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jun 2008 00:39:07 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail02.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KBPas-0002ZB-A8
	for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jun 2008 00:39:07 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel@lists.sourceforge.net
Cc: Paul Mundt <lethal@linux-sh.org>, Linux-sh <linux-sh@vger.kernel.org>

Makefile and Kconfig of driver for LCDC interface on SH7760 and SH7763 SoCs.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/video/Kconfig  |   13 +++++++++++++
 drivers/video/Makefile |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 002b61b..f79634d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1950,6 +1950,19 @@ config FB_AM200EPD
          This enables support for the Metronome display controller used on
          the E-Ink AM-200 EPD devkit.

+config FB_SH7760
+	bool "SH7760/SH7763 LCDC support"
+	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  Support for the SH7760/SH7763 integrated (D)STN/TFT LCD Controller.
+	  Supports display resolutions up to 1024x1024 pixel, grayscale and
+	  color operation, with depths ranging from 1 bpp to 8 bpp monochrome
+	  and 8, 15 or 16 bpp color; 90 degrees clockwise display rotation for
+	  panels <= 320 pixel horizontal resolution.
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 04bca35..0dcd740 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_FB_SM501)            += sm501fb.o
 obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
+obj-$(CONFIG_FB_SH7760)		  += sh7760fb.o

 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
-- 
1.5.5.1


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
