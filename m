From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fbdev kconfig update
Date: Sun, 10 Aug 2008 19:22:07 +0200
Message-ID: <20080810192207.f65de894.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSEWy-0004jq-Bh for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 10:16:36 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSEWu-0008UN-J9
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 10:16:36 -0700
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Update Kconfig for Permedia 2, Trident and
3Dfx frame buffer drivers.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

These are drivers I has been involved in testing or
changing.

It would be nice to have this updated description
in 2.6.27 kernel as the patch can hardly produce any
regression.

--- linux-old/drivers/video/Kconfig	2008-08-04 18:00:45.000000000 +0200
+++ linux-mm/drivers/video/Kconfig	2008-08-10 19:15:39.463597618 +0200
@@ -259,16 +259,24 @@ config FB_PM2
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	help
-	  This is the frame buffer device driver for the Permedia2 AGP frame
-	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
-	  product page at
-	  <http://www.ask.com.hk/product/Permedia%202/permedia2.htm>.
+	  This is the frame buffer device driver for cards based on
+	  the 3D Labs Permedia, Permedia 2 and Permedia 2V chips.
+	  The driver was tesed on following cards are:
+		Diamond FireGL 1000 PRO AGP
+		ELSA Gloria Synergy PCI
+		Appian Jeronimo PRO (both heads) PCI
+		3DLabs Oxygen ACX aka EONtronics Picasso P2 PCI
+		Techsource Raptor GFX-8P (aka Sun PGX-32) on SPARC
+		ASK Graphic Blaster Exxtreme AGP
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pm2fb.
 
 config FB_PM2_FIFO_DISCONNECT
 	bool "enable FIFO disconnect feature"
 	depends on FB_PM2 && PCI
 	help
-	  Support the Permedia2 FIFO disconnect feature (see CONFIG_FB_PM2).
+	  Support the Permedia2 FIFO disconnect feature.
 
 config FB_ARMCLCD
 	tristate "ARM PrimeCell PL110 support"
@@ -1545,25 +1553,25 @@ config FB_KYRO
 	  module will be called kyrofb.
 
 config FB_3DFX
-	tristate "3Dfx Banshee/Voodoo3 display support"
+	tristate "3Dfx Banshee/Voodoo3/Voodoo5 display support"
 	depends on FB && PCI
 	select FB_CFB_IMAGEBLIT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	help
-	  This driver supports graphics boards with the 3Dfx Banshee/Voodoo3
-	  chips. Say Y if you have such a graphics board.
+	  This driver supports graphics boards with the 3Dfx Banshee,
+	  Voodoo3 or VSA-100 (aka Voodoo4/5) chips. Say Y if you have
+	  such a graphics board.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called tdfxfb.
 
 config FB_3DFX_ACCEL
-	bool "3Dfx Banshee/Voodoo3 Acceleration functions (EXPERIMENTAL)"
+	bool "3Dfx Acceleration functions (EXPERIMENTAL)"
 	depends on FB_3DFX && EXPERIMENTAL
 	---help---
-	This will compile the 3Dfx Banshee/Voodoo3 frame buffer device
-	with acceleration functions.
-
+	This will compile the 3Dfx Banshee/Voodoo3/VSA-100 frame buffer
+	device driver with acceleration functions.
 
 config FB_VOODOO1
 	tristate "3Dfx Voodoo Graphics (sst1) support"
@@ -1629,17 +1637,16 @@ config FB_TRIDENT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	---help---
-	  This driver is supposed to support graphics boards with the
-	  Trident CyberXXXX/Image/CyberBlade chips mostly found in laptops
+	  This is frame buffer device driver for Trident PCI/AGP chipsets.
+	  Supported chipset families are TGUI 9440/96XX, 3DImage, Blade3D
+	  and Blade XP.
+	  There are also integrated versions of these chips called CyberXXXX,
+	  CyberImage or CyberBlade. These chips are mostly found in laptops
 	  but also on some motherboards. For more information, read
 	  <file:Documentation/fb/tridentfb.txt>
 
-	  Cyberblade/i1 support will be removed soon, use the cyblafb driver
-	  instead.
-
 	  Say Y if you have such a graphics board.
 
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called tridentfb.
 


----------------------------------------------------------------------
Tylko dla detektywow! Konkurs na Smaker.pl
Kliknij >>> http://link.interia.pl/f1eb1


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
