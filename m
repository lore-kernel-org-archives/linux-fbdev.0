From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH] 2.5.59 for ATI Mach64(port from Daniel code for 2.5.59)
Date: Fri, 17 Jan 2003 22:27:29 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200301172227.30029.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TLNVGRMVAHFCCZTS6RBS"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Ze2B-0008BV-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Jan 2003 13:28:15 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Linux-fbdev-devel@lists.sourceforge.net


--------------Boundary-00=_TLNVGRMVAHFCCZTS6RBS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, tested with ATI RAGE 3D MOBILITY M1 (P/M). 1400x1050 works, i assume =
all=20
others must work too.=20


--------------Boundary-00=_TLNVGRMVAHFCCZTS6RBS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="aty_rage_mobility.2.5.59-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="aty_rage_mobility.2.5.59-2.patch"

diff -u -r /usr/src/linux-2.5.orig/include/video/mach64.h /usr/src/linux-2.5.XX/include/video/mach64.h
--- /usr/src/linux-2.5.orig/include/video/mach64.h	2003-01-02 04:22:23.000000000 +0100
+++ /usr/src/linux-2.5.XX/include/video/mach64.h	2003-01-11 00:40:00.000000000 +0100
@@ -558,7 +558,7 @@
 #define CRTC_CSYNC_EN		0x00000010
 #define CRTC_PIX_BY_2_EN	0x00000020	/* unused on RAGE */
 #define CRTC_DISPLAY_DIS	0x00000040
-#define CRTC_VGA_XOVERSCAN	0x00000040
+#define CRTC_VGA_XOVERSCAN	0x00000080
 
 #define CRTC_PIX_WIDTH_MASK	0x00000700
 #define CRTC_PIX_WIDTH_4BPP	0x00000100
@@ -1148,6 +1148,65 @@
 #define APC_LUT_MN		0x39
 #define APC_LUT_OP		0x3A
 
+/* Values in LCD_GEN_CTRL */
+#define CRT_ON                          0x00000001ul
+#define LCD_ON                          0x00000002ul
+#define HORZ_DIVBY2_EN                  0x00000004ul
+#define DONT_DS_ICON                    0x00000008ul
+#define LOCK_8DOT                       0x00000010ul
+#define ICON_ENABLE                     0x00000020ul
+#define DONT_SHADOW_VPAR                0x00000040ul
+#define V2CLK_PM_EN                     0x00000080ul
+#define RST_FM                          0x00000100ul
+#define DISABLE_PCLK_RESET              0x00000200ul    /* XC/XL */
+#define DIS_HOR_CRT_DIVBY2              0x00000400ul
+#define SCLK_SEL                        0x00000800ul
+#define SCLK_DELAY                      0x0000f000ul
+#define TVCLK_PM_EN                     0x00010000ul
+#define VCLK_DAC_PM_EN                  0x00020000ul
+#define VCLK_LCD_OFF                    0x00040000ul
+#define SELECT_WAIT_4MS                 0x00080000ul
+#define XTALIN_PM_EN                    0x00080000ul    /* XC/XL */
+#define V2CLK_DAC_PM_EN                 0x00100000ul
+#define LVDS_EN                         0x00200000ul
+#define LVDS_PLL_EN                     0x00400000ul
+#define LVDS_PLL_RESET                  0x00800000ul
+#define LVDS_RESERVED_BITS              0x07000000ul
+#define CRTC_RW_SELECT                  0x08000000ul    /* LTPro */
+#define USE_SHADOWED_VEND               0x10000000ul
+#define USE_SHADOWED_ROWCUR             0x20000000ul
+#define SHADOW_EN                       0x40000000ul
+#define SHADOW_RW_EN                    0x80000000ul
+
+/* Values in HORZ_STRETCHING */
+#define HORZ_STRETCH_BLEND              0x00000ffful
+#define HORZ_STRETCH_RATIO              0x0000fffful
+#define HORZ_STRETCH_LOOP               0x00070000ul
+#define HORZ_STRETCH_LOOP09                     0x00000000ul
+#define HORZ_STRETCH_LOOP11                     0x00010000ul
+#define HORZ_STRETCH_LOOP12                     0x00020000ul
+#define HORZ_STRETCH_LOOP14                     0x00030000ul
+#define HORZ_STRETCH_LOOP15                     0x00040000ul
+/*      ?                                       0x00050000ul */
+/*      ?                                       0x00060000ul */
+/*      ?                                       0x00070000ul */
+/*      ?                               0x00080000ul */
+#define HORZ_PANEL_SIZE                 0x0ff00000ul    /* XC/XL */
+/*      ?                               0x10000000ul */
+#define AUTO_HORZ_RATIO                 0x20000000ul    /* XC/XL */
+#define HORZ_STRETCH_MODE               0x40000000ul
+#define HORZ_STRETCH_EN                 0x80000000ul
+
+/* Values in VERT_STRETCHING */
+#define VERT_STRETCH_RATIO0             0x000003fful
+#define VERT_STRETCH_RATIO1             0x000ffc00ul
+#define VERT_STRETCH_RATIO2             0x3ff00000ul
+#define VERT_STRETCH_USE0               0x40000000ul
+#define VERT_STRETCH_EN                 0x80000000ul
+
+/* Values in EXT_VERT_STRETCH */
+#define AUTO_VERT_RATIO                 0x00400000ul
+#define VERT_STRETCH_MODE		0x00000400ul
 
 /* Values in LCD_MISC_CNTL */
 #define BIAS_MOD_LEVEL_MASK	0x0000ff00

--------------Boundary-00=_TLNVGRMVAHFCCZTS6RBS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="aty_rage_mobility.2.5.59-1b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="aty_rage_mobility.2.5.59-1b.patch"

diff -u -r /usr/src/linux-2.5.orig/drivers/video/Kconfig /usr/src/linux-2.5.XX/drivers/video/Kconfig
--- /usr/src/linux-2.5.orig/drivers/video/Kconfig	2003-01-17 16:13:53.000000000 +0100
+++ /usr/src/linux-2.5.XX/drivers/video/Kconfig	2003-01-17 16:15:59.000000000 +0100
@@ -704,6 +704,13 @@
 	  framebuffer device.  The ATI product support page for these boards
 	  is at <http://support.ati.com/products/pc/mach64/>.
 
+config FB_ATY_GENERIC_LCD
+	bool "generic LCD support (EXPERIMENTAL)"
+	depends on FB_ATY_CT
+	help
+	  say Y here to support ATI Rage 3D MOBILITY M1 or others flawours
+	  of Mach64 on Notebooks
+
 config FB_ATY_GX
 	bool "Mach64 GX support" if PCI
 	depends on FB_ATY
diff -u -r /usr/src/linux-2.5.orig/drivers/video/Makefile /usr/src/linux-2.5.XX/drivers/video/Makefile
--- /usr/src/linux-2.5.orig/drivers/video/Makefile	2003-01-17 16:13:53.000000000 +0100
+++ /usr/src/linux-2.5.XX/drivers/video/Makefile	2003-01-17 16:19:00.000000000 +0100
@@ -71,7 +71,7 @@
 obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/ cfbimgblt.o vgastate.o 
 obj-$(CONFIG_FB_SIS)		  += sis/
-obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbimgblt.o
+obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbcopyarea.o
 obj-$(CONFIG_FB_I810)             += i810/ cfbfillrect.o cfbcopyarea.o \
 	                             cfbimgblt.o vgastate.o
 
diff -u -r /usr/src/linux-2.5.orig/drivers/video/aty/atyfb.h /usr/src/linux-2.5.XX/drivers/video/aty/atyfb.h
--- /usr/src/linux-2.5.orig/drivers/video/aty/atyfb.h	2003-01-17 16:13:53.000000000 +0100
+++ /usr/src/linux-2.5.XX/drivers/video/aty/atyfb.h	2003-01-17 17:54:54.000000000 +0100
@@ -10,6 +10,9 @@
 struct crtc {
 	u32 vxres;
 	u32 vyres;
+	u32 xoffset;
+	u32 yoffset;
+	u32 bpp;
 	u32 h_tot_disp;
 	u32 h_sync_strt_wid;
 	u32 v_tot_disp;
@@ -18,6 +21,11 @@
 	u32 gen_cntl;
 	u32 dp_pix_width;	/* acceleration */
 	u32 dp_chain_mask;	/* acceleration */
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	u32 monitors_enabled; /* LCD monitor support */
+	u16 h_stretching;     /* LCD monitor support */
+	u16 v_stretching;     /* LCD monitor support */
+#endif
 };
 
 struct pll_514 {
@@ -33,16 +41,16 @@
 };
 
 struct pll_ct {
-	u8 pll_ref_div;
+/*	u8 pll_ref_div;
 	u8 pll_gen_cntl;
-	u8 mclk_fb_div;
+	u8 mclk_fb_div; */
 	u8 pll_vclk_cntl;
 	u8 vclk_post_div;
 	u8 vclk_fb_div;
-	u8 pll_ext_cntl;
+/*	u8 pll_ext_cntl; */
 	u32 dsp_config;		/* Mach64 GTB DSP */
 	u32 dsp_on_off;		/* Mach64 GTB DSP */
-	u8 mclk_post_div_real;
+/*	u8 mclk_post_div_real; */
 	u8 vclk_post_div_real;
 };
 
@@ -75,23 +83,54 @@
 	u32 ref_clk_per;
 	u32 pll_per;
 	u32 mclk_per;
+	u32 xclk_per;
 	u8 bus_type;
 	u8 ram_type;
 	u8 mem_refresh_rate;
 	u8 blitter_may_be_busy;
+	unsigned char clock;
 	u32 accel_flags;
 #ifdef __sparc__
 	struct pci_mmap_map *mmap_map;
 	u8 mmaped;
 	int open;
 #endif
+#ifdef CONFIG_FB_ATY_CT
+	u8 pll_ref_div;
+	u8 xclk_post_div_real;
+	u16 mclk_fb_div;
+	u8 fifo_size;
+	u8 dsp_loop_latency;
+	u8 page_size;
+#endif
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	unsigned long bios_base_phys;
+	unsigned long bios_base;
+	unsigned long lcd_table;
+	u16 lcd_width;
+	u16 lcd_height;
+	u32 lcd_pixclock;
+	u16 lcd_htotal;
+	u16 lcd_hdisp;
+	u16 lcd_hsync_start;
+	u16 lcd_hsync_delay;
+	u16 lcd_hsync_width;
+	u16 lcd_vtotal;
+	u16 lcd_vdisp;
+	u16 lcd_vsync_start;
+	u16 lcd_vsync_width;
+	u16 lcd_right;
+	u16 lcd_lower;
+	u16 lcd_hblank_width;
+	u16 lcd_vblank_width;
+#endif
 #ifdef CONFIG_PMAC_PBOOK
 	struct fb_info *next;
 	unsigned char *save_framebuffer;
 	unsigned long save_pll[64];
 #endif
 };
-    
+
     /*
      *  ATI Mach64 features
      */
@@ -211,11 +250,12 @@
 
 struct aty_pll_ops {
 	int (*var_to_pll) (const struct fb_info * info, u32 vclk_per,
-			   u8 bpp, union aty_pll * pll);
+			   u32 bpp, u32 width, union aty_pll * pll);
 	 u32(*pll_to_var) (const struct fb_info * info,
 			   const union aty_pll * pll);
 	void (*set_pll) (const struct fb_info * info,
 			 const union aty_pll * pll);
+	void (*init_pll)(struct fb_info * info);
 };
 
 extern const struct aty_pll_ops aty_pll_ati18818_1;	/* ATI 18818 */
@@ -229,8 +269,8 @@
 
 extern void aty_set_pll_ct(const struct fb_info *info,
 			   const union aty_pll *pll);
-extern void aty_calc_pll_ct(const struct fb_info *info,
-			    struct pll_ct *pll);
+/* extern void aty_calc_pll_ct(const struct fb_info *info,
+			    struct pll_ct *pll); */
 
 
     /*
diff -u -r /usr/src/linux-2.5.orig/drivers/video/aty/atyfb_base.c /usr/src/linux-2.5.XX/drivers/video/aty/atyfb_base.c
--- /usr/src/linux-2.5.orig/drivers/video/aty/atyfb_base.c	2003-01-17 16:13:53.000000000 +0100
+++ /usr/src/linux-2.5.XX/drivers/video/aty/atyfb_base.c	2003-01-17 18:04:46.000000000 +0100
@@ -24,6 +24,8 @@
  *			   Harry AC Eaton
  *			   Anthony Tong <atong@uiuc.edu>
  *
+ *  Generic LCD support written by Daniel Mantione, ported from 2.4.20 by Alex Kern
+ *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
  *  more details.
@@ -93,7 +95,7 @@
  * Debug flags.
  */
 #undef DEBUG
-
+#define DEBUG
 /* Make sure n * PAGE_SIZE is protected at end of Aperture for GUI-regs */
 /*  - must be large enough to catch all GUI-Regs   */
 /*  - must be aligned to a PAGE boundary           */
@@ -103,7 +105,6 @@
 /* FIXME: remove the FAIL definition */
 #define FAIL(x) do { printk(x "\n"); return -EINVAL; } while (0)
 
