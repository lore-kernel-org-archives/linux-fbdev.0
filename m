From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Allow core fb to be built as a module
Date: Wed, 2 Mar 2005 12:54:57 -0500
Message-ID: <9e47339105030209542a06a882@mail.gmail.com>
References: <9e4733910502241239268ca595@mail.gmail.com>
	 <Pine.LNX.4.56.0502282010070.16877@pentafluge.infradead.org>
	 <200503012031.50512.adaplas@hotpop.com>
	 <9e473391050302092834dc6e36@mail.gmail.com>
	 <Pine.LNX.4.56.0503021730340.20488@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6Y3o-0000hb-L7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:55:00 -0800
Received: from rproxy.gmail.com ([64.233.170.196])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6Y3n-0006fz-Rn
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:55:00 -0800
Received: by rproxy.gmail.com with SMTP id z35so328527rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Mar 2005 09:54:58 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0503021730340.20488@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>

Patch to allow building of the fbdev core as a module.
Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

-- 
Jon Smirl
jonsmirl@gmail.com

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-03-02 12:51:46 -05:00
+++ b/drivers/video/Kconfig	2005-03-02 12:51:46 -05:00
@@ -5,7 +5,7 @@
 menu "Graphics support"
 
 config FB
-	bool "Support for frame buffer devices"
+	tristate "Support for frame buffer devices"
 	---help---
 	  The frame buffer device provides an abstraction for the graphics
 	  hardware. It represents the frame buffer of some video hardware and
@@ -269,11 +269,11 @@
 
 config FB_ASILIANT
 	bool "Chips 69000 display support"
-	depends on FB && PCI
+	depends on (FB = y) && PCI
 
 config FB_IMSTT
 	bool "IMS Twin Turbo display support"
-	depends on FB && PCI
+	depends on (FB = y) && PCI
 	help
 	  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
 	  many Macintosh and compatible computers.
@@ -330,7 +330,7 @@
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on FB && (X86 || X86_64)
+	depends on (FB = y) && (X86 || X86_64)
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-03-02 12:51:46 -05:00
+++ b/drivers/video/Makefile	2005-03-02 12:51:46 -05:00
@@ -8,11 +8,13 @@
 obj-$(CONFIG_LOGO)		  += logo/
 obj-$(CONFIG_SYSFS)		  += backlight/
 
-obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o
fbsysfs.o modedb.o softcursor.o
+obj-$(CONFIG_FB)                  += fb.o
+fb-y                              := fbmem.o fbmon.o fbcmap.o
fbsysfs.o modedb.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC
-ifeq ($(CONFIG_FB),y)
-obj-$(CONFIG_PPC)                 += macmodes.o
+ifneq ($(CONFIG_FB),n)
+fb-$(CONFIG_PPC)                  += macmodes.o
 endif
+fb-objs                           := $(fb-y)
 
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2005-03-02 12:51:46 -05:00
+++ b/drivers/video/fbmem.c	2005-03-02 12:51:46 -05:00
@@ -1204,7 +1204,22 @@
 	}
 	return 0;
 }
+
+void __exit
+fbmem_exit(void)
+{
+	class_simple_destroy(fb_class);
+}
+
+#ifdef MODULE
+module_init(fbmem_init);
+module_exit(fbmem_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Framebuffer base");
+#else
 subsys_initcall(fbmem_init);
+subsys_exitcall(fbmem_exit);
+#endif
 
 static char *video_options[FB_MAX];
 static int ofonly;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
