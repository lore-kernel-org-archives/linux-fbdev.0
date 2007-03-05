From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/4] fbdev: Fix kconfig error if FB_DDC=n
Date: Mon, 05 Mar 2007 17:53:49 +0800
Message-ID: <45EBE8AD.1020309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HO9s8-0000bD-2I for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 01:52:48 -0800
Received: from nz-out-0506.google.com ([64.233.162.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HO9s7-0003eB-91
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 01:52:48 -0800
Received: by nz-out-0506.google.com with SMTP id i11so2494886nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 05 Mar 2007 01:52:47 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: James Simmons <jsimmons@infradead.org>

Fix the following error if FB_DDC=n

Kernel: arch/x86_64/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST 229 modules
WARNING: "fb_ddc_read" [drivers/video/nvidia/nvidiafb.ko] undefined!
make[1]: *** [__modpost] Error 1

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4133a7a..49f7349 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -707,8 +707,6 @@ config FB_S1D13XXX
 config FB_NVIDIA
 	tristate "nVidia Framebuffer Support"
 	depends on FB && PCI
-	select I2C_ALGOBIT if FB_NVIDIA_I2C
-	select I2C if FB_NVIDIA_I2C
 	select FB_BACKLIGHT if FB_NVIDIA_BACKLIGHT
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
@@ -727,6 +725,7 @@ config FB_NVIDIA
 config FB_NVIDIA_I2C
        bool "Enable DDC Support"
        depends on FB_NVIDIA
+       select FB_DDC
        help
 	  This enables I2C support for nVidia Chipsets.  This is used
 	  only for getting EDID information from the attached display
@@ -746,7 +745,6 @@ config FB_NVIDIA_BACKLIGHT
 config FB_RIVA
 	tristate "nVidia Riva support"
 	depends on FB && PCI
-	select FB_DDC if FB_RIVA_I2C
 	select FB_BACKLIGHT if FB_RIVA_BACKLIGHT
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
@@ -764,6 +762,7 @@ config FB_RIVA
 config FB_RIVA_I2C
        bool "Enable DDC Support"
        depends on FB_RIVA
+       select FB_DDC
        help
 	  This enables I2C support for nVidia Chipsets.  This is used
 	  only for getting EDID information from the attached display
@@ -842,8 +841,6 @@ config FB_INTEL
 	depends on FB && EXPERIMENTAL && PCI && X86
 	select AGP
 	select AGP_INTEL
-	select I2C_ALGOBIT if FB_INTEL_I2C
-	select I2C if FB_INTEL_I2C
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -876,6 +873,7 @@ config FB_INTEL_DEBUG
 config FB_INTEL_I2C
 	bool "DDC/I2C for Intel framebuffer support"
 	depends on FB_INTEL
+	select FB_DDC
 	default y
 	help
 	  Say Y here if you want DDC/I2C support for your on-board Intel graphics.
@@ -954,8 +952,8 @@ config FB_MATROX_G
 
 config FB_MATROX_I2C
 	tristate "Matrox I2C support"
-	depends on FB_MATROX && I2C
-	select I2C_ALGOBIT
+	depends on FB_MATROX
+	select FB_DDC
 	---help---
 	  This drivers creates I2C buses which are needed for accessing the
 	  DDC (I2C) bus present on all Matroxes, an I2C bus which
@@ -1023,7 +1021,6 @@ config FB_MATROX_MULTIHEAD
 config FB_RADEON
 	tristate "ATI Radeon display support"
 	depends on FB && PCI
-	select FB_DDC if FB_RADEON_I2C
 	select FB_BACKLIGHT if FB_RADEON_BACKLIGHT
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
@@ -1048,6 +1045,7 @@ config FB_RADEON
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
 	depends on FB_RADEON
+	select FB_DDC
 	default y
 	help
 	  Say Y here if you want DDC/I2C support for your Radeon board. 
@@ -1155,7 +1153,6 @@ config FB_S3
 config FB_SAVAGE
 	tristate "S3 Savage support"
 	depends on FB && PCI && EXPERIMENTAL
-	select FB_DDC if FB_SAVAGE_I2C
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -1172,6 +1169,7 @@ config FB_SAVAGE
 config FB_SAVAGE_I2C
        bool "Enable DDC2 Support"
        depends on FB_SAVAGE
+       select FB_DDC
        help
 	  This enables I2C support for S3 Savage Chipsets.  This is used
 	  only for getting EDID information from the attached display


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