-
     /*
      *  The Hardware parameters for each card
      */
@@ -140,7 +141,7 @@
 static int atyfb_release(struct fb_info *info, int user);
 static int atyfb_check_var(struct fb_var_screeninfo *var,
 			   struct fb_info *info);
-static int atyfb_set_par(struct fb_info *info); 
+static int atyfb_set_par(struct fb_info *info);
 static int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			   u_int transp, struct fb_info *info);
 static int atyfb_pan_display(struct fb_var_screeninfo *var,
@@ -214,6 +215,7 @@
 static u32 default_vram __initdata = 0;
 static int default_pll __initdata = 0;
 static int default_mclk __initdata = 0;
+static int default_xclk __initdata = 0;
 
 #ifndef MODULE
 static char *mode_option __initdata = NULL;
@@ -257,134 +259,135 @@
 static char m64n_xl[] __initdata = "3D RAGE (XL)";
 static char m64n_ltp_a[] __initdata = "3D RAGE LT PRO (AGP)";
 static char m64n_ltp_p[] __initdata = "3D RAGE LT PRO (PCI)";
-static char m64n_mob_p[] __initdata = "3D RAGE Mobility (PCI)";
-static char m64n_mob_a[] __initdata = "3D RAGE Mobility (AGP)";
+static char m64n_mob_p[] __initdata = "3D RAGE Mobility P/M (AGP 2x)";
+static char m64n_mob_a[] __initdata = "3D RAGE Mobility L (AGP 2x)";
 #endif /* CONFIG_FB_ATY_CT */
 
 static struct {
 	u16 pci_id, chip_type;
 	u8 rev_mask, rev_val;
 	const char *name;
-	int pll, mclk;
+	int pll, mclk, xclk;
 	u32 features;
 } aty_chips[] __initdata = {
 #ifdef CONFIG_FB_ATY_GX
 	/* Mach64 GX */
 	{
-	0x4758, 0x00d7, 0x00, 0x00, m64n_gx, 135, 50, M64F_GX}, {
-	0x4358, 0x0057, 0x00, 0x00, m64n_cx, 135, 50, M64F_GX},
+	0x4758, 0x00d7, 0x00, 0x00, m64n_gx, 135, 50, 50, M64F_GX}, {
+	0x4358, 0x0057, 0x00, 0x00, m64n_cx, 135, 50, 50, M64F_GX},
 #endif				/* CONFIG_FB_ATY_GX */
 #ifdef CONFIG_FB_ATY_CT
 	    /* Mach64 CT */
 	{
-	0x4354, 0x4354, 0x00, 0x00, m64n_ct, 135, 60,
+	0x4354, 0x4354, 0x00, 0x00, m64n_ct, 135, 60, 60,
 		    M64F_CT | M64F_INTEGRATED | M64F_CT_BUS |
 		    M64F_MAGIC_FIFO}, {
-	0x4554, 0x4554, 0x00, 0x00, m64n_et, 135, 60,
+	0x4554, 0x4554, 0x00, 0x00, m64n_et, 135, 60, 60,
 		    M64F_CT | M64F_INTEGRATED | M64F_CT_BUS |
 		    M64F_MAGIC_FIFO},
 	    /* Mach64 VT */
 	{
-	0x5654, 0x5654, 0xc7, 0x00, m64n_vta3, 170, 67,
+	0x5654, 0x5654, 0xc7, 0x00, m64n_vta3, 170, 67, 67,
 		    M64F_VT | M64F_INTEGRATED | M64F_VT_BUS |
 		    M64F_MAGIC_FIFO | M64F_FIFO_24}, {
-	0x5654, 0x5654, 0xc7, 0x40, m64n_vta4, 200, 67,
+	0x5654, 0x5654, 0xc7, 0x40, m64n_vta4, 200, 67, 67,
 		    M64F_VT | M64F_INTEGRATED | M64F_VT_BUS |
 		    M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_MAGIC_POSTDIV}, {
-	0x5654, 0x5654, 0x00, 0x00, m64n_vtb, 200, 67,
+	0x5654, 0x5654, 0x00, 0x00, m64n_vtb, 200, 67, 67,
 		    M64F_VT | M64F_INTEGRATED | M64F_VT_BUS |
 		    M64F_GTB_DSP | M64F_FIFO_24}, {
-	0x5655, 0x5655, 0x00, 0x00, m64n_vtb, 200, 67,
+	0x5655, 0x5655, 0x00, 0x00, m64n_vtb, 200, 67, 67,
 		    M64F_VT | M64F_INTEGRATED | M64F_VT_BUS |
 		    M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL}, {
-	0x5656, 0x5656, 0x00, 0x00, m64n_vt4, 230, 83,
+	0x5656, 0x5656, 0x00, 0x00, m64n_vt4, 230, 83, 83,
 		    M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP},
 	    /* Mach64 GT (3D RAGE) */
 	{
-	0x4754, 0x4754, 0x07, 0x00, m64n_gt, 135, 63,
+	0x4754, 0x4754, 0x07, 0x00, m64n_gt, 135, 63, 63,
 		    M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO |
 		    M64F_FIFO_24 | M64F_EXTRA_BRIGHT}, {
-	0x4754, 0x4754, 0x07, 0x01, m64n_gt, 170, 67,
+	0x4754, 0x4754, 0x07, 0x01, m64n_gt, 170, 67, 67,
 		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
 		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT}, {
-	0x4754, 0x4754, 0x07, 0x02, m64n_gt, 200, 67,
+	0x4754, 0x4754, 0x07, 0x02, m64n_gt, 200, 67, 67,
 		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
 		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT}, {
-	0x4755, 0x4755, 0x00, 0x00, m64n_gtb, 200, 67,
+	0x4755, 0x4755, 0x00, 0x00, m64n_gtb, 200, 67, 67,
 		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
 		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT}, {
-	0x4756, 0x4756, 0x00, 0x00, m64n_iic_p, 230, 83,
+	0x4756, 0x4756, 0x00, 0x00, m64n_iic_p, 230, 83, 83,
 		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
 		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT}, {
-	0x4757, 0x4757, 0x00, 0x00, m64n_iic_a, 230, 83,
+	0x4757, 0x4757, 0x00, 0x00, m64n_iic_a, 230, 83, 83,
 		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
 		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT}, {
-	0x475a, 0x475a, 0x00, 0x00, m64n_iic_a, 230, 83,
+	0x475a, 0x475a, 0x00, 0x00, m64n_iic_a, 230, 83, 83,
 		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
 		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT},
 	    /* Mach64 LT */
 	{
-	0x4c54, 0x4c54, 0x00, 0x00, m64n_lt, 135, 63,
+	0x4c54, 0x4c54, 0x00, 0x00, m64n_lt, 135, 63, 63,
 		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP}, {
-	0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg, 230, 63,
+	0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg, 230, 63, 63,
 		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
 		    M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT |
 		    M64F_LT_SLEEP | M64F_G3_PB_1024x768},
 	    /* Mach64 GTC (3D RAGE PRO) */
 	{
-	0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba, 230, 100,
+	0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba, 230, 100, 100,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
 		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT}, {
-	0x4744, 0x4744, 0x00, 0x00, m64n_gtc_ba1, 230, 100,
+	0x4744, 0x4744, 0x00, 0x00, m64n_gtc_ba1, 230, 100, 100,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
 		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT}, {
-	0x4749, 0x4749, 0x00, 0x00, m64n_gtc_bp, 230, 100,
+	0x4749, 0x4749, 0x00, 0x00, m64n_gtc_bp, 230, 100, 100,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
 		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT | M64F_MAGIC_VRAM_SIZE}, {
-	0x4750, 0x4750, 0x00, 0x00, m64n_gtc_pp, 230, 100,
+	0x4750, 0x4750, 0x00, 0x00, m64n_gtc_pp, 230, 100, 100,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
 		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT}, {
-	0x4751, 0x4751, 0x00, 0x00, m64n_gtc_ppl, 230, 100,
+	0x4751, 0x4751, 0x00, 0x00, m64n_gtc_ppl, 230, 100, 100,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
 		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT},
 	    /* 3D RAGE XL */
 	{
-	0x4752, 0x4752, 0x00, 0x00, m64n_xl, 230, 100,
+	0x4752, 0x4752, 0x00, 0x00, m64n_xl, 235, 83, 63,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
 		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
 		    M64F_EXTRA_BRIGHT | M64F_XL_DLL},
 	    /* Mach64 LT PRO */
 	{
-	0x4c42, 0x4c42, 0x00, 0x00, m64n_ltp_a, 230, 100,
+	0x4c42, 0x4c42, 0x00, 0x00, m64n_ltp_a, 236, 75, 100,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
-		    M64F_GTB_DSP}, {
-	0x4c44, 0x4c44, 0x00, 0x00, m64n_ltp_p, 230, 100,
+		    M64F_GTB_DSP | M64F_EXTRA_BRIGHT}, {
+	0x4c44, 0x4c44, 0x00, 0x00, m64n_ltp_p, 230, 100, 100,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
-		    M64F_GTB_DSP}, {
-	0x4c49, 0x4c49, 0x00, 0x00, m64n_ltp_p, 230, 100,
+		    M64F_GTB_DSP | M64F_EXTRA_BRIGHT}, {
+	0x4c49, 0x4c49, 0x00, 0x00, m64n_ltp_p, 230, 100, 100,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
 		    M64F_GTB_DSP | M64F_EXTRA_BRIGHT |
 		    M64F_G3_PB_1_1 | M64F_G3_PB_1024x768}, {
-	0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p, 230, 100,
+	0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p, 230, 100, 100,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
-		    M64F_GTB_DSP},
+		    M64F_GTB_DSP | M64F_EXTRA_BRIGHT},
 	    /* 3D RAGE Mobility */
 	{
-	0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p, 230, 50,
+	0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p, 230, 83, 125,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
-		    M64F_GTB_DSP | M64F_MOBIL_BUS}, {
-	0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a, 230, 50,
+		    M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_XL_DLL |
+		    M64F_EXTRA_BRIGHT}, {
+	0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a, 230, 83, 125,
 		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
 		    M64F_GTB_DSP | M64F_MOBIL_BUS},
 #endif				/* CONFIG_FB_ATY_CT */
@@ -461,7 +464,7 @@
 
 #endif				/* defined(CONFIG_PPC) */
 
-#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_PMAC_BACKLIGHT)
+#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
 static void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
 {
 	unsigned long temp;
@@ -483,7 +486,15 @@
 	/* read the register value */
 	return aty_ld_le32(LCD_DATA, par);
 }
-#endif				/* CONFIG_PMAC_PBOOK || CONFIG_PMAC_BACKLIGHT */
+#endif				/* CONFIG_PMAC_PBOOK || CONFIG_PMAC_BACKLIGHT || CONFIG_FB_ATY_GENERIC_LCD */
+
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+static void atyfb_monitors_enabled(struct atyfb_par *par, struct crtc *crtc) {
+	if (par->lcd_table != 0) {
+		crtc->monitors_enabled = aty_ld_lcd(LCD_GEN_CTRL, par) & 3;
+	}
+}
+#endif
 
 /* ------------------------------------------------------------------------- */
 
@@ -494,6 +505,8 @@
 static void aty_set_crtc(const struct atyfb_par *par,
 			 const struct crtc *crtc)
 {
+	u32 v;
+
 	aty_st_le32(CRTC_H_TOTAL_DISP, crtc->h_tot_disp, par);
 	aty_st_le32(CRTC_H_SYNC_STRT_WID, crtc->h_sync_strt_wid, par);
 	aty_st_le32(CRTC_V_TOTAL_DISP, crtc->v_tot_disp, par);
@@ -501,6 +514,63 @@
 	aty_st_le32(CRTC_VLINE_CRNT_VLINE, 0, par);
 	aty_st_le32(CRTC_OFF_PITCH, crtc->off_pitch, par);
 	aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl, par);
