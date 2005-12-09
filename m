From: syrjala@sci.fi
Subject: [PATCH 06/10] atyfb: Set ECP divider
Date: Fri,  9 Dec 2005 02:44:28 +0200 (EET)
Message-ID: <20051209004428.15D4A20F@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkWNK-0004wQ-NY
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:38 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkWNJ-0004rm-Os
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:38 -0800
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
Content-Type: text; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: alex.kern@gmx.de
Cc: linux-fbdev-devel@lists.sourceforge.net

Set ECP (scaler/overlay clock) divider. The limits were taken from the=20
XFree86 ati driver.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 atyfb.h      |    1=20
 atyfb_base.c |   86 +++++++++++++++++++++++++++++++-----------------------=
-----
 mach64_ct.c  |   17 +++++++++--
 3 files changed, 61 insertions(+), 43 deletions(-)

diff -urpN linux-5/drivers/video/aty/atyfb_base.c linux-6/drivers/video/aty=
/atyfb_base.c
--- linux-5/drivers/video/aty/atyfb_base.c	2005-12-09 02:53:55.000000000 +0=
200
+++ linux-6/drivers/video/aty/atyfb_base.c	2005-12-09 02:54:45.000000000 +0=
200
@@ -368,58 +368,58 @@ static unsigned long phys_guiregbase[FB_
 static struct {
 	u16 pci_id;
 	const char *name;
-	int pll, mclk, xclk;
+	int pll, mclk, xclk, ecp_max;
 	u32 features;
 } aty_chips[] __devinitdata =3D {
 #ifdef CONFIG_FB_ATY_GX
 	/* Mach64 GX */
-	{ PCI_CHIP_MACH64GX, "ATI888GX00 (Mach64 GX)", 135, 50, 50, ATI_CHIP_8880=
0GX },
-	{ PCI_CHIP_MACH64CX, "ATI888CX00 (Mach64 CX)", 135, 50, 50, ATI_CHIP_8880=
0CX },
+	{ PCI_CHIP_MACH64GX, "ATI888GX00 (Mach64 GX)", 135, 50, 50, 0, ATI_CHIP_8=
8800GX },
+	{ PCI_CHIP_MACH64CX, "ATI888CX00 (Mach64 CX)", 135, 50, 50, 0, ATI_CHIP_8=
8800CX },
 #endif /* CONFIG_FB_ATY_GX */
=20
 #ifdef CONFIG_FB_ATY_CT
-	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, ATI_CHIP_264CT =
},
-	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, ATI_CHIP_264ET =
},
-	{ PCI_CHIP_MACH64VT, "ATI264VT? (Mach64 VT)", 170, 67, 67, ATI_CHIP_264VT=
 },
-	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, ATI_CHIP_264GT },
+	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, 0, ATI_CHIP_264=
CT },
+	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, 0, ATI_CHIP_264=
ET },
+	{ PCI_CHIP_MACH64VT, "ATI264VT? (Mach64 VT)", 170, 67, 67, 80, ATI_CHIP_2=
64VT },
+	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, 80, ATI_CHIP_264=
GT },
 	/* FIXME { ...ATI_264GU, maybe ATI_CHIP_264GTDVD }, */
-	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GTB)", 200, 67, 67, ATI_CHIP_26=
4GTB  },
-	{ PCI_CHIP_MACH64VU, "ATI264VTB (Mach64 VU)", 200, 67, 67, ATI_CHIP_264VT=
3 },
+	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GTB)", 200, 67, 67, 100, ATI_CH=
IP_264GTB  },
+	{ PCI_CHIP_MACH64VU, "ATI264VTB (Mach64 VU)", 200, 67, 67, 80, ATI_CHIP_2=
64VT3 },
=20
-	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, ATI_CHIP_264L=
T },
+	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, 0, ATI_CHIP_2=
64LT },
 	 /* FIXME chipset maybe ATI_CHIP_264LTPRO ? */
-	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, ATI_CHIP_26=
4LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
+	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, 100, ATI_CH=
IP_264LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
=20
-	{ PCI_CHIP_MACH64VV, "ATI264VT4 (Mach64 VV)", 230, 83, 83, ATI_CHIP_264VT=
4 },
+	{ PCI_CHIP_MACH64VV, "ATI264VT4 (Mach64 VV)", 230, 83, 83, 100, ATI_CHIP_=
264VT4 },
=20
-	{ PCI_CHIP_MACH64GV, "3D RAGE IIC (Mach64 GV, PCI)", 230, 83, 83, ATI_CHI=
P_264GT2C },
-	{ PCI_CHIP_MACH64GW, "3D RAGE IIC (Mach64 GW, AGP)", 230, 83, 83, ATI_CHI=
P_264GT2C },
-	{ PCI_CHIP_MACH64GY, "3D RAGE IIC (Mach64 GY, PCI)", 230, 83, 83, ATI_CHI=
P_264GT2C },
-	{ PCI_CHIP_MACH64GZ, "3D RAGE IIC (Mach64 GZ, AGP)", 230, 83, 83, ATI_CHI=
P_264GT2C },
-
-	{ PCI_CHIP_MACH64GB, "3D RAGE PRO (Mach64 GB, BGA, AGP)", 230, 100, 100, =
ATI_CHIP_264GTPRO },
-	{ PCI_CHIP_MACH64GD, "3D RAGE PRO (Mach64 GD, BGA, AGP 1x)", 230, 100, 10=
0, ATI_CHIP_264GTPRO },
-	{ PCI_CHIP_MACH64GI, "3D RAGE PRO (Mach64 GI, BGA, PCI)", 230, 100, 100, =
ATI_CHIP_264GTPRO | M64F_MAGIC_VRAM_SIZE },
-	{ PCI_CHIP_MACH64GP, "3D RAGE PRO (Mach64 GP, PQFP, PCI)", 230, 100, 100,=
 ATI_CHIP_264GTPRO },
