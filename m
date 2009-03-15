From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: delete acceleration Kconfig
	option
Date: Sun, 15 Mar 2009 19:39:11 +0100
Message-ID: <20090315193911.5d813a6e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Liv95-0002Zx-OZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Mar 2009 18:33:11 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Liv8z-0008Em-55 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Mar 2009 18:33:06 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove Kconfig option for tridentfb acceleration.
The acceleration can be switched off with modules
"noaccel" parameter.
The acceleration for Trident chips was fixed
in  the 2.6.27 kernel.

Also, add CyberXXX and CyberBlade names to
Kconfig option's name. It should make easier
to find the tridentfb choice for cyblafb
driver's users. The cyblafb driver has been
replaced by the tridentfb driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/Kconfig     |    9 +--------
 drivers/video/tridentfb.c |   12 ------------
 2 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index a54c0e0..6ff3364 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1598,7 +1598,7 @@ config FB_VT8623
 	  VIA VT8623 [Apollo CLE266] chipset.
 
 config FB_TRIDENT
-	tristate "Trident support"
+	tristate "Trident/CyberXXX/CyberBlade support"
 	depends on FB && PCI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -1617,13 +1617,6 @@ config FB_TRIDENT
 	  To compile this driver as a module, choose M here: the
 	  module will be called tridentfb.
 
-config FB_TRIDENT_ACCEL
-	bool "Trident Acceleration functions (EXPERIMENTAL)"
-	depends on FB_TRIDENT && EXPERIMENTAL
-	---help---
-	This will compile the Trident frame buffer device with
-	acceleration functions.
-
 config FB_ARK
 	tristate "ARK 2000PV support"
 	depends on FB && PCI
diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
index 4428c70..4b446eb 100644
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -490,7 +490,6 @@ static void tgui_copy_rect(struct tridentfb_par *par,
 /*
  * Accel functions called by the upper layers
  */
-#ifdef CONFIG_FB_TRIDENT_ACCEL
 static void tridentfb_fillrect(struct fb_info *info,
 			       const struct fb_fillrect *fr)
 {
@@ -565,11 +564,6 @@ static int tridentfb_sync(struct fb_info *info)
 		par->wait_engine(par);
 	return 0;
 }
-#else
-#define tridentfb_fillrect cfb_fillrect
-#define tridentfb_copyarea cfb_copyarea
-#define tridentfb_imageblit cfb_imageblit
-#endif /* CONFIG_FB_TRIDENT_ACCEL */
 
 /*
  * Hardware access functions
@@ -1333,9 +1327,7 @@ static struct fb_ops tridentfb_ops = {
 	.fb_fillrect = tridentfb_fillrect,
 	.fb_copyarea = tridentfb_copyarea,
 	.fb_imageblit = tridentfb_imageblit,
-#ifdef CONFIG_FB_TRIDENT_ACCEL
 	.fb_sync = tridentfb_sync,
-#endif
 };
 
 static int __devinit trident_pci_probe(struct pci_dev *dev,
@@ -1359,10 +1351,6 @@ static int __devinit trident_pci_probe(struct pci_dev *dev,
 
 	chip_id = id->device;
 
-#ifndef CONFIG_FB_TRIDENT_ACCEL
-	noaccel = 1;
-#endif
-
 	/* If PCI id is 0x9660 then further detect chip type */
 
 	if (chip_id == TGUI9660) {
-- 
1.5.2.2



----------------------------------------------------------------------
Program tylko dla graczy komputerowych! 
Ogladaj >>> http://link.interia.pl/f207f 


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