+#ifdef DEBUG
+	printk(KERN_INFO "Setting up CRTC\n");
+	printk(KERN_INFO "CRTC_GEN_CNTL: %x\n",crtc->gen_cntl);
+	printk(KERN_INFO "CRTC_H_TOTAL_DISP: %x\n",crtc->h_tot_disp);
+	printk(KERN_INFO "CRTC_H_SYNC_STRT_WID: %x\n",crtc->h_sync_strt_wid);
+	printk(KERN_INFO "CRTC_V_TOTAL_DISP: %x\n",crtc->v_tot_disp);
+	printk(KERN_INFO "CRTC_V_SYNC_STRT_WID: %x\n",crtc->v_sync_strt_wid);
+#endif
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	/* After setting the CRTC registers we should set the LCD
+	 * registers.
+	 */
+	if (par->lcd_table != 0) {
+		/* Enable/disable horizontal stretching */
+		v = aty_ld_lcd(HORZ_STRETCHING, par);
+		v = v & ~(HORZ_STRETCH_RATIO | HORZ_STRETCH_EN | AUTO_HORZ_RATIO);
+		v = v | HORZ_STRETCH_MODE; /* Use interpolation instead of duplication. */
+		if (crtc->h_stretching != 0)
+			v = v | HORZ_STRETCH_EN | crtc->h_stretching;
+		aty_st_lcd(HORZ_STRETCHING, v, par);
+#ifdef DEBUG
+	printk(KERN_INFO "HORZ_STRETCHING: %x\n", v);
+#endif
+
+		/* Enable/disable vertital stretching */
+		v = aty_ld_lcd(VERT_STRETCHING, par);
+		v = v & ~(VERT_STRETCH_RATIO0 | VERT_STRETCH_EN);
+		v = v | VERT_STRETCH_USE0; /* Use VERT_STRETCH_RATIO0. */
+		if (crtc->v_stretching != 0)
+			v = v | VERT_STRETCH_EN | crtc->v_stretching;
+		aty_st_lcd(VERT_STRETCHING, v, par);
+#ifdef DEBUG
+		printk(KERN_INFO "VERT_STRETCHING: %x\n", v);
+#endif
+		v = aty_ld_lcd(EXT_VERT_STRETCH, par);
+		v = v & ~AUTO_VERT_RATIO;  /* Forbit the chip to guess the vertical
+	                                      expansion (used for vga compatibility) */
+		v = v | VERT_STRETCH_MODE; /* Use interpolation instead of duplication. */
+		aty_st_lcd(EXT_VERT_STRETCH, v, par);
+#ifdef DEBUG
+		printk(KERN_INFO "EXT_VERT_STRETCH: %x\n", v);
+#endif
+
+		/* Don't use shadowing. Don't divide the horizontal paramters.
+		   (VGA compatibility junk that might be enabled.)
+		   Enable only the monitors that were enabled before we switched the
+		   video mode.
+		 */
+		v = aty_ld_lcd(LCD_GEN_CTRL, par);
+		v = v & ~(HORZ_DIVBY2_EN | SCLK_SEL | USE_SHADOWED_VEND | SHADOW_EN | LCD_ON | CRT_ON);
+		v = v | DONT_SHADOW_VPAR | crtc->monitors_enabled;
+		aty_st_lcd(LCD_GEN_CTRL, v, par);
+#ifdef DEBUG
+		printk(KERN_INFO "LCD_GEN_CTRL: %x\n", v);
+#endif
+	}
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
 }
 
 static int aty_var_to_crtc(const struct fb_info *info,
@@ -508,16 +578,18 @@
 			   struct crtc *crtc)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	u32 xres, yres, vxres, vyres, xoffset, yoffset, bpp;
+	u32 xres, yres, ryres, vxres, vyres, xoffset, yoffset, bpp;
 	u32 left, right, upper, lower, hslen, vslen, sync, vmode;
-	u32 h_total, h_disp, h_sync_strt, h_sync_dly, h_sync_wid,
-	    h_sync_pol;
+	u32 h_total, h_disp, h_sync_strt, h_sync_dly, h_sync_wid, h_sync_pol;
 	u32 v_total, v_disp, v_sync_strt, v_sync_wid, v_sync_pol, c_sync;
 	u32 pix_width, dp_pix_width, dp_chain_mask;
-
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	u32 lcd_hsync_start, lcd_htotal, lcd_vsync_start, lcd_vtotal;
+#endif
 	/* input */
 	xres = var->xres;
 	yres = var->yres;
+	ryres = yres;
 	vxres = var->xres_virtual;
 	vyres = var->yres_virtual;
 	xoffset = var->xoffset;
@@ -568,6 +640,18 @@
 	if (v_total > 0x7ff)
 		FAIL("v_total too large");
 	v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
+	/* In double scan mode, the vertical parameters need to be doubled.
+	   But in interlaced mode, there is no need to half the vertical parameters.
+	   Code has been tested in 1024x768, 43 Hz interlaced and 640x480, 60 Hz
+	   double scan.
+	 */
+	if ((vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
+		ryres <<= 1;
+		v_total <<= 1;
+		v_disp <<= 1;
+		v_sync_strt <<= 1;
+		v_sync_wid <<= 1;
+	}
 
 	c_sync = sync & FB_SYNC_COMP_HIGH_ACT ? CRTC_CSYNC_EN : 0;
 
@@ -603,28 +687,106 @@
 	if (vxres * vyres * bpp / 8 > info->fix.smem_len)
 		FAIL("not enough video RAM");
 
-	if ((vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
-		FAIL("invalid vmode");
+/*	if ((vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
+		FAIL("invalid vmode"); */
 
 	/* output */
 	crtc->vxres = vxres;
 	crtc->vyres = vyres;
-	crtc->h_tot_disp = h_total | (h_disp << 16);
-	crtc->h_sync_strt_wid = (h_sync_strt & 0xff) | (h_sync_dly << 8) |
-	    ((h_sync_strt & 0x100) << 4) | (h_sync_wid << 16) |
-	    (h_sync_pol << 21);
-	crtc->v_tot_disp = v_total | (v_disp << 16);
-	crtc->v_sync_strt_wid =
-	    v_sync_strt | (v_sync_wid << 16) | (v_sync_pol << 21);
-	crtc->off_pitch =
-	    ((yoffset * vxres + xoffset) * bpp / 64) | (vxres << 19);
-	crtc->gen_cntl =
-	    pix_width | c_sync | CRTC_EXT_DISP_EN | CRTC_ENABLE;
+	crtc->xoffset = xoffset;
+	crtc->yoffset = yoffset;
+	crtc->bpp = bpp;
+	crtc->off_pitch = ((yoffset*vxres+xoffset)*bpp/64) | (vxres<<19);
+	crtc->gen_cntl = pix_width | c_sync | CRTC_EXT_DISP_EN | CRTC_ENABLE;
+	/* Enable doublescan mode if requested */
+	if ((vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE)
+		crtc->gen_cntl|=CRTC_DBL_SCAN_EN;
+	/* Enable interlaced mode if requested */
+	if ((vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED)
+		crtc->gen_cntl|=CRTC_INTERLACE_EN;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	/* We can only program the real mode parameters to the CRTC
+	   if the LCD monitor is switched off. Otherwise we will have to
+	   use the parameters the LCD monitor prefers, effectively setting
+	   a completely different mode which simulates the requested
+	   video mode.
+	 */
+	atyfb_monitors_enabled(par, crtc);
+	if ((par->lcd_table != 0) && ((crtc->monitors_enabled & LCD_ON) != 0) &&
+	   ((xres > par->lcd_width) || (ryres > par->lcd_height))) {
+		/* We cannot display the mode on the LCD. If the CRT is enabled
+		   we can turn off the LCD.
+		   If the CRT is off, it isn't a good idea to switch it on; we don't
+		   know if one is connected. So it's better to fail then.
+		 */
+		if (crtc->monitors_enabled & CRT_ON) {
+			printk(KERN_INFO "Disabling lcd monitor because video mode does not fit.\n");
+			crtc->monitors_enabled &= (~LCD_ON);
+		} else {
+			FAIL("Video mode exceeds size of lcd monitor.\nConnect this computer to a conventional monitor if you really need this mode.");
+		}
+	}
+
+	if ((par->lcd_table == 0) || ((crtc->monitors_enabled & LCD_ON) == 0)) {
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
+		crtc->h_tot_disp = h_total | (h_disp<<16);
+		crtc->h_sync_strt_wid = (h_sync_strt & 0xff) | (h_sync_dly<<8) |
+			((h_sync_strt & 0x100)<<4) | (h_sync_wid<<16) | (h_sync_pol<<21);
+		crtc->v_tot_disp = v_total | (v_disp<<16);
+		crtc->v_sync_strt_wid = v_sync_strt | (v_sync_wid<<16) | (v_sync_pol<<21);
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+		/* No hardware stretching please! */
+		crtc->h_stretching = 0;
+		crtc->v_stretching = 0;
+	} else {
+		/* This is horror! When we simulate, say 640x480 on an 800x600
+		   lcd monitor, the CRTC should be programmed 800x600 values for
+		   the non visible part, but 640x480 for the visible part.
+		   This code has been tested on a laptop with it's 800x600 lcd
+		   monitor and a conventional monitor both switched on.
+		   Tested modes: 640x400, 720x400, 800x600, 320x200-doublescan,
+		      800x600-interlaced
+		 */
+		lcd_htotal = h_disp + par->lcd_hblank_width;
+		lcd_hsync_start = h_disp + par->lcd_right;
+		lcd_vtotal = v_disp + par->lcd_vblank_width;
+		lcd_vsync_start = v_disp + par->lcd_lower;
+
+		crtc->h_tot_disp = (lcd_htotal) | (h_disp<<16);
+		crtc->h_sync_strt_wid = (lcd_hsync_start & 0xff) |
+			(par->lcd_hsync_delay<<8) | ((lcd_hsync_start & 0x100)<<4) |
+			(par->lcd_hsync_width<<16);
+		crtc->v_tot_disp = lcd_vtotal | (v_disp<<16);
+		crtc->v_sync_strt_wid = lcd_vsync_start | (par->lcd_vsync_width<<16);
+		/* To simulate the requested video mode, we use the hardware stretcher,
+		   which zooms the image to the dimensions of the LCD screen. It has
+		   two modes; replication and blending. Replication duplicates some
+		   pixels, blending interpolates between pixels. We use blending.
+		   The formula for blending is:
+		      h_stretching=(source_with/dest_width)*4096
+		      v_stretching=(source_lines/dest_lines)*1024
+		 */
+		if (xres != par->lcd_width)
+			crtc->h_stretching = (xres*4096)/par->lcd_width;
+		else
+			crtc->h_stretching = 0;
+
+		if (ryres != par->lcd_height)
+			crtc->v_stretching = (ryres*1024)/par->lcd_height;
+		else
+			crtc->v_stretching = 0;
+		/* The prefered mode for the lcd is not interlaced, so disable it if
+		   it was enabled. For doublescan there is no problem, because we can
+		   compensate for it in the hardware stretching (we stretch half as much)
+		 */
+		crtc->gen_cntl&=~CRTC_INTERLACE_EN;
+	}
+
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
 	if (M64_HAS(MAGIC_FIFO)) {
 		/* Not VTB/GTB */
 		/* FIXME: magic FIFO values */
-		crtc->gen_cntl |=
-		    aty_ld_le32(CRTC_GEN_CNTL, par) & 0x000e0000;
+		crtc->gen_cntl |= aty_ld_le32(CRTC_GEN_CNTL, par) & 0x000e0000;
 	}
 	crtc->dp_pix_width = dp_pix_width;
 	crtc->dp_chain_mask = dp_chain_mask;
@@ -641,12 +803,12 @@
 	    h_sync_pol;
 	u32 v_total, v_disp, v_sync_strt, v_sync_wid, v_sync_pol, c_sync;
 	u32 pix_width;
+	u32 double_scan, interlace;
 
 	/* input */
 	h_total = crtc->h_tot_disp & 0x1ff;
 	h_disp = (crtc->h_tot_disp >> 16) & 0xff;
-	h_sync_strt = (crtc->h_sync_strt_wid & 0xff) |
-	    ((crtc->h_sync_strt_wid >> 4) & 0x100);
+	h_sync_strt = (crtc->h_sync_strt_wid & 0xff) | ((crtc->h_sync_strt_wid >> 4) & 0x100);
 	h_sync_dly = (crtc->h_sync_strt_wid >> 8) & 0x7;
 	h_sync_wid = (crtc->h_sync_strt_wid >> 16) & 0x1f;
 	h_sync_pol = (crtc->h_sync_strt_wid >> 21) & 0x1;
@@ -657,6 +819,8 @@
 	v_sync_pol = (crtc->v_sync_strt_wid >> 21) & 0x1;
 	c_sync = crtc->gen_cntl & CRTC_CSYNC_EN ? 1 : 0;
 	pix_width = crtc->gen_cntl & CRTC_PIX_WIDTH_MASK;
+	double_scan = crtc->gen_cntl & CRTC_DBL_SCAN_EN;
+	interlace = crtc->gen_cntl & CRTC_INTERLACE_EN;
 
 	/* convert */
 	xres = (h_disp + 1) * 8;
@@ -760,6 +924,23 @@
 	var->vsync_len = vslen;
 	var->sync = sync;
 	var->vmode = FB_VMODE_NONINTERLACED;
+	/* In double scan mode, the vertical parameters are doubled, so we need to
+	   half them to get the right values.
+	   In interlaced mode the values are already correct, so no correction is
+	   necessary.
+	   Code has been tested in 1024x768, 43 Hz interlaced and 640x480, 60 Hz
+	   doublesscan.
+	 */
+	if (interlace)
+		var->vmode = FB_VMODE_INTERLACED;
+
+	if (double_scan) {
+		var->vmode = FB_VMODE_DOUBLE;
+		var->yres>>=1;
+		var->upper_margin>>=1;
+		var->lower_margin>>=1;
+		var->vsync_len>>=1;
+	}
 
 	return 0;
 }
@@ -771,12 +952,21 @@
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	struct fb_var_screeninfo *var = &info->var;
 	u8 tmp;
-	u32 i;
+	u32 i, xres, pixclock;
 	int err;
 
-	if ((err = aty_var_to_crtc(info, var, &par->crtc)) ||
-	    (err = par->pll_ops->var_to_pll(info, var->pixclock,
-					var->bits_per_pixel, &par->pll)))
+	if ((err = aty_var_to_crtc(info, var, &par->crtc)))
+		return err;
+
+	pixclock = var->pixclock;
+	xres = 0;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if ((par->lcd_table != 0) && ((par->crtc.monitors_enabled & LCD_ON) != 0)) {
+		pixclock = par->lcd_pixclock;
+		xres = var->xres;
+	}
+#endif
+	if((err = par->pll_ops->var_to_pll(info, pixclock, var->bits_per_pixel, xres, &par->pll)))
 		return err;
 
 	par->accel_flags = var->accel_flags;	/* hack */
@@ -785,9 +975,16 @@
 		wait_for_idle(par);
 	tmp = aty_ld_8(CRTC_GEN_CNTL + 3, par);
 	aty_set_crtc(par, &par->crtc);
-	aty_st_8(CLOCK_CNTL + par->clk_wr_offset, 0, par);
-	/* better call aty_StrobeClock ?? */
-	aty_st_8(CLOCK_CNTL + par->clk_wr_offset, CLOCK_STROBE, par);
+
+	aty_st_8(CLOCK_CNTL, 0, par);
+#if 1
+	aty_st_8(CLOCK_CNTL, CLOCK_STROBE | CLOCK_DIV, par);
+#else
+	if (M64_HAS(MOBIL_BUS)&&M64_HAS(XL_DLL))
+		aty_st_8(CLOCK_CNTL + par->clk_wr_offset, CLOCK_STROBE | CLOCK_DIV | (par->clock & CLOCK_SEL), par);
+	else
+		aty_st_8(CLOCK_CNTL + par->clk_wr_offset, CLOCK_STROBE, par);
+#endif
 
 	par->dac_ops->set_dac(info, &par->pll, var->bits_per_pixel,
 			      par->accel_flags);
@@ -867,17 +1064,40 @@
 			   struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
+	int err;
 	struct crtc crtc;
 	union aty_pll pll;
-	int err;
+	u32 pixclock, xres;
 
-	if ((err = aty_var_to_crtc(info, var, &crtc)) ||
-	    (err = par->pll_ops->var_to_pll(info, var->pixclock,
-					var->bits_per_pixel, &pll)))
+	err = aty_var_to_crtc(info, var, &crtc);
+	if (err == 0) {
+		/* Alert! aty_var_to_crtc can modify monitors_enabled which is
+		   important for the pixclock decision */
+		pixclock = var->pixclock;
+		xres = 0; /* non LCD */
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+		if ((par->lcd_table != 0) && ((crtc.monitors_enabled & LCD_ON) != 0)) {
+			pixclock = par->lcd_pixclock;
+			xres = var->xres;
+		}
+#endif
+		if (pixclock == 0) {
+			FAIL("Invalid pixclock");
+		} else {
+			err = par->pll_ops->var_to_pll(info, pixclock, var->bits_per_pixel, xres, &pll);
+		}
+	}
+
+	if (err != 0)
 		return err;
 
-#if 0	/* fbmon is not done. uncomment for 2.5.x -brad */
-	if (!fbmon_valid_timings(var->pixclock, htotal, vtotal, info))
+	if (var->accel_flags & FB_ACCELF_TEXT)
+		info->var.accel_flags = FB_ACCELF_TEXT;
+	else
+		info->var.accel_flags = 0;
+
+#if 0 /* fbmon is not done. uncomment for 2.5.x -brad */
+	if (!fbmon_valid_timings(pixclock, htotal, vtotal, info))
 		return -EINVAL;
 #endif
 	aty_crtc_to_var(&crtc, var);
@@ -885,20 +1105,37 @@
 	return 0;
 }
 
-static void set_off_pitch(struct atyfb_par *par,
-			  const struct fb_info *info)
+	/* In the display mode set code we need to make desisions depending on
+	 * wether the LCD or CRT monitor is enabled.
+	 * This is going to give problems in the unlikely case that someone
+	 * for example turns on the LCD monitor just after we tested what
+	 * monitors are enabled. Since the consequences are very serious
+	 * (the graphic card crashes and sends the wrong signals to the lcd
+	 *  monitor which gets brighter and brighter; to prevent it from
+	 * damage the computer must be switched off as soon as possible)
+	 * we need to prevent this.
+	 *
+	 * As far as I know there is no way to prevent people switching on the
+	 * LCD monitor while we are programming the video card. So the best way
+	 * to do it, is detect what monitors are enabled before programming the
+	 * video chip. After programming the video chip, we write this information
+	 * back to the video chip, switching the LCD off again if someone enabled
+	 * it. But isn't the card already crashed before we have the chance to
+	 * turn the display back off? I don't think so because the CRTC is disabled
+	 * while we program it.
+	 */
+
+static void set_off_pitch(struct atyfb_par *par, const struct fb_info *info)
 {
 	u32 xoffset = info->var.xoffset;
 	u32 yoffset = info->var.yoffset;
 	u32 vxres = par->crtc.vxres;
 	u32 bpp = info->var.bits_per_pixel;
 
-	par->crtc.off_pitch =
-	    ((yoffset * vxres + xoffset) * bpp / 64) | (vxres << 19);
+	par->crtc.off_pitch = ((yoffset * vxres + xoffset) * bpp / 64) | (vxres << 19);
 	aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
 }
 
-
     /*
      *  Open/Release the frame buffer device
      */
@@ -965,7 +1202,7 @@
 				}
 			}
 		}
