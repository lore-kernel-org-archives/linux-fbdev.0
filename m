From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH] 2.4.21-pre3 for ATI Mach64(99% Work from Daniel Mantione)
Date: Fri, 17 Jan 2003 22:27:31 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200301172227.31692.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_VLNVWB7NYNR7EONF8M0R"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Ze2M-0008CK-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Jan 2003 13:28:26 -0800
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


--------------Boundary-00=_VLNVWB7NYNR7EONF8M0R
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, patch to 2.4.21-pre3, tested with ATI RAGE 3D MOBILITY M1 (P/M). Alls=
=20
resolutions work.


--------------Boundary-00=_VLNVWB7NYNR7EONF8M0R
Content-Type: text/x-diff;
  charset="us-ascii";
  name="aty_rage_mobility.2.4.21-pre3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="aty_rage_mobility.2.4.21-pre3.patch"

diff -r -u /usr/src/linux-2.4.20.orig/drivers/video/Config.in /usr/src/linux-2.4.XX/drivers/video/Config.in
--- /usr/src/linux-2.4.20.orig/drivers/video/Config.in	2002-11-29 00:53:15.000000000 +0100
+++ /usr/src/linux-2.4.XX/drivers/video/Config.in	2002-12-30 11:51:45.000000000 +0100
@@ -138,6 +138,9 @@
 	 if [ "$CONFIG_FB_ATY" != "n" ]; then
 	    bool '    Mach64 GX support (EXPERIMENTAL)' CONFIG_FB_ATY_GX
 	    bool '    Mach64 CT/VT/GT/LT (incl. 3D RAGE) support' CONFIG_FB_ATY_CT
+	    if [ "$CONFIG_FB_ATY_CT" != "n" ]; then
+	       bool '      generic LCD support (EXPERIMENTAL)' CONFIG_FB_ATY_GENERIC_LCD  
+	    fi
 	 fi
  	 tristate '  ATI Radeon display support (EXPERIMENTAL)' CONFIG_FB_RADEON
 	 tristate '  ATI Rage128 display support (EXPERIMENTAL)' CONFIG_FB_ATY128
diff -r -u /usr/src/linux-2.4.20.orig/drivers/video/aty/atyfb.h /usr/src/linux-2.4.XX/drivers/video/aty/atyfb.h
--- /usr/src/linux-2.4.20.orig/drivers/video/aty/atyfb.h	2002-11-29 00:53:15.000000000 +0100
+++ /usr/src/linux-2.4.XX/drivers/video/aty/atyfb.h	2002-12-23 23:04:05.000000000 +0100
@@ -5,7 +5,6 @@
 
 #include <linux/config.h>
 
-
     /*
      *  Elements of the hardware specific atyfb_par structure
      */
@@ -24,6 +23,11 @@
     u32 gen_cntl;
     u32 dp_pix_width;	/* acceleration */
     u32 dp_chain_mask;	/* acceleration */
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+    u32 monitors_enabled; /* LCD monitor support */
+    u16 h_stretching;     /* LCD monitor support */
+    u16 v_stretching;     /* LCD monitor support */
+#endif
 };
 
 struct pll_514 {
@@ -40,16 +44,17 @@
 };
 
 struct pll_ct {
-    u8 pll_ref_div;
-    u8 pll_gen_cntl;
-    u8 mclk_fb_div;
+//    u8 pll_ref_div;
+//    u8 pll_gen_cntl;
+//    u8 mclk_fb_div;
     u8 pll_vclk_cntl;
     u8 vclk_post_div;
     u8 vclk_fb_div;
-    u8 pll_ext_cntl;
+//    u8 alt_post_div;
+//    u8 pll_ext_cntl;
     u32 dsp_config;	/* Mach64 GTB DSP */
     u32 dsp_on_off;	/* Mach64 GTB DSP */
-    u8 mclk_post_div_real;
+//    u8 mclk_post_div_real;
     u8 vclk_post_div_real;
 };
 
@@ -93,7 +98,38 @@
     unsigned long ati_regbase;
     unsigned long frame_buffer_phys;
     unsigned long frame_buffer;
-    unsigned long clk_wr_offset;
+    unsigned char clk_wr_offset;
+    unsigned char clock;
+    unsigned short reserved;
+#ifdef CONFIG_FB_ATY_CT
+    u8 pll_ref_div;
+    u8 xclk_post_div_real;
+    u16 mclk_fb_div;
+    u8 fifo_size;
+    u8 dsp_loop_latency;
+    u8 page_size;
+#endif
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+    unsigned long bios_base_phys;
+    unsigned long bios_base;
+    unsigned long lcd_table;
+    u16 lcd_width;
+    u16 lcd_height;
+    u32 lcd_pixclock;
+    u16 lcd_htotal;
+    u16 lcd_hdisp;
+    u16 lcd_hsync_start;
+    u16 lcd_hsync_delay;
+    u16 lcd_hsync_width;
+    u16 lcd_vtotal;
+    u16 lcd_vdisp;
+    u16 lcd_vsync_start;
+    u16 lcd_vsync_width;
+    u16 lcd_right;
+    u16 lcd_lower;
+    u16 lcd_hblank_width;
+    u16 lcd_vblank_width;
+#endif
     struct pci_mmap_map *mmap_map;
     struct aty_cursor *cursor;
     struct aty_cmap_regs *aty_cmap_regs;
@@ -105,6 +141,7 @@
     u32 ref_clk_per;
     u32 pll_per;
     u32 mclk_per;
+    u32 xclk_per;
     u8 bus_type;
     u8 ram_type;
     u8 mem_refresh_rate;
@@ -174,10 +211,10 @@
 {
     /* Hack for bloc 1, should be cleanly optimized by compiler */
     if (regindex >= 0x400)
-	regindex -= 0x800;
+    	regindex -= 0x800;
 
-#ifdef CONFIG_ATARI
-    return in_le32((volatile u32 *)(info->ati_regbase+regindex));
+#if defined(__mc68000__)
+    return le32_to_cpu(*((volatile u32 *)(info->ati_regbase+regindex)));
 #else
     return readl (info->ati_regbase + regindex);
 #endif
@@ -188,10 +225,10 @@
 {
     /* Hack for bloc 1, should be cleanly optimized by compiler */
     if (regindex >= 0x400)
-	regindex -= 0x800;
+    	regindex -= 0x800;
 
-#ifdef CONFIG_ATARI
-    out_le32 (info->ati_regbase+regindex, val);
+#if defined(__mc68000__)
+    *((volatile u32 *)(info->ati_regbase+regindex)) = cpu_to_le32(val);
 #else
     writel (val, info->ati_regbase + regindex);
 #endif
@@ -202,13 +239,9 @@
 {
     /* Hack for bloc 1, should be cleanly optimized by compiler */
     if (regindex >= 0x400)
-	regindex -= 0x800;
+    	regindex -= 0x800;
 
-#ifdef CONFIG_ATARI
-    return in_8 (info->ati_regbase + regindex);
-#else
     return readb (info->ati_regbase + regindex);
-#endif
 }
 
 static inline void aty_st_8(int regindex, u8 val,
@@ -216,13 +249,9 @@
 {
     /* Hack for bloc 1, should be cleanly optimized by compiler */
     if (regindex >= 0x400)
-	regindex -= 0x800;
+    	regindex -= 0x800;
 
-#ifdef CONFIG_ATARI
-    out_8 (info->ati_regbase + regindex, val);
-#else
     writeb (val, info->ati_regbase + regindex);
-#endif
 }
 
 static inline u8 aty_ld_pll(int offset, const struct fb_info_aty *info)
@@ -259,10 +288,11 @@
 
 struct aty_pll_ops {
     int (*var_to_pll)(const struct fb_info_aty *info, u32 vclk_per, u8 bpp,
-		      union aty_pll *pll);
+		      u32 xres, union aty_pll *pll);
     u32 (*pll_to_var)(const struct fb_info_aty *info,
 	    	      const union aty_pll *pll);
     void (*set_pll)(const struct fb_info_aty *info, const union aty_pll *pll);
+    void (*init_pll)(struct fb_info_aty *info);
 };
 
 extern const struct aty_pll_ops aty_pll_ati18818_1;	/* ATI 18818 */
@@ -276,8 +306,8 @@
 
 extern void aty_set_pll_ct(const struct fb_info_aty *info,
 			   const union aty_pll *pll);
-extern void aty_calc_pll_ct(const struct fb_info_aty *info,
-			    struct pll_ct *pll);
+//extern void aty_calc_pll_ct(const struct fb_info_aty *info,
+//			    struct pll_ct *pll);
 
 
     /*
diff -r -u /usr/src/linux-2.4.20.orig/drivers/video/aty/atyfb_base.c /usr/src/linux-2.4.XX/drivers/video/aty/atyfb_base.c
--- /usr/src/linux-2.4.20.orig/drivers/video/aty/atyfb_base.c	2002-11-29 00:53:15.000000000 +0100
+++ /usr/src/linux-2.4.XX/drivers/video/aty/atyfb_base.c	2002-12-30 11:53:22.000000000 +0100
@@ -1,4 +1,3 @@
-
 /*
  *  ATI Frame Buffer Device Driver Core
  *
@@ -25,6 +24,8 @@
  *			   Harry AC Eaton
  *			   Anthony Tong <atong@uiuc.edu>
  *
+ *  Generic LCD support written by Daniel Mantione
+ *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
  *  more details.
@@ -105,7 +106,8 @@
 /*
  * Debug flags.
  */
-#undef DEBUG
+/* #undef DEBUG */
+#define DEBUG
 
 /* Make sure n * PAGE_SIZE is protected at end of Aperture for GUI-regs */
 /*  - must be large enough to catch all GUI-Regs   */
@@ -116,7 +118,6 @@
 /* FIXME: remove the FAIL definition */
 #define FAIL(x) do { printk(x "\n"); return -EINVAL; } while (0)
 
-
     /*
      *  The Hardware parameters for each card
      */
@@ -188,7 +189,7 @@
 			 const struct crtc *crtc);
 static int aty_var_to_crtc(const struct fb_info_aty *info,
 			   const struct fb_var_screeninfo *var,
-			   struct crtc *crtc);
+			   struct crtc *crtc, u32 *monitors_enabled);
 static int aty_crtc_to_var(const struct crtc *crtc,
 			   struct fb_var_screeninfo *var);
 
@@ -196,7 +197,8 @@
 			  struct fb_info_aty *info);
 static int atyfb_decode_var(const struct fb_var_screeninfo *var,
 			    struct atyfb_par *par,
-			    const struct fb_info_aty *info);
+			    const struct fb_info_aty *info,
+			    u32 monitors_enabled);
 static int atyfb_encode_var(struct fb_var_screeninfo *var,
 			    const struct atyfb_par *par,
 			    const struct fb_info_aty *info);
