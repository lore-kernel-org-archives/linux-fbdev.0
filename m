From: David Vrabel <dvrabel@arcom.com>
Subject: [patch] Framebuffer kbuild -- add FB_SOFT_CURSOR option (3/4)
Date: Tue, 15 Feb 2005 10:54:15 +0000
Message-ID: <4211D4D7.6030001@arcom.com>
References: <421096C6.3030105@arcom.com> <Pine.GSO.4.61.0502141322060.16209@waterleaf.sonytel.be> <Pine.LNX.4.56.0502141724240.6781@pentafluge.infradead.org> <4211D2DF.2070302@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000301060402030803010202"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D10LV-0004Ns-Gv
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 02:54:21 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D10LV-0004IY-2c
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 02:54:21 -0800
In-Reply-To: <4211D2DF.2070302@arcom.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000301060402030803010202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Add FB_SOFT_CURSOR option to the framebuffer Kconfig and Makefile.  This
enables the inclusion of the soft_cursor function.

Signed-off-by: David Vrabel <dvrabel@arcom.com>

--------------000301060402030803010202
Content-Type: text/plain;
 name="fb-kbuild-add-FB_SOFT_CURSOR"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fb-kbuild-add-FB_SOFT_CURSOR"

Index: linux-2.6-i386/drivers/video/Kconfig
===================================================================
--- linux-2.6-i386.orig/drivers/video/Kconfig	2005-02-15 10:12:46.078098585 +0000
+++ linux-2.6-i386/drivers/video/Kconfig	2005-02-15 10:14:15.831297005 +0000
@@ -65,6 +65,15 @@
 	  blitting. This is used by drivers that don't provide their own
 	  (accelerated) version.
 
+config FB_SOFT_CURSOR
+	tristate
+	depends on FB
+	default n
+	---help---
+	  Include the soft_cursor function for generic software cursor support.
+	  This is used by drivers that don't provide their own (accelerated)
+	  version.
+
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
Index: linux-2.6-i386/drivers/video/Makefile
===================================================================
--- linux-2.6-i386.orig/drivers/video/Makefile	2005-02-15 10:12:46.082097881 +0000
+++ linux-2.6-i386/drivers/video/Makefile	2005-02-15 10:12:58.740869230 +0000
@@ -7,7 +7,7 @@
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 
-obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o softcursor.o
+obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o
 # Only include macmodes.o if we have FB support and are PPC
 ifeq ($(CONFIG_FB),y)
 obj-$(CONFIG_PPC)                 += macmodes.o
@@ -16,6 +16,7 @@
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
 obj-$(CONFIG_FB_CFB_IMAGEBLIT) += cfbimgblt.o
+obj-$(CONFIG_FB_SOFT_CURSOR)   += softcursor.o
 
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o

--------------000301060402030803010202--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