-	} 
+	}
 #endif
 	return (0);
 }
@@ -1045,13 +1282,13 @@
 	case ATYIO_CLKR:
 		if (M64_HAS(INTEGRATED)) {
 			struct atyclk clk;
-			union aty_pll *pll = par->pll;
+			union aty_pll *pll = &(par->pll);
 			u32 dsp_config = pll->ct.dsp_config;
 			u32 dsp_on_off = pll->ct.dsp_on_off;
 			clk.ref_clk_per = par->ref_clk_per;
-			clk.pll_ref_div = pll->ct.pll_ref_div;
-			clk.mclk_fb_div = pll->ct.mclk_fb_div;
-			clk.mclk_post_div = pll->ct.mclk_post_div_real;
+			clk.pll_ref_div = par->pll_ref_div;
+			clk.mclk_fb_div = par->mclk_fb_div;
+			/* clk.mclk_post_div = pll->ct.mclk_post_div_real; */
 			clk.vclk_fb_div = pll->ct.vclk_fb_div;
 			clk.vclk_post_div = pll->ct.vclk_post_div_real;
 			clk.dsp_xclks_per_row = dsp_config & 0x3fff;
@@ -1068,14 +1305,14 @@
 	case ATYIO_CLKW:
 		if (M64_HAS(INTEGRATED)) {
 			struct atyclk clk;
-			union aty_pll *pll = par->pll;
+			union aty_pll *pll = &(par->pll);
 			if (copy_from_user
 			    (&clk, (struct atyclk *) arg, sizeof(clk)))
 				return -EFAULT;
 			par->ref_clk_per = clk.ref_clk_per;
-			pll->ct.pll_ref_div = clk.pll_ref_div;
-			pll->ct.mclk_fb_div = clk.mclk_fb_div;
-			pll->ct.mclk_post_div_real = clk.mclk_post_div;
+			par->pll_ref_div = clk.pll_ref_div;
+			par->mclk_fb_div = clk.mclk_fb_div;
+			/* pll->ct.mclk_post_div_real = clk.mclk_post_div; */
 			pll->ct.vclk_fb_div = clk.vclk_fb_div;
 			pll->ct.vclk_post_div_real = clk.vclk_post_div;
 			pll->ct.dsp_config =
@@ -1088,7 +1325,7 @@
 			    (clk.
 			     dsp_on & 0x7ff) | ((clk.
 						 dsp_off & 0x7ff) << 16);
-			aty_calc_pll_ct(info, &pll->ct);
+			/* aty_calc_pll_ct(info, &pll->ct); */
 			aty_set_pll_ct(info, pll);
 		} else
 			return -EINVAL;
@@ -1506,7 +1743,7 @@
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	const char *chipname = NULL, *ramname = NULL, *xtal;
-	int j, pll, mclk, gtb_memsize;
+	int j, pll, mclk, xclk, gtb_memsize;
 	struct fb_var_screeninfo var;
 	u32 chip_id, i;
 	u16 type;
@@ -1528,6 +1765,7 @@
 			chipname = aty_chips[j].name;
 			pll = aty_chips[j].pll;
 			mclk = aty_chips[j].mclk;
+			xclk = aty_chips[j].xclk;
 			par->features = aty_chips[j].features;
 			goto found;
 		}
@@ -1573,8 +1811,7 @@
 			par->dac_ops = &aty_dac_att21c498;
 			break;
 		default:
-			printk
-			    (" atyfb_set_par: DAC type not implemented yet!\n");
+			printk(" atyfb_set_par: DAC type not implemented yet!\n");
 			par->dac_ops = &aty_dac_unsupported;
 			break;
 		}
@@ -1595,8 +1832,7 @@
 			par->pll_ops = &aty_pll_ibm514;
 			break;
 		default:
-			printk
-			    (" atyfb_set_par: CLK type not implemented yet!");
+			printk(" atyfb_set_par: CLK type not implemented yet!");
 			par->pll_ops = &aty_pll_unsupported;
 			break;
 		}
@@ -1610,8 +1846,8 @@
 		par->dac_ops = &aty_dac_ct;
 		par->pll_ops = &aty_pll_ct;
 		/* for many chips, the mclk is 67 MHz for SDRAM, 63 MHz otherwise */
-		if (mclk == 67 && par->ram_type < SDRAM)
-			mclk = 63;
+		if (xclk == 67 && par->ram_type < SDRAM)
+			xclk = 63;
 	}
 #endif				/* CONFIG_FB_ATY_CT */
 
@@ -1728,47 +1964,70 @@
 		pll = default_pll;
 	if (default_mclk)
 		mclk = default_mclk;
+	if (default_xclk)
+		xclk = default_xclk;
 
-	printk("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK\n",
-	       info->fix.smem_len ==
-	       0x80000 ? 512 : (info->fix.smem_len >> 20),
-	       info->fix.smem_len == 0x80000 ? 'K' : 'M', ramname,
-	       xtal, pll, mclk);
+	printk("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK, %d Mhz XCLK\n",
+		info->fix.smem_len == 0x80000 ? 512 : (info->fix.smem_len >> 20),
+		info->fix.smem_len == 0x80000 ? 'K' : 'M', ramname, xtal, pll, mclk, xclk);
 
-	if (mclk < 44)
+	if (xclk < 44)
 		par->mem_refresh_rate = 0;	/* 000 = 10 Mhz - 43 Mhz */
-	else if (mclk < 50)
+	else if (xclk < 50)
 		par->mem_refresh_rate = 1;	/* 001 = 44 Mhz - 49 Mhz */
-	else if (mclk < 55)
+	else if (xclk < 55)
 		par->mem_refresh_rate = 2;	/* 010 = 50 Mhz - 54 Mhz */
-	else if (mclk < 66)
+	else if (xclk < 66)
 		par->mem_refresh_rate = 3;	/* 011 = 55 Mhz - 65 Mhz */
-	else if (mclk < 75)
+	else if (xclk < 75)
 		par->mem_refresh_rate = 4;	/* 100 = 66 Mhz - 74 Mhz */
-	else if (mclk < 80)
+	else if (xclk < 80)
 		par->mem_refresh_rate = 5;	/* 101 = 75 Mhz - 79 Mhz */
-	else if (mclk < 100)
+	else if (xclk < 100)
 		par->mem_refresh_rate = 6;	/* 110 = 80 Mhz - 100 Mhz */
 	else
 		par->mem_refresh_rate = 7;	/* 111 = 100 Mhz and above */
 	par->pll_per = 1000000 / pll;