@@ -252,6 +254,7 @@
 static u32 default_vram __initdata = 0;
 static int default_pll __initdata = 0;
 static int default_mclk __initdata = 0;
+static int default_xclk __initdata = 0;
 
 #ifndef MODULE
 static char *mode_option __initdata = NULL;
@@ -300,73 +303,72 @@
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
-    int pll, mclk;
+    int pll, mclk, xclk;
     u32 features;
 } aty_chips[] __initdata = {
 #ifdef CONFIG_FB_ATY_GX
     /* Mach64 GX */
-    { 0x4758, 0x00d7, 0x00, 0x00, m64n_gx,      135,  50, M64F_GX },
-    { 0x4358, 0x0057, 0x00, 0x00, m64n_cx,      135,  50, M64F_GX },
+    { 0x4758, 0x00d7, 0x00, 0x00, m64n_gx,      135,  50,  50, M64F_GX },
+    { 0x4358, 0x0057, 0x00, 0x00, m64n_cx,      135,  50,  50, M64F_GX },
 #endif /* CONFIG_FB_ATY_GX */
 
 #ifdef CONFIG_FB_ATY_CT
     /* Mach64 CT */
-    { 0x4354, 0x4354, 0x00, 0x00, m64n_ct,      135,  60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
-    { 0x4554, 0x4554, 0x00, 0x00, m64n_et,      135,  60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
+    { 0x4354, 0x4354, 0x00, 0x00, m64n_ct,      135,  60,  60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
+    { 0x4554, 0x4554, 0x00, 0x00, m64n_et,      135,  60,  60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
 
     /* Mach64 VT */
-    { 0x5654, 0x5654, 0xc7, 0x00, m64n_vta3,    170,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 },
-    { 0x5654, 0x5654, 0xc7, 0x40, m64n_vta4,    200,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_MAGIC_POSTDIV },
-    { 0x5654, 0x5654, 0x00, 0x00, m64n_vtb,     200,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 },
-    { 0x5655, 0x5655, 0x00, 0x00, m64n_vtb,     200,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL },
-    { 0x5656, 0x5656, 0x00, 0x00, m64n_vt4,     230,  83, M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP },
+    { 0x5654, 0x5654, 0xc7, 0x00, m64n_vta3,    170,  67,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 },
+    { 0x5654, 0x5654, 0xc7, 0x40, m64n_vta4,    200,  67,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_MAGIC_POSTDIV },
+    { 0x5654, 0x5654, 0x00, 0x00, m64n_vtb,     200,  67,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 },
+    { 0x5655, 0x5655, 0x00, 0x00, m64n_vtb,     200,  67,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL },
+    { 0x5656, 0x5656, 0x00, 0x00, m64n_vt4,     230,  83,  83, M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP },
 
     /* Mach64 GT (3D RAGE) */
-    { 0x4754, 0x4754, 0x07, 0x00, m64n_gt,      135,  63, M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT },
-    { 0x4754, 0x4754, 0x07, 0x01, m64n_gt,      170,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4754, 0x4754, 0x07, 0x02, m64n_gt,      200,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4755, 0x4755, 0x00, 0x00, m64n_gtb,     200,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4756, 0x4756, 0x00, 0x00, m64n_iic_p,   230,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4757, 0x4757, 0x00, 0x00, m64n_iic_a,   230,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x475a, 0x475a, 0x00, 0x00, m64n_iic_a,   230,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4754, 0x4754, 0x07, 0x00, m64n_gt,      135,  63,  63, M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT },
+    { 0x4754, 0x4754, 0x07, 0x01, m64n_gt,      170,  67,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4754, 0x4754, 0x07, 0x02, m64n_gt,      200,  67,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4755, 0x4755, 0x00, 0x00, m64n_gtb,     200,  67,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4756, 0x4756, 0x00, 0x00, m64n_iic_p,   230,  83,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4757, 0x4757, 0x00, 0x00, m64n_iic_a,   230,  83,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x475a, 0x475a, 0x00, 0x00, m64n_iic_a,   230,  83,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 
     /* Mach64 LT */
-    { 0x4c54, 0x4c54, 0x00, 0x00, m64n_lt,      135,  63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP },
-    { 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg,     230,  63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },
+    { 0x4c54, 0x4c54, 0x00, 0x00, m64n_lt,      135,  63,  63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP },
+    { 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg,     230,  63,  63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },
 
     /* Mach64 GTC (3D RAGE PRO) */
-    { 0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba,  230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4744, 0x4744, 0x00, 0x00, m64n_gtc_ba1, 230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4749, 0x4749, 0x00, 0x00, m64n_gtc_bp,  230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_MAGIC_VRAM_SIZE },
-    { 0x4750, 0x4750, 0x00, 0x00, m64n_gtc_pp,  230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4751, 0x4751, 0x00, 0x00, m64n_gtc_ppl, 230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba,  230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4744, 0x4744, 0x00, 0x00, m64n_gtc_ba1, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4749, 0x4749, 0x00, 0x00, m64n_gtc_bp,  230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_MAGIC_VRAM_SIZE },
+    { 0x4750, 0x4750, 0x00, 0x00, m64n_gtc_pp,  230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4751, 0x4751, 0x00, 0x00, m64n_gtc_ppl, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 
     /* 3D RAGE XL */
-    { 0x4752, 0x4752, 0x00, 0x00, m64n_xl, 230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL },
+    { 0x4752, 0x4752, 0x00, 0x00, m64n_xl,      235,  83,  63, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL },
 
     /* Mach64 LT PRO */
-    { 0x4c42, 0x4c42, 0x00, 0x00, m64n_ltp_a,   230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
-    { 0x4c44, 0x4c44, 0x00, 0x00, m64n_ltp_p,   230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
-    { 0x4c49, 0x4c49, 0x00, 0x00, m64n_ltp_p,   230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
-    { 0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p,   230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
+    { 0x4c42, 0x4c42, 0x00, 0x00, m64n_ltp_a,   236,  75, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT},
+    { 0x4c44, 0x4c44, 0x00, 0x00, m64n_ltp_p,   230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT},
+    { 0x4c49, 0x4c49, 0x00, 0x00, m64n_ltp_p,   230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
+    { 0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p,   230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT},
 
     /* 3D RAGE Mobility */
-    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   230,  50, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
-    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230,  50, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
+    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   230,  83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_XL_DLL | M64F_EXTRA_BRIGHT },
+    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230,  83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
 #endif /* CONFIG_FB_ATY_CT */
 };
 
 #if defined(CONFIG_FB_ATY_GX) || defined(CONFIG_FB_ATY_CT)
 static char ram_dram[] __initdata = "DRAM";
-static char ram_resv[] __initdata = "RESV";
 #endif /* CONFIG_FB_ATY_GX || CONFIG_FB_ATY_CT */
 
 #ifdef CONFIG_FB_ATY_GX
@@ -379,6 +381,7 @@
 static char ram_sgram[] __initdata = "SGRAM";
 static char ram_wram[] __initdata = "WRAM";
 static char ram_off[] __initdata = "OFF";
+static char ram_resv[] __initdata = "RESV";
 #endif /* CONFIG_FB_ATY_CT */
 
 #ifdef CONFIG_FB_ATY_GX
@@ -438,7 +441,7 @@
 
 #endif /* defined(CONFIG_PPC) */
 
-#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_PMAC_BACKLIGHT)
+#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
 static void aty_st_lcd(int index, u32 val, const struct fb_info_aty *info)
 {
     unsigned long temp;
@@ -460,7 +463,7 @@
     /* read the register value */
     return aty_ld_le32(LCD_DATA, info);
 }
-#endif /* CONFIG_PMAC_PBOOK || CONFIG_PMAC_BACKLIGHT */
+#endif /* CONFIG_PMAC_PBOOK || CONFIG_PMAC_BACKLIGHT || CONFIG_FB_ATY_GENERIC_LCD*/
 
 /* ------------------------------------------------------------------------- */
 
@@ -471,6 +474,8 @@
 static void aty_set_crtc(const struct fb_info_aty *info,
 			 const struct crtc *crtc)
 {
+    u32 v;
+    
     aty_st_le32(CRTC_H_TOTAL_DISP, crtc->h_tot_disp, info);
     aty_st_le32(CRTC_H_SYNC_STRT_WID, crtc->h_sync_strt_wid, info);
     aty_st_le32(CRTC_V_TOTAL_DISP, crtc->v_tot_disp, info);
@@ -478,21 +483,83 @@
     aty_st_le32(CRTC_VLINE_CRNT_VLINE, 0, info);
     aty_st_le32(CRTC_OFF_PITCH, crtc->off_pitch, info);
     aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl, info);
+#ifdef DEBUG
+    printk(KERN_INFO "Setting up CRTC\n");
+    printk(KERN_INFO "CRTC_GEN_CNTL: %x\n",crtc->gen_cntl);
+    printk(KERN_INFO "CRTC_H_TOTAL_DISP: %x\n",crtc->h_tot_disp);
+    printk(KERN_INFO "CRTC_H_SYNC_STRT_WID: %x\n",crtc->h_sync_strt_wid);
+    printk(KERN_INFO "CRTC_V_TOTAL_DISP: %x\n",crtc->v_tot_disp);
+    printk(KERN_INFO "CRTC_V_SYNC_STRT_WID: %x\n",crtc->v_sync_strt_wid);
+#endif
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+    /* After setting the CRTC registers we should set the LCD
+       registers.
+     */
+    if (info->lcd_table != 0) {
+        /* Enable/disable horizontal stretching */
+        v = aty_ld_lcd(HORZ_STRETCHING, info);
+	v = v & ~(HORZ_STRETCH_RATIO | HORZ_STRETCH_EN | AUTO_HORZ_RATIO);
+	v = v | HORZ_STRETCH_MODE; /* Use interpolation instead of duplication. */
+	if (crtc->h_stretching != 0)
+	    v = v | HORZ_STRETCH_EN | crtc->h_stretching;
+        aty_st_lcd(HORZ_STRETCHING, v, info);
+#ifdef DEBUG
+	printk(KERN_INFO "HORZ_STRETCHING: %x\n", v);
+#endif
+
+        /* Enable/disable vertital stretching */
+        v = aty_ld_lcd(VERT_STRETCHING, info);
+	v = v & ~(VERT_STRETCH_RATIO0 | VERT_STRETCH_EN);
+	v = v | VERT_STRETCH_USE0; /* Use VERT_STRETCH_RATIO0. */
+	if (crtc->v_stretching != 0)
+	    v = v | VERT_STRETCH_EN | crtc->v_stretching;
+        aty_st_lcd(VERT_STRETCHING, v, info);
+#ifdef DEBUG
+	printk(KERN_INFO "VERT_STRETCHING: %x\n", v);
+#endif
+	v = aty_ld_lcd(EXT_VERT_STRETCH, info);
+	v = v & ~AUTO_VERT_RATIO;  /* Forbit the chip to guess the vertical
+	                              expansion (used for vga compatibility) */
+	v = v | VERT_STRETCH_MODE; /* Use interpolation instead of duplication. */
+	aty_st_lcd(EXT_VERT_STRETCH, v, info);
+#ifdef DEBUG
+	printk(KERN_INFO "EXT_VERT_STRETCH: %x\n", v);
+#endif
+
+        /* Don't use shadowing. Don't divide the horizontal paramters.
+	   (VGA compatibility junk that might be enabled.)
+           Enable only the monitors that were enabled before we switched the
+           video mode.
+         */
+        v = aty_ld_lcd(LCD_GEN_CTRL, info);
+        v = v & ~(HORZ_DIVBY2_EN | SCLK_SEL | USE_SHADOWED_VEND | SHADOW_EN |
+                  LCD_ON | CRT_ON);
+        v = v | DONT_SHADOW_VPAR | crtc->monitors_enabled;
+        aty_st_lcd(LCD_GEN_CTRL, v, info);
+#ifdef DEBUG
+	printk(KERN_INFO "LCD_GEN_CTRL: %x\n", v);
+#endif
+    };
+#endif
 }
 
 static int aty_var_to_crtc(const struct fb_info_aty *info,
 			   const struct fb_var_screeninfo *var,
-			   struct crtc *crtc)
+			   struct crtc *crtc, u32 *monitors_enabled)
 {
-    u32 xres, yres, vxres, vyres, xoffset, yoffset, bpp;
+    u32 xres, yres, ryres, vxres, vyres, xoffset, yoffset, bpp;
     u32 left, right, upper, lower, hslen, vslen, sync, vmode;
     u32 h_total, h_disp, h_sync_strt, h_sync_dly, h_sync_wid, h_sync_pol;
     u32 v_total, v_disp, v_sync_strt, v_sync_wid, v_sync_pol, c_sync;
     u32 pix_width, dp_pix_width, dp_chain_mask;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+    u32 lcd_hsync_start,lcd_htotal,lcd_vsync_start,lcd_vtotal;
+#endif
 
     /* input */
     xres = var->xres;
     yres = var->yres;
+    ryres = yres;
     vxres = var->xres_virtual;
     vyres = var->yres_virtual;
     xoffset = var->xoffset;
@@ -501,6 +568,7 @@
     left = var->left_margin;
     right = var->right_margin;
     upper = var->upper_margin;
+    
     lower = var->lower_margin;
     hslen = var->hsync_len;
     vslen = var->vsync_len;
@@ -543,7 +611,19 @@
     if (v_total > 0x7ff)
 	FAIL("v_total too large");
     v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
-
+    /* In double scan mode, the vertical parameters need to be doubled.
+       But in interlaced mode, there is no need to half the vertical parameters.
+       Code has been tested in 1024x768, 43 Hz interlaced and 640x480, 60 Hz
+       double scan.
+     */
+   if ((vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
+       ryres <<= 1;
+       v_total <<= 1;
+       v_disp <<= 1;
+       v_sync_strt <<= 1;
+       v_sync_wid <<= 1;
+   };
+							   
     c_sync = sync & FB_SYNC_COMP_HIGH_ACT ? CRTC_CSYNC_EN : 0;
 
     if (bpp <= 8) {
@@ -574,8 +654,8 @@
     if (vxres*vyres*bpp/8 > info->total_vram)
 	FAIL("not enough video RAM");
 
-    if ((vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
-	FAIL("invalid vmode");
+//    if ((vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
+//	FAIL("invalid vmode");
 
     /* output */
     crtc->vxres = vxres;
@@ -583,14 +663,93 @@
     crtc->xoffset = xoffset;
     crtc->yoffset = yoffset;
     crtc->bpp = bpp;
-    crtc->h_tot_disp = h_total | (h_disp<<16);
-    crtc->h_sync_strt_wid = (h_sync_strt & 0xff) | (h_sync_dly<<8) |
-			    ((h_sync_strt & 0x100)<<4) | (h_sync_wid<<16) |
-			    (h_sync_pol<<21);
-    crtc->v_tot_disp = v_total | (v_disp<<16);
-    crtc->v_sync_strt_wid = v_sync_strt | (v_sync_wid<<16) | (v_sync_pol<<21);
     crtc->off_pitch = ((yoffset*vxres+xoffset)*bpp/64) | (vxres<<19);
     crtc->gen_cntl = pix_width | c_sync | CRTC_EXT_DISP_EN | CRTC_ENABLE;
+    /* Enable doublescan mode if requested */
+    if ((vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE)
+        crtc->gen_cntl|=CRTC_DBL_SCAN_EN;
+    /* Enable interlaced mode if requested */
+    if ((vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED)
+        crtc->gen_cntl|=CRTC_INTERLACE_EN;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+    /* We can only program the real mode parameters to the CRTC
+       if the LCD monitor is switched off. Otherwise we will have to
+       use the parameters the LCD monitor prefers, effectively setting
+       a completely different mode which simulates the requested 
+       video mode.
+     */
+    if ((info->lcd_table != 0) && ((*monitors_enabled & LCD_ON) != 0) && 
+        ((xres > info->lcd_width) || (ryres > info->lcd_height))
+       ) {
+	/* We cannot display the mode on the LCD. If the CRT is enabled
+	   we can turn off the LCD.
+	   If the CRT is off, it isn't a good idea to switch it on; we don't
+	   know if one is connected. So it's better to fail then.
+	 */
+	if (*monitors_enabled & CRT_ON) {
+	    printk(KERN_INFO "Disabling lcd monitor because video mode does not fit.\n");
+	    *monitors_enabled = *monitors_enabled & (~LCD_ON);
+	} else
+	    FAIL("Video mode exceeds size of lcd monitor.\nConnect this computer to a conventional monitor if you really need this mode.");
+    };
+    if ((info->lcd_table == 0) || ((*monitors_enabled & LCD_ON) == 0)) {
+#endif
+        crtc->h_tot_disp = h_total | (h_disp<<16);
+	crtc->h_sync_strt_wid = (h_sync_strt & 0xff) | (h_sync_dly<<8) |
+				((h_sync_strt & 0x100)<<4) | (h_sync_wid<<16) |
+				(h_sync_pol<<21);
+	crtc->v_tot_disp = v_total | (v_disp<<16);
+	crtc->v_sync_strt_wid = v_sync_strt | (v_sync_wid<<16) | (v_sync_pol<<21);
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	/* No hardware stretching please! */
+	crtc->h_stretching = 0;
+	crtc->v_stretching = 0;
+    } else {
+	/* This is horror! When we simulate, say 640x480 on an 800x600
+	   lcd monitor, the CRTC should be programmed 800x600 values for
+	   the non visible part, but 640x480 for the visible part.
+	   This code has been tested on a laptop with it's 800x600 lcd
+	   monitor and a conventional monitor both switched on.
+	   Tested modes: 640x400, 720x400, 800x600, 320x200-doublescan,
+	                 800x600-interlaced
+	 */
+	lcd_htotal = h_disp + info->lcd_hblank_width;
+	lcd_hsync_start = h_disp + info->lcd_right;
+	lcd_vtotal = v_disp + info->lcd_vblank_width;
+	lcd_vsync_start = v_disp + info->lcd_lower;
+	
+        crtc->h_tot_disp = (lcd_htotal) | (h_disp<<16);
+	crtc->h_sync_strt_wid = (lcd_hsync_start & 0xff) |
+				(info->lcd_hsync_delay<<8) |
+				((lcd_hsync_start & 0x100)<<4) |
+				(info->lcd_hsync_width<<16);
+	crtc->v_tot_disp = lcd_vtotal | (v_disp<<16);
+	crtc->v_sync_strt_wid = lcd_vsync_start |
+				(info->lcd_vsync_width<<16);
+	/* To simulate the requested video mode, we use the hardware stretcher,
+	   which zooms the image to the dimensions of the LCD screen. It has
+	   two modes; replication and blending. Replication duplicates some
+	   pixels, blending interpolates between pixels. We use blending.
+	   The formula for blending is:
+	      h_stretching=(source_with/dest_width)*4096
+	      v_stretching=(source_lines/dest_lines)*1024
+	 */
+	if (xres != info->lcd_width)
+	    crtc->h_stretching = (xres*4096)/info->lcd_width;
+	else
+	    crtc->h_stretching = 0;
+	if (ryres != info->lcd_height)
+	    crtc->v_stretching = (ryres*1024)/info->lcd_height;
+	else
+	    crtc->v_stretching = 0;
+	/* The prefered mode for the lcd is not interlaced, so disable it if
+	   it was enabled. For doublescan there is no problem, because we can
+	   compensate for it in the hardware stretching (we stretch half as much)
+	 */
+        crtc->gen_cntl&=~CRTC_INTERLACE_EN;
+    };
+    crtc->monitors_enabled = *monitors_enabled;
+#endif
     if (M64_HAS(MAGIC_FIFO)) {
 	/* Not VTB/GTB */
 	/* FIXME: magic FIFO values */
@@ -610,7 +769,8 @@
     u32 h_total, h_disp, h_sync_strt, h_sync_dly, h_sync_wid, h_sync_pol;
     u32 v_total, v_disp, v_sync_strt, v_sync_wid, v_sync_pol, c_sync;
     u32 pix_width;
-
+    u32 double_scan, interlace;
+	    
     /* input */
     h_total = crtc->h_tot_disp & 0x1ff;
     h_disp = (crtc->h_tot_disp>>16) & 0xff;
@@ -626,7 +786,9 @@
     v_sync_pol = (crtc->v_sync_strt_wid>>21) & 0x1;
     c_sync = crtc->gen_cntl & CRTC_CSYNC_EN ? 1 : 0;
     pix_width = crtc->gen_cntl & CRTC_PIX_WIDTH_MASK;
-
+    double_scan = crtc->gen_cntl & CRTC_DBL_SCAN_EN;
+    interlace = crtc->gen_cntl & CRTC_INTERLACE_EN;
+		
     /* convert */
     xres = (h_disp+1)*8;
     yres = v_disp+1;
@@ -731,7 +893,23 @@
     var->vsync_len = vslen;
     var->sync = sync;
     var->vmode = FB_VMODE_NONINTERLACED;
-
+    /* In double scan mode, the vertical parameters are doubled, so we need to
+       half them to get the right values.
+       In interlaced mode the values are already correct, so no correction is
+       necessary.
+       Code has been tested in 1024x768, 43 Hz interlaced and 640x480, 60 Hz
+       doublesscan.
+    */
+    if (interlace)
+	var->vmode = FB_VMODE_INTERLACED;
+    if (double_scan) {
+        var->vmode = FB_VMODE_DOUBLE;
+	var->yres>>=1;
+	var->upper_margin>>=1;
+	var->lower_margin>>=1;
+	var->vsync_len>>=1;
+    };
+				    
     return 0;
 }
 
@@ -752,9 +930,16 @@
 	wait_for_idle(info);
     tmp = aty_ld_8(CRTC_GEN_CNTL + 3, info);
     aty_set_crtc(info, &par->crtc);
-    aty_st_8(CLOCK_CNTL + info->clk_wr_offset, 0, info);
-					/* better call aty_StrobeClock ?? */
-    aty_st_8(CLOCK_CNTL + info->clk_wr_offset, CLOCK_STROBE, info);
+
+    aty_st_8(CLOCK_CNTL, 0, info);
+#if 1
+    aty_st_8(CLOCK_CNTL, CLOCK_STROBE | CLOCK_DIV, info);
+#else
+    if (M64_HAS(MOBIL_BUS)&&M64_HAS(XL_DLL))
+	aty_st_8(CLOCK_CNTL + info->clk_wr_offset, CLOCK_STROBE | CLOCK_DIV | (info->clock & CLOCK_SEL), info);
+    else
+	aty_st_8(CLOCK_CNTL + info->clk_wr_offset, CLOCK_STROBE, info);
+#endif
 
     info->dac_ops->set_dac(info, &par->pll, par->crtc.bpp, accelmode);
     info->pll_ops->set_pll(info, &par->pll);
@@ -845,13 +1030,31 @@
 
 static int atyfb_decode_var(const struct fb_var_screeninfo *var,
 			    struct atyfb_par *par,
-			    const struct fb_info_aty *info)
+			    const struct fb_info_aty *info,
+			    u32 monitors_enabled)
 {
     int err;
+    u32 pixclock,xres;
 
-    if ((err = aty_var_to_crtc(info, var, &par->crtc)) ||
-	(err = info->pll_ops->var_to_pll(info, var->pixclock, par->crtc.bpp,
-		    			 &par->pll)))
+    err = aty_var_to_crtc(info, var, &par->crtc, &monitors_enabled);
+    if (err == 0) {
+	/* Alert! aty_var_to_crtc can modify monitors_enabled which is
+	   important for the pixclock decision */
+        pixclock = var->pixclock;
+	xres = 0;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if ((info->lcd_table != 0) && ((monitors_enabled & LCD_ON) != 0)) {
+	    pixclock = info->lcd_pixclock;
+	    xres = var->xres;
+	};
+#endif
+	if (pixclock == 0) {
+	    FAIL("Invalid pixclock");
+	} else
+	err = info->pll_ops->var_to_pll(info, pixclock, par->crtc.bpp, xres,
+					&par->pll);
+    };
+    if (err != 0)
 	return err;
 
     if (var->accel_flags & FB_ACCELF_TEXT)
@@ -860,7 +1063,7 @@
 	par->accel_flags = 0;
 
 #if 0 /* fbmon is not done. uncomment for 2.5.x -brad */
-    if (!fbmon_valid_timings(var->pixclock, htotal, vtotal, info))
+    if (!fbmon_valid_timings(pixclock, htotal, vtotal, info))
 	return -EINVAL;
 #endif
 
@@ -1035,7 +1238,10 @@
     if (con == -1)
 	par = info->default_par;
     else
-	atyfb_decode_var(&fb_display[con].var, &par, info);
+	/* The monitors_enabled information is not important for
+	   the calculation of the information in par that encode_fix
+	   needs, so we pass a 0. */
+	atyfb_decode_var(&fb_display[con].var, &par, info, 0);
     encode_fix(fix, &par, info);
     return 0;
 }
@@ -1100,6 +1306,36 @@
 #endif /* CONFIG_FB_ATY_CT */
 }
 
+    /* In the display mode set code we need to make desisions depending on
+     * wether the LCD or CRT monitor is enabled.
+     * This is going to give problems in the unlikely case that someone
+     * for example turns on the LCD monitor just after we tested what
+     * monitors are enabled. Since the consequences are very serious
+     * (the graphic card crashes and sends the wrong signals to the lcd
+     *  monitor which gets brighter and brighter; to prevent it from
+     * damage the computer must be switched off as soon as possible)
+     * we need to prevent this.
+     *
+     * As far as I know there is no way to prevent people switching on the
+     * LCD monitor while we are programming the video card. So the best way
+     * to do it, is detect what monitors are enabled before programming the
+     * video chip. After programming the video chip, we write this information
+     * back to the video chip, switching the LCD off again if someone enabled
+     * it. But isn't the card already crashed before we have the chance to
+     * turn the display back off? I don't think so because the CRTC is disabled
+     * while we program it.
+     */
+
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+static u32 atyfb_monitors_enabled(struct fb_info_aty *info) {
+     if (info->lcd_table != 0) {
+         return aty_ld_lcd(LCD_GEN_CTRL, info) & 3;
+     };
+     return 0;
+};
+#else
+#define atyfb_monitors_enabled(info) 0
+#endif
 
     /*
      *  Set the User Defined Part of the Display
@@ -1113,17 +1349,46 @@
     struct display *display;
     int oldxres, oldyres, oldvxres, oldvyres, oldbpp, oldaccel, accel, err;
     int activate = var->activate;
+    u32 monitors_enabled;
 
     if (con >= 0)
 	display = &fb_display[con];
     else
 	display = fb->disp;	/* used during initialization */
 
-    if ((err = atyfb_decode_var(var, &par, info)))
+    monitors_enabled = atyfb_monitors_enabled(info);
+
+    /*
+     * We have to be very carefull with encode_var for LCD_panels. Fbdev
+     * applications do not know about LCD monitors. We have to make them
+     * think they are using a CRT. That means that alltough the video
+     * chip is programmed for the resolution of the LCD monitor (say 800x600),
+     * the applications expect the mode they asked for, say 640x480
+     *
+     * So when a program asks for 640x480, atyfb_decode_var sets the crtc
+     * registers for 800x600. Then atyfb_encode_var calculates the crtc
+     * registers back into the var variable, but now the var variable
+     * will contain wrong values for 800x600! Result: wrong information is
+     * returned to the program!
+     *
+     * To counter this, we call atyfb_decode_var first like if there is no
+     * lcd monitor switched on. Then we call atyfb_decode_var. Now
+     * the correct information is returned to the program, but the values
+     * for the crtc registers are not suited for the LCD monitor. We call
+     * atyfb_decode_var again to calculate the registers again, this time
+     * with the right monitors_enabled.
+     */
+
+    if ((err = atyfb_decode_var(var, &par, info, CRT_ON)))
 	return err;
 
     atyfb_encode_var(var, &par, (struct fb_info_aty *)info);
 
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+    if ((err = atyfb_decode_var(var, &par, info, monitors_enabled)))
+	return err;
+#endif
+
     if ((activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
 	oldxres = display->var.xres;
 	oldyres = display->var.yres;
@@ -1241,32 +1506,10 @@
 }
 
 
-#ifdef DEBUG
-#define ATYIO_CLKR		0x41545900	/* ATY\00 */
-#define ATYIO_CLKW		0x41545901	/* ATY\01 */
-
-struct atyclk {
-    u32 ref_clk_per;
-    u8 pll_ref_div;
-    u8 mclk_fb_div;
-    u8 mclk_post_div;		/* 1,2,3,4,8 */
-    u8 vclk_fb_div;
-    u8 vclk_post_div;		/* 1,2,3,4,6,8,12 */
-    u32 dsp_xclks_per_row;	/* 0-16383 */
-    u32 dsp_loop_latency;	/* 0-15 */
-    u32 dsp_precision;		/* 0-7 */
-    u32 dsp_on;			/* 0-2047 */
-    u32 dsp_off;		/* 0-2047 */
-};
-
-#define ATYIO_FEATR		0x41545902	/* ATY\02 */
-#define ATYIO_FEATW		0x41545903	/* ATY\03 */
-#endif
-
 static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 		       u_long arg, int con, struct fb_info *info2)
 {
-#if defined(__sparc__) || (defined(DEBUG) && defined(CONFIG_FB_ATY_CT))
+#if defined(__sparc__)
     struct fb_info_aty *info = (struct fb_info_aty *)info2;
 #endif /* __sparc__ || DEBUG */
 #ifdef __sparc__
@@ -1768,11 +1957,12 @@
     u16 type;
     u8 rev;
     const char *chipname = NULL, *ramname = NULL, *xtal;
-    int pll, mclk, gtb_memsize;
+    int pll, mclk, xclk, gtb_memsize;
 #if defined(CONFIG_PPC)
     int sense;
 #endif
     u8 pll_ref_div;
+    u32 monitors_enabled;
 
     info->aty_cmap_regs = (struct aty_cmap_regs *)(info->ati_regbase+0xc0);
     chip_id = aty_ld_le32(CONFIG_CHIP_ID, info);
@@ -1784,6 +1974,7 @@
 	    chipname = aty_chips[j].name;
 	    pll = aty_chips[j].pll;
 	    mclk = aty_chips[j].mclk;
+	    xclk = aty_chips[j].xclk;
 	    info->features = aty_chips[j].features;
 	    goto found;
 	}
@@ -1862,8 +2053,8 @@
 	info->dac_ops = &aty_dac_ct;
 	info->pll_ops = &aty_pll_ct;
 	/* for many chips, the mclk is 67 MHz for SDRAM, 63 MHz otherwise */
-	if (mclk == 67 && info->ram_type < SDRAM)
-	    mclk = 63;
+	if (xclk == 67 && info->ram_type < SDRAM)
+	    xclk = 63;
     }
 #endif /* CONFIG_FB_ATY_CT */
 
@@ -1958,34 +2149,60 @@
 	pll = default_pll;
     if (default_mclk)
 	mclk = default_mclk;
+    if (default_xclk)
+	xclk = default_xclk;
 
-    printk("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK\n",
+    printk("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK, %d Mhz XCLK\n",
     	   info->total_vram == 0x80000 ? 512 : (info->total_vram >> 20),
-    	   info->total_vram == 0x80000 ? 'K' : 'M', ramname, xtal, pll, mclk);
+    	   info->total_vram == 0x80000 ? 'K' : 'M', ramname, xtal, pll, mclk,
+	   xclk);
 
-    if (mclk < 44)
+    if (xclk < 44)
 	info->mem_refresh_rate = 0;	/* 000 = 10 Mhz - 43 Mhz */
-    else if (mclk < 50)
+    else if (xclk < 50)
 	info->mem_refresh_rate = 1;	/* 001 = 44 Mhz - 49 Mhz */
-    else if (mclk < 55)
+    else if (xclk < 55)
 	info->mem_refresh_rate = 2;	/* 010 = 50 Mhz - 54 Mhz */
-    else if (mclk < 66)
+    else if (xclk < 66)
 	info->mem_refresh_rate = 3;	/* 011 = 55 Mhz - 65 Mhz */
-    else if (mclk < 75)
+    else if (xclk < 75)
 	info->mem_refresh_rate = 4;	/* 100 = 66 Mhz - 74 Mhz */
-    else if (mclk < 80)
+    else if (xclk < 80)
 	info->mem_refresh_rate = 5;	/* 101 = 75 Mhz - 79 Mhz */
-    else if (mclk < 100)
+    else if (xclk < 100)
 	info->mem_refresh_rate = 6;	/* 110 = 80 Mhz - 100 Mhz */
     else
 	info->mem_refresh_rate = 7;	/* 111 = 100 Mhz and above */
     info->pll_per = 1000000/pll;
-    info->mclk_per = 1000000/mclk;
+    if ((mclk < 0) || (xclk < 0)) {
+	info->mclk_per = 0;
+	info->xclk_per = 0;
+    } else {
+	info->mclk_per = 1000000/mclk;
+	info->xclk_per = 1000000/xclk;
+    };
 
 #ifdef DEBUG
     if (M64_HAS(INTEGRATED)) {
 	int i;
 	printk("BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL "
+	       "DSP_CONFIG DSP_ON_OFF CLOCK_CNTL\n"
+	       "%08x %08x %08x %08x     %08x      %08x   %08x   %08x\n"
+	       "PLL",
+	       aty_ld_le32(BUS_CNTL, info), aty_ld_le32(DAC_CNTL, info),
+	       aty_ld_le32(MEM_CNTL, info), aty_ld_le32(EXT_MEM_CNTL, info),
+	       aty_ld_le32(CRTC_GEN_CNTL, info), aty_ld_le32(DSP_CONFIG, info),
+	       aty_ld_le32(DSP_ON_OFF, info), aty_ld_le32(CLOCK_CNTL ,info));
+	for (i = 0; i < 40; i++)
+	    printk(" %02x", aty_ld_pll(i, info));
+	printk("\n");
+    }
+#endif
+    info->pll_ops->init_pll(info);
+#ifdef DEBUG
+    if (M64_HAS(INTEGRATED)) {
+	int i;
+	printk("BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL "
 	       "DSP_CONFIG DSP_ON_OFF\n"
 	       "%08x %08x %08x %08x     %08x      %08x   %08x\n"
 	       "PLL",
@@ -1993,7 +2210,7 @@
 	       aty_ld_le32(MEM_CNTL, info), aty_ld_le32(EXT_MEM_CNTL, info),
 	       aty_ld_le32(CRTC_GEN_CNTL, info), aty_ld_le32(DSP_CONFIG, info),
 	       aty_ld_le32(DSP_ON_OFF, info));
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < 40; i++)
 	    printk(" %02x", aty_ld_pll(i, info));
 	printk("\n");
     }
@@ -2102,7 +2319,9 @@
 		var.yres_virtual = var.yres;
     }
 
-    if (atyfb_decode_var(&var, &info->default_par, info)) {
+    monitors_enabled = atyfb_monitors_enabled(info);
+
+    if (atyfb_decode_var(&var, &info->default_par, info, monitors_enabled)) {
 	printk("atyfb: can't set default video mode\n");
 	return 0;
     }
@@ -2134,7 +2353,43 @@
 
     info->next = fb_list;
     fb_list = info;
-
+#ifdef DEBUG
+{
+    /* dump non shadow CRTC, pll, LCD registers */
+    int i; u32 base;
+    /* CRTC registers */
+    base = 0x2000;
+    printk("Mach64 non-shadow register values:");
+    for (i = 0; i < 256; i = i+4) {
+        if(i%16 == 0) printk("\n0x%04X: ", base + i);
+        printk(" %08X", aty_ld_le32(i, info));
+    }
+    printk("\n\n");
+
+    /* PLL registers */
+    base = 0x00;
+    printk("Mach64 PLL register values:");
+    for (i = 0; i < 64; i++) {
+        if(i%16 == 0) printk("\n0x%02X: ", base + i);
+        if(i%4 == 0)  printk(" ");
+
+        printk("%02X", aty_ld_pll(i, info));
+    }
+    printk("\n\n");
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+    if(info->lcd_table != 0) {
+        /* LCD registers */
+        base = 0x00;
+        printk("LCD register values:");
+        for (i = 0; i < 64; i++) {
+            if(i%4 == 0) printk("\n0x%02X: ", base + i);
+            printk(" %08X", aty_ld_lcd(i, info));
+        }
+        printk("\n\n");
+    }
+#endif
+}
+#endif
     printk("fb%d: %s frame buffer device on %s\n",
 	   GET_FB_IDX(info->fb_info.node), atyfb_name, name);
     return 1;
@@ -2163,6 +2418,10 @@
     int aux_app;
     unsigned long raddr;
 #endif
+#if defined(CONFIG_FB_ATY_GENERIC_LCD)
+    u16 lcd_ofs;
+    u32 driv_inf_tab,sig,rom_addr;
+#endif
 
     while ((pdev = pci_find_device(PCI_VENDOR_ID_ATI, PCI_ANY_ID, pdev))) {
 	if ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
@@ -2443,6 +2702,205 @@
 	    info->frame_buffer_phys = addr;
 	    info->frame_buffer = (unsigned long)ioremap(addr, 0x800000);
 
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
+	    rom_addr = 0xc0000 + ((aty_ld_le32(SCRATCH_REG1,info) & 0x7f) << 11);
+	    info->bios_base_phys = rom_addr;
+	    info->bios_base = (unsigned long)ioremap(rom_addr,0x10000);
+	    
+	    /* The BIOS starts with 0xaa55. */
+	    if (*((u16 *)info->bios_base) == 0xaa55) {
+		printk(KERN_INFO "atyfb: Mach64 BIOS is located at %x, mapped at %x.\n",
+		 (u32)info->bios_base_phys,(u32)info->bios_base);
+	    
+		/* Address of driver information table is at offset 0x78. */
+		driv_inf_tab=info->bios_base + *((u16 *)(info->bios_base+0x78));
+		
+		/* Check for the driver information table signature. */
+		sig = (*(u32 *)driv_inf_tab);
+		if ((sig == 0x54504c24) || /* Rage LT pro */
+		    (sig == 0x544d5224) || /* Rage mobility */
+		    (sig == 0x54435824) || /* Rage XC */
+		    (sig == 0x544c5824)) { /* Rage XL */
+		    printk(KERN_INFO "atyfb: BIOS contains driver information table.\n");
+		    lcd_ofs = (*(u16 *)(driv_inf_tab + 10));
+		    info->lcd_table = 0;
+		    if (lcd_ofs != 0) {
+			info->lcd_table = info->bios_base + lcd_ofs;
+		    };
+		};
+	    };
+	    if (info->lcd_table != 0) {
+		char model[24];
+		char strbuf[16];
+		char refresh_rates_buf[100];
+		int id,tech,f,i,m,default_refresh_rate;
+		char *txtcolour;
+		char *txtmonitor;
+		char *txtdual;
+		char *txtformat;
+		u16 width,height,panel_type,refresh_rates;
+		u16 *lcdmodeptr;
+		u32 format;
+		u8 lcd_refresh_rates[16] = {50,56,60,67,70,72,75,76,85,90,100,120,140,150,160,200};
+		/* The most important information is the panel size at
+		   offset 25 and 27, but there's some other nice information
+		   which we print to the screen.
+		 */
+		id = *(u8 *)info->lcd_table;
+		strncpy(model,(char *)info->lcd_table+1,24);
+		model[23]=0;
+		
+		width = info->lcd_width = *(u16 *)(info->lcd_table+25);
+		height = info->lcd_height = *(u16 *)(info->lcd_table+27);
+		panel_type = *(u16 *)(info->lcd_table+29);
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
+		};
+		format = *(u32 *)(info->lcd_table+57);
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
+		    };
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
+		    };
+		};
+		printk(KERN_INFO "atyfb: %s%s %s monitor detected: %s\n        id=%d, %dx%d pixels, %s\n",
+		 txtdual,txtcolour,txtmonitor,model,id,width,height,txtformat);
+		refresh_rates_buf[0] = 0;
+		refresh_rates = *(u16 *)(info->lcd_table+62);
+		m = 1;
+		f = 0;
+		for (i=0;i<16;i++) {
+		    if (refresh_rates & m) {
+			if (f == 0) {
+			    sprintf(strbuf,"%d",lcd_refresh_rates[i]);
+			    f++;
+			} else
+			    sprintf(strbuf,",%d",lcd_refresh_rates[i]);
+			strcat(refresh_rates_buf,strbuf);
+		    };
+		    m = m << 1;
+		};
+		default_refresh_rate = (*(u8 *)(info->lcd_table+61) & 0xf0) >> 4;
+		printk(KERN_INFO "        supports %s Hz refresh rates, default %d Hz\n",
+		 refresh_rates_buf,lcd_refresh_rates[default_refresh_rate]);
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
+		lcdmodeptr = (u16 *)(info->lcd_table + 64);
+		while (*lcdmodeptr != 0) {
+		    u32 modeptr;
+		    u16 mwidth,mheight;
+		    modeptr = info->bios_base + *lcdmodeptr;
+		    
+		    mwidth = *((u16 *)(modeptr+0));
+		    mheight = *((u16 *)(modeptr+2));
+		    
+		    if (mwidth == width && mheight == height) {
+			info->lcd_pixclock = 100000000 / *((u16 *)(modeptr+9));
+			info->lcd_htotal = *((u16 *)(modeptr+17)) & 511;
+			info->lcd_hdisp = *((u16 *)(modeptr+19)) & 511;
+			info->lcd_hsync_start = *((u16 *)(modeptr+21)) & 511;
+			info->lcd_hsync_delay = (*((u16 *)(modeptr+21)) >> 9) & 7;
+			info->lcd_hsync_width = *((u8 *)(modeptr+23)) & 63;
+			info->lcd_vtotal = *((u16 *)(modeptr+24)) & 2047;
+			info->lcd_vdisp = *((u16 *)(modeptr+26)) & 2047;
+			info->lcd_vsync_start = *((u16 *)(modeptr+28)) & 2047;
+			info->lcd_vsync_width = (*((u16 *)(modeptr+28)) >> 11) & 31;
+			info->lcd_right = info->lcd_hsync_start - info->lcd_hdisp;
+			info->lcd_lower = info->lcd_vsync_start - info->lcd_vdisp;
+			info->lcd_hblank_width = info->lcd_htotal - info->lcd_hdisp;
+			info->lcd_vblank_width = info->lcd_vtotal - info->lcd_vdisp;
+			break;
+		    };
+		    
+		    lcdmodeptr++;
+		};
+		if (*lcdmodeptr == 0) {
+		    printk(KERN_WARNING "atyfb: LCD monitor CRTC parameters not found!!!\n");
+		    /* To do: Switch to CRT if possible. */
+		} else {
+		    printk(KERN_INFO "        LCD CRTC parameters: %d %d %d %d %d %d %d %d %d %d\n",
+		     info->lcd_pixclock,info->lcd_htotal,info->lcd_hdisp,info->lcd_hsync_start,
+		     info->lcd_hsync_delay,info->lcd_hsync_width,info->lcd_vtotal,info->lcd_vdisp,
+		     info->lcd_vsync_start,info->lcd_vsync_width);
+		};
+	    };
+#endif
+
 	    if(!info->frame_buffer) {
 		    kfree(info);
 		    release_mem_region(res_start, res_size);
@@ -2516,11 +2974,9 @@
 	 *  Map the video memory (physical address given) to somewhere in the
 	 *  kernel address space.
 	 */
-	info->frame_buffer = (unsigned long)ioremap(phys_vmembase[m64_num],
-						    phys_size[m64_num]);
+	info->frame_buffer = ioremap(phys_vmembase[m64_num], phys_size[m64_num]);
 	info->frame_buffer_phys = info->frame_buffer;  /* Fake! */
-	info->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
-						   0x10000)+0xFC00ul;
+	info->ati_regbase = ioremap(phys_guiregbase[m64_num], 0x10000)+0xFC00ul;
 	info->ati_regbase_phys = info->ati_regbase;  /* Fake! */
 
 	aty_st_le32(CLOCK_CNTL, 0x12345678, info);
@@ -2578,8 +3034,10 @@
 		default_vram = simple_strtoul(this_opt+5, NULL, 0);
 	else if (!strncmp(this_opt, "pll:", 4))
 		default_pll = simple_strtoul(this_opt+4, NULL, 0);
-	else if (!strncmp(this_opt, "mclk:", 5))
-		default_mclk = simple_strtoul(this_opt+5, NULL, 0);
+	else if (!strncmp(this_opt, "mclk:", 4))
+		default_mclk = simple_strtoul(this_opt+4, NULL, 0);
+	else if (!strncmp(this_opt, "xclk:", 5))
+		default_xclk = simple_strtoul(this_opt+5, NULL, 0);
 #ifdef CONFIG_PPC
 	else if (!strncmp(this_opt, "vmode:", 6)) {
 	    unsigned int vmode = simple_strtoul(this_opt+6, NULL, 0);
@@ -2679,6 +3137,7 @@
 {
     struct fb_info_aty *info = (struct fb_info_aty *)fb;
     struct atyfb_par par;
+    u32 monitors_enabled;
 
     /* Do we have to save the colormap? */
     if (fb_display[currcon].cmap.len)
@@ -2693,7 +3152,9 @@
 
     currcon = con;
 
-    atyfb_decode_var(&fb_display[con].var, &par, info);
+    monitors_enabled = atyfb_monitors_enabled(info);
+
+    atyfb_decode_var(&fb_display[con].var, &par, info, monitors_enabled);
     atyfb_set_par(&par, info);
     atyfb_set_dispsw(&fb_display[con], info, par.crtc.bpp,
 		     par.accel_flags & FB_ACCELF_TEXT);
@@ -2798,17 +3259,10 @@
     aty_st_8(DAC_CNTL, i, info);
     aty_st_8(DAC_MASK, 0xff, info);
     scale = (M64_HAS(INTEGRATED) && info->current_par.crtc.bpp == 16) ? 3 : 0;
-#ifdef CONFIG_ATARI
-    out_8(&info->aty_cmap_regs->windex, regno << scale);
-    out_8(&info->aty_cmap_regs->lut, red);
-    out_8(&info->aty_cmap_regs->lut, green);
-    out_8(&info->aty_cmap_regs->lut, blue);
-#else
     writeb(regno << scale, &info->aty_cmap_regs->windex);
     writeb(red, &info->aty_cmap_regs->lut);
     writeb(green, &info->aty_cmap_regs->lut);
     writeb(blue, &info->aty_cmap_regs->lut);
-#endif
     if (regno < 16)
 	switch (info->current_par.crtc.bpp) {
 #ifdef FBCON_HAS_CFB16
@@ -2937,3 +3391,19 @@
 
 #endif
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Geert Uytterhoeven, Bernd Harries, Eddie C. Dost, Daniel Mantione");
+MODULE_DESCRIPTION("Accelerated FBDev driver for ATI Mach64 and derivates");
+
+MODULE_PARM(curblink, "i");
+MODULE_PARM_DESC(noblink, "Enable(1) or disable(0) cursor blinking");
+MODULE_PARM(noaccel, "i");
+MODULE_PARM_DESC(noaccel, "Disable(1) or enable(0) 2d acceleration");
+MODULE_PARM(default_vram, "i");
+MODULE_PARM_DESC(default_vram, "Specify the amount of available video memory");
+MODULE_PARM(default_pll, "i");
+MODULE_PARM_DESC(default_pll, "Specify the maximum PLL rate");
+MODULE_PARM(default_mclk, "i");
+MODULE_PARM_DESC(default_mclk, "Program the chip clock frequency (in MHz)");
+MODULE_PARM(default_xclk, "i");
+MODULE_PARM_DESC(default_xclk, "Program the memory clock frequency (in MHz)");
+
diff -r -u /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64.h /usr/src/linux-2.4.XX/drivers/video/aty/mach64.h
--- /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64.h	2001-07-31 23:43:29.000000000 +0200
+++ /usr/src/linux-2.4.XX/drivers/video/aty/mach64.h	2002-12-13 19:57:22.000000000 +0100
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
diff -r -u /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64_accel.c /usr/src/linux-2.4.XX/drivers/video/aty/mach64_accel.c
--- /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64_accel.c	2002-08-03 02:39:45.000000000 +0200
+++ /usr/src/linux-2.4.XX/drivers/video/aty/mach64_accel.c	2002-05-18 10:46:50.000000000 +0200
@@ -3,7 +3,6 @@
  *  ATI Mach64 Hardware Acceleration
  */
 
-#include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
 
@@ -327,7 +326,7 @@
 		     fbcon_cfb##width##_clear_margins(conp, p, bottom_only), \
 		     int bottom_only) \
  \
-const struct display_switch fbcon_aty##width = { \
+const struct display_switch fbcon_aty##width## = { \
     setup:		fbcon_cfb##width##_setup, \
     bmove:		fbcon_aty_bmove, \
     clear:		fbcon_aty_clear, \
diff -r -u /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64_ct.c /usr/src/linux-2.4.XX/drivers/video/aty/mach64_ct.c
--- /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64_ct.c	2001-07-31 23:43:29.000000000 +0200
+++ /usr/src/linux-2.4.XX/drivers/video/aty/mach64_ct.c	2002-12-23 23:21:26.000000000 +0100
@@ -20,14 +20,14 @@
 
 static int aty_valid_pll_ct(const struct fb_info_aty *info, u32 vclk_per,
 			    struct pll_ct *pll);
-static int aty_dsp_gt(const struct fb_info_aty *info, u8 bpp,
+static int aty_dsp_gt(const struct fb_info_aty *info, u8 bpp, u32 stretch,
 		      struct pll_ct *pll);
 static int aty_var_to_pll_ct(const struct fb_info_aty *info, u32 vclk_per,
-			     u8 bpp, union aty_pll *pll);
+			     u8 bpp, u32 stretch, union aty_pll *pll);
 static u32 aty_pll_ct_to_var(const struct fb_info_aty *info,
 			     const union aty_pll *pll);
 
-
+static u8 postdividers[] = {1,2,4,8,3};
 
 static void aty_st_pll(int offset, u8 val, const struct fb_info_aty *info)
 {
@@ -35,10 +35,9 @@
     aty_st_8(CLOCK_CNTL + 1, (offset << 2) | PLL_WR_EN, info);
     /* write the register value */
     aty_st_8(CLOCK_CNTL + 2, val, info);
-    aty_st_8(CLOCK_CNTL + 1, (offset << 2) & ~PLL_WR_EN, info);
+    aty_st_8(CLOCK_CNTL + 1, (offset << 2), info);
 }
 
-
 /* ------------------------------------------------------------------------- */
 
     /*
@@ -46,54 +45,35 @@
      */
 
 static int aty_dsp_gt(const struct fb_info_aty *info, u8 bpp,
-		      struct pll_ct *pll)
+		      u32 width, struct pll_ct *pll)
 {
-    u32 dsp_xclks_per_row, dsp_loop_latency, dsp_precision, dsp_off, dsp_on;
-    u32 xclks_per_row, fifo_off, fifo_on, y, fifo_size, page_size;
+    u32 dsp_xclks_per_row, dsp_precision, dsp_off, dsp_on;
+    u32 xclks_per_row, fifo_off, fifo_on, y, page_size;
 
     /* xclocks_per_row<<11 */
-    xclks_per_row = (pll->mclk_fb_div*pll->vclk_post_div_real*64<<11)/
-		    (pll->vclk_fb_div*pll->mclk_post_div_real*bpp);
+    xclks_per_row = (info->mclk_fb_div*pll->vclk_post_div_real*64<<11)/
+		    (pll->vclk_fb_div*info->xclk_post_div_real*bpp);
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+    if (width != 0)
+	xclks_per_row = (xclks_per_row * info->lcd_width) / width;
+#endif
     if (xclks_per_row < (1<<11))
 	FAIL("Dotclock to high");
-    if (M64_HAS(FIFO_24)) {
-	fifo_size = 24;
-	dsp_loop_latency = 0;
-    } else {
-	fifo_size = 32;
-	dsp_loop_latency = 2;
-    }
     dsp_precision = 0;
-    y = (xclks_per_row*fifo_size)>>11;
+    y = (xclks_per_row*info->fifo_size)>>11;
     while (y) {
 	y >>= 1;
 	dsp_precision++;
     }
     dsp_precision -= 5;
     /* fifo_off<<6 */
-    fifo_off = ((xclks_per_row*(fifo_size-1))>>5)+(3<<6);
+    fifo_off = ((xclks_per_row*(info->fifo_size-1))>>5)+(3<<6);
 
-    if (info->total_vram > 1*1024*1024) {
-	if (info->ram_type >= SDRAM) {
-	    /* >1 MB SDRAM */
-	    dsp_loop_latency += 8;
-	    page_size = 8;
-	} else {
-	    /* >1 MB DRAM */
-	    dsp_loop_latency += 6;
-	    page_size = 9;
-	}
-    } else {
-	if (info->ram_type >= SDRAM) {
-	    /* <2 MB SDRAM */
-	    dsp_loop_latency += 9;
-	    page_size = 10;
-	} else {
-	    /* <2 MB DRAM */
-	    dsp_loop_latency += 8;
-	    page_size = 10;
-	}
-    }
+    page_size = info->page_size;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+    if (width != 0)
+	page_size = (page_size * info->lcd_width) / width;
+#endif
     /* fifo_on<<6 */
     if (xclks_per_row >= (page_size<<11))
 	fifo_on = ((2*page_size+1)<<6)+(xclks_per_row>>5);
@@ -105,9 +85,9 @@
     dsp_off = fifo_off>>dsp_precision;
 
     pll->dsp_config = (dsp_xclks_per_row & 0x3fff) |
-		      ((dsp_loop_latency & 0xf)<<16) |
+		      ((info->dsp_loop_latency & 0xf)<<16) |
 		      ((dsp_precision & 7)<<20);
-    pll->dsp_on_off = (dsp_on & 0x7ff) | ((dsp_off & 0x7ff)<<16);
+    pll->dsp_on_off = (dsp_off & 0x7ff) | ((dsp_on & 0x7ff)<<16);
     return 0;
 }
 
@@ -117,107 +97,36 @@
     u32 q, x;			/* x is a workaround for sparc64-linux-gcc */
     x = x;			/* x is a workaround for sparc64-linux-gcc */
 
-    pll->pll_ref_div = info->pll_per*2*255/info->ref_clk_per;
-
-    /* FIXME: use the VTB/GTB /3 post divider if it's better suited */
-    q = info->ref_clk_per*pll->pll_ref_div*4/info->mclk_per;	/* actually 8*q */
-    if (q < 16*8 || q > 255*8)
-	FAIL("mclk out of range");
-    else if (q < 32*8)
-	pll->mclk_post_div_real = 8;
-    else if (q < 64*8)
-	pll->mclk_post_div_real = 4;
-    else if (q < 128*8)
-	pll->mclk_post_div_real = 2;
-    else
-	pll->mclk_post_div_real = 1;
-    pll->mclk_fb_div = q*pll->mclk_post_div_real/8;
-
     /* FIXME: use the VTB/GTB /{3,6,12} post dividers if they're better suited */
-    q = info->ref_clk_per*pll->pll_ref_div*4/vclk_per;	/* actually 8*q */
+    q = info->ref_clk_per*info->pll_ref_div*4/vclk_per;	/* actually 8*q */
     if (q < 16*8 || q > 255*8)
 	FAIL("vclk out of range");
-    else if (q < 32*8)
-	pll->vclk_post_div_real = 8;
-    else if (q < 64*8)
-	pll->vclk_post_div_real = 4;
-    else if (q < 128*8)
-	pll->vclk_post_div_real = 2;
-    else
-	pll->vclk_post_div_real = 1;
+    else {
+	pll->vclk_post_div = 0;
+	if (q < 128*8)
+	    pll->vclk_post_div++;
+	if (q < 64*8)
+	    pll->vclk_post_div++;
+	if (q < 32*8)
+	    pll->vclk_post_div++;
+    };
+    pll->vclk_post_div_real = postdividers[pll->vclk_post_div];
     pll->vclk_fb_div = q*pll->vclk_post_div_real/8;
-    return 0;
-}
-
-void aty_calc_pll_ct(const struct fb_info_aty *info, struct pll_ct *pll)
-{
-    u8 mpostdiv = 0;
-    u8 vpostdiv = 0;
-
-    if (M64_HAS(SDRAM_MAGIC_PLL) && (info->ram_type >= SDRAM))
-	pll->pll_gen_cntl = 0x04;
-    else
-	pll->pll_gen_cntl = 0x84;
-
-    switch (pll->mclk_post_div_real) {
-	case 1:
-	    mpostdiv = 0;
-	    break;
-	case 2:
-	    mpostdiv = 1;
-	    break;
-	case 3:
-	    mpostdiv = 4;
-	    break;
-	case 4:
-	    mpostdiv = 2;
-	    break;
-	case 8:
-	    mpostdiv = 3;
-	    break;
-    }
-    pll->pll_gen_cntl |= mpostdiv<<4;	/* mclk */
-
-    if (M64_HAS(MAGIC_POSTDIV))
-	pll->pll_ext_cntl = 0;
-    else
-    	pll->pll_ext_cntl = mpostdiv;	/* xclk == mclk */
-
-    switch (pll->vclk_post_div_real) {
-	case 2:
-	    vpostdiv = 1;
-	    break;
-	case 3:
-	    pll->pll_ext_cntl |= 0x10;
-	case 1:
-	    vpostdiv = 0;
-	    break;
-	case 6:
-	    pll->pll_ext_cntl |= 0x10;
-	case 4:
-	    vpostdiv = 2;
-	    break;
-	case 12:
-	    pll->pll_ext_cntl |= 0x10;
-	case 8:
-	    vpostdiv = 3;
-	    break;
-    }
-
     pll->pll_vclk_cntl = 0x03;	/* VCLK = PLL_VCLK/VCLKx_POST */
-    pll->vclk_post_div = vpostdiv;
+    return 0;
 }
 
 static int aty_var_to_pll_ct(const struct fb_info_aty *info, u32 vclk_per,
-			     u8 bpp, union aty_pll *pll)
+			     u8 bpp, u32 width, union aty_pll *pll)
 {
     int err;
 
     if ((err = aty_valid_pll_ct(info, vclk_per, &pll->ct)))
 	return err;
-    if (M64_HAS(GTB_DSP) && (err = aty_dsp_gt(info, bpp, &pll->ct)))
+//    aty_dsp_gt2(info,bpp,width,vclk_per,&pll->ct);
+    if (M64_HAS(GTB_DSP) && (err = aty_dsp_gt(info, bpp, width, &pll->ct)))
 	return err;
-    aty_calc_pll_ct(info, &pll->ct);
+//    aty_calc_pll_ct(info, &pll->ct);
     return 0;
 }
 
@@ -225,7 +134,7 @@
 			     const union aty_pll *pll)
 {
     u32 ref_clk_per = info->ref_clk_per;
-    u8 pll_ref_div = pll->ct.pll_ref_div;
+    u8 pll_ref_div = info->pll_ref_div;
     u8 vclk_fb_div = pll->ct.vclk_fb_div;
     u8 vclk_post_div = pll->ct.vclk_post_div_real;
 
@@ -234,14 +143,177 @@
 
 void aty_set_pll_ct(const struct fb_info_aty *info, const union aty_pll *pll)
 {
-    aty_st_pll(PLL_REF_DIV, pll->ct.pll_ref_div, info);
-    aty_st_pll(PLL_GEN_CNTL, pll->ct.pll_gen_cntl, info);
-    aty_st_pll(MCLK_FB_DIV, pll->ct.mclk_fb_div, info);
+    u8 tmp, tmp2; u32 crtc_gen_cntl;
+#ifdef DEBUG
+    printk("aty_set_pll_ct: setting clock %i for FeedBackDivider %i, ReferenceDivider %i, PostDivider %i\n",
+        info->clock, pll->ct.vclk_fb_div, info->pll_ref_div, pll->ct.vclk_post_div);
+#endif
+    /* Temporarily switch to accelerator mode */
+    crtc_gen_cntl = aty_ld_le32(CRTC_GEN_CNTL, info);
+    if (!(crtc_gen_cntl & CRTC_EXT_DISP_EN))
+        aty_st_le32(CRTC_GEN_CNTL, crtc_gen_cntl | CRTC_EXT_DISP_EN, info);
+
+    /* Reset VCLK generator */
     aty_st_pll(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl, info);
-    aty_st_pll(VCLK_POST_DIV, pll->ct.vclk_post_div, info);
-    aty_st_pll(VCLK0_FB_DIV, pll->ct.vclk_fb_div, info);
-    aty_st_pll(PLL_EXT_CNTL, pll->ct.pll_ext_cntl, info);
 
+    /* Set post-divider */
+    tmp2 = info->clock << 1;
+    tmp = aty_ld_pll(VCLK_POST_DIV, info);
+    tmp &= ~(0x03U << tmp2);
+    tmp |= ((pll->ct.vclk_post_div & 0x03U) << tmp2);
+    aty_st_pll(VCLK_POST_DIV, tmp, info);
+
+    /* Set extended post-divider */
+    tmp = aty_ld_pll(PLL_EXT_CNTL, info);
+    tmp &= ~(0x10U << info->clock);
+    tmp |= (((pll->ct.vclk_post_div >> 2) & 0x10U) << info->clock);
+    aty_st_pll(PLL_EXT_CNTL, tmp, info);
+
+    /* Set feedback divider */
+    tmp = VCLK0_FB_DIV + info->clock;
+    aty_st_pll(tmp, (pll->ct.vclk_fb_div & 0xFFU), info);
+
+    /* End VCLK generator reset */
+    aty_st_pll(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl & ~(0x04U), info);
+
+    /* Reset write bit */
+    /* ATIAccessMach64PLLReg(pATI, 0, FALSE); */
+
+    /* Restore register */
+    if (!(crtc_gen_cntl & CRTC_EXT_DISP_EN))
+        aty_st_le32(CRTC_GEN_CNTL, crtc_gen_cntl, info);
+
+    if (M64_HAS(GTB_DSP)) {
+	aty_st_le32(DSP_CONFIG, pll->ct.dsp_config, info);
+	aty_st_le32(DSP_ON_OFF, pll->ct.dsp_on_off, info);
+    }
+}
+
+
+static void __init aty_init_pll_ct(struct fb_info_aty *info) {
+    u8 pll_ref_div,pll_gen_cntl,pll_ext_cntl;
+    u8 mpost_div,xpost_div;
+    u8 sclk_post_div_real,sclk_fb_div,spll_cntl2;
+    u32 q;
+
+    if (M64_HAS(FIFO_24)) {
+	info->fifo_size = 24;
+	info->dsp_loop_latency = 0;
+    } else {
+	info->fifo_size = 32;
+	info->dsp_loop_latency = 2;
+    }
+    if (info->total_vram > 1*1024*1024) {
+	if (info->ram_type >= SDRAM) {
+	    /* >1 MB SDRAM */
+	    info->dsp_loop_latency += 8;
+	    info->page_size = 8;
+	} else {
+	    /* >1 MB DRAM */
+	    info->dsp_loop_latency += 6;
+	    info->page_size = 9;
+	}
+    } else {
+	if (info->ram_type >= SDRAM) {
+	    /* <2 MB SDRAM */
+	    info->dsp_loop_latency += 9;
+	    info->page_size = 10;
+	} else {
+	    /* <2 MB DRAM */
+	    info->dsp_loop_latency += 8;
+	    info->page_size = 10;
+	}
+    };
+
+    /* Exit if the user does not want us to play with the clock
+       rates of her chip. */
+    if (info->mclk_per == 0) {
+	u16 mclk_fb_div;
+	u8 pll_ext_cntl;
+
+	info->pll_ref_div = aty_ld_pll(PLL_REF_DIV, info);
+	pll_ext_cntl = aty_ld_pll(PLL_EXT_CNTL, info);
+	info->xclk_post_div_real = postdividers[pll_ext_cntl & 7];
+	mclk_fb_div = aty_ld_pll(MCLK_FB_DIV, info);
+	if (pll_ext_cntl & 8)
+	    mclk_fb_div <<= 1;
+	info->mclk_fb_div = mclk_fb_div;
+	return;
+    };
+
+    pll_ref_div = info->pll_per*2*255/info->ref_clk_per;
+    info->pll_ref_div = pll_ref_div;
+
+    /* FIXME: use the VTB/GTB /3 post divider if it's better suited */
+    q = info->ref_clk_per*pll_ref_div*4/info->xclk_per;	/* actually 8*q */
+    if (q < 16*8 || q > 255*8) {
+	printk(KERN_CRIT "xclk out of range\n");
+	return;
+    } else {
+	xpost_div = 0;
+	if (q < 128*8)
+	    xpost_div++;
+	if (q < 64*8)
+	    xpost_div++;
+	if (q < 32*8)
+	    xpost_div++;
+    };
+    info->xclk_post_div_real = postdividers[xpost_div];
+    info->mclk_fb_div = q*info->xclk_post_div_real/8;
+
+    if (M64_HAS(SDRAM_MAGIC_PLL) && (info->ram_type >= SDRAM))
+	pll_gen_cntl = 0x04;
+    else
+	pll_gen_cntl = 0x84;
+
+    if (M64_HAS(MAGIC_POSTDIV))
+	pll_ext_cntl = 0;
+    else
+    	pll_ext_cntl = xpost_div;
+
+    if (info->mclk_per == info->xclk_per)
+	pll_gen_cntl |= xpost_div<<4; /* mclk == xclk */
+    else {
+        pll_gen_cntl |= 6<<4;	/* mclk == sclk*/
+
+        q = info->ref_clk_per*pll_ref_div*4/info->mclk_per;	/* actually 8*q */
+	if (q < 16*8 || q > 255*8) {
+	    printk(KERN_CRIT "mclk out of range\n");
+	    return;
+	} else {
+	    mpost_div = 0;
+	    if (q < 128*8)
+		mpost_div++;
+	    if (q < 64*8)
+		mpost_div++;
+	    if (q < 32*8)
+		mpost_div++;
+	};
+	sclk_post_div_real = postdividers[mpost_div];
+	sclk_fb_div = q*sclk_post_div_real/8;
+	spll_cntl2 = mpost_div << 4;
+/*
+	This disables the sclk, crashes the computer as reported:
+	aty_st_pll(SPLL_CNTL2, 3, info);
+
+	So it seems the sclk must be enabled before it is used;
+	so PLL_GEN_CNTL must be programmed *after* the sclk.
+*/
+#ifdef DEBUG
+	printk(KERN_INFO "sclk_fb_div: %x spll_cntl2:%x\n",
+	    sclk_fb_div,spll_cntl2);
+#endif
+	aty_st_pll(SPLL_CNTL2, spll_cntl2, info);
+	aty_st_pll(SCLK_FB_DIV, sclk_fb_div, info);
+    };
+#ifdef DEBUG
+    printk(KERN_INFO "pll_ref_div: %x pll_gencntl: %x mclk_fb_div: %x pll_ext_cntl: %x\n",
+	   pll_ref_div,pll_gen_cntl,info->mclk_fb_div,pll_ext_cntl);
+#endif
+    aty_st_pll(PLL_REF_DIV, pll_ref_div, info);
+    aty_st_pll(PLL_GEN_CNTL, pll_gen_cntl, info);
+    aty_st_pll(MCLK_FB_DIV, info->mclk_fb_div, info);
+    aty_st_pll(PLL_EXT_CNTL, pll_ext_cntl, info);
     if (M64_HAS(GTB_DSP)) {
 	if (M64_HAS(XL_DLL))
 	    aty_st_pll(DLL_CNTL, 0x80, info);
@@ -250,10 +322,8 @@
 	else
 	    aty_st_pll(DLL_CNTL, 0xa0, info);
 	aty_st_pll(VFC_CNTL, 0x1b, info);
-	aty_st_le32(DSP_CONFIG, pll->ct.dsp_config, info);
-	aty_st_le32(DSP_ON_OFF, pll->ct.dsp_on_off, info);
-    }
-}
+    };
+};
 
 static int dummy(void)
 {
@@ -268,5 +338,6 @@
     var_to_pll:	aty_var_to_pll_ct,
     pll_to_var:	aty_pll_ct_to_var,
     set_pll:	aty_set_pll_ct,
+    init_pll:	aty_init_pll_ct
 };
 
diff -r -u /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64_cursor.c /usr/src/linux-2.4.XX/drivers/video/aty/mach64_cursor.c
--- /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64_cursor.c	2001-10-25 22:53:52.000000000 +0200
+++ /usr/src/linux-2.4.XX/drivers/video/aty/mach64_cursor.c	2002-05-18 10:46:50.000000000 +0200
@@ -144,6 +144,10 @@
 			yoff = 0;
 		}
 
+                /* In doublescan mode, the cursor location also needs to be
+		   doubled. */
+                if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
+		   y<<=1;
 		wait_for_fifo(4, fb);
 		aty_st_le32(CUR_OFFSET, (c->offset >> 3) + (yoff << 1), fb);
 		aty_st_le32(CUR_HORZ_VERT_OFF,
diff -r -u /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64_gx.c /usr/src/linux-2.4.XX/drivers/video/aty/mach64_gx.c
--- /usr/src/linux-2.4.20.orig/drivers/video/aty/mach64_gx.c	2002-08-03 02:39:45.000000000 +0200
+++ /usr/src/linux-2.4.XX/drivers/video/aty/mach64_gx.c	2002-05-18 10:46:50.000000000 +0200
@@ -5,7 +5,6 @@
 
 #include <linux/delay.h>
 #include <linux/fb.h>
-#include <linux/sched.h>
 
 #include <asm/io.h>
 
@@ -37,6 +36,11 @@
 #define MIN_N		35
 #define MAX_N		255-8
 
+static int dummy(void)
+{
+    return 0;
+}
+
 
     /*
      *  Support Functions
@@ -183,6 +187,7 @@
     var_to_pll:	aty_var_to_pll_514,
     pll_to_var:	aty_pll_514_to_var,
     set_pll:	aty_set_pll_514,
+    init_pll:	(void *)dummy
 };
 
 
@@ -467,6 +472,7 @@
     var_to_pll:	aty_var_to_pll_18818,
     pll_to_var:	aty_pll_18818_to_var,
     set_pll:	aty_set_pll18818,
+    init_pll:	(void *)dummy
 };
 
 
@@ -580,6 +586,7 @@
     var_to_pll:	aty_var_to_pll_1703,
     pll_to_var:	aty_pll_1703_to_var,
     set_pll:	aty_set_pll_1703,
+    init_pll:	(void *)dummy
 };
 
 
@@ -707,6 +714,7 @@
     var_to_pll:	aty_var_to_pll_8398,
     pll_to_var:	aty_pll_8398_to_var,
     set_pll:	aty_set_pll_8398,
+    init_pll:	(void *)dummy
 };
 
 
@@ -851,6 +859,7 @@
     var_to_pll:	aty_var_to_pll_408,
     pll_to_var:	aty_pll_408_to_var,
     set_pll:	aty_set_pll_408,
+    init_pll:	(void *)dummy
 };
 
 
@@ -870,11 +879,6 @@
     return 0;
 }
 
-static int dummy(void)
-{
-    return 0;
-}
-
 const struct aty_dac_ops aty_dac_unsupported = {
     set_dac:	aty_set_dac_unsupported,
 };
@@ -883,5 +887,6 @@
     var_to_pll:	(void *)dummy,
     pll_to_var:	(void *)dummy,
     set_pll:	(void *)dummy,
+    init_pll:	(void *)dummy
 };
 
diff -r -u /usr/src/linux-2.4.20.orig/drivers/video/modedb.c /usr/src/linux-2.4.XX/drivers/video/modedb.c
--- /usr/src/linux-2.4.20.orig/drivers/video/modedb.c	2001-12-21 18:41:55.000000000 +0100
+++ /usr/src/linux-2.4.XX/drivers/video/modedb.c	2002-12-13 19:41:20.000000000 +0100
@@ -135,6 +135,18 @@
 	NULL, 78, 1152, 864, 9090, 228, 88, 32, 0, 84, 12,
 	0, FB_VMODE_NONINTERLACED
     }, {
+	/* 1400x1050 @ 75 Hz, 82.5 kHz hsync */
+	NULL, 75, 1400, 1050, 6243, 287, 16, 34, 0, 241, 13,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }, {
+	/* 1400x1050 @ 75,107 Hz, 82,392 kHz +hsync +vsync*/
+	"LCD_XGA_75", 75, 1400, 1050, 9271, 120, 56, 13, 0, 112, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }, {
+	/* 1400x1050 @ 60 Hz, ? kHz +hsync +vsync*/
+	"LCD_XGA_60", 60, 1400, 1050, 9259, 128, 40, 12, 0, 112, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }, {
 	/* 1280x1024 @ 70 Hz, 74.59 kHz hsync */
 	NULL, 70, 1280, 1024, 7905, 224, 32, 28, 8, 160, 8,
 	0, FB_VMODE_NONINTERLACED

--------------Boundary-00=_VLNVWB7NYNR7EONF8M0R--



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
