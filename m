From: Michal Januszewski <spock@gentoo.org>
Subject: [announce 6/7] fbsplash - kconfig and makefiles
Date: Tue, 8 Mar 2005 03:15:42 +0100
Message-ID: <20050308021542.GG26249@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8UGB-0003fV-4S
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 18:15:47 -0800
Received: from ipp23-131.piekary.net ([80.48.23.131] helo=spock.one.pl)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D8UG9-00089W-CT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 18:15:47 -0800
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Michael Januszewski <spock@gentoo.org>

---
diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-03-07 16:50:34 +01:00
+++ b/drivers/video/Kconfig	2005-03-07 16:50:34 +01:00
@@ -1140,5 +1140,15 @@
 	source "drivers/video/backlight/Kconfig"
 endif
 
-endmenu
+config FB_SPLASH
+	bool "Support for the framebuffer splash"
+	depends on FRAMEBUFFER_CONSOLE=y && !FB_TILEBLITTING
+	default n
+	---help---
+	  This option enables support for graphical backgrounds on consoles. 
+	  Note that you will need userspace splash utilities in order to take
+	  advantage of these features. Refer to Documentation/fb/splash.txt 
+	  for more information.
 
+	  If unsure, say N.
+endmenu
diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2005-03-07 16:50:34 +01:00
+++ b/drivers/Makefile	2005-03-07 16:50:34 +01:00
@@ -7,15 +7,14 @@
 
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
+# char/ comes before serial/ etc so that the VT console is the boot-time
+# default.
+obj-y				+= char/
 obj-y				+= video/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
-
-# char/ comes before serial/ etc so that the VT console is the boot-time
-# default.
-obj-y				+= char/
 
 # i810fb and intelfb depend on char/agp/
 obj-$(CONFIG_FB_I810)           += video/i810/
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-03-07 16:50:34 +01:00
+++ b/drivers/video/Makefile	2005-03-07 16:50:34 +01:00
@@ -7,6 +7,7 @@
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 obj-$(CONFIG_SYSFS)		  += backlight/
+obj-$(CONFIG_FB_SPLASH)	  += fbsplash.o cfbsplash.o
 
 obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
