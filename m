From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Mon, 7 Mar 2005 13:20:20 -0500
Message-ID: <9e4733910503071020515b2014@mail.gmail.com>
References: <200503060816.55890.adaplas@hotpop.com>
	 <20050307022828.54d52983.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Mq6-00085h-T8
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:20:22 -0800
Received: from rproxy.gmail.com ([64.233.170.204])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Mq6-00048R-HE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:20:22 -0800
Received: by rproxy.gmail.com with SMTP id z35so2017115rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Mar 2005 10:20:21 -0800 (PST)
In-Reply-To: <20050307022828.54d52983.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

This should fix the tileblit build problem. I think it fixes the ppc
build too but I don't have a ppc machine to try it on.


===== drivers/video/Kconfig 1.77 vs edited =====
--- 1.77/drivers/video/Kconfig	2005-03-02 18:18:16 -05:00
+++ edited/drivers/video/Kconfig	2005-03-07 12:38:27 -05:00
@@ -541,6 +541,7 @@
 config FB_MATROX
 	tristate "Matrox acceleration"
 	depends on FB && PCI
+	select FB_TILEBLITTING
 	---help---
 	  Say Y here if you have a Matrox Millennium, Matrox Millennium II,
 	  Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
===== drivers/video/Makefile 1.117 vs edited =====
--- 1.117/drivers/video/Makefile	2005-02-17 19:03:05 -05:00
+++ edited/drivers/video/Makefile	2005-03-07 12:33:35 -05:00
@@ -10,10 +10,6 @@
 
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o
fbsysfs.o modedb.o softcursor.o
-# Only include macmodes.o if we have FB support and are PPC
-ifneq ($(CONFIG_FB),n)
-fb-$(CONFIG_PPC)                  += macmodes.o
-endif
 fb-objs                           := $(fb-y)
 
 # Hardware specific drivers go first
===== drivers/video/console/Makefile 1.19 vs edited =====
--- 1.19/drivers/video/console/Makefile	2004-10-19 05:40:21 -04:00
+++ edited/drivers/video/console/Makefile	2005-03-07 12:32:16 -05:00
@@ -25,7 +25,9 @@
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
 obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbcon.o bitblit.o font.o
-obj-$(CONFIG_FB_TILEBLITTING)     += tileblit.o
+ifeq ($(CONFIG_FB_TILEBLITTING),y)
+obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += tileblit.o
+endif
 
 obj-$(CONFIG_FB_STI)              += sticore.o
 

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
