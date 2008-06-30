From: <JosephChan@via.com.tw>
Subject: [PATCH 2/13] viafb: Makefile, Kconfig
Date: Mon, 30 Jun 2008 14:33:54 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7716@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDCxa-0000fI-4v for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Jun 2008 23:33:58 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDCxZ-00052H-PS
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Jun 2008 23:33:58 -0700
Content-class: urn:content-classes:message
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: JosephChan@via.com.tw, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, geert@linux-m68k.org

Modified drivers/video/Makefile and drivers/video/Kconfig files of 2.6.26-rc8 kernel.

Signed-off-by: Joseph Chan <josephchan@via.com.tw>

diff -Nur a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2008-06-30 09:54:30.000000000 +0800
+++ b/drivers/video/Kconfig	2008-06-30 09:55:20.000000000 +0800
@@ -1498,6 +1498,23 @@
 	  (315/H/PRO, 55x, 650, 651, 740, 330, 661, 741, 760, 761) as well
 	  as XGI V3XT, V5, V8 and Z7.
 
+config FB_VIA
+       tristate "VIA UniChrome (Pro) and Chrome9 display support"
+       depends on FB && PCI
+       select FB_CFB_FILLRECT
+       select FB_CFB_COPYAREA
+       select FB_CFB_IMAGEBLIT
+       select FB_SOFT_CURSOR
+       help
+	  This is the frame buffer device driver for Graphics chips of VIA 
+	  UniChrome (Pro) Family (CLE266,PM800/CN400,P4M800CE/P4M800Pro/
+	  CN700/VN800,CX700/VX700,P4M890) and Chrome9 Family (K8M890,CN896
+ 	  /P4M900,VX800)
+	  Say Y if you have a VIA UniChrome graphics board.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called viafb.
+
 config FB_NEOMAGIC
 	tristate "NeoMagic display support"
 	depends on FB && PCI
diff -Nur a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2008-06-30 09:53:16.000000000 +0800
+++ b/drivers/video/Makefile	2008-06-30 09:55:24.000000000 +0800
@@ -43,6 +43,7 @@
 obj-$(CONFIG_FB_ATY128)		  += aty/ macmodes.o
 obj-$(CONFIG_FB_RADEON)		  += aty/
 obj-$(CONFIG_FB_SIS)		  += sis/
+obj-$(CONFIG_FB_VIA)		  += via/
 obj-$(CONFIG_FB_KYRO)             += kyro/
 obj-$(CONFIG_FB_SAVAGE)		  += savage/
 obj-$(CONFIG_FB_GEODE)		  += geode/
-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