-	{ PCI_CHIP_MACH64GQ, "3D RAGE PRO (Mach64 GQ, PQFP, PCI, limited 3D)", 23=
0, 100, 100, ATI_CHIP_264GTPRO },
-
-	{ PCI_CHIP_MACH64LB, "3D RAGE LT PRO (Mach64 LB, AGP)", 236, 75, 100, ATI=
_CHIP_264LTPRO },
-	{ PCI_CHIP_MACH64LD, "3D RAGE LT PRO (Mach64 LD, AGP)", 230, 100, 100, AT=
I_CHIP_264LTPRO },
-	{ PCI_CHIP_MACH64LI, "3D RAGE LT PRO (Mach64 LI, PCI)", 230, 100, 100, AT=
I_CHIP_264LTPRO | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
-	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, AT=
I_CHIP_264LTPRO },
-	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, AT=
I_CHIP_264LTPRO },
-
-	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, ATI_CHIP=
_264XL },
-	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, ATI_CHIP=
_264XL },
-	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, A=
TI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, AT=
I_CHIP_264XL },
-	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, ATI_CHIP=
_264XL },
-	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, ATI_CHIP=
_264XL },
-
-	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83,=
 125, ATI_CHIP_MOBILITY },
-	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83, 1=
25, ATI_CHIP_MOBILITY },
-	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility P/M (Mach64 LR, PCI)", 230, 83, 12=
5, ATI_CHIP_MOBILITY },
-	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility L (Mach64 LS, PCI)", 230, 83, 125,=
 ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64GV, "3D RAGE IIC (Mach64 GV, PCI)", 230, 83, 83, 100, AT=
I_CHIP_264GT2C },
+	{ PCI_CHIP_MACH64GW, "3D RAGE IIC (Mach64 GW, AGP)", 230, 83, 83, 100, AT=
I_CHIP_264GT2C },
+	{ PCI_CHIP_MACH64GY, "3D RAGE IIC (Mach64 GY, PCI)", 230, 83, 83, 100, AT=
I_CHIP_264GT2C },
+	{ PCI_CHIP_MACH64GZ, "3D RAGE IIC (Mach64 GZ, AGP)", 230, 83, 83, 100, AT=
I_CHIP_264GT2C },
+
+	{ PCI_CHIP_MACH64GB, "3D RAGE PRO (Mach64 GB, BGA, AGP)", 230, 100, 100, =
125, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GD, "3D RAGE PRO (Mach64 GD, BGA, AGP 1x)", 230, 100, 10=
0, 125, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GI, "3D RAGE PRO (Mach64 GI, BGA, PCI)", 230, 100, 100, =
125, ATI_CHIP_264GTPRO | M64F_MAGIC_VRAM_SIZE },
+	{ PCI_CHIP_MACH64GP, "3D RAGE PRO (Mach64 GP, PQFP, PCI)", 230, 100, 100,=
 125, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GQ, "3D RAGE PRO (Mach64 GQ, PQFP, PCI, limited 3D)", 23=
0, 100, 100, 125, ATI_CHIP_264GTPRO },
+
+	{ PCI_CHIP_MACH64LB, "3D RAGE LT PRO (Mach64 LB, AGP)", 236, 75, 100, 135=
, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LD, "3D RAGE LT PRO (Mach64 LD, AGP)", 230, 100, 100, 13=
5, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LI, "3D RAGE LT PRO (Mach64 LI, PCI)", 230, 100, 100, 13=
5, ATI_CHIP_264LTPRO | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
+	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, 13=
5, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, 13=
5, ATI_CHIP_264LTPRO },
+
+	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, 135, ATI=
_CHIP_264XL },
+	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, 135, ATI=
_CHIP_264XL },
+	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, 1=
35, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, 13=
5, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, 135, ATI=
_CHIP_264XL },
+	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, 135, ATI=
_CHIP_264XL },
+
+	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83,=
 125, 135, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83, 1=
25, 135, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility P/M (Mach64 LR, PCI)", 230, 83, 12=
5, 135, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility L (Mach64 LS, PCI)", 230, 83, 125,=
 135, ATI_CHIP_MOBILITY },
 #endif /* CONFIG_FB_ATY_CT */
 };