-	par->mclk_per = 1000000 / mclk;
+	if ((mclk < 0) || (xclk < 0)) {
+		par->mclk_per = 0;
+		par->xclk_per = 0;
+	} else {
+		par->mclk_per = 1000000/mclk;
+		par->xclk_per = 1000000/xclk;
+	}
 
 #ifdef DEBUG
 	if (M64_HAS(INTEGRATED)) {
 		int i;
-		printk
-		    ("BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL "
-		     "DSP_CONFIG DSP_ON_OFF\n"
-		     "%08x %08x %08x %08x     %08x      %08x   %08x\n"
-		     "PLL", aty_ld_le32(BUS_CNTL, par),
-		     aty_ld_le32(DAC_CNTL, par), aty_ld_le32(MEM_CNTL,
-							     par),
-		     aty_ld_le32(EXT_MEM_CNTL, par),
-		     aty_ld_le32(CRTC_GEN_CNTL, par),
-		     aty_ld_le32(DSP_CONFIG, par), aty_ld_le32(DSP_ON_OFF,
-							       par));
-		for (i = 0; i < 16; i++)
+		printk("BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL "
+		       "DSP_CONFIG DSP_ON_OFF CLOCK_CNTL\n"
+		       "%08x %08x %08x %08x     %08x      %08x   %08x   %08x\n"
+		       "PLL",
+			aty_ld_le32(BUS_CNTL, par), aty_ld_le32(DAC_CNTL, par),
+			aty_ld_le32(MEM_CNTL, par), aty_ld_le32(EXT_MEM_CNTL, par),
+			aty_ld_le32(CRTC_GEN_CNTL, par), aty_ld_le32(DSP_CONFIG, par),
+			aty_ld_le32(DSP_ON_OFF, par), aty_ld_le32(CLOCK_CNTL, par));
+		for (i = 0; i < 40; i++)
+			printk(" %02x", aty_ld_pll(i, par));
+		printk("\n");
+	}
+#endif
+	printk("vor init_pll\n");
+	par->pll_ops->init_pll(info);
+	printk("after init_pll\n");
+	
+#ifdef DEBUG
+	if (M64_HAS(INTEGRATED)) {
+		int i;
+		printk("BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL "
+		       "DSP_CONFIG DSP_ON_OFF CLOCK_CNTL\n"
+		       "%08x %08x %08x %08x     %08x      %08x   %08x   %08x\n"
+		       "PLL",
+			aty_ld_le32(BUS_CNTL, par), aty_ld_le32(DAC_CNTL, par),
+			aty_ld_le32(MEM_CNTL, par), aty_ld_le32(EXT_MEM_CNTL, par),
+			aty_ld_le32(CRTC_GEN_CNTL, par), aty_ld_le32(DSP_CONFIG, par),
+			aty_ld_le32(DSP_ON_OFF, par), aty_ld_le32(CLOCK_CNTL, par));
+		for (i = 0; i < 40; i++)
 			printk(" %02x", aty_ld_pll(i, par));
 		printk("\n");
 	}
@@ -1780,7 +2039,7 @@
 	 *  the full 8 MB of video RAM on 8 MB boards
 	 */
 	if (info->fix.smem_len == 0x800000 ||
-	    (par->bus_type == ISA 
+	    (par->bus_type == ISA
 	     && info->fix.smem_len == 0x400000))
 		info->fix.smem_len -= GUI_RESERVE;
 
@@ -1855,14 +2114,12 @@
 #else				/* !CONFIG_PPC */
 #ifdef __sparc__
 	if (mode_option) {
-		if (!fb_find_mode
-		    (&var, info, mode_option, NULL, 0, NULL, 8))
+		if (!fb_find_mode(&var, info, mode_option, NULL, 0, NULL, 8))
 			var = default_var;
 	} else
 		var = default_var;
 #else
-	if (!fb_find_mode
-	    (&var, info, mode_option, NULL, 0, NULL, 8))
+	if (!fb_find_mode(&var, info, mode_option, NULL, 0, NULL, 8))
 		var = default_var;
 #endif				/* !__sparc__ */
 #endif				/* !CONFIG_PPC */
@@ -1900,9 +2157,45 @@
 		return 0;
 
 	fb_list = info;
-
+#ifdef DEBUG
+{
+	/* dump non shadow CRTC, pll, LCD registers */
+	int i; u32 base;
+	/* CRTC registers */
+	base = 0x2000;
+	printk("Mach64 non-shadow register values:");
+	for (i = 0; i < 256; i = i+4) {
+		if(i%16 == 0) printk("\n0x%04X: ", base + i);
+		printk(" %08X", aty_ld_le32(i, par));
+	}
+	printk("\n\n");
+
+	/* PLL registers */
+	base = 0x00;
+	printk("Mach64 PLL register values:");
+	for (i = 0; i < 64; i++) {
+		if(i%16 == 0) printk("\n0x%02X: ", base + i);
+		if(i%4 == 0)  printk(" ");
+		printk("%02X", aty_ld_pll(i, par));
+	}
+	printk("\n\n");
+
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if(par->lcd_table != 0) {
+		/* LCD registers */
+		base = 0x00;
+		printk("LCD register values:");
+		for (i = 0; i < 64; i++) {
+			if(i%4 == 0) printk("\n0x%02X: ", base + i);
+			printk(" %08X", aty_ld_lcd(i, par));
+		}
+		printk("\n\n");
+	}
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
+}
+#endif
 	printk("fb%d: %s frame buffer device on %s\n",
-	       minor(info->node), info->fix.id, name);
+		minor(info->node), info->fix.id, name);
 	return 1;
 }
 
@@ -1928,9 +2221,11 @@
 #else
 	u16 tmp;
 #endif
