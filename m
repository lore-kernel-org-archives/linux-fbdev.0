From: syrjala@sci.fi
Subject: [PATCH 7/8] atyfb: LT/LG cleanup
Date: Thu, 17 Mar 2005 08:31:05 +0200 (EET)
Message-ID: <20050317063105.27F317A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBoXE-0006G7-Kp
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:08 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBoXD-00049y-L1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:08 -0800
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
MIME-Version: 1.0
Content-Type: text; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: alex.kern@gmx.de

Clean up LT and LG chip descriptions.

"Mach64 LG" is called 3D Rage LT in the specs and ATI press releases.

"Mach64 LT" is unclear. XFree86 driver doesn't know this chip at all. 
Windows display.inf calls it just "mach64 LT" and it uses the same 
driver as VT-A/GT-A and older chips. VT-B/GT-B and better use another 
driver and all of those chips have a more descriptive name in the 
display.inf file. That makes me think this chip is not a 3D Rage chip. 
Maybe it's a mobile version of ET?

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 atyfb_base.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff -urN linux/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2005-03-16 19:23:19.000000000 +0200
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-16 19:37:14.000000000 +0200
@@ -349,6 +349,7 @@
 #define ATI_CHIP_264VT3    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL)
 #define ATI_CHIP_264VT4    (M64F_VT | M64F_INTEGRATED               | M64F_GTB_DSP)
 
+/* FIXME what is this chip? */
 #define ATI_CHIP_264LT     (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP)
 
 /* make sets shorter */
@@ -381,6 +382,9 @@
 	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, 0, ATI_CHIP_264CT },
 	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, 0, ATI_CHIP_264ET },
 
+	/* FIXME what is this chip? */
+	{ PCI_CHIP_MACH64LT, "ATI264LT (Mach64 LT)", 135, 63, 63, 0, ATI_CHIP_264LT },
+
 	{ PCI_CHIP_MACH64VT, "ATI264VT (Mach64 VT)", 170, 67, 67, 80, ATI_CHIP_264VT },
 	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, 80, ATI_CHIP_264GT },
 
@@ -388,9 +392,7 @@
 	/* FIXME { ...ATI_264GU, maybe ATI_CHIP_264GTDVD }, */
 	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GU)", 200, 67, 67, 100, ATI_CHIP_264GTB },
 
-	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, 0, ATI_CHIP_264LT },
-	 /* FIXME chipset maybe ATI_CHIP_264LTPRO ? */
-	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, 100, ATI_CHIP_264LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
+	{ PCI_CHIP_MACH64LG, "3D RAGE LT (Mach64 LG)", 230, 63, 63, 100, ATI_CHIP_264LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
 
 	{ PCI_CHIP_MACH64VV, "ATI264VT4 (Mach64 VV)", 230, 83, 83, 100, ATI_CHIP_264VT4 },
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
