From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Allow core fb to be built as a module
Date: Thu, 24 Feb 2005 15:39:47 -0500
Message-ID: <9e4733910502241239268ca595@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4PmA-0001rU-D5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Feb 2005 12:39:58 -0800
Received: from rproxy.gmail.com ([64.233.170.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D4Pm7-0006q6-Vd
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Feb 2005 12:39:58 -0800
Received: by rproxy.gmail.com with SMTP id z35so913005rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 24 Feb 2005 12:39:48 -0800 (PST)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

I'm starting to get too many patches hanging around. Is there any
reason this one can't be pushed up stream? My next target would be the
sysfs patch.

-- 
Jon Smirl
jonsmirl@gmail.com


diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-02-17 19:11:37 -05:00
+++ b/drivers/video/Kconfig	2005-02-17 19:11:37 -05:00
@@ -5,7 +5,7 @@
 menu "Graphics support"
 
 config FB
-	bool "Support for frame buffer devices"
+	tristate "Support for frame buffer devices"
 	---help---
 	  The frame buffer device provides an abstraction for the graphics
 	  hardware. It represents the frame buffer of some video hardware and
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-02-17 19:11:37 -05:00
+++ b/drivers/video/Makefile	2005-02-17 19:11:37 -05:00
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
--- a/drivers/video/fbmem.c	2005-02-17 19:11:37 -05:00
+++ b/drivers/video/fbmem.c	2005-02-17 19:11:37 -05:00
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
