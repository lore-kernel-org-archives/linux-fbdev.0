From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/7 fbdev: Remove remains of epson1356fb
Date: Mon, 07 Nov 2005 19:19:04 +0800
Message-ID: <436F3828.9000909@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5Bk-0004Vi-G4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:24 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5Bh-0006Hq-2L
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:24 -0800
Received: by xproxy.gmail.com with SMTP id i28so364656wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:29:20 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ralf Baechle <ralf@linux-mips.org>

From: Ralf Baechle <ralf@linux-mips.org>

Delete leftovers of the FB_E1356 and anything that did depend on it.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 arch/mips/au1000/common/setup.c           |   11 ----------
 arch/mips/configs/ddb5476_defconfig       |    1 
 arch/mips/configs/jmr3927_defconfig       |    1 
 arch/mips/configs/ocelot_3_defconfig      |    1 
 arch/mips/configs/pnx8550-v2pci_defconfig |    1 
 arch/mips/configs/rbhma4500_defconfig     |    1 
 drivers/video/Kconfig                     |   32 ------------------------------
 7 files changed, 48 deletions(-)


diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index 1ef15d5..4f21f42 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -111,17 +111,6 @@ void __init plat_setup(void)
     }
 #endif
 
-#ifdef CONFIG_FB_E1356
-	if ((argptr = strstr(argptr, "video=")) == NULL) {
-		argptr = prom_getcmdline();
-#ifdef CONFIG_MIPS_PB1000
-		strcat(argptr, " video=e1356fb:system:pb1000,mmunalign:1");
-#else
-		strcat(argptr, " video=e1356fb:system:pb1500");
-#endif
-	}
-#endif
-
 #ifdef CONFIG_FB_XPERT98
 	if ((argptr = strstr(argptr, "video=")) == NULL) {
 		argptr = prom_getcmdline();
diff --git a/arch/mips/configs/ddb5476_defconfig b/arch/mips/configs/ddb5476_defconfig
index b260e51..326f3aa 100644
--- a/arch/mips/configs/ddb5476_defconfig
+++ b/arch/mips/configs/ddb5476_defconfig
@@ -658,7 +658,6 @@ CONFIG_FB=y
 # CONFIG_FB_SMIVGX is not set
 # CONFIG_FB_CYBLA is not set
 # CONFIG_FB_TRIDENT is not set
-# CONFIG_FB_E1356 is not set
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 9a728c2..6390a75 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -628,7 +628,6 @@ CONFIG_FB=y
 # CONFIG_FB_SMIVGX is not set
 # CONFIG_FB_CYBLA is not set
 # CONFIG_FB_TRIDENT is not set
-# CONFIG_FB_E1356 is not set
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 
diff --git a/arch/mips/configs/ocelot_3_defconfig b/arch/mips/configs/ocelot_3_defconfig
index ffb23fc..f18d05c 100644
--- a/arch/mips/configs/ocelot_3_defconfig
+++ b/arch/mips/configs/ocelot_3_defconfig
@@ -758,7 +758,6 @@ CONFIG_FB_MODE_HELPERS=y
 # CONFIG_FB_SMIVGX is not set
 # CONFIG_FB_CYBLA is not set
 # CONFIG_FB_TRIDENT is not set
-# CONFIG_FB_E1356 is not set
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 
diff --git a/arch/mips/configs/pnx8550-v2pci_defconfig b/arch/mips/configs/pnx8550-v2pci_defconfig
index deb24c2..4a74f8c 100644
--- a/arch/mips/configs/pnx8550-v2pci_defconfig
+++ b/arch/mips/configs/pnx8550-v2pci_defconfig
@@ -895,7 +895,6 @@ CONFIG_FB=y
 # CONFIG_FB_SMIVGX is not set
 # CONFIG_FB_CYBLA is not set
 # CONFIG_FB_TRIDENT is not set
-# CONFIG_FB_E1356 is not set
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index 2bc61ca..897420d 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -876,7 +876,6 @@ CONFIG_FB_ATY_CT=y
 # CONFIG_FB_SMIVGX is not set
 # CONFIG_FB_CYBLA is not set
 # CONFIG_FB_TRIDENT is not set
-# CONFIG_FB_E1356 is not set
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 44b6ca2..25b6ca6 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -593,38 +593,6 @@ config FB_EPSON1355
 	  framebuffer.  Product specs at
 	  <http://www.erd.epson.com/vdc/html/products.htm>.
 
-config FB_E1356
-	tristate "Epson SED1356 framebuffer support"
-	depends on FB && EXPERIMENTAL && PCI && MIPS
-
-config PB1000_CRT
-	bool "Use CRT on Pb1000 (J65)"
-	depends on MIPS_PB1000=y && FB_E1356
-
-config PB1000_NTSC
-	bool "Use Compsite NTSC on Pb1000 (J63)"
-	depends on MIPS_PB1000=y && FB_E1356
-
-config PB1000_TFT
-	bool "Use TFT Panel on Pb1000 (J64)"
-	depends on MIPS_PB1000=y && FB_E1356
-
-config PB1500_CRT
-	bool "Use CRT on Pb1500 " if MIPS_PB1500=y
-	depends on FB_E1356
-
-config PB1500_CRT
-	prompt "Use CRT on Pb1100 "
-	depends on FB_E1356 && MIPS_PB1100=y
-
-config PB1500_TFT
-	bool "Use TFT Panel on Pb1500 " if MIPS_PB1500=y
-	depends on FB_E1356
-
-config PB1500_TFT
-	prompt "Use TFT Panel on Pb1100 "
-	depends on FB_E1356 && MIPS_PB1100=y
-
 config FB_S1D13XXX
 	tristate "Epson S1D13XXX framebuffer support"
 	depends on FB



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
