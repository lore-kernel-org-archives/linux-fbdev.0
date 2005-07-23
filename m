From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] FB_INTEL must depend on HW_CONSOLE
Date: Sun, 24 Jul 2005 00:05:23 +0200
Message-ID: <20050723220523.GM3160@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DwS8V-0007Pu-Ep
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 23 Jul 2005 15:06:23 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1DwS8T-0005hu-TB
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 23 Jul 2005 15:06:23 -0700
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

CONFIG_FB_INTEL=y and CONFIG_HW_CONSOLE results in the following compile 
error:

<--  snip  -->

...
  LD      vmlinux
drivers/built-in.o: In function `intelfb_pci_register':
intelfbdrv.c:(.text+0x171960): undefined reference to `color_table'
intelfbdrv.c:(.text+0x171971): undefined reference to `default_red'
intelfbdrv.c:(.text+0x17197e): undefined reference to `default_grn'
intelfbdrv.c:(.text+0x17198b): undefined reference to `default_blu'
intelfbdrv.c:(.text+0x17199a): undefined reference to `color_table'
make: *** [vmlinux] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/video/Kconfig.old	2005-07-23 22:12:18.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/video/Kconfig	2005-07-23 22:12:51.000000000 +0200
@@ -756,7 +756,7 @@
 
 config FB_INTEL
 	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
-	depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
+	depends on FB && HW_CONSOLE && EXPERIMENTAL && PCI && X86 && !X86_64
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
