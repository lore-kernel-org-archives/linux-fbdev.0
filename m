From: syrjala@sci.fi
Subject: [PATCH 4/8] atyfb: Set ECP divider
Date: Thu, 17 Mar 2005 08:31:04 +0200 (EET)
Message-ID: <20050317063104.7C5F87A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBoXD-0006G2-Td
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:07 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBoXB-00049S-Ce
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:07 -0800
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

Set ECP (scaler/overlay clock) divider. The limits were taken from the 
XFree86 ati driver.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 atyfb.h      |    1 
 atyfb_base.c |   86 +++++++++++++++++++++++++++++++----------------------------
 mach64_ct.c  |   17 +++++++++--
 3 files changed, 61 insertions(+), 43 deletions(-)

diff -urN linux/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2005-03-16 19:02:03.000000000 +0200
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-16 19:09:32.000000000 +0200
@@ -368,58 +368,58 @@
 static struct {
 	u16 pci_id;
 	const char *name;
-	int pll, mclk, xclk;
+	int pll, mclk, xclk, ecp_max;
 	u32 features;
 } aty_chips[] __initdata = {
 #ifdef CONFIG_FB_ATY_GX
 	/* Mach64 GX */
-	{ PCI_CHIP_MACH64GX, "ATI888GX00 (Mach64 GX)", 135, 50, 50, ATI_CHIP_88800GX },
-	{ PCI_CHIP_MACH64CX, "ATI888CX00 (Mach64 CX)", 135, 50, 50, ATI_CHIP_88800CX },
+	{ PCI_CHIP_MACH64GX, "ATI888GX00 (Mach64 GX)", 135, 50, 50, 0, ATI_CHIP_88800GX },
+	{ PCI_CHIP_MACH64CX, "ATI888CX00 (Mach64 CX)", 135, 50, 50, 0, ATI_CHIP_88800CX },
 #endif /* CONFIG_FB_ATY_GX */
 
 #ifdef CONFIG_FB_ATY_CT
-	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, ATI_CHIP_264CT },
-	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, ATI_CHIP_264ET },
-	{ PCI_CHIP_MACH64VT, "ATI264VT? (Mach64 VT)", 170, 67, 67, ATI_CHIP_264VT },
-	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, ATI_CHIP_264GT },
+	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, 0, ATI_CHIP_264CT },
+	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, 0, ATI_CHIP_264ET },
+	{ PCI_CHIP_MACH64VT, "ATI264VT? (Mach64 VT)", 170, 67, 67, 80, ATI_CHIP_264VT },
+	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, 80, ATI_CHIP_264GT },
 	/* FIXME { ...ATI_264GU, maybe ATI_CHIP_264GTDVD }, */
-	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GTB)", 200, 67, 67, ATI_CHIP_264GTB  },
-	{ PCI_CHIP_MACH64VU, "ATI264VTB (Mach64 VU)", 200, 67, 67, ATI_CHIP_264VT3 },
+	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GTB)", 200, 67, 67, 100, ATI_CHIP_264GTB  },
+	{ PCI_CHIP_MACH64VU, "ATI264VTB (Mach64 VU)", 200, 67, 67, 80, ATI_CHIP_264VT3 },
 
-	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, ATI_CHIP_264LT },
+	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, 0, ATI_CHIP_264LT },
 	 /* FIXME chipset maybe ATI_CHIP_264LTPRO ? */
-	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, ATI_CHIP_264LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
+	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, 100, ATI_CHIP_264LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
 
-	{ PCI_CHIP_MACH64VV, "ATI264VT4 (Mach64 VV)", 230, 83, 83, ATI_CHIP_264VT4 },
+	{ PCI_CHIP_MACH64VV, "ATI264VT4 (Mach64 VV)", 230, 83, 83, 100, ATI_CHIP_264VT4 },
 
