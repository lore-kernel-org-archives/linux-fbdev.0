From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] FB_GEODE should depend on PCI
Date: Sat, 3 Sep 2005 14:01:34 +0200
Message-ID: <20050903120134.GL3657@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750894AbVICMBv@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Vrabel <dvrabel@arcom.com>
Cc: James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@pol.net>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Due to fbdev-geode-updates.patch, building with CONFIG_PCI=n results in 
the following error:

<--  snip  -->

...
  CC [M]  drivers/video/geode/gx1fb_core.o
drivers/video/geode/gx1fb_core.c: In function 'gx1fb_map_video_memory':
drivers/video/geode/gx1fb_core.c:218: warning: implicit declaration of 
function 'pci_request_region'
drivers/video/geode/gx1fb_core.c: In function 'gx1fb_probe':
drivers/video/geode/gx1fb_core.c:372: warning: implicit declaration of 
function 'pci_release_region'
...
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  2.6.13-mm1; fi
WARNING: /lib/modules/2.6.13-mm1/kernel/drivers/video/geode/gx1fb.ko needs unknown symbol pci_release_region

<--  snip  -->


Since the driver doesn't seem to be working without pci_request_region() 
this patch adds the required dependency on PCI.

The dependency is placed at FB_GEODE since there's (at least currently) 
no reason to show this option if no driver depending on it is available 
without PCI.

Additionally, it removes two superfluous "default n".


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/drivers/video/geode/Kconfig.old	2005-09-03 13:55:41.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/video/geode/Kconfig	2005-09-03 13:56:17.000000000 +0200
@@ -3,15 +3,13 @@
 #
 config FB_GEODE
 	bool "AMD Geode family framebuffer support (EXPERIMENTAL)"
-	default n
-	depends on FB && EXPERIMENTAL && X86
+	depends on FB && PCI && EXPERIMENTAL && X86
 	---help---
 	  Say 'Y' here to allow you to select framebuffer drivers for
 	  the AMD Geode family of processors.
 
 config FB_GEODE_GX1
 	tristate "AMD Geode GX1 framebuffer support (EXPERIMENTAL)"
-	default n
 	depends on FB_GEODE && EXPERIMENTAL
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
