From: David Vrabel <dvrabel@arcom.com>
Subject: [patch] Framebuffer kbuild -- add FB_CFB_xxx options (1/2)
Date: Mon, 14 Feb 2005 14:04:22 +0000
Message-ID: <4210AFE6.1090201@arcom.com>
References: <421096C6.3030105@arcom.com> <Pine.GSO.4.61.0502141322060.16209@waterleaf.sonytel.be> <4210AC9A.9080707@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050702010509060104050800"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0gpy-0001Io-38
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 06:04:30 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D0gpw-0007AQ-Jj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 06:04:30 -0800
In-Reply-To: <4210AC9A.9080707@arcom.com>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

This is a multi-part message in MIME format.
--------------050702010509060104050800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Add FB_CFB_FILLRECT, FB_CFB_COPYAREA, and FB_CFB_IMAGEBLIT options to
the framebuffer Kconfig and Makefile.  This enables the inclusion of the
cfb_fillrect, cfb_copyarea and cfb_imageblt functions.

Signed-off-by: David Vrabel <dvrabel@arcom.com>

--------------050702010509060104050800
Content-Type: text/plain;
 name="fb-kbuild-add-FB_CFB_xxx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fb-kbuild-add-FB_CFB_xxx"

Index: linux-2.6-i386/drivers/video/Kconfig
===================================================================
--- linux-2.6-i386.orig/drivers/video/Kconfig	2005-02-14 11:02:39.000000000 +0000
+++ linux-2.6-i386/drivers/video/Kconfig	2005-02-14 13:38:03.257815634 +0000
@@ -38,6 +38,30 @@
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
 
+config FB_CFB_FILLRECT
+	tristate
+	depends on FB
+	default n
+	---help---
+	  Include the cfb_fillrect function for generic software rectangle filling.
+	  This is used by drivers that don't provide their own (accelerated) version.
+
+config FB_CFB_COPYAREA
+	tristate
+	depends on FB
+	default n
+	---help---
+	  Include the cfb_copyarea function for generic software area copying.
+	  This is used by drivers that don't provide their own (accelerated) version.
+
+config FB_CFB_IMAGEBLIT
+	tristate
+	depends on FB
+	default n
+	---help---
+	  Include the cfb_imageblit function for generic software image blitting.
+	  This is used by drivers that don't provide their own (accelerated) version.
+
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
Index: linux-2.6-i386/drivers/video/Makefile
===================================================================
--- linux-2.6-i386.orig/drivers/video/Makefile	2005-02-14 11:02:39.000000000 +0000
+++ linux-2.6-i386/drivers/video/Makefile	2005-02-14 13:36:19.558072584 +0000
@@ -13,6 +13,10 @@
 obj-$(CONFIG_PPC)                 += macmodes.o
 endif
 
+obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
+obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
+obj-$(CONFIG_FB_CFB_IMAGEBLIT) += cfbimgblt.o
+
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p.o

--------------050702010509060104050800--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
