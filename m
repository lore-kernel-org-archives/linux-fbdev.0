From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/9][FBDEV]: select FB_MODE_HELPERS for i810fb, rivafb, radeonfb
Date: Sat, 21 Aug 2004 21:33:26 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408212054.01047.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByW1C-0008Gb-LF
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:50 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1ByW1C-0008NH-7q
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:50 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 74290720CD
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 13:34:38 +0000 (UTC)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Patch is from Kronos <kronos@people.it>:

Select FB_MODE_HELPERS for i810fb, rivafb, radeonfb.  Full functionality for
these drivers requires this option, and it fixes the 'vesa_modes' compile
error for radeonfb.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Kconfig |    3 +++
 1 files changed, 3 insertions(+)
diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/Kconfig linux-2.6.8.1-mm3/drivers/video/Kconfig
--- linux-2.6.8.1-mm3-orig/drivers/video/Kconfig	2004-08-21 18:26:53.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/Kconfig	2004-08-21 18:52:00.028189320 +0800
@@ -450,6 +450,7 @@ config FB_RIVA
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_RIVA_I2C
 	select I2C if FB_RIVA_I2C
+	select FB_MODE_HELPERS
 	help
 	  This driver supports graphics boards with the nVidia Riva/Geforce
 	  chips.
@@ -484,6 +485,7 @@ config FB_I810
 	depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
 	select AGP
 	select AGP_INTEL
+	select FB_MODE_HELPERS
 	help
 	  This driver supports the on-board graphics built in to the Intel 810 
           and 815 chipsets.  Say Y if you have and plan to use such a board.
@@ -687,6 +689,7 @@ config FB_RADEON
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_RADEON_I2C
 	select I2C if FB_RADEON_I2C
+	select FB_MODE_HELPERS
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
