From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fbdev: does not allow VESA modes
 without compiled-in drivers (bug #13249)
Date: Thu, 18 Jun 2009 23:13:33 +0200
Message-ID: <20090618231333.8311b85c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MHOnt-0003jn-Ja
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Jun 2009 21:05:49 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHOnq-0006wK-Lw for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Jun 2009 21:05:49 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Werner Lemberg <wl@gnu.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Does not allow to accept VESA modes by the "vga=" kernel parameter
if there is no frame buffer driver compiled-in to handle it.

Bug was reported by Werner Lemberg as kernel bug #13249
"Intel 945GM: Boot option`vga=0x31a' breaks display of TTYs".

Also, there is a comment added to the Kconfig description
after Werner Lemberg's suggestion

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
CC: Werner Lemberg
---

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 932ffdb..d6d65ef 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1122,12 +1122,14 @@ config FB_INTEL
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_BOOT_VESA_SUPPORT
+	select FB_BOOT_VESA_SUPPORT if FB_INTEL = y
 	help
 	  This driver supports the on-board graphics built in to the Intel
           830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets.
           Say Y if you have and plan to use such a board.
 
+	  To make FB_INTELFB=Y work you need to say AGP_INTEL=y too.
+
 	  To compile this driver as a module, choose M here: the
 	  module will be called intelfb.
 
@@ -1460,7 +1462,7 @@ config FB_SIS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_BOOT_VESA_SUPPORT
+	select FB_BOOT_VESA_SUPPORT if FB_SIS = y
 	help
 	  This is the frame buffer device driver for the SiS 300, 315, 330
 	  and 340 series as well as XGI V3XT, V5, V8, Z7 graphics chipsets.

----------------------------------------------------------------------
Masz juz dosc wysokich rachunkow? Wygraj nowa mozliwosc komunikacji!
Sprawdz >>> http://link.interia.pl/f21d2


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
