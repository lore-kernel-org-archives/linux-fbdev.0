From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH 3/7]
Date: Sun, 21 Mar 2004 20:38:08 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403212038.08712.alex.kern@gmx.de>
References: <200403212033.39808.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_g8eXAl8D/a7gO+l"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B58m6-0001gw-Kt
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:38:22 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B58m4-0002NW-Ad
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:38:20 -0800
In-Reply-To: <200403212033.39808.alex.kern@gmx.de>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>


--Boundary-00=_g8eXAl8D/a7gO+l
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_g8eXAl8D/a7gO+l
Content-Type: text/x-diff;
  charset="utf-8";
  name="03_mach64-chipset2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="03_mach64-chipset2.diff"

diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/ati_ids.h linux-2.6.alex/drivers/video/aty/ati_ids.h
--- linux-2.6.4/drivers/video/aty/ati_ids.h	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/ati_ids.h	2004-03-18 18:34:33.000000000 +0100
@@ -64,6 +64,7 @@
 #define PCI_CHIP_MACH64LQ		0x4C51
 #define PCI_CHIP_MACH64LR		0x4C52
 #define PCI_CHIP_MACH64LS		0x4C53
+#define PCI_CHIP_MACH64LT		0x4C54
 #define PCI_CHIP_RADEON_LW		0x4C57
 #define PCI_CHIP_RADEON_LX		0x4C58
 #define PCI_CHIP_RADEON_LY		0x4C59
diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/atyfb.h linux-2.6.alex/drivers/video/aty/atyfb.h
--- linux-2.6.4/drivers/video/aty/atyfb.h	2004-03-13 23:29:07.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb.h	2004-03-18 19:52:51.000000000 +0100
@@ -122,6 +122,7 @@ struct atyfb_par {
 	unsigned long clk_wr_offset; /* meaning overloaded, clock id by CT */
 	struct crtc crtc;
 	union aty_pll pll;
+	struct pll_info pll_limits;
 	u32 features;
 	u32 ref_clk_per;
 	u32 pll_per;
@@ -130,6 +131,7 @@ struct atyfb_par {
 	u8 bus_type;
 	u8 ram_type;
 	u8 mem_refresh_rate;
+	u16 pci_id;
 	u32 accel_flags;
 	int blitter_may_be_busy;
 	int asleep;
diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/atyfb_base.c linux-2.6.alex/drivers/video/aty/atyfb_base.c
--- linux-2.6.4/drivers/video/aty/atyfb_base.c	2004-03-13 23:29:07.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb_base.c	2004-03-18 19:57:59.000000000 +0100
@@ -67,6 +67,7 @@
 
 #include <video/mach64.h>
 #include "atyfb.h"
+#include "ati_ids.h"
 
 #ifdef __powerpc__
 #include <asm/prom.h>
@@ -282,104 +283,154 @@ static unsigned long phys_size[FB_MAX] _
 static unsigned long phys_guiregbase[FB_MAX] __initdata = { 0, };
 #endif
 
-#ifdef CONFIG_FB_ATY_GX
-static char m64n_gx[] __initdata = "mach64GX (ATI888GX00)";
-static char m64n_cx[] __initdata = "mach64CX (ATI888CX00)";
-#endif /* CONFIG_FB_ATY_GX */
-#ifdef CONFIG_FB_ATY_CT
-static char m64n_ct[] __initdata = "mach64CT (ATI264CT)";
-static char m64n_et[] __initdata = "mach64ET (ATI264ET)";
-static char m64n_vta3[] __initdata = "mach64VTA3 (ATI264VT)";
-static char m64n_vta4[] __initdata = "mach64VTA4 (ATI264VT)";
-static char m64n_vtb[] __initdata = "mach64VTB (ATI264VTB)";
-static char m64n_vt4[] __initdata = "mach64VT4 (ATI264VT4)";
-static char m64n_gt[] __initdata = "3D RAGE (GT)";
-static char m64n_gtb[] __initdata = "3D RAGE II+ (GTB)";
-static char m64n_iic_p[] __initdata = "3D RAGE IIC (PCI)";
-static char m64n_iic_a[] __initdata = "3D RAGE IIC (AGP)";
-static char m64n_lt[] __initdata = "3D RAGE LT";
-static char m64n_ltg[] __initdata = "3D RAGE LT-G";
-static char m64n_gtc_ba[] __initdata = "3D RAGE PRO (BGA, AGP)";
-static char m64n_gtc_ba1[] __initdata = "3D RAGE PRO (BGA, AGP, 1x only)";
-static char m64n_gtc_bp[] __initdata = "3D RAGE PRO (BGA, PCI)";
-static char m64n_gtc_pp[] __initdata = "3D RAGE PRO (PQFP, PCI)";
-static char m64n_gtc_ppl[] __initdata = "3D RAGE PRO (PQFP, PCI, limited 3D)";
-static char m64n_xl_33[] __initdata = "3D RAGE (XL PCI-33MHz)";
-static char m64n_xl_66[] __initdata = "3D RAGE (XL PCI-66MHz)";
-static char m64n_ltp_a[] __initdata = "3D RAGE LT PRO (AGP)";
-static char m64n_ltp_p[] __initdata = "3D RAGE LT PRO (PCI)";
-static char m64n_mob_p[] __initdata = "3D RAGE Mobility P/M (AGP 2x)";
-static char m64n_mob_a[] __initdata = "3D RAGE Mobility L (AGP 2x)";
-#endif /* CONFIG_FB_ATY_CT */
+#define ATI_CHIP_88800GX (M64F_GX | M64F_NO_HW_TRIPLE)
+#define ATI_CHIP_88800CX ATI_CHIP_88800GX
+#define ATI_CHIP_264CT     (M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO | M64F_NO_HW_TRIPLE)
+#define ATI_CHIP_264ET      ATI_CHIP_264CT
+
+#define ATI_CHIP_264VT     (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_NO_HW_TRIPLE)
+#define ATI_CHIP_264VTA4   (ATI_CHIP_264VT | M64F_MAGIC_POSTDIV)
+#define ATI_CHIP_264GT     (M64F_GT | M64F_INTEGRATED               | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_NO_HW_TRIPLE | M64F_EXTRA_BRIGHT)
+#define ATI_CHIP_264VTB    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_NO_HW_TRIPLE)
+#define ATI_CHIP_264GTB    (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_NO_HW_TRIPLE | M64F_EXTRA_BRIGHT | M64F_SDRAM_MAGIC_PLL) 
+#define ATI_CHIP_264VT3    (ATI_CHIP_264VTB | M64F_SDRAM_MAGIC_PLL)
+/*#define ATI_CHIP_264GTDVD  ?*/
+#define ATI_CHIP_264LT     (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_NO_HW_TRIPLE)
+#define ATI_CHIP_264LTG    (ATI_CHIP_264LT                                                           | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT)
+#define ATI_CHIP_264VT4    (M64F_VT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_NO_HW_TRIPLE)
+#define ATI_CHIP_264GT2C   (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT)
+#define ATI_CHIP_264GTPRO  (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP                   | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_RESET_3D)
+#define ATI_CHIP_264LTPRO  (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP                                          | M64F_EXTRA_BRIGHT | M64F_RESET_3D)
+#define ATI_CHIP_264XL     (ATI_CHIP_264GTPRO | M64F_XL_DLL | M64F_MFB_FORCE_4)
+#define ATI_CHIP_MOBILITY  (ATI_CHIP_264LTPRO | M64F_XL_DLL | M64F_MFB_FORCE_4 | M64F_MOBIL_BUS )
 
 static struct {
-	u16 pci_id, chip_type;
-	u8 rev_mask, rev_val;
+	u16 pci_id;
 	const char *name;
 	int pll, mclk, xclk;
 	u32 features;
 } aty_chips[] __initdata = {
 #ifdef CONFIG_FB_ATY_GX
 	/* Mach64 GX */
-	{ 0x4758, 0x00d7, 0x00, 0x00, m64n_gx, 135, 50, 50, M64F_GX | M64F_NO_HW_TRIPLE },
-	{ 0x4358, 0x0057, 0x00, 0x00, m64n_cx, 135, 50, 50, M64F_GX | M64F_NO_HW_TRIPLE },
+	{ PCI_CHIP_MACH64GX, "ATI888GX00 (Mach64 GX)", 135, 50, 50, ATI_CHIP_88800GX },
+	{ PCI_CHIP_MACH64CX, "ATI888CX00 (Mach64 CX)", 135, 50, 50, ATI_CHIP_88800CX },
 #endif /* CONFIG_FB_ATY_GX */
 
 #ifdef CONFIG_FB_ATY_CT
-	/* Mach64 CT */
-	{ 0x4354, 0x4354, 0x00, 0x00, m64n_ct, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO | M64F_NO_HW_TRIPLE },
-	{ 0x4554, 0x4554, 0x00, 0x00, m64n_et, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO | M64F_NO_HW_TRIPLE },
-
-	/* Mach64 VT */
-	{ 0x5654, 0x5654, 0xc7, 0x00, m64n_vta3, 170, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
-	{ 0x5654, 0x5654, 0xc7, 0x40, m64n_vta4, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_NO_HW_TRIPLE | M64F_MAGIC_POSTDIV },
-	{ 0x5654, 0x5654, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
-	{ 0x5655, 0x5655, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_NO_HW_TRIPLE | M64F_SDRAM_MAGIC_PLL },
-	{ 0x5656, 0x5656, 0x00, 0x00, m64n_vt4, 230, 83, 83, M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
-
-	/* Mach64 LT */
-	{ 0x4c54, 0x4c54, 0x00, 0x00, m64n_lt, 135, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
-	{ 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg, 230, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 | M64F_NO_HW_TRIPLE },
-
-	/* Mach64 GT (3D RAGE) */
-	{ 0x4754, 0x4754, 0x07, 0x00, m64n_gt, 135, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
-	{ 0x4754, 0x4754, 0x07, 0x01, m64n_gt, 170, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
-	{ 0x4754, 0x4754, 0x07, 0x02, m64n_gt, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
-	{ 0x4755, 0x4755, 0x00, 0x00, m64n_gtb, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
+	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, ATI_CHIP_264CT },
+	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, ATI_CHIP_264ET },
+	{ PCI_CHIP_MACH64VT, "ATI264VT? (Mach64 VT)", 170, 67, 67, ATI_CHIP_264VT },
+	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, ATI_CHIP_264GT },
+	/* FIXME { ...ATI_264GU, maybe ATI_CHIP_264GTDVD }, */
+	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GTB)", 200, 67, 67, ATI_CHIP_264GTB  },
+	{ PCI_CHIP_MACH64VU, "ATI264VTB (Mach64 VU)", 200, 67, 67, ATI_CHIP_264VT3 },
 
-	/* Mach64 RAGE 3D IIc, first chip with hardware tripple */
-	{ 0x4756, 0x4756, 0x00, 0x00, m64n_iic_p, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4757, 0x4757, 0x00, 0x00, m64n_iic_a, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4759, 0x4759, 0x00, 0x00, m64n_iic_p, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x475a, 0x475a, 0x00, 0x00, m64n_iic_a, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, ATI_CHIP_264LT },
+	 /* FIXME chipset maybe ATI_CHIP_264LTPRO ? */
+	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, ATI_CHIP_264LTG | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },
 
-	/* Mach64 GTC (3D RAGE PRO) */
-	{ 0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4744, 0x4744, 0x00, 0x00, m64n_gtc_ba1, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4749, 0x4749, 0x00, 0x00, m64n_gtc_bp, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_MAGIC_VRAM_SIZE },
-	{ 0x4750, 0x4750, 0x00, 0x00, m64n_gtc_pp, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4751, 0x4751, 0x00, 0x00, m64n_gtc_ppl, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+	{ PCI_CHIP_MACH64VV, "ATI264VT4 (Mach64 VV)", 230, 83, 83, ATI_CHIP_264VT4 },
 
+	{ PCI_CHIP_MACH64GV, "3D RAGE IIC (Mach64 GV, PCI)", 230, 83, 83, ATI_CHIP_264GT2C },
+	{ PCI_CHIP_MACH64GW, "3D RAGE IIC (Mach64 GW, AGP)", 230, 83, 83, ATI_CHIP_264GT2C },
+	{ PCI_CHIP_MACH64GY, "3D RAGE IIC (Mach64 GY, PCI)", 230, 83, 83, ATI_CHIP_264GT2C },
+	{ PCI_CHIP_MACH64GZ, "3D RAGE IIC (Mach64 GZ, AGP)", 230, 83, 83, ATI_CHIP_264GT2C },
 
-	/* 3D RAGE XL Unknown model */
-	{ 0x474d, 0x474d, 0x00, 0x00, m64n_xl_66, 230, 83, 63, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL | M64F_MFB_FORCE_4 },
-	/* 3D RAGE XL PCI-66/BGA */
-	{ 0x474f, 0x474f, 0x00, 0x00, m64n_xl_66, 230, 83, 63, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL | M64F_MFB_FORCE_4 },
-	/* 3D RAGE XL PCI-33/BGA */
-	{ 0x4752, 0x4752, 0x00, 0x00, m64n_xl_33, 230, 83, 63, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL | M64F_MFB_FORCE_4 },
+	{ PCI_CHIP_MACH64GB, "3D RAGE PRO (Mach64 GB, BGA, AGP)", 230, 100, 100, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GD, "3D RAGE PRO (Mach64 GD, BGA, AGP 1x)", 230, 100, 100, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GI, "3D RAGE PRO (Mach64 GI, BGA, PCI)", 230, 100, 100, ATI_CHIP_264GTPRO | M64F_MAGIC_VRAM_SIZE },
+	{ PCI_CHIP_MACH64GP, "3D RAGE PRO (Mach64 GP, PQFP, PCI)", 230, 100, 100, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GQ, "3D RAGE PRO (Mach64 GQ, PQFP, PCI, limited 3D)", 230, 100, 100, ATI_CHIP_264GTPRO },
+	
+	{ PCI_CHIP_MACH64LB, "3D RAGE LT PRO (Mach64 LB, AGP)", 236, 75, 100, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LD, "3D RAGE LT PRO (Mach64 LD, AGP)", 230, 100, 100, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LI, "3D RAGE LT PRO (Mach64 LI, PCI)", 230, 100, 100, ATI_CHIP_264LTPRO | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
+	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, ATI_CHIP_264LTPRO },
 
-	/* Mach64 LT PRO */
-	{ 0x4c42, 0x4c42, 0x00, 0x00, m64n_ltp_a, 236, 75, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT },
-	{ 0x4c44, 0x4c44, 0x00, 0x00, m64n_ltp_p, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT },
-	{ 0x4c49, 0x4c49, 0x00, 0x00, m64n_ltp_p, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
-	{ 0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT },
+	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, ATI_CHIP_264XL },
 
-	/* 3D RAGE Mobility */
-	{ 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p, 230, 83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_XL_DLL | M64F_EXTRA_BRIGHT | M64F_MFB_FORCE_4 },
-	{ 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a, 230, 83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_MFB_FORCE_4 },
+	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83, 125, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility (Mach64 LN, AGP 2x)", 230, 83, 125, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility (Mach64 LR, PCI)", 230, 83, 125, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility (Mach64 LS, PCI)", 230, 83, 125, ATI_CHIP_MOBILITY },
 #endif /* CONFIG_FB_ATY_CT */
 };
 
+/* can not fail */
+static void __devinit correct_chipset(int i, struct atyfb_par *par)
+{
+	u8 rev;
+	u16 type;
+	u32 chip_id;
+	const char *name;
+
+	name = aty_chips[i].name;
+	par->pll_limits.pll_max = aty_chips[i].pll;
+	par->pll_limits.mclk = aty_chips[i].mclk;
+	par->pll_limits.xclk = aty_chips[i].xclk;
+	par->features = aty_chips[i].features;
+	par->pci_id = aty_chips[i].pci_id;
+	
+	chip_id = aty_ld_le32(CONFIG_CHIP_ID, par);
+	type = chip_id & CFG_CHIP_TYPE;
+	rev = (chip_id & CFG_CHIP_REV) >> 24;
+	switch(aty_chips[i].pci_id) {
+#ifdef CONFIG_FB_ATY_GX
+	case PCI_CHIP_MACH64GX:
+		assert(type == 0x00d7);
+		break;
+	case PCI_CHIP_MACH64CX:
+		assert(type == 0x0057);
+		break;
+#endif
+#ifdef CONFIG_FB_ATY_CT
+	case PCI_CHIP_MACH64VT:
+		rev &= 0xc7;
+		if(rev == 0x00) {
+			name = "ATI264VTA3 (Mach64 VT)";
+			par->pll_limits.pll_max = 170;
+			par->pll_limits.mclk = 67;
+			par->pll_limits.xclk = 67;
+			par->features = ATI_CHIP_264VT;
+		} else if(rev == 0x40) {
+			name = "ATI264VTA4 (Mach64 VT)";
+			par->pll_limits.pll_max = 200;
+			par->pll_limits.mclk = 67;
+			par->pll_limits.xclk = 67;
+			par->features = ATI_CHIP_264VTA4;
+		} else {
+			name = "ATI264VTB (Mach64 VT)";
+			par->pll_limits.pll_max = 200;
+			par->pll_limits.mclk = 67;
+			par->pll_limits.xclk = 67;
+			par->features = ATI_CHIP_264VTB;
+		} 
+		break;
+	case PCI_CHIP_MACH64GT:
+		rev &= 0x07;
+		if(rev == 0x01) {
+			par->pll_limits.pll_max = 170;
+			par->pll_limits.mclk = 67;
+			par->pll_limits.xclk = 67;
+			par->features = ATI_CHIP_264GTB;
+		} else if(rev == 0x02) {
+			par->pll_limits.pll_max = 200;
+			par->pll_limits.mclk = 67;
+			par->pll_limits.xclk = 67;
+			par->features = ATI_CHIP_264GTB;
+		}
+		break;
+#endif
+	}
+
+	printk("atyfb: %s [0x%04x rev 0x%02x] ", name, type, rev);
+}
 
 static char ram_dram[] __initdata = "DRAM";
 static char ram_resv[] __initdata = "RESV";
@@ -1912,7 +1963,7 @@ static struct backlight_controller aty_b
 };
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
-static void __init aty_calc_mem_refresh(struct atyfb_par *par, u16 id, int xclk)
+static void __init aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
 {
 	const int ragepro_tbl[] = {
 		44, 50, 55, 66, 75, 80, 100
@@ -1924,7 +1975,7 @@ static void __init aty_calc_mem_refresh(
 	const int *refresh_tbl;
 	int i, size;
 
-	if (IS_XL(id)) {
+	if (IS_XL(par->pci_id)) {
 		refresh_tbl = ragexl_tbl;
 		size = sizeof(ragexl_tbl)/sizeof(int);
 	} else {
@@ -1948,48 +1999,29 @@ static struct fb_info *fb_list = NULL;
 static int __init aty_init(struct fb_info *info, const char *name)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	const char *chipname = NULL, *ramname = NULL, *xtal;
-	int pll, mclk, xclk, gtb_memsize, j;
+	const char *ramname = NULL, *xtal;
+	int gtb_memsize;
 	struct fb_var_screeninfo var;
-	u8 pll_ref_div, rev;
-	u32 chip_id, i;
-	u16 type;
+	u8 pll_ref_div;
+	u32 i;
 #if defined(CONFIG_PPC)
 	int sense;
 #endif
 
 	par->aty_cmap_regs =
 	    (struct aty_cmap_regs *) (par->ati_regbase + 0xc0);
-	chip_id = aty_ld_le32(CONFIG_CHIP_ID, par);
-	type = chip_id & CFG_CHIP_TYPE;
-	rev = (chip_id & CFG_CHIP_REV) >> 24;
-	for (j = 0; j < (sizeof(aty_chips) / sizeof(*aty_chips)); j++)
-		if (type == aty_chips[j].chip_type &&
-		    (rev & aty_chips[j].rev_mask) == aty_chips[j].rev_val) {
-			chipname = aty_chips[j].name;
-			pll = aty_chips[j].pll;
-			mclk = aty_chips[j].mclk;
-			xclk = aty_chips[j].xclk;
-			par->features = aty_chips[j].features;
-			goto found;
-		}
-	printk("atyfb: Unknown mach64 0x%04x rev 0x%04x\n", type, rev);
-	return 0;
-
-      found:
-	printk("atyfb: %s [0x%04x rev 0x%02x] ", chipname, type, rev);
 
 	if (default_pll)
-		pll = default_pll;
+		par->pll_limits.pll_max = default_pll;
 	if (default_mclk)
-		mclk = default_mclk;
+		par->pll_limits.mclk = default_mclk;
 	if (default_xclk)
-		xclk = default_xclk;
+		par->pll_limits.xclk = default_xclk;
 
-	aty_calc_mem_refresh(par, type, xclk);
-	par->pll_per = 1000000/pll;
-	par->mclk_per = 1000000/mclk;
-	par->xclk_per = 1000000/xclk;
+	aty_calc_mem_refresh(par, par->pll_limits.xclk);
+	par->pll_per = 1000000/par->pll_limits.pll_max;
+	par->mclk_per = 1000000/par->pll_limits.mclk;
+	par->xclk_per = 1000000/par->pll_limits.xclk;
 
 	par->ref_clk_per = 1000000000000ULL / 14318180;
 	xtal = "14.31818";
@@ -2065,15 +2097,15 @@ static int __init aty_init(struct fb_inf
 		ramname = aty_ct_ram[par->ram_type];
 
 		/* for many chips, the mclk is 67 MHz for SDRAM, 63 MHz otherwise */
-		if (mclk == 67 && par->ram_type < SDRAM)
-			mclk = 63;
+		if (par->pll_limits.mclk == 67 && par->ram_type < SDRAM)
+			par->pll_limits.mclk = 63;
 	}
 
 	if (M64_HAS(GTB_DSP)
 	    && (pll_ref_div = aty_ld_pll_ct(PLL_REF_DIV, par))) {
 		int diff1, diff2;
-		diff1 = 510 * 14 / pll_ref_div - pll;
-		diff2 = 510 * 29 / pll_ref_div - pll;
+		diff1 = 510 * 14 / pll_ref_div - par->pll_limits.pll_max;
+		diff2 = 510 * 29 / pll_ref_div - par->pll_limits.pll_max;
 		if (diff1 < 0)
 			diff1 = -diff1;
 		if (diff2 < 0)
@@ -2182,8 +2214,8 @@ static int __init aty_init(struct fb_inf
 
 	printk("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK, %d MHz XCLK\n",
 	       info->fix.smem_len == 0x80000 ? 512 : (info->fix.smem_len >> 20),
-	       info->fix.smem_len == 0x80000 ? 'K' : 'M', ramname, xtal, pll,
-	       mclk, xclk);
+	       info->fix.smem_len == 0x80000 ? 'K' : 'M', ramname, xtal, par->pll_limits.pll_max,
+	       par->pll_limits.mclk, par->pll_limits.xclk);
 
 #if defined(DEBUG) && defined(CONFIG_ATY_CT)
 	if (M64_HAS(INTEGRATED)) {
@@ -3105,6 +3137,9 @@ static int __devinit atyfb_pci_probe(str
 		goto err_free;
 	}
 
+	/* set default Values aus pci_table */
+	correct_chipset(i, par);
+
 	/* Setup "info" structure */
 #ifdef __sparc__
 	rc = atyfb_setup_sparc(pdev, info, addr);


--Boundary-00=_g8eXAl8D/a7gO+l--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