-
-	while ((pdev =
-		pci_find_device(PCI_VENDOR_ID_ATI, PCI_ANY_ID, pdev))) {
+#if defined(CONFIG_FB_ATY_GENERIC_LCD)
+	u16 lcd_ofs;
+	u32 driv_inf_tab, sig, rom_addr;
+#endif
+	while ((pdev = pci_find_device(PCI_VENDOR_ID_ATI, PCI_ANY_ID, pdev))) {
 		if ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
 			struct resource *rp;
 
@@ -1942,11 +2237,9 @@
 			if (i < 0)
 				continue;
 
-			info =
-			    kmalloc(sizeof(struct fb_info), GFP_ATOMIC);
+			info = kmalloc(sizeof(struct fb_info), GFP_ATOMIC);
 			if (!info) {
-				printk
-				    ("atyfb_init: can't alloc fb_info\n");
+				printk("atyfb_init: can't alloc fb_info\n");
 				return -ENXIO;
 			}
 			memset(info, 0, sizeof(struct fb_info));
@@ -1954,8 +2247,7 @@
 			default_par =
 			    kmalloc(sizeof(struct atyfb_par), GFP_ATOMIC);
 			if (!default_par) {
-				printk
-				    ("atyfb_init: can't alloc atyfb_par\n");
+				printk("atyfb_init: can't alloc atyfb_par\n");
 				kfree(info);
 				return -ENXIO;
 			}
@@ -1987,7 +2279,7 @@
 			/*
 			 * Map in big-endian aperture.
 			 */
-			info->screen_base = (char *) (addr + 0x800000UL);
+			info->screen_base = (char *)(addr + 0x800000UL);
 			info->fix.smem_start = addr + 0x800000UL;
 
 			/*
@@ -2002,8 +2294,7 @@
 			    kmalloc(j * sizeof(*default_par->mmap_map),
 				    GFP_ATOMIC);
 			if (!default_par->mmap_map) {
-				printk
-				    ("atyfb_init: can't alloc mmap_map\n");
+				printk("atyfb_init: can't alloc mmap_map\n");
 				kfree(info);
 				release_mem_region(res_start, res_size);
 				return -ENXIO;
@@ -2014,15 +2305,12 @@
 			for (i = 0, j = 2;
 			     i < 6 && pdev->resource[i].start; i++) {
 				struct resource *rp = &pdev->resource[i];
-				int io, breg =
-				    PCI_BASE_ADDRESS_0 + (i << 2);
+				int io, breg = PCI_BASE_ADDRESS_0 + (i << 2);
 				unsigned long base;
 				u32 size, pbase;
 
 				base = rp->start;
-
 				io = (rp->flags & IORESOURCE_IO);
-
 				size = rp->end - base + 1;
 
 				pci_read_config_dword(pdev, breg, &pbase);
@@ -2037,18 +2325,11 @@
 				 * to stay compatible with older ones...
 				 */
 				if (base == addr) {
-					default_par->mmap_map[j].voff =
-					    (pbase +
-					     0x10000000) & PAGE_MASK;
-					default_par->mmap_map[j].poff =
-					    base & PAGE_MASK;
-					default_par->mmap_map[j].size =
-					    (size +
-					     ~PAGE_MASK) & PAGE_MASK;
-					default_par->mmap_map[j].prot_mask =
-					    _PAGE_CACHE;
-					default_par->mmap_map[j].prot_flag =
-					    _PAGE_E;
+					default_par->mmap_map[j].voff = (pbase + 0x10000000) & PAGE_MASK;
+					default_par->mmap_map[j].poff = base & PAGE_MASK;
+					default_par->mmap_map[j].size = (size + ~PAGE_MASK) & PAGE_MASK;
+					default_par->mmap_map[j].prot_mask = _PAGE_CACHE;
+					default_par->mmap_map[j].prot_flag = _PAGE_E;
 					j++;
 				}
 
@@ -2057,23 +2338,18 @@
 				 * set for the big endian half of the framebuffer...
 				 */
 				if (base == addr) {
-					default_par->mmap_map[j].voff =
-					    (pbase + 0x800000) & PAGE_MASK;
-					default_par->mmap_map[j].poff =
-					    (base + 0x800000) & PAGE_MASK;
+					default_par->mmap_map[j].voff = (pbase + 0x800000) & PAGE_MASK;
+					default_par->mmap_map[j].poff = (base + 0x800000) & PAGE_MASK;
 					default_par->mmap_map[j].size = 0x800000;
-					default_par->mmap_map[j].prot_mask =
-					    _PAGE_CACHE;
-					default_par->mmap_map[j].prot_flag =
-					    _PAGE_E | _PAGE_IE;
+					default_par->mmap_map[j].prot_mask = _PAGE_CACHE;
+					default_par->mmap_map[j].prot_flag = _PAGE_E | _PAGE_IE;
 					size -= 0x800000;
 					j++;
 				}
 
 				default_par->mmap_map[j].voff = pbase & PAGE_MASK;
 				default_par->mmap_map[j].poff = base & PAGE_MASK;
-				default_par->mmap_map[j].size =
-				    (size + ~PAGE_MASK) & PAGE_MASK;
+				default_par->mmap_map[j].size = (size + ~PAGE_MASK) & PAGE_MASK;
 				default_par->mmap_map[j].prot_mask = _PAGE_CACHE;
 				default_par->mmap_map[j].prot_flag = _PAGE_E;
 				j++;
@@ -2085,8 +2361,7 @@
 				 */
 				mem = aty_ld_le32(MEM_CNTL, default_par);
 				chip_id = aty_ld_le32(CONFIG_CHIP_ID, default_par);
-				if (((chip_id & CFG_CHIP_TYPE) == VT_CHIP_ID)
-				    && !((chip_id >> 24) & 1)) {
+				if (((chip_id & CFG_CHIP_TYPE) == VT_CHIP_ID) && !((chip_id >> 24) & 1)) {
 					switch (mem & 0x0f) {
 					case 3:
 						mem = (mem & ~(0x0f)) | 2;
@@ -2117,9 +2392,7 @@
 			node = prom_getchild(prom_root_node);
 			node = prom_searchsiblings(node, "aliases");
 			if (node) {
-				len =
-				    prom_getproperty(node, "screen", prop,
-						     sizeof(prop));
+				len = prom_getproperty(node, "screen", prop, sizeof(prop));
 				if (len > 0) {
 					prop[len] = '\0';
 					node = prom_finddevice(prop);
@@ -2131,41 +2404,26 @@
 			pcp = pdev->sysdata;
 			if (node == pcp->prom_node) {
 
-				struct fb_var_screeninfo *var =
-				    &default_var;
+				struct fb_var_screeninfo *var = &default_var;
 				unsigned int N, P, Q, M, T, R;
 				u32 v_total, h_total;
 				struct crtc crtc;
 				u8 pll_regs[16];
 				u8 clock_cntl;
 
-				crtc.vxres =
-				    prom_getintdefault(node, "width",
-						       1024);
-				crtc.vyres =
-				    prom_getintdefault(node, "height",
-						       768);
-				var->bits_per_pixel =
-				    prom_getintdefault(node, "depth", 8);
+				crtc.vxres = prom_getintdefault(node, "width", 1024);
+				crtc.vyres = prom_getintdefault(node, "height", 768);
+				var->bits_per_pixel = prom_getintdefault(node, "depth", 8);
 				var->xoffset = var->yoffset = 0;
-				crtc.h_tot_disp =
-				    aty_ld_le32(CRTC_H_TOTAL_DISP, default_par);
-				crtc.h_sync_strt_wid =
-				    aty_ld_le32(CRTC_H_SYNC_STRT_WID,
-						default_par);
-				crtc.v_tot_disp =
-				    aty_ld_le32(CRTC_V_TOTAL_DISP, default_par);
-				crtc.v_sync_strt_wid =
-				    aty_ld_le32(CRTC_V_SYNC_STRT_WID,
-						default_par);
-				crtc.gen_cntl =
-				    aty_ld_le32(CRTC_GEN_CNTL, default_par);
+				crtc.h_tot_disp = aty_ld_le32(CRTC_H_TOTAL_DISP, default_par);
+				crtc.h_sync_strt_wid = aty_ld_le32(CRTC_H_SYNC_STRT_WID, default_par);
+				crtc.v_tot_disp = aty_ld_le32(CRTC_V_TOTAL_DISP, default_par);
+				crtc.v_sync_strt_wid = aty_ld_le32(CRTC_V_SYNC_STRT_WID, default_par);
+				crtc.gen_cntl = aty_ld_le32(CRTC_GEN_CNTL, default_par);
 				aty_crtc_to_var(&crtc, var);
 
-				h_total = var->xres + var->right_margin +
-				    var->hsync_len + var->left_margin;
-				v_total = var->yres + var->lower_margin +
-				    var->vsync_len + var->upper_margin;
+				h_total = var->xres + var->right_margin + var->hsync_len + var->left_margin;
+				v_total = var->yres + var->lower_margin + var->vsync_len + var->upper_margin;
 
 				/*
 				 * Read the PLL to figure actual Refresh Rate.
@@ -2188,8 +2446,7 @@
 				/*
 				 * PLL Post Divider P (Dependant on CLOCK_CNTL):
 				 */
-				P = 1 << (pll_regs[6] >>
-					  ((clock_cntl & 3) << 1));
+				P = 1 << (pll_regs[6] >> ((clock_cntl & 3) << 1));
 
 				/*
 				 * PLL Divider Q:
@@ -2217,8 +2474,7 @@
 #else				/* __sparc__ */
 
 			info->fix.mmio_start = 0x7ff000 + addr;
-			default_par->ati_regbase = (unsigned long)
-			    ioremap(info->fix.mmio_start, 0x1000);
+			default_par->ati_regbase = (unsigned long)ioremap(info->fix.mmio_start, 0x1000);
 
 			if (!default_par->ati_regbase) {
 				kfree(default_par);
@@ -2237,8 +2493,7 @@
 			pci_read_config_word(pdev, PCI_COMMAND, &tmp);
 			if (!(tmp & PCI_COMMAND_MEMORY)) {
 				tmp |= PCI_COMMAND_MEMORY;
-				pci_write_config_word(pdev, PCI_COMMAND,
-						      tmp);
+				pci_write_config_word(pdev, PCI_COMMAND, tmp);
 			}
 #ifdef __BIG_ENDIAN
 			/* Use the big-endian aperture */
@@ -2247,8 +2502,207 @@
 
 			/* Map in frame buffer */
 			info->fix.smem_start = addr;
-			info->screen_base =
-			    (char *) ioremap(addr, 0x800000);
+			info->screen_base = (char *)ioremap(addr, 0x800000);
+
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	    /* To support an LCD panel, we should know it's dimensions and
+	       it's desired pixel clock.
+	       There are two ways to do it:
+	         - Check the startup video mode and calculate the panel
+		   size from it. This is unreliable.
+		 - Read it from the driver information table in the video BIOS.
+
+	       So, we try to find a BIOS and get access to it.
+	    */
+	    rom_addr = 0xc0000 + ((aty_ld_le32(SCRATCH_REG1, default_par) & 0x7f) << 11);
+	    default_par->bios_base_phys = rom_addr;
+	    default_par->bios_base = (unsigned long)ioremap(rom_addr, 0x10000);
+
+	    /* The BIOS starts with 0xaa55. */
+	    if (*((u16 *)default_par->bios_base) == 0xaa55) {
+		printk(KERN_INFO "atyfb: Mach64 BIOS is located at %x, mapped at %x.\n",
+		(u32)default_par->bios_base_phys, (u32)default_par->bios_base);
+
+		/* Address of driver information table is at offset 0x78. */
+		driv_inf_tab = default_par->bios_base + *((u16 *)(default_par->bios_base+0x78));
+
+		/* Check for the driver information table signature. */
+		sig = (*(u32 *)driv_inf_tab);
+		if ((sig == 0x54504c24) || /* Rage LT pro */
+		    (sig == 0x544d5224) || /* Rage mobility */
+		    (sig == 0x54435824) || /* Rage XC */
+		    (sig == 0x544c5824)) { /* Rage XL */
+		    printk(KERN_INFO "atyfb: BIOS contains driver information table.\n");
+		    lcd_ofs = (*(u16 *)(driv_inf_tab + 10));
+		    default_par->lcd_table = 0;
+		    if (lcd_ofs != 0) {
+			default_par->lcd_table = default_par->bios_base + lcd_ofs;
+		    }
+		}
+	}
+	    if (default_par->lcd_table != 0) {
+		char model[24];
+		char strbuf[16];
+		char refresh_rates_buf[100];
+		int id, tech, f, i, m, default_refresh_rate;
+		char *txtcolour;
+		char *txtmonitor;
+		char *txtdual;
+		char *txtformat;
+		u16 width, height, panel_type, refresh_rates;
+		u16 *lcdmodeptr;
+		u32 format;
+		u8 lcd_refresh_rates[16] = {50,56,60,67,70,72,75,76,85,90,100,120,140,150,160,200};
+		/* The most important information is the panel size at
+		   offset 25 and 27, but there's some other nice information
+		   which we print to the screen.
+		 */
+		id = *(u8 *)default_par->lcd_table;
+		strncpy(model,(char *)default_par->lcd_table+1,24);
+		model[23]=0;
+
+		width = default_par->lcd_width = *(u16 *)(default_par->lcd_table+25);
+		height = default_par->lcd_height = *(u16 *)(default_par->lcd_table+27);
+		panel_type = *(u16 *)(default_par->lcd_table+29);
+		if (panel_type & 1)
+		    txtcolour = "colour";
+		else
+		    txtcolour = "monochrome";
+		if (panel_type & 2)
+		    txtdual = "dual (split) ";
+		else
+		    txtdual = "";
+		tech = (panel_type>>2) & 63;
+		switch (tech) {
+		    case 0:
+			txtmonitor = "passive matrix";
+			break;
+		    case 1:
+			txtmonitor = "active matrix";
+			break;
+		    case 2:
+			txtmonitor = "active addressed STN";
+			break;
+		    case 3:
+			txtmonitor = "EL";
+			break;
+		    case 4:
+			txtmonitor = "plasma";
+			break;
+		    default:
+			txtmonitor = "unknown";
+		}
+		format = *(u32 *)(default_par->lcd_table+57);
+		if (tech == 0 || tech == 2) {
+		    switch (format & 7) {
+			case 0:
+			    txtformat = "12 bit interface";
+			    break;
+			case 1:
+			    txtformat = "16 bit interface";
+			    break;
+			case 2:
+			    txtformat = "24 bit interface";
+			    break;
+			default:
+			    txtformat = "unkown format";
+		    }
+		} else {
+		    switch (format & 7) {
+			case 0:
+			    txtformat = "8 colours";
+			    break;
+			case 1:
+			    txtformat = "512 colours";
+			    break;
+			case 2:
+			    txtformat = "4096 colours";
+			    break;
+			case 4:
+			    txtformat = "262144 colours (LT mode)";
+			    break;
+			case 5:
+			    txtformat = "16777216 colours";
+			    break;
+			case 6:
+			    txtformat = "262144 colours (FDPI-2 mode)";
+			    break;
+			default:
+			    txtformat = "unkown format";
+		    }
+		}
+		printk(KERN_INFO "atyfb: %s%s %s monitor detected: %s\n        id=%d, %dx%d pixels, %s\n",
+		 txtdual ,txtcolour, txtmonitor, model, id, width, height, txtformat);
+		refresh_rates_buf[0] = 0;
+		refresh_rates = *(u16 *)(default_par->lcd_table+62);
+		m = 1;
+		f = 0;
+		for (i=0;i<16;i++) {
+		    if (refresh_rates & m) {
+			if (f == 0) {
+			    sprintf(strbuf, "%d", lcd_refresh_rates[i]);
+			    f++;
+			} else {
+			    sprintf(strbuf, ",%d", lcd_refresh_rates[i]);
+			}
+			strcat(refresh_rates_buf,strbuf);
+		    }
+		    m = m << 1;
+		}
+		default_refresh_rate = (*(u8 *)(default_par->lcd_table+61) & 0xf0) >> 4;
+		printk(KERN_INFO "        supports %s Hz refresh rates, default %d Hz\n",
+		 refresh_rates_buf, lcd_refresh_rates[default_refresh_rate]);
+		/* We now need to determine the crtc parameters for the
+		   lcd monitor. This is tricky, because they are not stored
+		   individually in the BIOS. Instead, the BIOS contains a
+		   table of display modes that work for this monitor.
+
+		   The idea is that we search for a mode of the same dimensions
+		   as the dimensions of the lcd monitor. Say our lcd monitor
+		   is 800x600 pixels, we search for a 800x600 monitor.
+		   The CRTC parameters we find here are the ones that we need
+		   to use to simulate other resolutions on the lcd screen.
+		 */
+		lcdmodeptr = (u16 *)(default_par->lcd_table + 64);
+		while (*lcdmodeptr != 0) {
+		    u32 modeptr;
+		    u16 mwidth,mheight;
+		    modeptr = default_par->bios_base + *lcdmodeptr;
+
+		    mwidth = *((u16 *)(modeptr+0));
+		    mheight = *((u16 *)(modeptr+2));
+
+		    if (mwidth == width && mheight == height) {
+			default_par->lcd_pixclock = 100000000 / *((u16 *)(modeptr+9));
+			default_par->lcd_htotal = *((u16 *)(modeptr+17)) & 511;
+			default_par->lcd_hdisp = *((u16 *)(modeptr+19)) & 511;
+			default_par->lcd_hsync_start = *((u16 *)(modeptr+21)) & 511;
+			default_par->lcd_hsync_delay = (*((u16 *)(modeptr+21)) >> 9) & 7;
+			default_par->lcd_hsync_width = *((u8 *)(modeptr+23)) & 63;
+			default_par->lcd_vtotal = *((u16 *)(modeptr+24)) & 2047;
+			default_par->lcd_vdisp = *((u16 *)(modeptr+26)) & 2047;
+			default_par->lcd_vsync_start = *((u16 *)(modeptr+28)) & 2047;
+			default_par->lcd_vsync_width = (*((u16 *)(modeptr+28)) >> 11) & 31;
+			default_par->lcd_right = default_par->lcd_hsync_start - default_par->lcd_hdisp;
+			default_par->lcd_lower = default_par->lcd_vsync_start - default_par->lcd_vdisp;
+			default_par->lcd_hblank_width = default_par->lcd_htotal - default_par->lcd_hdisp;
+			default_par->lcd_vblank_width = default_par->lcd_vtotal - default_par->lcd_vdisp;
+			break;
+		    }
+
+		    lcdmodeptr++;
+		}
+		if (*lcdmodeptr == 0) {
+		    printk(KERN_WARNING "atyfb: LCD monitor CRTC parameters not found!!!\n");
+		    /* To do: Switch to CRT if possible. */
+		} else {
+		    printk(KERN_INFO "        LCD CRTC parameters: %d %d %d %d %d %d %d %d %d %d\n",
+		     default_par->lcd_pixclock, default_par->lcd_htotal, default_par->lcd_hdisp, default_par->lcd_hsync_start,
+		     default_par->lcd_hsync_delay, default_par->lcd_hsync_width, default_par->lcd_vtotal, default_par->lcd_vdisp,
+		     default_par->lcd_vsync_start, default_par->lcd_vsync_width);
+		}
+	    }
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
 
 			if (!info->screen_base) {
 				kfree(info);
@@ -2377,11 +2831,11 @@
 			default_vram =
 			    simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "pll:", 4))
-			default_pll =
-			    simple_strtoul(this_opt + 4, NULL, 0);
+			default_pll = simple_strtoul(this_opt + 4, NULL, 0);
 		else if (!strncmp(this_opt, "mclk:", 5))
-			default_mclk =
-			    simple_strtoul(this_opt + 5, NULL, 0);
+			default_mclk = simple_strtoul(this_opt + 5, NULL, 0);
+		else if (!strncmp(this_opt, "xclk:", 5))
+			default_xclk = simple_strtoul(this_opt + 5, NULL, 0);
 #ifdef CONFIG_PPC
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			unsigned int vmode =
diff -u -r /usr/src/linux-2.5.orig/drivers/video/aty/mach64_ct.c /usr/src/linux-2.5.XX/drivers/video/aty/mach64_ct.c
--- /usr/src/linux-2.5.orig/drivers/video/aty/mach64_ct.c	2003-01-02 04:20:50.000000000 +0100
+++ /usr/src/linux-2.5.XX/drivers/video/aty/mach64_ct.c	2003-01-17 17:54:53.000000000 +0100
@@ -13,18 +13,19 @@
 
 /* FIXME: remove the FAIL definition */
 #define FAIL(x) do { printk(x "\n"); return -EINVAL; } while (0)
+#define DENBUG
 
 static void aty_st_pll(int offset, u8 val, const struct atyfb_par *par);
 static int aty_valid_pll_ct(const struct fb_info *info, u32 vclk_per,
 			    struct pll_ct *pll);
-static int aty_dsp_gt(const struct fb_info *info, u8 bpp,
+static int aty_dsp_gt(const struct fb_info *info, u32 bpp, u32 stretch,
 		      struct pll_ct *pll);
 static int aty_var_to_pll_ct(const struct fb_info *info, u32 vclk_per,
-			     u8 bpp, union aty_pll *pll);
+			     u32 bpp, u32 stretch, union aty_pll *pll);
 static u32 aty_pll_ct_to_var(const struct fb_info *info,
 			     const union aty_pll *pll);
 
-
+static u8 postdividers[] = {1,2,4,8,3};
 
 static void aty_st_pll(int offset, u8 val, const struct atyfb_par *par)
 {
@@ -32,7 +33,7 @@
 	aty_st_8(CLOCK_CNTL + 1, (offset << 2) | PLL_WR_EN, par);
 	/* write the register value */
 	aty_st_8(CLOCK_CNTL + 2, val, par);
-	aty_st_8(CLOCK_CNTL + 1, (offset << 2) & ~PLL_WR_EN, par);
+	aty_st_8(CLOCK_CNTL + 1, (offset << 2), par);
 }
 
 
@@ -42,58 +43,39 @@
      *  PLL programming (Mach64 CT family)
      */
 
-static int aty_dsp_gt(const struct fb_info *info, u8 bpp,
-		      struct pll_ct *pll)
+static int aty_dsp_gt(const struct fb_info *info, u32 bpp,
+		      u32 width, struct pll_ct *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	u32 dsp_xclks_per_row, dsp_loop_latency, dsp_precision, dsp_off,
-	    dsp_on;
-	u32 xclks_per_row, fifo_off, fifo_on, y, fifo_size, page_size;
+	u32 dsp_xclks_per_row, dsp_precision, dsp_off, dsp_on;
+	u32 xclks_per_row, fifo_off, fifo_on, y, page_size;
 
 	/* xclocks_per_row<<11 */
 	xclks_per_row =
-	    (pll->mclk_fb_div * pll->vclk_post_div_real * 64 << 11) /
-	    (pll->vclk_fb_div * pll->mclk_post_div_real * bpp);
+	    (par->mclk_fb_div * pll->vclk_post_div_real * 64 << 11) /
+	    (pll->vclk_fb_div * par->xclk_post_div_real * bpp);
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (width != 0)
+		xclks_per_row = (xclks_per_row * par->lcd_width) / width;
+#endif
 	if (xclks_per_row < (1 << 11))
 		FAIL("Dotclock to high");
-	if (M64_HAS(FIFO_24)) {
-		fifo_size = 24;
-		dsp_loop_latency = 0;
-	} else {
-		fifo_size = 32;
-		dsp_loop_latency = 2;
-	}
+
 	dsp_precision = 0;
-	y = (xclks_per_row * fifo_size) >> 11;
+	y = (xclks_per_row * par->fifo_size) >> 11;
 	while (y) {
 		y >>= 1;
 		dsp_precision++;
 	}
 	dsp_precision -= 5;
 	/* fifo_off<<6 */
-	fifo_off = ((xclks_per_row * (fifo_size - 1)) >> 5) + (3 << 6);
+	fifo_off = ((xclks_per_row * (par->fifo_size - 1)) >> 5) + (3 << 6);
 
-	if (info->fix.smem_len > 1 * 1024 * 1024) {
-		if (par->ram_type >= SDRAM) {
-			/* >1 MB SDRAM */
-			dsp_loop_latency += 8;
-			page_size = 8;
-		} else {
-			/* >1 MB DRAM */
-			dsp_loop_latency += 6;
-			page_size = 9;
-		}
-	} else {
-		if (par->ram_type >= SDRAM) {
-			/* <2 MB SDRAM */
-			dsp_loop_latency += 9;
-			page_size = 10;
-		} else {
-			/* <2 MB DRAM */
-			dsp_loop_latency += 8;
-			page_size = 10;
-		}
-	}
+	page_size = par->page_size;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (width != 0)
+		page_size = (page_size * par->lcd_width) / width;
+#endif
 	/* fifo_on<<6 */
 	if (xclks_per_row >= (page_size << 11))
 		fifo_on =
@@ -106,7 +88,7 @@
 	dsp_off = fifo_off >> dsp_precision;
 
 	pll->dsp_config = (dsp_xclks_per_row & 0x3fff) |
-	    ((dsp_loop_latency & 0xf) << 16) | ((dsp_precision & 7) << 20);
+	    ((par->dsp_loop_latency & 0xf) << 16) | ((dsp_precision & 7) << 20);
 	pll->dsp_on_off = (dsp_on & 0x7ff) | ((dsp_off & 0x7ff) << 16);
 	return 0;
 }
@@ -118,109 +100,40 @@
 	u32 q, x;		/* x is a workaround for sparc64-linux-gcc */
 	x = x;			/* x is a workaround for sparc64-linux-gcc */
 
-	pll->pll_ref_div = par->pll_per * 2 * 255 / par->ref_clk_per;
-
-	/* FIXME: use the VTB/GTB /3 post divider if it's better suited */
-	q = par->ref_clk_per * pll->pll_ref_div * 4 / par->mclk_per;	/* actually 8*q */
-	if (q < 16 * 8 || q > 255 * 8)
-		FAIL("mclk out of range");
-	else if (q < 32 * 8)
-		pll->mclk_post_div_real = 8;
-	else if (q < 64 * 8)
-		pll->mclk_post_div_real = 4;
-	else if (q < 128 * 8)
-		pll->mclk_post_div_real = 2;
-	else
-		pll->mclk_post_div_real = 1;
-	pll->mclk_fb_div = q * pll->mclk_post_div_real / 8;
+	par->pll_ref_div = par->pll_per * 2 * 255 / par->ref_clk_per;
 
 	/* FIXME: use the VTB/GTB /{3,6,12} post dividers if they're better suited */
-	q = par->ref_clk_per * pll->pll_ref_div * 4 / vclk_per;	/* actually 8*q */
-	if (q < 16 * 8 || q > 255 * 8)
+	q = par->ref_clk_per * par->pll_ref_div * 4 / vclk_per;	/* actually 8*q */
+	if (q < 16*8 || q > 255*8)
 		FAIL("vclk out of range");
-	else if (q < 32 * 8)
-		pll->vclk_post_div_real = 8;
-	else if (q < 64 * 8)
-		pll->vclk_post_div_real = 4;
-	else if (q < 128 * 8)
-		pll->vclk_post_div_real = 2;
-	else
-		pll->vclk_post_div_real = 1;
-	pll->vclk_fb_div = q * pll->vclk_post_div_real / 8;
-	return 0;
-}
-
-void aty_calc_pll_ct(const struct fb_info *info, struct pll_ct *pll)
-{
-	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	u8 mpostdiv = 0;
-	u8 vpostdiv = 0;
-
-	if (M64_HAS(SDRAM_MAGIC_PLL) && (par->ram_type >= SDRAM))
-		pll->pll_gen_cntl = 0x04;
-	else
-		pll->pll_gen_cntl = 0x84;
-
-	switch (pll->mclk_post_div_real) {
-	case 1:
-		mpostdiv = 0;
-		break;
-	case 2:
-		mpostdiv = 1;
-		break;
-	case 3:
-		mpostdiv = 4;
-		break;
-	case 4:
-		mpostdiv = 2;
-		break;
-	case 8:
-		mpostdiv = 3;
-		break;
+	else {
+		pll->vclk_post_div = 0;
+		if (q < 128*8)
+			pll->vclk_post_div++;
+		if (q < 64*8)
+			pll->vclk_post_div++;
+		if (q < 32*8)
+			pll->vclk_post_div++;
 	}
-	pll->pll_gen_cntl |= mpostdiv << 4;	/* mclk */
-
-	if (M64_HAS(MAGIC_POSTDIV))
-		pll->pll_ext_cntl = 0;
-	else
-		pll->pll_ext_cntl = mpostdiv;	/* xclk == mclk */
-
-	switch (pll->vclk_post_div_real) {
-	case 2:
-		vpostdiv = 1;
-		break;
-	case 3:
-		pll->pll_ext_cntl |= 0x10;
-	case 1:
-		vpostdiv = 0;
-		break;
-	case 6:
-		pll->pll_ext_cntl |= 0x10;
-	case 4:
-		vpostdiv = 2;
-		break;
-	case 12:
-		pll->pll_ext_cntl |= 0x10;
-	case 8:
-		vpostdiv = 3;
-		break;
-	}
-
+	pll->vclk_post_div_real = postdividers[pll->vclk_post_div];
+	pll->vclk_fb_div = q*pll->vclk_post_div_real/8;
 	pll->pll_vclk_cntl = 0x03;	/* VCLK = PLL_VCLK/VCLKx_POST */
-	pll->vclk_post_div = vpostdiv;
+
+	return 0;
 }
 
 static int aty_var_to_pll_ct(const struct fb_info *info, u32 vclk_per,
-			     u8 bpp, union aty_pll *pll)
+			     u32 bpp, u32 width, union aty_pll *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	int err;
 
 	if ((err = aty_valid_pll_ct(info, vclk_per, &pll->ct)))
 		return err;
-	if (M64_HAS(GTB_DSP) && (err = aty_dsp_gt(info, bpp, &pll->ct)))
+//    aty_dsp_gt2(info,bpp,width,vclk_per,&pll->ct);
+	if (M64_HAS(GTB_DSP) && (err = aty_dsp_gt(info, bpp, width, &pll->ct)))
 		return err;
-	aty_calc_pll_ct(info, &pll->ct);
+//    aty_calc_pll_ct(info, &pll->ct);
 	return 0;
 }
 
@@ -230,7 +143,7 @@
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
 	u32 ref_clk_per = par->ref_clk_per;
-	u8 pll_ref_div = pll->ct.pll_ref_div;
+	u8 pll_ref_div = par->pll_ref_div;
 	u8 vclk_fb_div = pll->ct.vclk_fb_div;
 	u8 vclk_post_div = pll->ct.vclk_post_div_real;
 
@@ -240,16 +153,181 @@
 void aty_set_pll_ct(const struct fb_info *info,
 		    const union aty_pll *pll)
 {
-	struct atyfb_par *par = (struct atyfb_par *) info->par;
+	struct atyfb_par *par = (struct atyfb_par *)info->par;
+
+	u8 tmp, tmp2; u32 crtc_gen_cntl;
+#ifdef DEBUG
+	printk("aty_set_pll_ct: setting clock %i for FeedBackDivider %i, ReferenceDivider %i, PostDivider %i\n",
+		par->clock, pll->ct.vclk_fb_div, par->pll_ref_div, pll->ct.vclk_post_div);
+#endif
+    /* Temporarily switch to accelerator mode */
+    crtc_gen_cntl = aty_ld_le32(CRTC_GEN_CNTL, par);
+    if (!(crtc_gen_cntl & CRTC_EXT_DISP_EN))
+        aty_st_le32(CRTC_GEN_CNTL, crtc_gen_cntl | CRTC_EXT_DISP_EN, par);
+
+    /* Reset VCLK generator */
+    aty_st_pll(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl, par);
+
+    /* Set post-divider */
+    tmp2 = par->clock << 1;
+    tmp = aty_ld_pll(VCLK_POST_DIV, par);
+    tmp &= ~(0x03U << tmp2);
+    tmp |= ((pll->ct.vclk_post_div & 0x03U) << tmp2);
+    aty_st_pll(VCLK_POST_DIV, tmp, par);
+
+    /* Set extended post-divider */
+    tmp = aty_ld_pll(PLL_EXT_CNTL, par);
+    tmp &= ~(0x10U << par->clock);
+    tmp |= (((pll->ct.vclk_post_div >> 2) & 0x10U) << par->clock);
+    aty_st_pll(PLL_EXT_CNTL, tmp, par);
+
+    /* Set feedback divider */
+    tmp = VCLK0_FB_DIV + par->clock;
+    aty_st_pll(tmp, (pll->ct.vclk_fb_div & 0xFFU), par);
+
+    /* End VCLK generator reset */
+    aty_st_pll(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl & ~(0x04U), par);
+
+    /* Reset write bit */
+    /* ATIAccessMach64PLLReg(pATI, 0, FALSE); */
+
+    /* Restore register */
+    if (!(crtc_gen_cntl & CRTC_EXT_DISP_EN))
+        aty_st_le32(CRTC_GEN_CNTL, crtc_gen_cntl, par);
+
+    if (M64_HAS(GTB_DSP)) {
+	aty_st_le32(DSP_CONFIG, pll->ct.dsp_config, par);
+	aty_st_le32(DSP_ON_OFF, pll->ct.dsp_on_off, par);
+    }
+}
+
+
+static void __init aty_init_pll_ct(struct fb_info *info) {
+	struct atyfb_par *par = (struct atyfb_par *)info->par;
+	u8 pll_ref_div, pll_gen_cntl, pll_ext_cntl;
+	u8 mpost_div, xpost_div;
+	u8 sclk_post_div_real, sclk_fb_div, spll_cntl2;
+	u32 q;
 
-	aty_st_pll(PLL_REF_DIV, pll->ct.pll_ref_div, par);
-	aty_st_pll(PLL_GEN_CNTL, pll->ct.pll_gen_cntl, par);
-	aty_st_pll(MCLK_FB_DIV, pll->ct.mclk_fb_div, par);
-	aty_st_pll(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl, par);
-	aty_st_pll(VCLK_POST_DIV, pll->ct.vclk_post_div, par);
-	aty_st_pll(VCLK0_FB_DIV, pll->ct.vclk_fb_div, par);
-	aty_st_pll(PLL_EXT_CNTL, pll->ct.pll_ext_cntl, par);
+	if (M64_HAS(FIFO_24)) {
+		par->fifo_size = 24;
+		par->dsp_loop_latency = 0;
+	} else {
+		par->fifo_size = 32;
+		par->dsp_loop_latency = 2;
+	}
 
+	if (info->fix.smem_len > 1*1024*1024) {
+		if (par->ram_type >= SDRAM) {
+			/* >1 MB SDRAM */
+			par->dsp_loop_latency += 8;
+			par->page_size = 8;
+		} else {
+			/* >1 MB DRAM */
+			par->dsp_loop_latency += 6;
+			par->page_size = 9;
+		}
+	} else {
+		if (par->ram_type >= SDRAM) {
+			/* <2 MB SDRAM */
+			par->dsp_loop_latency += 9;
+			par->page_size = 10;
+		} else {
+			/* <2 MB DRAM */
+			par->dsp_loop_latency += 8;
+			par->page_size = 10;
+		}
+	}
+
+	/* Exit if the user does not want us to play with the clock
+	   rates of her chip. */
+	if (par->mclk_per == 0) {
+		u16 mclk_fb_div;
+		u8 pll_ext_cntl;
+
+		par->pll_ref_div = aty_ld_pll(PLL_REF_DIV, par);
+		pll_ext_cntl = aty_ld_pll(PLL_EXT_CNTL, par);
+		par->xclk_post_div_real = postdividers[pll_ext_cntl & 7];
+		mclk_fb_div = aty_ld_pll(MCLK_FB_DIV, par);
+		if (pll_ext_cntl & 8)
+			mclk_fb_div <<= 1;
+		par->mclk_fb_div = mclk_fb_div;
+		return;
+	}
+
+	pll_ref_div = par->pll_per * 2 * 255 / par->ref_clk_per;
+	par->pll_ref_div = pll_ref_div;
+
+	/* FIXME: use the VTB/GTB /3 post divider if it's better suited */
+	q = par->ref_clk_per * pll_ref_div * 4 / par->xclk_per;	/* actually 8*q */
+	if (q < 16*8 || q > 255*8) {
+		printk(KERN_CRIT "xclk out of range\n");
+		return;
+	} else {
+		xpost_div = 0;
+		if (q < 128*8)
+			xpost_div++;
+		if (q < 64*8)
+			xpost_div++;
+		if (q < 32*8)
+			xpost_div++;
+	}
+	par->xclk_post_div_real = postdividers[xpost_div];
+	par->mclk_fb_div = q * par->xclk_post_div_real / 8;
+
+	if (M64_HAS(SDRAM_MAGIC_PLL) && (par->ram_type >= SDRAM))
+		pll_gen_cntl = 0x04;
+	else
+		pll_gen_cntl = 0x84;
+
+	if (M64_HAS(MAGIC_POSTDIV))
+		pll_ext_cntl = 0;
+	else
+		pll_ext_cntl = xpost_div;
+
+	if (par->mclk_per == par->xclk_per)
+		pll_gen_cntl |= xpost_div<<4; /* mclk == xclk */
+	else {
+		pll_gen_cntl |= 6<<4;	/* mclk == sclk*/
+
+		q = par->ref_clk_per * pll_ref_div * 4 / par->mclk_per;	/* actually 8*q */
+		if (q < 16 * 8 || q > 255 * 8) {
+			printk(KERN_CRIT "mclk out of range\n");
+			return;
+		} else {
+			mpost_div = 0;
+			if (q < 128*8)
+				mpost_div++;
+			if (q < 64*8)
+				mpost_div++;
+			if (q < 32*8)
+				mpost_div++;
+		}
+		sclk_post_div_real = postdividers[mpost_div];
+		sclk_fb_div = q * sclk_post_div_real / 8;
+		spll_cntl2 = mpost_div << 4;
+/*
+		This disables the sclk, crashes the computer as reported:
+		aty_st_pll(SPLL_CNTL2, 3, info);
+
+		So it seems the sclk must be enabled before it is used;
+		so PLL_GEN_CNTL must be programmed *after* the sclk.
+*/
+#ifdef DEBUG
+		printk(KERN_INFO "sclk_fb_div: %x spll_cntl2:%x\n",
+			sclk_fb_div, spll_cntl2);
+#endif
+		aty_st_pll(SPLL_CNTL2, spll_cntl2, par);
+		aty_st_pll(SCLK_FB_DIV, sclk_fb_div, par);
+	}
+#ifdef DEBUG
+	printk(KERN_INFO "pll_ref_div: %x pll_gencntl: %x mclk_fb_div: %x pll_ext_cntl: %x\n",
+		pll_ref_div, pll_gen_cntl, par->mclk_fb_div, pll_ext_cntl);
+#endif
+	aty_st_pll(PLL_REF_DIV, pll_ref_div, par);
+	aty_st_pll(PLL_GEN_CNTL, pll_gen_cntl, par);
+	aty_st_pll(MCLK_FB_DIV, par->mclk_fb_div, par);
+	aty_st_pll(PLL_EXT_CNTL, pll_ext_cntl, par);
 	if (M64_HAS(GTB_DSP)) {
 		if (M64_HAS(XL_DLL))
 			aty_st_pll(DLL_CNTL, 0x80, par);
@@ -258,8 +336,6 @@
 		else
 			aty_st_pll(DLL_CNTL, 0xa0, par);
 		aty_st_pll(VFC_CNTL, 0x1b, par);
-		aty_st_le32(DSP_CONFIG, pll->ct.dsp_config, par);
-		aty_st_le32(DSP_ON_OFF, pll->ct.dsp_on_off, par);
 	}
 }
 
@@ -269,11 +345,12 @@
 }
 
 const struct aty_dac_ops aty_dac_ct = {
-	.set_dac	= (void *) dummy,
+	set_dac: (void *)dummy,
 };
 
 const struct aty_pll_ops aty_pll_ct = {
-	.var_to_pll	= aty_var_to_pll_ct,
-	.pll_to_var	= aty_pll_ct_to_var,
-	.set_pll	= aty_set_pll_ct,
+	var_to_pll: aty_var_to_pll_ct,
+	pll_to_var: aty_pll_ct_to_var,
+	set_pll:    aty_set_pll_ct,
+	init_pll:   aty_init_pll_ct
 };
diff -u -r /usr/src/linux-2.5.orig/drivers/video/aty/mach64_cursor.c /usr/src/linux-2.5.XX/drivers/video/aty/mach64_cursor.c
--- /usr/src/linux-2.5.orig/drivers/video/aty/mach64_cursor.c	2003-01-02 04:23:09.000000000 +0100
+++ /usr/src/linux-2.5.XX/drivers/video/aty/mach64_cursor.c	2003-01-17 18:40:50.000000000 +0100
@@ -135,6 +135,10 @@
 			yoff = 0;
 		}
 
+		/* In doublescan mode, the cursor location also needs to be
+		   doubled. */
+                if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
+			y<<=1;
 		wait_for_fifo(4, par);
 		aty_st_le32(CUR_OFFSET, (info->fix.smem_len >> 3) + (yoff << 1),
 			    par);
diff -u -r /usr/src/linux-2.5.orig/drivers/video/aty/mach64_gx.c /usr/src/linux-2.5.XX/drivers/video/aty/mach64_gx.c
--- /usr/src/linux-2.5.orig/drivers/video/aty/mach64_gx.c	2003-01-02 04:21:12.000000000 +0100
+++ /usr/src/linux-2.5.XX/drivers/video/aty/mach64_gx.c	2003-01-17 19:04:58.000000000 +0100
@@ -5,7 +5,6 @@
 
 #include <linux/delay.h>
 #include <linux/fb.h>
-#include <linux/sched.h>
 
 #include <asm/io.h>
 
@@ -35,7 +34,11 @@
 #define MIN_N		35
 #define MAX_N		255-8
 
-
+static int dummy(void)
+{
+	return 0;
+}
+    
     /*
      *  Support Functions
      */
@@ -189,13 +192,14 @@
 }
 
 const struct aty_dac_ops aty_dac_ibm514 = {
-	.set_dac	= aty_set_dac_514,
+	set_dac:	aty_set_dac_514,
 };
 
 const struct aty_pll_ops aty_pll_ibm514 = {
-	.var_to_pll	= aty_var_to_pll_514,
-	.pll_to_var	= aty_pll_514_to_var,
-	.set_pll	= aty_set_pll_514,
+	var_to_pll:	aty_var_to_pll_514,
+	pll_to_var:	aty_pll_514_to_var,
+	set_pll:	aty_set_pll_514,
+	init_pll:	(void *) dummy
 };
 
 
@@ -278,7 +282,7 @@
 }
 
 const struct aty_dac_ops aty_dac_ati68860b = {
-	.set_dac	= aty_set_dac_ATI68860_B,
+	set_dac:	aty_set_dac_ATI68860_B,
 };
 
 
@@ -331,7 +335,7 @@
 }
 
 const struct aty_dac_ops aty_dac_att21c498 = {
-	.set_dac	= aty_set_dac_ATT21C498,
+	set_dac:	aty_set_dac_ATT21C498,
 };
 
 
@@ -485,9 +489,10 @@
 }
 
 const struct aty_pll_ops aty_pll_ati18818_1 = {
-	.var_to_pll	= aty_var_to_pll_18818,
-	.pll_to_var	= aty_pll_18818_to_var,
-	.set_pll	= aty_set_pll18818,
+	var_to_pll:	aty_var_to_pll_18818,
+	pll_to_var:	aty_pll_18818_to_var,
+	set_pll:	aty_set_pll18818,
+	init_pll:	(void *) dummy
 };
 
 
@@ -601,9 +606,10 @@
 }
 
 const struct aty_pll_ops aty_pll_stg1703 = {
-	.var_to_pll	= aty_var_to_pll_1703,
-	.pll_to_var	= aty_pll_1703_to_var,
-	.set_pll	= aty_set_pll_1703,
+	var_to_pll:	aty_var_to_pll_1703,
+	pll_to_var:	aty_pll_1703_to_var,
+	set_pll:	aty_set_pll_1703,
+	init_pll:	(void *) dummy
 };
 
 