=20
@@ -440,6 +440,7 @@ static int __devinit correct_chipset(str
 	par->pll_limits.pll_max =3D aty_chips[i].pll;
 	par->pll_limits.mclk =3D aty_chips[i].mclk;
 	par->pll_limits.xclk =3D aty_chips[i].xclk;
+	par->pll_limits.ecp_max =3D aty_chips[i].ecp_max;
 	par->features =3D aty_chips[i].features;
=20
 	chip_id =3D aty_ld_le32(CONFIG_CHIP_ID, par);
@@ -465,18 +466,21 @@ static int __devinit correct_chipset(str
 			par->pll_limits.pll_max =3D 170;
 			par->pll_limits.mclk =3D 67;
 			par->pll_limits.xclk =3D 67;
+			par->pll_limits.ecp_max =3D 80;
 			par->features =3D ATI_CHIP_264VT;
 		} else if(rev =3D=3D 0x40) {
 			name =3D "ATI264VTA4 (Mach64 VT)";
 			par->pll_limits.pll_max =3D 200;
 			par->pll_limits.mclk =3D 67;
 			par->pll_limits.xclk =3D 67;
+			par->pll_limits.ecp_max =3D 80;
 			par->features =3D ATI_CHIP_264VT | M64F_MAGIC_POSTDIV;
 		} else {
 			name =3D "ATI264VTB (Mach64 VT)";
 			par->pll_limits.pll_max =3D 200;
 			par->pll_limits.mclk =3D 67;
 			par->pll_limits.xclk =3D 67;
+			par->pll_limits.ecp_max =3D 80;
 			par->features =3D ATI_CHIP_264VTB;
 		}
 		break;
@@ -486,11 +490,13 @@ static int __devinit correct_chipset(str
 			par->pll_limits.pll_max =3D 170;
 			par->pll_limits.mclk =3D 67;
 			par->pll_limits.xclk =3D 67;
+			par->pll_limits.ecp_max =3D 80;
 			par->features =3D ATI_CHIP_264GTB;
 		} else if(rev =3D=3D 0x02) {
 			par->pll_limits.pll_max =3D 200;
 			par->pll_limits.mclk =3D 67;
 			par->pll_limits.xclk =3D 67;
+			par->pll_limits.ecp_max =3D 100;
 			par->features =3D ATI_CHIP_264GTB;
 		}
 		break;
diff -urpN linux-5/drivers/video/aty/atyfb.h linux-6/drivers/video/aty/atyf=
b.h
--- linux-5/drivers/video/aty/atyfb.h	2005-12-09 00:46:22.000000000 +0200
+++ linux-6/drivers/video/aty/atyfb.h	2005-12-09 00:47:17.000000000 +0200
@@ -50,6 +50,7 @@ struct pll_info {
 	int sclk, mclk, mclk_pm, xclk;
 	int ref_div;
 	int ref_clk;
+	int ecp_max;
 };
=20
 typedef struct {
diff -urpN linux-5/drivers/video/aty/mach64_ct.c linux-6/drivers/video/aty/=
mach64_ct.c
--- linux-5/drivers/video/aty/mach64_ct.c	2005-12-09 00:46:22.000000000 +02=
00
+++ linux-6/drivers/video/aty/mach64_ct.c	2005-12-09 00:47:18.000000000 +02=
00
@@ -206,9 +206,7 @@ static int aty_valid_pll_ct(const struct
 {
 	u32 q;
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
-#ifdef DEBUG
 	int pllvclk;
-#endif
=20
 	/* FIXME: use the VTB/GTB /{3,6,12} post dividers if they're better suite=
d */
 	q =3D par->ref_clk_per * pll->pll_ref_div * 4 / vclk_per;
@@ -223,13 +221,26 @@ static int aty_valid_pll_ct(const struct
 	pll->vclk_post_div_real =3D postdividers[pll->vclk_post_div];
 	//    pll->vclk_post_div <<=3D 6;
 	pll->vclk_fb_div =3D q * pll->vclk_post_div_real / 8;
-#ifdef DEBUG
 	pllvclk =3D (1000000 * 2 * pll->vclk_fb_div) /
 		(par->ref_clk_per * pll->pll_ref_div);
+#ifdef DEBUG
 	printk("atyfb(%s): pllvclk=3D%d MHz, vclk=3D%d MHz\n",
 		__FUNCTION__, pllvclk, pllvclk / pll->vclk_post_div_real);
 #endif
 	pll->pll_vclk_cntl =3D 0x03; /* VCLK =3D PLL_VCLK/VCLKx_POST */
+
+	/* Set ECP (scaler/overlay clock) divider */
+	if (par->pll_limits.ecp_max) {
+		int ecp =3D pllvclk / pll->vclk_post_div_real;
+		int ecp_div =3D 0;
+
+		while (ecp > par->pll_limits.ecp_max && ecp_div < 2) {
+			ecp >>=3D 1;
+			ecp_div++;
+		}
+		pll->pll_vclk_cntl |=3D ecp_div << 4;
+	}
+
 	return 0;
 }
=20



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