-	{ PCI_CHIP_MACH64GV, "3D RAGE IIC (Mach64 GV, PCI)", 230, 83, 83, ATI_CHIP_264GT2C },
-	{ PCI_CHIP_MACH64GW, "3D RAGE IIC (Mach64 GW, AGP)", 230, 83, 83, ATI_CHIP_264GT2C },
-	{ PCI_CHIP_MACH64GY, "3D RAGE IIC (Mach64 GY, PCI)", 230, 83, 83, ATI_CHIP_264GT2C },
-	{ PCI_CHIP_MACH64GZ, "3D RAGE IIC (Mach64 GZ, AGP)", 230, 83, 83, ATI_CHIP_264GT2C },
-
-	{ PCI_CHIP_MACH64GB, "3D RAGE PRO (Mach64 GB, BGA, AGP)", 230, 100, 100, ATI_CHIP_264GTPRO },
-	{ PCI_CHIP_MACH64GD, "3D RAGE PRO (Mach64 GD, BGA, AGP 1x)", 230, 100, 100, ATI_CHIP_264GTPRO },
-	{ PCI_CHIP_MACH64GI, "3D RAGE PRO (Mach64 GI, BGA, PCI)", 230, 100, 100, ATI_CHIP_264GTPRO | M64F_MAGIC_VRAM_SIZE },
-	{ PCI_CHIP_MACH64GP, "3D RAGE PRO (Mach64 GP, PQFP, PCI)", 230, 100, 100, ATI_CHIP_264GTPRO },
-	{ PCI_CHIP_MACH64GQ, "3D RAGE PRO (Mach64 GQ, PQFP, PCI, limited 3D)", 230, 100, 100, ATI_CHIP_264GTPRO },
-
-	{ PCI_CHIP_MACH64LB, "3D RAGE LT PRO (Mach64 LB, AGP)", 236, 75, 100, ATI_CHIP_264LTPRO },
-	{ PCI_CHIP_MACH64LD, "3D RAGE LT PRO (Mach64 LD, AGP)", 230, 100, 100, ATI_CHIP_264LTPRO },
-	{ PCI_CHIP_MACH64LI, "3D RAGE LT PRO (Mach64 LI, PCI)", 230, 100, 100, ATI_CHIP_264LTPRO | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
-	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, ATI_CHIP_264LTPRO },
-	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, ATI_CHIP_264LTPRO },
-
-	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, ATI_CHIP_264XL },
-
-	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83, 125, ATI_CHIP_MOBILITY },
-	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83, 125, ATI_CHIP_MOBILITY },
-	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility P/M (Mach64 LR, PCI)", 230, 83, 125, ATI_CHIP_MOBILITY },
-	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility L (Mach64 LS, PCI)", 230, 83, 125, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64GV, "3D RAGE IIC (Mach64 GV, PCI)", 230, 83, 83, 100, ATI_CHIP_264GT2C },
+	{ PCI_CHIP_MACH64GW, "3D RAGE IIC (Mach64 GW, AGP)", 230, 83, 83, 100, ATI_CHIP_264GT2C },
+	{ PCI_CHIP_MACH64GY, "3D RAGE IIC (Mach64 GY, PCI)", 230, 83, 83, 100, ATI_CHIP_264GT2C },
+	{ PCI_CHIP_MACH64GZ, "3D RAGE IIC (Mach64 GZ, AGP)", 230, 83, 83, 100, ATI_CHIP_264GT2C },
+
+	{ PCI_CHIP_MACH64GB, "3D RAGE PRO (Mach64 GB, BGA, AGP)", 230, 100, 100, 125, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GD, "3D RAGE PRO (Mach64 GD, BGA, AGP 1x)", 230, 100, 100, 125, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GI, "3D RAGE PRO (Mach64 GI, BGA, PCI)", 230, 100, 100, 125, ATI_CHIP_264GTPRO | M64F_MAGIC_VRAM_SIZE },
+	{ PCI_CHIP_MACH64GP, "3D RAGE PRO (Mach64 GP, PQFP, PCI)", 230, 100, 100, 125, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GQ, "3D RAGE PRO (Mach64 GQ, PQFP, PCI, limited 3D)", 230, 100, 100, 125, ATI_CHIP_264GTPRO },
+
+	{ PCI_CHIP_MACH64LB, "3D RAGE LT PRO (Mach64 LB, AGP)", 236, 75, 100, 135, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LD, "3D RAGE LT PRO (Mach64 LD, AGP)", 230, 100, 100, 135, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LI, "3D RAGE LT PRO (Mach64 LI, PCI)", 230, 100, 100, 135, ATI_CHIP_264LTPRO | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
+	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, 135, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, 135, ATI_CHIP_264LTPRO },
+
+	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, 135, ATI_CHIP_264XL },
+
+	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83, 125, 135, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83, 125, 135, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility P/M (Mach64 LR, PCI)", 230, 83, 125, 135, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility L (Mach64 LS, PCI)", 230, 83, 125, 135, ATI_CHIP_MOBILITY },
 #endif /* CONFIG_FB_ATY_CT */
 };
 
