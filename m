From: David Vrabel <dvrabel@arcom.com>
Subject: [patch] Framebuffer kbuild -- add FB_SOFTWARE_CFB_OPS for building
 cfb*.o (1/2)
Date: Mon, 14 Feb 2005 12:43:22 +0000
Message-ID: <42109CEA.4050302@arcom.com>
References: <421096C6.3030105@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0fZa-0004qU-Cc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 04:43:30 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D0fZY-0000Yh-OH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 04:43:30 -0800
In-Reply-To: <421096C6.3030105@arcom.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Add a FB_SOFTWARE_CFB_OPS option to the framebuffer Kconfig and
Makefile.  This enables the building of the cfbfillrect, cfbcopyarea and
cfbimageblt objects.

Signed-off-by: David Vrabel <dvrabel@arcom.com>

Index: linux-2.6-i386/drivers/video/Kconfig
===================================================================
--- linux-2.6-i386.orig/drivers/video/Kconfig	2005-02-14
11:02:39.000000000 +0000
+++ linux-2.6-i386/drivers/video/Kconfig	2005-02-14 11:27:34.506113502 +0000
@@ -38,6 +38,14 @@
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.

+config FB_SOFTWARE_CFB_OPS
+	tristate
+	depends on FB
+	default n
+	---help---
+	  This enables functions for some generic software drawing operations
for drivers
+	  which don't provide their own (accelerated) ones.
+
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
Index: linux-2.6-i386/drivers/video/Makefile
===================================================================
--- linux-2.6-i386.orig/drivers/video/Makefile	2005-02-14
11:02:39.000000000 +0000
+++ linux-2.6-i386/drivers/video/Makefile	2005-02-14 11:28:49.062987325
+0000
@@ -13,6 +13,8 @@
 obj-$(CONFIG_PPC)                 += macmodes.o
 endif

+obj-$(CONFIG_FB_SOFTWARE_CFB_OPS) += cfbfillrect.o cfbcopyarea.o
cfbimgblt.o
+
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p.o


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