@@ -725,9 +731,10 @@
 }
 
 const struct aty_pll_ops aty_pll_ch8398 = {
-	.var_to_pll	= aty_var_to_pll_8398,
-	.pll_to_var	= aty_pll_8398_to_var,
-	.set_pll	= aty_set_pll_8398,
+	var_to_pll:	aty_var_to_pll_8398,
+	pll_to_var:	aty_pll_8398_to_var,
+	set_pll:	aty_set_pll_8398,
+	init_pll:	(void *) dummy
 };
 
 
@@ -872,9 +879,10 @@
 }
 
 const struct aty_pll_ops aty_pll_att20c408 = {
-	.var_to_pll	= aty_var_to_pll_408,
-	.pll_to_var	= aty_pll_408_to_var,
-	.set_pll	= aty_set_pll_408,
+	var_to_pll:	aty_var_to_pll_408,
+	pll_to_var:	aty_pll_408_to_var,
+	set_pll:	aty_set_pll_408,
+	init_pll:	(void *) dummy
 };
 
 
@@ -896,17 +904,13 @@
 	return 0;
 }
 
-static int dummy(void)
-{
-	return 0;
-}
-
 const struct aty_dac_ops aty_dac_unsupported = {
-	.set_dac	= aty_set_dac_unsupported,
+	set_dac:	aty_set_dac_unsupported,
 };
 
 const struct aty_pll_ops aty_pll_unsupported = {
-	.var_to_pll	= (void *) dummy,
-	.pll_to_var	= (void *) dummy,
-	.set_pll	= (void *) dummy,
+	var_to_pll:	(void *) dummy,
+	pll_to_var:	(void *) dummy,
+	set_pll:	(void *) dummy,
+	init_pll:	(void *) dummy
 };