@@ -440,6 +440,7 @@
 	par->pll_limits.pll_max = aty_chips[i].pll;
 	par->pll_limits.mclk = aty_chips[i].mclk;
 	par->pll_limits.xclk = aty_chips[i].xclk;
+	par->pll_limits.ecp_max = aty_chips[i].ecp_max;
 	par->features = aty_chips[i].features;
 
 	chip_id = aty_ld_le32(CONFIG_CHIP_ID, par);
@@ -465,18 +466,21 @@
 			par->pll_limits.pll_max = 170;
 			par->pll_limits.mclk = 67;
 			par->pll_limits.xclk = 67;
+			par->pll_limits.ecp_max = 80;
 			par->features = ATI_CHIP_264VT;
 		} else if(rev == 0x40) {
 			name = "ATI264VTA4 (Mach64 VT)";
 			par->pll_limits.pll_max = 200;
 			par->pll_limits.mclk = 67;
 			par->pll_limits.xclk = 67;
+ 			par->pll_limits.ecp_max = 80;
 			par->features = ATI_CHIP_264VT | M64F_MAGIC_POSTDIV;
 		} else {
 			name = "ATI264VTB (Mach64 VT)";
 			par->pll_limits.pll_max = 200;
 			par->pll_limits.mclk = 67;
 			par->pll_limits.xclk = 67;
+ 			par->pll_limits.ecp_max = 80;
 			par->features = ATI_CHIP_264VTB;
 		}
 		break;
@@ -486,11 +490,13 @@
 			par->pll_limits.pll_max = 170;
 			par->pll_limits.mclk = 67;
 			par->pll_limits.xclk = 67;
+ 			par->pll_limits.ecp_max = 80;
 			par->features = ATI_CHIP_264GTB;
 		} else if(rev == 0x02) {
 			par->pll_limits.pll_max = 200;
 			par->pll_limits.mclk = 67;
 			par->pll_limits.xclk = 67;
+ 			par->pll_limits.ecp_max = 100;
 			par->features = ATI_CHIP_264GTB;
 		}
 		break;
diff -urN linux/drivers/video/aty/atyfb.h linux/drivers/video/aty/atyfb.h
--- linux/drivers/video/aty/atyfb.h	2005-03-16 19:00:00.000000000 +0200
+++ linux/drivers/video/aty/atyfb.h	2005-03-16 19:03:02.000000000 +0200
@@ -50,6 +50,7 @@
 	int sclk, mclk, mclk_pm, xclk;
 	int ref_div;
 	int ref_clk;
+	int ecp_max;
 };
 
 typedef struct {
diff -urN linux/drivers/video/aty/mach64_ct.c linux/drivers/video/aty/mach64_ct.c
--- linux/drivers/video/aty/mach64_ct.c	2005-03-16 19:00:00.000000000 +0200
+++ linux/drivers/video/aty/mach64_ct.c	2005-03-16 19:40:50.000000000 +0200
@@ -206,9 +206,7 @@
 {
 	u32 q;
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-#ifdef DEBUG
 	int pllvclk;
-#endif
 
 	/* FIXME: use the VTB/GTB /{3,6,12} post dividers if they're better suited */
 	q = par->ref_clk_per * pll->pll_ref_div * 4 / vclk_per;
@@ -223,13 +221,26 @@
 	pll->vclk_post_div_real = postdividers[pll->vclk_post_div];
 	//    pll->vclk_post_div <<= 6;
 	pll->vclk_fb_div = q * pll->vclk_post_div_real / 8;
-#ifdef DEBUG
 	pllvclk = (1000000 * 2 * pll->vclk_fb_div) /
 		(par->ref_clk_per * pll->pll_ref_div);
+#ifdef DEBUG
 	printk("atyfb(%s): pllvclk=%d MHz, vclk=%d MHz\n",
 		__FUNCTION__, pllvclk, pllvclk / pll->vclk_post_div_real);
 #endif
 	pll->pll_vclk_cntl = 0x03; /* VCLK = PLL_VCLK/VCLKx_POST */
+
+	/* Set ECP (scaler/overlay clock) divider */
+	if (par->pll_limits.ecp_max) {
+		int ecp = pllvclk / pll->vclk_post_div_real;
+		int ecp_div = 0;
+
+		while (ecp > par->pll_limits.ecp_max && ecp_div < 2) {
+			ecp >>= 1;
+			ecp_div++;
+		}
+		pll->pll_vclk_cntl |= ecp_div << 4;
+	}
+
 	return 0;
 }
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
