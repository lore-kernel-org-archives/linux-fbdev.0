From: syrjala@sci.fi
Subject: [PATCH 6/8] atyfb: VT/GT cleanup
Date: Thu, 17 Mar 2005 05:07:52 +0200 (EET)
Message-ID: <20050317030752.EAF1D7A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBlMZ-00057q-O1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 19:07:55 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DBlMX-0003Ij-Ve
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 19:07:55 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 1B116DC659
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Mar 2005 05:07:53 +0200 (EET)
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
Cc: alex.kern@gmx.de

Clean up VT and GT chip descriptions.

All B revision VT chips are called 264VT3. Verified from pictures of the 
chips as the specs are a bit unlear in this.

GT revision B1 is Rage II, B2 is Rage II+. Specs and chip pictures seem 
to agree.

VT revision A4 is 264VT2. Verified from chip pictures and Windows 
display.inf. So revision A3 is probably a plain 264VT. I didn't find any 
proof for that though...

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 atyfb_base.c |   61 +++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 41 insertions(+), 20 deletions(-)

diff -urN linux/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2005-03-16 19:09:32.000000000 +0200
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-16 19:16:37.000000000 +0200
@@ -380,11 +380,13 @@
 #ifdef CONFIG_FB_ATY_CT
 	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, 0, ATI_CHIP_264CT },
 	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, 0, ATI_CHIP_264ET },
-	{ PCI_CHIP_MACH64VT, "ATI264VT? (Mach64 VT)", 170, 67, 67, 80, ATI_CHIP_264VT },
+
+	{ PCI_CHIP_MACH64VT, "ATI264VT (Mach64 VT)", 170, 67, 67, 80, ATI_CHIP_264VT },
 	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, 80, ATI_CHIP_264GT },
+
+	{ PCI_CHIP_MACH64VU, "ATI264VT3 (Mach64 VU)", 200, 67, 67, 80, ATI_CHIP_264VT3 },
 	/* FIXME { ...ATI_264GU, maybe ATI_CHIP_264GTDVD }, */
-	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GTB)", 200, 67, 67, 100, ATI_CHIP_264GTB  },
-	{ PCI_CHIP_MACH64VU, "ATI264VTB (Mach64 VU)", 200, 67, 67, 80, ATI_CHIP_264VT3 },
+	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GU)", 200, 67, 67, 100, ATI_CHIP_264GTB },
 
 	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, 0, ATI_CHIP_264LT },
 	 /* FIXME chipset maybe ATI_CHIP_264LTPRO ? */
@@ -460,44 +462,63 @@
 #endif
 #ifdef CONFIG_FB_ATY_CT
 	case PCI_CHIP_MACH64VT:
-		rev &= 0xc7;
-		if(rev == 0x00) {
-			name = "ATI264VTA3 (Mach64 VT)";
-			par->pll_limits.pll_max = 170;
-			par->pll_limits.mclk = 67;
-			par->pll_limits.xclk = 67;
-			par->pll_limits.ecp_max = 80;
-			par->features = ATI_CHIP_264VT;
-		} else if(rev == 0x40) {
-			name = "ATI264VTA4 (Mach64 VT)";
+		switch (rev & 0x07) {
+		case 0x00:
+			switch (rev & 0xc0) {
+			case 0x00:
+				name = "ATI264VT (A3) (Mach64 VT)";
+				par->pll_limits.pll_max = 170;
+				par->pll_limits.mclk = 67;
+				par->pll_limits.xclk = 67;
+				par->pll_limits.ecp_max = 80;
+				par->features = ATI_CHIP_264VT;
+				break;
+			case 0x40:
+				name = "ATI264VT2 (A4) (Mach64 VT)";
+				par->pll_limits.pll_max = 200;
+				par->pll_limits.mclk = 67;
+				par->pll_limits.xclk = 67;
+				par->pll_limits.ecp_max = 80;
+				par->features = ATI_CHIP_264VT | M64F_MAGIC_POSTDIV;
+				break;
+			}
+			break;
+		case 0x01:
+			name = "ATI264VT3 (B1) (Mach64 VT)";
 			par->pll_limits.pll_max = 200;
 			par->pll_limits.mclk = 67;
 			par->pll_limits.xclk = 67;
  			par->pll_limits.ecp_max = 80;
-			par->features = ATI_CHIP_264VT | M64F_MAGIC_POSTDIV;
-		} else {
-			name = "ATI264VTB (Mach64 VT)";
+			par->features = ATI_CHIP_264VTB;
+			break;
+		case 0x02:
+			name = "ATI264VT3 (B2) (Mach64 VT)";
 			par->pll_limits.pll_max = 200;
 			par->pll_limits.mclk = 67;
 			par->pll_limits.xclk = 67;
  			par->pll_limits.ecp_max = 80;
-			par->features = ATI_CHIP_264VTB;
+			par->features = ATI_CHIP_264VT3;
+			break;
 		}
 		break;
 	case PCI_CHIP_MACH64GT:
-		rev &= 0x07;
-		if(rev == 0x01) {
+		switch (rev & 0x07) {
+		case  0x01:
+			name = "3D RAGE II (Mach64 GT)";
 			par->pll_limits.pll_max = 170;
 			par->pll_limits.mclk = 67;
 			par->pll_limits.xclk = 67;
  			par->pll_limits.ecp_max = 80;
 			par->features = ATI_CHIP_264GTB;
-		} else if(rev == 0x02) {
+			break;
+		case 0x02:
+			name = "3D RAGE II+ (Mach64 GT)";
 			par->pll_limits.pll_max = 200;
 			par->pll_limits.mclk = 67;
 			par->pll_limits.xclk = 67;
  			par->pll_limits.ecp_max = 100;
 			par->features = ATI_CHIP_264GTB;
+			break;
 		}
 		break;
 #endif



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