diff -u -r /usr/src/linux-2.5.orig/drivers/video/modedb.c /usr/src/linux-2.5.XX/drivers/video/modedb.c
--- /usr/src/linux-2.5.orig/drivers/video/modedb.c	2003-01-02 04:21:55.000000000 +0100
+++ /usr/src/linux-2.5.XX/drivers/video/modedb.c	2003-01-17 18:33:32.000000000 +0100
@@ -129,6 +129,14 @@
 	NULL, 68, 1400, 1050, 9259, 136, 40, 13, 1, 112, 3,
 	0, FB_VMODE_NONINTERLACED   	
     }, {
+	/* 1400x1050 @ 75,107 Hz, 82,392 kHz +hsync +vsync*/
+	"LCD_XGA_75", 75, 1400, 1050, 9271, 120, 56, 13, 0, 112, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }, {
+	/* 1400x1050 @ 60 Hz, ? kHz +hsync +vsync*/
+	"LCD_XGA_60", 60, 1400, 1050, 9259, 128, 40, 12, 0, 112, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }, {
 	/* 1024x768 @ 85 Hz, 70.24 kHz hsync */
 	NULL, 85, 1024, 768, 10111, 192, 32, 34, 14, 160, 6,
 	0, FB_VMODE_NONINTERLACED

--------------Boundary-00=_TLNVGRMVAHFCCZTS6RBS--



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
