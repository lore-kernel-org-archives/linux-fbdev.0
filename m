From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/5] fbdev: Various mach64 changes
Date: Wed, 20 Oct 2004 08:15:41 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410200815.41690.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CK43U-0002QX-Aw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:16 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CK43T-0008Ot-6s
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:16 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8BE981175D84
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Oct 2004 00:10:08 +0000 (UTC)
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
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Alexander Kern <alex.kern@gmx.de>, Arnaud FONTAINE <arnaud.fontaine@free.fr>, Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>

  Alexander Kern <alex.kern@gmx.de>
  [PATCH] port Daniel Mantione 2.4 driver to 2.6
  [PATCH] add more pci_id number
  [PATCH] add accelerated imgblit
  [PATCH] revert SDRAM_MAGIC_PLL to old behaviour
  [PATCH] do a "from BIOS" initialisation only by __i386__

  Arnaud FONTAINE <arnaud.fontaine@free.fr>
  [PATCH atyfb] correction for 3D Rage Mobility L

  Geert Uytterhoeven <geert@linux-m68k.org>
  [PATCH atyfb] Atari Atyfb fixes
  [PATCH atyfb] Atyfb on Mach64 GX or Atari
  [PATCH 468] m68k sparse floating point

  James Simmons <jsimmons@infradead.org>
  [PATCH add] port to framebuffer_alloc api

  Nicolas Souchu <nsouch@free.fr>
  [PATCH] I do not found a copy, but it was incorporated too

  Ville Syrj=E4l=E4 <syrjala@sci.fi>
  [PATCH] fix pan with doublescan
  [PATCH] another double scan fix
  [PATCH] disable linear aperture register access
  [PATCH] Memory type correction
  [PATCH] atyfb (2.6): Fix mmio_start
  [PATCH] atyfb (2.6): Fix mem_refresh_rate for Mobility
  [PATCH] atyfb (2.6): Add RGB565 support
  [PATCH] atyfb: Blank LCD by turning off backlight voltage
  [PATCH] atyfb: Rage LT LCD register access
  [PATCH] atyfb: vblank irq support
  [PATCH] atyfb: MTRR support

Signed-off-by: Antonino Daplas <adaplas@pol.net>
=2D--

 drivers/video/Kconfig             |   19
 drivers/video/aty/ati_ids.h       |    1
 drivers/video/aty/atyfb.h         |  207 +-
 drivers/video/aty/atyfb_base.c    | 3576 ++++++++++++++++++++++++---------=
=2D----
 drivers/video/aty/mach64_accel.c  |  212 ++
 drivers/video/aty/mach64_ct.c     |  731 +++++--
 drivers/video/aty/mach64_cursor.c |  309 +--
 drivers/video/aty/mach64_gx.c     |   20
 drivers/video/aty/xlinit.c        |   68
 include/video/mach64.h            |  351 +++
 10 files changed, 3680 insertions(+), 1814 deletions(-)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
=2D-- a/drivers/video/Kconfig	2004-10-17 14:02:58 +08:00
+++ b/drivers/video/Kconfig	2004-10-07 06:18:18 +08:00
@@ -750,6 +750,19 @@
 	  framebuffer device.  The ATI product support page for these boards
 	  is at <http://support.ati.com/products/pc/mach64/>.
=20
+config FB_ATY_GENERIC_LCD
+	bool "Mach64 generic LCD support (EXPERIMENTAL)"
+	depends on FB_ATY_CT
+	help
+	  Say Y if you have a laptop with an ATI Rage LT PRO, Rage Mobility,
+	  Rage XC, or Rage XL chipset.
+
+config FB_ATY_XL_INIT
+	bool "Rage XL No-BIOS Init support"
+	depends on FB_ATY_CT
+	help
+	  Say Y here to support booting a Rage XL without BIOS support.
+
 config FB_ATY_GX
 	bool "Mach64 GX support" if PCI
 	depends on FB_ATY
@@ -760,12 +773,6 @@
 	  framebuffer device.  The ATI product support page for these boards
 	  is at
 	  <http://support.ati.com/products/pc/mach64/graphics_xpression.html>.
=2D
=2Dconfig FB_ATY_XL_INIT
=2D	bool "  Rage XL No-BIOS Init support" if FB_ATY_CT
=2D	depends on FB_ATY
=2D	help
=2D	  Say Y here to support booting a Rage XL without BIOS support.
=20
 config FB_SIS
 	tristate "SiS acceleration"
diff -Nru a/drivers/video/aty/ati_ids.h b/drivers/video/aty/ati_ids.h
=2D-- a/drivers/video/aty/ati_ids.h	2004-10-19 20:22:38 +08:00
+++ b/drivers/video/aty/ati_ids.h	2004-10-07 06:18:18 +08:00
@@ -64,6 +64,7 @@
 #define PCI_CHIP_MACH64LQ		0x4C51
 #define PCI_CHIP_MACH64LR		0x4C52
 #define PCI_CHIP_MACH64LS		0x4C53
+#define PCI_CHIP_MACH64LT		0x4C54
 #define PCI_CHIP_RADEON_LW		0x4C57
 #define PCI_CHIP_RADEON_LX		0x4C58
 #define PCI_CHIP_RADEON_LY		0x4C59
diff -Nru a/drivers/video/aty/atyfb.h b/drivers/video/aty/atyfb.h
=2D-- a/drivers/video/aty/atyfb.h	2004-10-19 20:22:40 +08:00
+++ b/drivers/video/aty/atyfb.h	2004-10-11 03:43:16 +08:00
@@ -3,6 +3,8 @@
  */
=20
 #include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
     /*
      *  Elements of the hardware specific atyfb_par structure
      */
@@ -10,16 +12,60 @@
 struct crtc {
 	u32 vxres;
 	u32 vyres;
+	u32 xoffset;
+	u32 yoffset;
+	u32 bpp;
 	u32 h_tot_disp;
 	u32 h_sync_strt_wid;
 	u32 v_tot_disp;
 	u32 v_sync_strt_wid;
+	u32 vline_crnt_vline;
 	u32 off_pitch;
 	u32 gen_cntl;
 	u32 dp_pix_width;	/* acceleration */
 	u32 dp_chain_mask;	/* acceleration */
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	u32 horz_stretching;
+	u32 vert_stretching;
+	u32 ext_vert_stretch;
+	u32 shadow_h_tot_disp;
+	u32 shadow_h_sync_strt_wid;
+	u32 shadow_v_tot_disp;
+	u32 shadow_v_sync_strt_wid;
+	u32 lcd_gen_cntl;
+	u32 lcd_config_panel;
+	u32 lcd_index;
+#endif
+};
+
+struct aty_interrupt {
+	wait_queue_head_t wait;
+	unsigned int count;
+	int pan_display;
+};
+
+struct pll_info {
+	int pll_max;
+	int pll_min;
+	int sclk, mclk, mclk_pm, xclk;
+	int ref_div;
+	int ref_clk;
 };
=20
+typedef struct {
+	u16 unknown1;
+	u16 PCLK_min_freq;
+	u16 PCLK_max_freq;
+	u16 unknown2;
+	u16 ref_freq;
+	u16 ref_divider;
+	u16 unknown3;
+	u16 MCLK_pwd;
+	u16 MCLK_max_freq;
+	u16 XCLK_max_freq;
+	u16 SCLK_freq;
+} __attribute__ ((packed)) PLL_BLOCK_MACH64;
+
 struct pll_514 {
 	u8 m;
 	u8 n;
@@ -36,16 +82,39 @@
 	u8 pll_ref_div;
 	u8 pll_gen_cntl;
 	u8 mclk_fb_div;
+	u8 mclk_fb_mult; /* 2 ro 4 */
+/*	u8 sclk_fb_div;*/
 	u8 pll_vclk_cntl;
 	u8 vclk_post_div;
 	u8 vclk_fb_div;
 	u8 pll_ext_cntl;
=2D	u32 dsp_config;		/* Mach64 GTB DSP */
=2D	u32 dsp_on_off;		/* Mach64 GTB DSP */
+/*	u8 ext_vpll_cntl;
+	u8 spll_cntl2;*/
+	u32 dsp_config; /* Mach64 GTB DSP */
+	u32 dsp_on_off; /* Mach64 GTB DSP */
+	u32 dsp_loop_latency;
+	u32 fifo_size;
+	u32 xclkpagefaultdelay;
+	u32 xclkmaxrasdelay;
+	u8 xclk_ref_div;
+	u8 xclk_post_div;
 	u8 mclk_post_div_real;
+	u8 xclk_post_div_real;
 	u8 vclk_post_div_real;
+	u8 features;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	u32 xres; /* use for LCD stretching/scaling */
+#endif
 };
=20
+/*
+	for pll_ct.features
+*/
+#define DONT_USE_SPLL 0x1
+#define DONT_USE_XDLL 0x2
+#define USE_CPUCLK    0x4
+#define POWERDOWN_PLL 0x8
+
 union aty_pll {
 	struct pll_ct ct;
 	struct pll_514 ibm514;
@@ -56,42 +125,68 @@
      *  The hardware parameters for each card
      */
=20
=2Dstruct aty_cursor {
=2D	u8 bits[8][64];
=2D	u8 mask[8][64];
=2D	u8 *ram;
=2D};
=2D
 struct atyfb_par {
 	struct aty_cmap_regs *aty_cmap_regs;
+	struct { u8 red, green, blue; } palette[256];
 	const struct aty_dac_ops *dac_ops;
 	const struct aty_pll_ops *pll_ops;
=2D	struct aty_cursor *cursor;
=2D	unsigned long ati_regbase;
=2D	unsigned long clk_wr_offset;
+	void *ati_regbase;
+	unsigned long clk_wr_offset; /* meaning overloaded, clock id by CT */
 	struct crtc crtc;
 	union aty_pll pll;
+	struct pll_info pll_limits;
 	u32 features;
 	u32 ref_clk_per;
 	u32 pll_per;
 	u32 mclk_per;
+	u32 xclk_per;
 	u8 bus_type;
 	u8 ram_type;
 	u8 mem_refresh_rate;
=2D	u8 blitter_may_be_busy;
+	u16 pci_id;
 	u32 accel_flags;
+	int blitter_may_be_busy;
+	int asleep;
+	int lock_blank;
+	unsigned long res_start;
+	unsigned long res_size;
 #ifdef __sparc__
 	struct pci_mmap_map *mmap_map;
 	u8 mmaped;
+#endif
 	int open;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	unsigned long bios_base_phys;
+	unsigned long bios_base;
+	unsigned long lcd_table;
+	u16 lcd_width;
+	u16 lcd_height;
+	u32 lcd_pixclock;
+	u16 lcd_refreshrate;
+	u16 lcd_htotal;
+	u16 lcd_hdisp;
+	u16 lcd_hsync_dly;
+	u16 lcd_hsync_len;
+	u16 lcd_vtotal;
+	u16 lcd_vdisp;
+	u16 lcd_vsync_len;
+	u16 lcd_right_margin;
+	u16 lcd_lower_margin;
+	u16 lcd_hblank_len;
+	u16 lcd_vblank_len;
 #endif
=2D#ifdef CONFIG_PMAC_PBOOK
=2D	struct fb_info *next;
=2D	unsigned char *save_framebuffer;
=2D	unsigned long save_pll[64];
+	unsigned long aux_start; /* auxiliary aperture */
+	unsigned long aux_size;
+	struct aty_interrupt vblank;
+	unsigned long irq_flags;
+	unsigned int irq;
+	spinlock_t int_lock;
+#ifdef CONFIG_MTRR
+	int mtrr_aper;
+	int mtrr_reg;
 #endif
 };
=2D   =20
+
     /*
      *  ATI Mach64 features
      */
@@ -101,7 +196,7 @@
 #define M64F_RESET_3D		0x00000001
 #define M64F_MAGIC_FIFO		0x00000002
 #define M64F_GTB_DSP		0x00000004
=2D#define M64F_FIFO_24		0x00000008
+#define M64F_FIFO_32		0x00000008
 #define M64F_SDRAM_MAGIC_PLL	0x00000010
 #define M64F_MAGIC_POSTDIV	0x00000020
 #define M64F_INTEGRATED		0x00000040
@@ -116,9 +211,10 @@
 #define M64F_G3_PB_1_1		0x00008000
 #define M64F_G3_PB_1024x768	0x00010000
 #define M64F_EXTRA_BRIGHT	0x00020000
=2D#define M64F_LT_SLEEP		0x00040000
+#define M64F_LT_LCD_REGS	0x00040000
 #define M64F_XL_DLL		0x00080000
=2D
+#define M64F_MFB_FORCE_4	0x00100000
+#define M64F_HW_TRIPLE		0x00200000
=20
     /*
      *  Register access
@@ -137,8 +233,7 @@
 #endif
 }
=20
=2Dstatic inline void aty_st_le32(int regindex, u32 val,
=2D			       const struct atyfb_par *par)
+static inline void aty_st_le32(int regindex, u32 val, const struct atyfb_p=
ar *par)
 {
 	/* Hack for bloc 1, should be cleanly optimized by compiler */
 	if (regindex >=3D 0x400)
@@ -163,8 +258,7 @@
 #endif
 }
=20
=2Dstatic inline void aty_st_8(int regindex, u8 val,
=2D			    const struct atyfb_par *par)
+static inline void aty_st_8(int regindex, u8 val, const struct atyfb_par *=
par)
 {
 	/* Hack for bloc 1, should be cleanly optimized by compiler */
 	if (regindex >=3D 0x400)
@@ -177,17 +271,10 @@
 #endif
 }
=20
=2Dstatic inline u8 aty_ld_pll(int offset, const struct atyfb_par *par)
=2D{
=2D	u8 res;
=2D
=2D	/* write addr byte */
=2D	aty_st_8(CLOCK_CNTL + 1, (offset << 2), par);
=2D	/* read the register value */
=2D	res =3D aty_ld_8(CLOCK_CNTL + 2, par);
=2D	return res;
=2D}
=2D
+#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFI=
G_FB_ATY_GENERIC_LCD)
+extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
+extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
+#endif
=20
     /*
      *  DAC operations
@@ -195,14 +282,14 @@
=20
 struct aty_dac_ops {
 	int (*set_dac) (const struct fb_info * info,
=2D			const union aty_pll * pll, u32 bpp, u32 accel);
+		const union aty_pll * pll, u32 bpp, u32 accel);
 };
=20
=2Dextern const struct aty_dac_ops aty_dac_ibm514;	/* IBM RGB514 */
=2Dextern const struct aty_dac_ops aty_dac_ati68860b;	/* ATI 68860-B */
=2Dextern const struct aty_dac_ops aty_dac_att21c498;	/* AT&T 21C498 */
=2Dextern const struct aty_dac_ops aty_dac_unsupported;	/* unsupported */
=2Dextern const struct aty_dac_ops aty_dac_ct;	/* Integrated */
+extern const struct aty_dac_ops aty_dac_ibm514; /* IBM RGB514 */
+extern const struct aty_dac_ops aty_dac_ati68860b; /* ATI 68860-B */
+extern const struct aty_dac_ops aty_dac_att21c498; /* AT&T 21C498 */
+extern const struct aty_dac_ops aty_dac_unsupported; /* unsupported */
+extern const struct aty_dac_ops aty_dac_ct; /* Integrated */
=20
=20
     /*
@@ -210,37 +297,32 @@
      */
=20
 struct aty_pll_ops {
=2D	int (*var_to_pll) (const struct fb_info * info, u32 vclk_per,
=2D			   u8 bpp, union aty_pll * pll);
=2D	 u32(*pll_to_var) (const struct fb_info * info,
=2D			   const union aty_pll * pll);
=2D	void (*set_pll) (const struct fb_info * info,
=2D			 const union aty_pll * pll);
+	int (*var_to_pll) (const struct fb_info * info, u32 vclk_per, u32 bpp, un=
ion aty_pll * pll);
+	u32 (*pll_to_var) (const struct fb_info * info, const union aty_pll * pll=
);
+	void (*set_pll)   (const struct fb_info * info, const union aty_pll * pll=
);
+	void (*get_pll)   (const struct fb_info *info, union aty_pll * pll);
+	int (*init_pll)   (const struct fb_info * info, union aty_pll * pll);
 };
=20
=2Dextern const struct aty_pll_ops aty_pll_ati18818_1;	/* ATI 18818 */
=2Dextern const struct aty_pll_ops aty_pll_stg1703;	/* STG 1703 */
=2Dextern const struct aty_pll_ops aty_pll_ch8398;	/* Chrontel 8398 */
=2Dextern const struct aty_pll_ops aty_pll_att20c408;	/* AT&T 20C408 */
=2Dextern const struct aty_pll_ops aty_pll_ibm514;	/* IBM RGB514 */
=2Dextern const struct aty_pll_ops aty_pll_unsupported;	/* unsupported */
=2Dextern const struct aty_pll_ops aty_pll_ct;	/* Integrated */
+extern const struct aty_pll_ops aty_pll_ati18818_1; /* ATI 18818 */
+extern const struct aty_pll_ops aty_pll_stg1703; /* STG 1703 */
+extern const struct aty_pll_ops aty_pll_ch8398; /* Chrontel 8398 */
+extern const struct aty_pll_ops aty_pll_att20c408; /* AT&T 20C408 */
+extern const struct aty_pll_ops aty_pll_ibm514; /* IBM RGB514 */
+extern const struct aty_pll_ops aty_pll_unsupported; /* unsupported */
+extern const struct aty_pll_ops aty_pll_ct; /* Integrated */
=20
=20
=2Dextern void aty_set_pll_ct(const struct fb_info *info,
=2D			   const union aty_pll *pll);
=2Dextern void aty_calc_pll_ct(const struct fb_info *info,
=2D			    struct pll_ct *pll);
+extern void aty_set_pll_ct(const struct fb_info *info, const union aty_pll=
 *pll);
+extern u8 aty_ld_pll_ct(int offset, const struct atyfb_par *par);
=20
=20
     /*
      *  Hardware cursor support
      */
=20
=2Dextern struct aty_cursor *aty_init_cursor(struct fb_info *info);
+extern int aty_init_cursor(struct fb_info *info);
 extern int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor);
=2Dextern void aty_set_cursor_color(struct fb_info *info);
=2Dextern void aty_set_cursor_shape(struct fb_info *info);
=20
     /*
      *  Hardware acceleration
@@ -260,6 +342,5 @@
 }
=20
 extern void aty_reset_engine(const struct atyfb_par *par);
=2Dextern void aty_init_engine(struct atyfb_par *par,
=2D			    struct fb_info *info);
+extern void aty_init_engine(struct atyfb_par *par, struct fb_info *info);
=20
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
=2D-- a/drivers/video/aty/atyfb_base.c	2004-10-19 20:22:41 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2004-10-11 04:38:39 +08:00
@@ -1,6 +1,7 @@
 /*
  *  ATI Frame Buffer Device Driver Core
  *
+ *	Copyright (C) 2004  Alex Kern <alex.kern@gmx.de>
  *	Copyright (C) 1997-2001  Geert Uytterhoeven
  *	Copyright (C) 1998  Bernd Harries
  *	Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
@@ -24,10 +25,13 @@
  *			   Harry AC Eaton
  *			   Anthony Tong <atong@uiuc.edu>
  *
+ *  Generic LCD support written by Daniel Mantione, ported from 2.4.20 by =
Alex Kern
+ *  Many Thanks to Ville Syrj=E4l=E4 for patches and fixing nasting 16 bit=
 color bug.
+ *
  *  This file is subject to the terms and conditions of the GNU General Pu=
blic
  *  License. See the file COPYING in the main directory of this archive for
  *  more details.
=2D * =20
+ *
  *  Many thanks to Nitya from ATI devrel for support and patience !
  */
=20
@@ -38,15 +42,16 @@
     - cursor support on all cards and all ramdacs.
     - cursor parameters controlable via ioctl()s.
     - guess PLL and MCLK based on the original PLL register values initial=
ized
=2D      by the BIOS or Open Firmware (if they are initialized).
+      by Open Firmware (if they are initialized). BIOS is done
=20
=2D						(Anyone to help with this?)
+    (Anyone with Mac to help with this?)
=20
 **************************************************************************=
****/
=20
=20
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -54,19 +59,20 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
=2D#include <linux/selection.h>
 #include <linux/console.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
=2D#include <linux/vt_kern.h>
=2D#include <linux/kd.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
=20
 #include <asm/io.h>
 #include <asm/uaccess.h>
=20
 #include <video/mach64.h>
 #include "atyfb.h"
+#include "ati_ids.h"
=20
 #ifdef __powerpc__
 #include <asm/prom.h>
@@ -87,23 +93,102 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
=2D
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
=20
 /*
  * Debug flags.
  */
=2D#undef DEBUG
+/*#undef DEBUG*/
+#define DEBUG
=20
 /* Make sure n * PAGE_SIZE is protected at end of Aperture for GUI-regs */
 /*  - must be large enough to catch all GUI-Regs   */
 /*  - must be aligned to a PAGE boundary           */
 #define GUI_RESERVE	(1 * PAGE_SIZE)
=20
=2D
 /* FIXME: remove the FAIL definition */
=2D#define FAIL(x) do { printk(x "\n"); return -EINVAL; } while (0)
+#define FAIL(msg) do { printk(KERN_CRIT "atyfb: " msg "\n"); return -EINVA=
L; } while (0)
+#define FAIL_MAX(msg, x, _max_) do { if(x > _max_) { printk(KERN_CRIT "aty=
fb: " msg " %x(%x)\n", x, _max_); return -EINVAL; } } while (0)
+
+#ifdef DEBUG
+#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "atyfb: " fmt, ## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
+#define PRINTKE(fmt, args...)	 printk(KERN_ERR "atyfb: " fmt, ## args)
+
+#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFI=
G_FB_ATY_GENERIC_LCD)
+static const u32 lt_lcd_regs[] =3D {
+	CONFIG_PANEL_LG,
+	LCD_GEN_CNTL_LG,
+	DSTN_CONTROL_LG,
+	HFB_PITCH_ADDR_LG,
+	HORZ_STRETCHING_LG,
+	VERT_STRETCHING_LG,
+	0, /* EXT_VERT_STRETCH */
+	LT_GIO_LG,
+	POWER_MANAGEMENT_LG
+};
+
+void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
+{
+	if (M64_HAS(LT_LCD_REGS)) {
+		aty_st_le32(lt_lcd_regs[index], val, par);
+	} else {
+		unsigned long temp;
+
+		/* write addr byte */
+		temp =3D aty_ld_le32(LCD_INDEX, par);
+		aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
+		/* write the register value */
+		aty_st_le32(LCD_DATA, val, par);
+	}
+}
+
+u32 aty_ld_lcd(int index, const struct atyfb_par *par)
+{
+	if (M64_HAS(LT_LCD_REGS)) {
+		return aty_ld_le32(lt_lcd_regs[index], par);
+	} else {
+		unsigned long temp;
+
+		/* write addr byte */
+		temp =3D aty_ld_le32(LCD_INDEX, par);
+		aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
+		/* read the register value */
+		return aty_ld_le32(LCD_DATA, par);
+	}
+}
+#endif /* defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined =
(CONFIG_FB_ATY_GENERIC_LCD) */
+
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+/*
+ * ATIReduceRatio --
+ *
+ * Reduce a fraction by factoring out the largest common divider of the
+ * fraction's numerator and denominator.
+ */
+static void ATIReduceRatio(int *Numerator, int *Denominator)
+{
+    int Multiplier, Divider, Remainder;
=20
+    Multiplier =3D *Numerator;
+    Divider =3D *Denominator;
=20
+    while ((Remainder =3D Multiplier % Divider))
+    {
+        Multiplier =3D Divider;
+        Divider =3D Remainder;
+    }
+
+    *Numerator /=3D Divider;
+    *Denominator /=3D Divider;
+}
+#endif
     /*
      *  The Hardware parameters for each card
      */
@@ -138,22 +223,19 @@
=20
 static int atyfb_open(struct fb_info *info, int user);
 static int atyfb_release(struct fb_info *info, int user);
=2Dstatic int atyfb_check_var(struct fb_var_screeninfo *var,
=2D			   struct fb_info *info);
=2Dstatic int atyfb_set_par(struct fb_info *info);=20
+static int atyfb_check_var(struct fb_var_screeninfo *var, struct fb_info *=
info);
+static int atyfb_set_par(struct fb_info *info);
 static int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
=2D			   u_int transp, struct fb_info *info);
=2Dstatic int atyfb_pan_display(struct fb_var_screeninfo *var,
=2D			     struct fb_info *info);
+	u_int transp, struct fb_info *info);
+static int atyfb_pan_display(struct fb_var_screeninfo *var, struct fb_info=
 *info);
 static int atyfb_blank(int blank, struct fb_info *info);
 static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
=2D		       u_long arg, struct fb_info *info);
+	u_long arg, struct fb_info *info);
 extern void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect =
*rect);
 extern void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea =
*area);
 extern void atyfb_imageblit(struct fb_info *info, const struct fb_image *i=
mage);
 #ifdef __sparc__
=2Dstatic int atyfb_mmap(struct fb_info *info, struct file *file,
=2D		      struct vm_area_struct *vma);
+static int atyfb_mmap(struct fb_info *info, struct file *file, struct vm_a=
rea_struct *vma);
 #endif
 static int atyfb_sync(struct fb_info *info);
=20
@@ -166,15 +248,14 @@
 static int store_video_par(char *videopar, unsigned char m64_num);
 #endif
=20
=2Dstatic void aty_set_crtc(const struct atyfb_par *par,
=2D			 const struct crtc *crtc);
=2Dstatic int aty_var_to_crtc(const struct fb_info *info,
=2D			   const struct fb_var_screeninfo *var,
=2D			   struct crtc *crtc);
=2Dstatic int aty_crtc_to_var(const struct crtc *crtc,
=2D			   struct fb_var_screeninfo *var);
=2Dstatic void set_off_pitch(struct atyfb_par *par,
=2D			  const struct fb_info *info);
+static struct crtc saved_crtc;
+static union aty_pll saved_pll;
+static void aty_get_crtc(const struct atyfb_par *par, struct crtc *crtc);
+
+static void aty_set_crtc(const struct atyfb_par *par, const struct crtc *c=
rtc);
+static int aty_var_to_crtc(const struct fb_info *info, const struct fb_var=
_screeninfo *var, struct crtc *crtc);
+static int aty_crtc_to_var(const struct crtc *crtc, struct fb_var_screenin=
fo *var);
+static void set_off_pitch(struct atyfb_par *par, const struct fb_info *inf=
o);
 #ifdef CONFIG_PPC
 static int read_aty_sense(const struct atyfb_par *par);
 #endif
@@ -184,10 +265,19 @@
      *  Interface used by the world
      */
=20
=2Dint atyfb_init(void);
=2D#ifndef MODULE
=2Dint atyfb_setup(char *);
=2D#endif
+struct fb_var_screeninfo default_var =3D {
+	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
+	640, 480, 640, 480, 0, 0, 8, 0,
+	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
+	0, 0, -1, -1, 0, 39722, 48, 16, 33, 10, 96, 2,
+	0, FB_VMODE_NONINTERLACED
+};
+
+static struct fb_videomode defmode =3D {
+	/* 640x480 @ 60 Hz, 31.5 kHz hsync */
+	NULL, 60, 640, 480, 39721, 40, 24, 32, 11, 96, 2,
+	0, FB_VMODE_NONINTERLACED
+};
=20
 static struct fb_ops atyfb_ops =3D {
 	.owner		=3D THIS_MODULE,
@@ -202,22 +292,22 @@
 	.fb_fillrect	=3D atyfb_fillrect,
 	.fb_copyarea	=3D atyfb_copyarea,
 	.fb_imageblit	=3D atyfb_imageblit,
=2D	.fb_cursor	=3D soft_cursor,
+	.fb_cursor	=3D atyfb_cursor,
 #ifdef __sparc__
 	.fb_mmap	=3D atyfb_mmap,
 #endif
 	.fb_sync	=3D atyfb_sync,
 };
=20
=2Dstatic char curblink __initdata =3D 1;
=2Dstatic char noaccel __initdata =3D 0;
=2Dstatic u32 default_vram __initdata =3D 0;
=2Dstatic int default_pll __initdata =3D 0;
=2Dstatic int default_mclk __initdata =3D 0;
=2D
=2D#ifndef MODULE
=2Dstatic char *mode_option __initdata =3D NULL;
=2D#endif
+static int noaccel;
+#ifdef CONFIG_MTRR
+static int nomtrr;
+#endif
+static int vram;
+static int pll;
+static int mclk;
+static int xclk;
+static char *mode;
=20
 #ifdef CONFIG_PPC
 static int default_vmode __initdata =3D VMODE_CHOOSE;
@@ -231,177 +321,185 @@
 static unsigned long phys_guiregbase[FB_MAX] __initdata =3D { 0, };
 #endif
=20
=2D#ifdef CONFIG_FB_ATY_GX
=2Dstatic char m64n_gx[] __initdata =3D "mach64GX (ATI888GX00)";
=2Dstatic char m64n_cx[] __initdata =3D "mach64CX (ATI888CX00)";
=2D#endif /* CONFIG_FB_ATY_GX */
=2D#ifdef CONFIG_FB_ATY_CT
=2Dstatic char m64n_ct[] __initdata =3D "mach64CT (ATI264CT)";
=2Dstatic char m64n_et[] __initdata =3D "mach64ET (ATI264ET)";
=2Dstatic char m64n_vta3[] __initdata =3D "mach64VTA3 (ATI264VT)";
=2Dstatic char m64n_vta4[] __initdata =3D "mach64VTA4 (ATI264VT)";
=2Dstatic char m64n_vtb[] __initdata =3D "mach64VTB (ATI264VTB)";
=2Dstatic char m64n_vt4[] __initdata =3D "mach64VT4 (ATI264VT4)";
=2Dstatic char m64n_gt[] __initdata =3D "3D RAGE (GT)";
=2Dstatic char m64n_gtb[] __initdata =3D "3D RAGE II+ (GTB)";
=2Dstatic char m64n_iic_p[] __initdata =3D "3D RAGE IIC (PCI)";
=2Dstatic char m64n_iic_a[] __initdata =3D "3D RAGE IIC (AGP)";
=2Dstatic char m64n_lt[] __initdata =3D "3D RAGE LT";
=2Dstatic char m64n_ltg[] __initdata =3D "3D RAGE LT-G";
=2Dstatic char m64n_gtc_ba[] __initdata =3D "3D RAGE PRO (BGA, AGP)";
=2Dstatic char m64n_gtc_ba1[] __initdata =3D "3D RAGE PRO (BGA, AGP, 1x onl=
y)";
=2Dstatic char m64n_gtc_bp[] __initdata =3D "3D RAGE PRO (BGA, PCI)";
=2Dstatic char m64n_gtc_pp[] __initdata =3D "3D RAGE PRO (PQFP, PCI)";
=2Dstatic char m64n_gtc_ppl[] __initdata =3D
=2D    "3D RAGE PRO (PQFP, PCI, limited 3D)";
=2Dstatic char m64n_xl[] __initdata =3D "3D RAGE (XL)";
=2Dstatic char m64n_ltp_a[] __initdata =3D "3D RAGE LT PRO (AGP)";
=2Dstatic char m64n_ltp_p[] __initdata =3D "3D RAGE LT PRO (PCI)";
=2Dstatic char m64n_mob_p[] __initdata =3D "3D RAGE Mobility (PCI)";
=2Dstatic char m64n_mob_a[] __initdata =3D "3D RAGE Mobility (AGP)";
=2D#endif /* CONFIG_FB_ATY_CT */
+/* top -> down is an evolution of mach64 chipset, any corrections? */
+#define ATI_CHIP_88800GX   (M64F_GX)
+#define ATI_CHIP_88800CX   (M64F_GX)
+
+#define ATI_CHIP_264CT     (M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F=
_MAGIC_FIFO)
+#define ATI_CHIP_264ET     (M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F=
_MAGIC_FIFO)
+
+#define ATI_CHIP_264VT     (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F=
_MAGIC_FIFO)
+#define ATI_CHIP_264GT     (M64F_GT | M64F_INTEGRATED               | M64F=
_MAGIC_FIFO | M64F_EXTRA_BRIGHT)
+
+#define ATI_CHIP_264VTB    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F=
_GTB_DSP)
+#define ATI_CHIP_264VT3    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F=
_GTB_DSP | M64F_SDRAM_MAGIC_PLL)
+#define ATI_CHIP_264VT4    (M64F_VT | M64F_INTEGRATED               | M64F=
_GTB_DSP)
+
+#define ATI_CHIP_264LT     (M64F_GT | M64F_INTEGRATED               | M64F=
_GTB_DSP)
+
+/* make sets shorter */
+#define ATI_MODERN_SET     (M64F_GT | M64F_INTEGRATED               | M64F=
_GTB_DSP | M64F_EXTRA_BRIGHT)
+
+#define ATI_CHIP_264GTB    (ATI_MODERN_SET | M64F_SDRAM_MAGIC_PLL)
+/*#define ATI_CHIP_264GTDVD  ?*/
+#define ATI_CHIP_264LTG    (ATI_MODERN_SET | M64F_SDRAM_MAGIC_PLL)
+
+#define ATI_CHIP_264GT2C   (ATI_MODERN_SET | M64F_SDRAM_MAGIC_PLL | M64F_H=
W_TRIPLE)
+#define ATI_CHIP_264GTPRO  (ATI_MODERN_SET | M64F_SDRAM_MAGIC_PLL | M64F_H=
W_TRIPLE | M64F_FIFO_32 | M64F_RESET_3D)
+#define ATI_CHIP_264LTPRO  (ATI_MODERN_SET | M64F_HW_TRIPLE | M64F_FIFO_32=
 | M64F_RESET_3D)
+
+#define ATI_CHIP_264XL     (ATI_MODERN_SET | M64F_HW_TRIPLE | M64F_FIFO_32=
 | M64F_RESET_3D | M64F_XL_DLL | M64F_MFB_FORCE_4)
+#define ATI_CHIP_MOBILITY  (ATI_MODERN_SET | M64F_HW_TRIPLE | M64F_FIFO_32=
 | M64F_RESET_3D | M64F_XL_DLL | M64F_MFB_FORCE_4 | M64F_MOBIL_BUS)
=20
 static struct {
=2D	u16 pci_id, chip_type;
=2D	u8 rev_mask, rev_val;
+	u16 pci_id;
 	const char *name;
=2D	int pll, mclk;
+	int pll, mclk, xclk;
 	u32 features;
 } aty_chips[] __initdata =3D {
 #ifdef CONFIG_FB_ATY_GX
 	/* Mach64 GX */
=2D	{
=2D	0x4758, 0x00d7, 0x00, 0x00, m64n_gx, 135, 50, M64F_GX}, {
=2D	0x4358, 0x0057, 0x00, 0x00, m64n_cx, 135, 50, M64F_GX},
=2D#endif				/* CONFIG_FB_ATY_GX */
+	{ PCI_CHIP_MACH64GX, "ATI888GX00 (Mach64 GX)", 135, 50, 50, ATI_CHIP_8880=
0GX },
+	{ PCI_CHIP_MACH64CX, "ATI888CX00 (Mach64 CX)", 135, 50, 50, ATI_CHIP_8880=
0CX },
+#endif /* CONFIG_FB_ATY_GX */
+
 #ifdef CONFIG_FB_ATY_CT
=2D	    /* Mach64 CT */
=2D	{
=2D	0x4354, 0x4354, 0x00, 0x00, m64n_ct, 135, 60,
=2D		    M64F_CT | M64F_INTEGRATED | M64F_CT_BUS |
=2D		    M64F_MAGIC_FIFO}, {
=2D	0x4554, 0x4554, 0x00, 0x00, m64n_et, 135, 60,
=2D		    M64F_CT | M64F_INTEGRATED | M64F_CT_BUS |
=2D		    M64F_MAGIC_FIFO},
=2D	    /* Mach64 VT */
=2D	{
=2D	0x5654, 0x5654, 0xc7, 0x00, m64n_vta3, 170, 67,
=2D		    M64F_VT | M64F_INTEGRATED | M64F_VT_BUS |
=2D		    M64F_MAGIC_FIFO | M64F_FIFO_24}, {
=2D	0x5654, 0x5654, 0xc7, 0x40, m64n_vta4, 200, 67,
=2D		    M64F_VT | M64F_INTEGRATED | M64F_VT_BUS |
=2D		    M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_MAGIC_POSTDIV}, {
=2D	0x5654, 0x5654, 0x00, 0x00, m64n_vtb, 200, 67,
=2D		    M64F_VT | M64F_INTEGRATED | M64F_VT_BUS |
=2D		    M64F_GTB_DSP | M64F_FIFO_24}, {
=2D	0x5655, 0x5655, 0x00, 0x00, m64n_vtb, 200, 67,
=2D		    M64F_VT | M64F_INTEGRATED | M64F_VT_BUS |
=2D		    M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL}, {
=2D	0x5656, 0x5656, 0x00, 0x00, m64n_vt4, 230, 83,
=2D		    M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP},
=2D	    /* Mach64 GT (3D RAGE) */
=2D	{
=2D	0x4754, 0x4754, 0x07, 0x00, m64n_gt, 135, 63,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO |
=2D		    M64F_FIFO_24 | M64F_EXTRA_BRIGHT}, {
=2D	0x4754, 0x4754, 0x07, 0x01, m64n_gt, 170, 67,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
=2D		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT}, {
=2D	0x4754, 0x4754, 0x07, 0x02, m64n_gt, 200, 67,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
=2D		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT}, {
=2D	0x4755, 0x4755, 0x00, 0x00, m64n_gtb, 200, 67,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
=2D		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT}, {
=2D	0x4756, 0x4756, 0x00, 0x00, m64n_iic_p, 230, 83,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
=2D		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT}, {
=2D	0x4757, 0x4757, 0x00, 0x00, m64n_iic_a, 230, 83,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
=2D		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT}, {
=2D	0x475a, 0x475a, 0x00, 0x00, m64n_iic_a, 230, 83,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
=2D		    M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT},
=2D	    /* Mach64 LT */
=2D	{
=2D	0x4c54, 0x4c54, 0x00, 0x00, m64n_lt, 135, 63,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP}, {
=2D	0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg, 230, 63,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP |
=2D		    M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT |
=2D		    M64F_LT_SLEEP | M64F_G3_PB_1024x768},
=2D	    /* Mach64 GTC (3D RAGE PRO) */
=2D	{
=2D	0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT}, {
=2D	0x4744, 0x4744, 0x00, 0x00, m64n_gtc_ba1, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT}, {
=2D	0x4749, 0x4749, 0x00, 0x00, m64n_gtc_bp, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT | M64F_MAGIC_VRAM_SIZE}, {
=2D	0x4750, 0x4750, 0x00, 0x00, m64n_gtc_pp, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT}, {
=2D	0x4751, 0x4751, 0x00, 0x00, m64n_gtc_ppl, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT},
=2D	    /* 3D RAGE XL */
=2D	{
=2D	0x4752, 0x4752, 0x00, 0x00, m64n_xl, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
=2D		    M64F_EXTRA_BRIGHT | M64F_XL_DLL},
=2D	    /* Mach64 LT PRO */
=2D	{
=2D	0x4c42, 0x4c42, 0x00, 0x00, m64n_ltp_a, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP}, {
=2D	0x4c44, 0x4c44, 0x00, 0x00, m64n_ltp_p, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP}, {
=2D	0x4c49, 0x4c49, 0x00, 0x00, m64n_ltp_p, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP | M64F_EXTRA_BRIGHT |
=2D		    M64F_G3_PB_1_1 | M64F_G3_PB_1024x768}, {
=2D	0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p, 230, 100,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP},
=2D	    /* 3D RAGE Mobility */
=2D	{
=2D	0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p, 230, 50,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP | M64F_MOBIL_BUS}, {
=2D	0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a, 230, 50,
=2D		    M64F_GT | M64F_INTEGRATED | M64F_RESET_3D |
=2D		    M64F_GTB_DSP | M64F_MOBIL_BUS},
=2D#endif				/* CONFIG_FB_ATY_CT */
+	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, ATI_CHIP_264CT =
},
+	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, ATI_CHIP_264ET =
},
+	{ PCI_CHIP_MACH64VT, "ATI264VT? (Mach64 VT)", 170, 67, 67, ATI_CHIP_264VT=
 },
+	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, ATI_CHIP_264GT },
+	/* FIXME { ...ATI_264GU, maybe ATI_CHIP_264GTDVD }, */
+	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GTB)", 200, 67, 67, ATI_CHIP_26=
4GTB  },
+	{ PCI_CHIP_MACH64VU, "ATI264VTB (Mach64 VU)", 200, 67, 67, ATI_CHIP_264VT=
3 },
+
+	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, ATI_CHIP_264L=
T },
+	 /* FIXME chipset maybe ATI_CHIP_264LTPRO ? */
+	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, ATI_CHIP_26=
4LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
+
+	{ PCI_CHIP_MACH64VV, "ATI264VT4 (Mach64 VV)", 230, 83, 83, ATI_CHIP_264VT=
4 },
+
+	{ PCI_CHIP_MACH64GV, "3D RAGE IIC (Mach64 GV, PCI)", 230, 83, 83, ATI_CHI=
P_264GT2C },
+	{ PCI_CHIP_MACH64GW, "3D RAGE IIC (Mach64 GW, AGP)", 230, 83, 83, ATI_CHI=
P_264GT2C },
+	{ PCI_CHIP_MACH64GY, "3D RAGE IIC (Mach64 GY, PCI)", 230, 83, 83, ATI_CHI=
P_264GT2C },
+	{ PCI_CHIP_MACH64GZ, "3D RAGE IIC (Mach64 GZ, AGP)", 230, 83, 83, ATI_CHI=
P_264GT2C },
+
+	{ PCI_CHIP_MACH64GB, "3D RAGE PRO (Mach64 GB, BGA, AGP)", 230, 100, 100, =
ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GD, "3D RAGE PRO (Mach64 GD, BGA, AGP 1x)", 230, 100, 10=
0, ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GI, "3D RAGE PRO (Mach64 GI, BGA, PCI)", 230, 100, 100, =
ATI_CHIP_264GTPRO | M64F_MAGIC_VRAM_SIZE },
+	{ PCI_CHIP_MACH64GP, "3D RAGE PRO (Mach64 GP, PQFP, PCI)", 230, 100, 100,=
 ATI_CHIP_264GTPRO },
+	{ PCI_CHIP_MACH64GQ, "3D RAGE PRO (Mach64 GQ, PQFP, PCI, limited 3D)", 23=
0, 100, 100, ATI_CHIP_264GTPRO },
+
+	{ PCI_CHIP_MACH64LB, "3D RAGE LT PRO (Mach64 LB, AGP)", 236, 75, 100, ATI=
_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LD, "3D RAGE LT PRO (Mach64 LD, AGP)", 230, 100, 100, AT=
I_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LI, "3D RAGE LT PRO (Mach64 LI, PCI)", 230, 100, 100, AT=
I_CHIP_264LTPRO | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
+	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, AT=
I_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, AT=
I_CHIP_264LTPRO },
+
+	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, ATI_CHIP=
_264XL },
+	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, ATI_CHIP=
_264XL },
+	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, A=
TI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, AT=
I_CHIP_264XL },
+	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, ATI_CHIP=
_264XL },
+	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, ATI_CHIP=
_264XL },
+
+	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83,=
 125, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83, 1=
25, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility P/M (Mach64 LR, PCI)", 230, 83, 12=
5, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility L (Mach64 LS, PCI)", 230, 83, 125,=
 ATI_CHIP_MOBILITY },
+#endif /* CONFIG_FB_ATY_CT */
 };
=20
+/* can not fail */
+static int __devinit correct_chipset(struct atyfb_par *par)
+{
+	u8 rev;
+	u16 type;
+	u32 chip_id;
+	const char *name;
+	int i;
+
+	for (i =3D sizeof(aty_chips) / sizeof(*aty_chips) - 1; i >=3D 0; i--)
+		if (par->pci_id =3D=3D aty_chips[i].pci_id)
+			break;
+
+	name =3D aty_chips[i].name;
+	par->pll_limits.pll_max =3D aty_chips[i].pll;
+	par->pll_limits.mclk =3D aty_chips[i].mclk;
+	par->pll_limits.xclk =3D aty_chips[i].xclk;
+	par->features =3D aty_chips[i].features;
+
+	chip_id =3D aty_ld_le32(CONFIG_CHIP_ID, par);
+	type =3D chip_id & CFG_CHIP_TYPE;
+	rev =3D (chip_id & CFG_CHIP_REV) >> 24;
+
+	switch(par->pci_id) {
+#ifdef CONFIG_FB_ATY_GX
+	case PCI_CHIP_MACH64GX:
+		if(type !=3D 0x00d7);
+			return -ENODEV;
+		break;
+	case PCI_CHIP_MACH64CX:
+		if(type !=3D 0x0057);
+			return -ENODEV;
+		break;
+#endif
+#ifdef CONFIG_FB_ATY_CT
+	case PCI_CHIP_MACH64VT:
+		rev &=3D 0xc7;
+		if(rev =3D=3D 0x00) {
+			name =3D "ATI264VTA3 (Mach64 VT)";
+			par->pll_limits.pll_max =3D 170;
+			par->pll_limits.mclk =3D 67;
+			par->pll_limits.xclk =3D 67;
+			par->features =3D ATI_CHIP_264VT;
+		} else if(rev =3D=3D 0x40) {
+			name =3D "ATI264VTA4 (Mach64 VT)";
+			par->pll_limits.pll_max =3D 200;
+			par->pll_limits.mclk =3D 67;
+			par->pll_limits.xclk =3D 67;
+			par->features =3D ATI_CHIP_264VT | M64F_MAGIC_POSTDIV;
+		} else {
+			name =3D "ATI264VTB (Mach64 VT)";
+			par->pll_limits.pll_max =3D 200;
+			par->pll_limits.mclk =3D 67;
+			par->pll_limits.xclk =3D 67;
+			par->features =3D ATI_CHIP_264VTB;
+		}
+		break;
+	case PCI_CHIP_MACH64GT:
+		rev &=3D 0x07;
+		if(rev =3D=3D 0x01) {
+			par->pll_limits.pll_max =3D 170;
+			par->pll_limits.mclk =3D 67;
+			par->pll_limits.xclk =3D 67;
+			par->features =3D ATI_CHIP_264GTB;
+		} else if(rev =3D=3D 0x02) {
+			par->pll_limits.pll_max =3D 200;
+			par->pll_limits.mclk =3D 67;
+			par->pll_limits.xclk =3D 67;
+			par->features =3D ATI_CHIP_264GTB;
+		}
+		break;
+#endif
+	}
+
+	PRINTKI("%s [0x%04x rev 0x%02x]\n", name, type, rev);
+	return 0;
+}
+
 static char ram_dram[] __initdata =3D "DRAM";
+static char ram_resv[] __initdata =3D "RESV";
 #ifdef CONFIG_FB_ATY_GX
 static char ram_vram[] __initdata =3D "VRAM";
 #endif /* CONFIG_FB_ATY_GX */
 #ifdef CONFIG_FB_ATY_CT
 static char ram_edo[] __initdata =3D "EDO";
=2Dstatic char ram_sdram[] __initdata =3D "SDRAM";
=2Dstatic char ram_sgram[] __initdata =3D "SGRAM";
=2Dstatic char ram_wram[] __initdata =3D "WRAM";
+static char ram_sdram[] __initdata =3D "SDRAM (1:1)";
+static char ram_sgram[] __initdata =3D "SGRAM (1:1)";
+static char ram_sdram32[] __initdata =3D "SDRAM (2:1) (32-bit)";
 static char ram_off[] __initdata =3D "OFF";
 #endif /* CONFIG_FB_ATY_CT */
=2Dstatic char ram_resv[] __initdata =3D "RESV";
+
=20
 static u32 pseudo_palette[17];
=20
@@ -410,109 +508,226 @@
 	ram_dram, ram_vram, ram_vram, ram_dram,
 	ram_dram, ram_vram, ram_vram, ram_resv
 };
=2D#endif				/* CONFIG_FB_ATY_GX */
+#endif /* CONFIG_FB_ATY_GX */
=20
 #ifdef CONFIG_FB_ATY_CT
 static char *aty_ct_ram[8] __initdata =3D {
 	ram_off, ram_dram, ram_edo, ram_edo,
=2D	ram_sdram, ram_sgram, ram_wram, ram_resv
+	ram_sdram, ram_sgram, ram_sdram32, ram_resv
 };
=2D#endif				/* CONFIG_FB_ATY_CT */
+#endif /* CONFIG_FB_ATY_CT */
=20
+static u32 atyfb_get_pixclock(struct fb_var_screeninfo *var, struct atyfb_=
par *par)
+{
+	u32 pixclock =3D var->pixclock;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	u32 lcd_on_off;
+	par->pll.ct.xres =3D 0;
+	if (par->lcd_table !=3D 0) {
+		lcd_on_off =3D aty_ld_lcd(LCD_GEN_CNTL, par);
+		if(lcd_on_off & LCD_ON) {
+			par->pll.ct.xres =3D var->xres;
+			pixclock =3D par->lcd_pixclock;
+		}
+	}
+#endif
+	return pixclock;
+}
=20
 #if defined(CONFIG_PPC)
=20
=2D    /*
=2D     *  Apple monitor sense
=2D     */
+/*
+ *  Apple monitor sense
+ */
=20
 static int __init read_aty_sense(const struct atyfb_par *par)
 {
 	int sense, i;
=20
=2D	aty_st_le32(GP_IO, 0x31003100, par);	/* drive outputs high */
+	aty_st_le32(GP_IO, 0x31003100, par); /* drive outputs high */
 	__delay(200);
=2D	aty_st_le32(GP_IO, 0, par);	/* turn off outputs */
+	aty_st_le32(GP_IO, 0, par); /* turn off outputs */
 	__delay(2000);
=2D	i =3D aty_ld_le32(GP_IO, par);	/* get primary sense value */
+	i =3D aty_ld_le32(GP_IO, par); /* get primary sense value */
 	sense =3D ((i & 0x3000) >> 3) | (i & 0x100);
=20
 	/* drive each sense line low in turn and collect the other 2 */
=2D	aty_st_le32(GP_IO, 0x20000000, par);	/* drive A low */
+	aty_st_le32(GP_IO, 0x20000000, par); /* drive A low */
 	__delay(2000);
 	i =3D aty_ld_le32(GP_IO, par);
 	sense |=3D ((i & 0x1000) >> 7) | ((i & 0x100) >> 4);
=2D	aty_st_le32(GP_IO, 0x20002000, par);	/* drive A high again */
+	aty_st_le32(GP_IO, 0x20002000, par); /* drive A high again */
 	__delay(200);
=20
=2D	aty_st_le32(GP_IO, 0x10000000, par);	/* drive B low */
+	aty_st_le32(GP_IO, 0x10000000, par); /* drive B low */
 	__delay(2000);
 	i =3D aty_ld_le32(GP_IO, par);
 	sense |=3D ((i & 0x2000) >> 10) | ((i & 0x100) >> 6);
=2D	aty_st_le32(GP_IO, 0x10001000, par);	/* drive B high again */
+	aty_st_le32(GP_IO, 0x10001000, par); /* drive B high again */
 	__delay(200);
=20
=2D	aty_st_le32(GP_IO, 0x01000000, par);	/* drive C low */
+	aty_st_le32(GP_IO, 0x01000000, par); /* drive C low */
 	__delay(2000);
 	sense |=3D (aty_ld_le32(GP_IO, par) & 0x3000) >> 12;
=2D	aty_st_le32(GP_IO, 0, par);	/* turn off outputs */
+	aty_st_le32(GP_IO, 0, par); /* turn off outputs */
 	return sense;
 }
=20
=2D#endif				/* defined(CONFIG_PPC) */
=2D
=2D#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_PMAC_BACKLIGHT)
=2Dstatic void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
=2D{
=2D	unsigned long temp;
=2D
=2D	/* write addr byte */
=2D	temp =3D aty_ld_le32(LCD_INDEX, par);
=2D	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
=2D	/* write the register value */
=2D	aty_st_le32(LCD_DATA, val, par);
=2D}
=2D
=2Dstatic u32 aty_ld_lcd(int index, const struct atyfb_par *par)
=2D{
=2D	unsigned long temp;
=2D
=2D	/* write addr byte */
=2D	temp =3D aty_ld_le32(LCD_INDEX, par);
=2D	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
=2D	/* read the register value */
=2D	return aty_ld_le32(LCD_DATA, par);
=2D}
=2D#endif				/* CONFIG_PMAC_PBOOK || CONFIG_PMAC_BACKLIGHT */
+#endif /* defined(CONFIG_PPC) */
=20
 /* -----------------------------------------------------------------------=
=2D- */
=20
=2D    /*
=2D     *  CRTC programming
=2D     */
+/*
+ *  CRTC programming
+ */
=20
=2Dstatic void aty_set_crtc(const struct atyfb_par *par,
=2D			 const struct crtc *crtc)
+static void aty_get_crtc(const struct atyfb_par *par, struct crtc *crtc)
 {
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (par->lcd_table !=3D 0) {
+		if(!M64_HAS(LT_LCD_REGS)) {
+		    crtc->lcd_index =3D aty_ld_le32(LCD_INDEX, par);
+		    aty_st_le32(LCD_INDEX, crtc->lcd_index, par);
+		}
+		crtc->lcd_config_panel =3D aty_ld_lcd(CONFIG_PANEL, par);
+		crtc->lcd_gen_cntl =3D aty_ld_lcd(LCD_GEN_CNTL, par);
+
+
+		/* switch to non shadow registers */
+		aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl &
+                    ~(CRTC_RW_SELECT | SHADOW_EN | SHADOW_RW_EN), par);
+
+		/* save stretching */
+		crtc->horz_stretching =3D aty_ld_lcd(HORZ_STRETCHING, par);
+		crtc->vert_stretching =3D aty_ld_lcd(VERT_STRETCHING, par);
+		if (!M64_HAS(LT_LCD_REGS))
+			crtc->ext_vert_stretch =3D aty_ld_lcd(EXT_VERT_STRETCH, par);
+	}
+#endif
+	crtc->h_tot_disp =3D aty_ld_le32(CRTC_H_TOTAL_DISP, par);
+	crtc->h_sync_strt_wid =3D aty_ld_le32(CRTC_H_SYNC_STRT_WID, par);
+	crtc->v_tot_disp =3D aty_ld_le32(CRTC_V_TOTAL_DISP, par);
+	crtc->v_sync_strt_wid =3D aty_ld_le32(CRTC_V_SYNC_STRT_WID, par);
+	crtc->vline_crnt_vline =3D aty_ld_le32(CRTC_VLINE_CRNT_VLINE, par);
+	crtc->off_pitch =3D aty_ld_le32(CRTC_OFF_PITCH, par);
+	crtc->gen_cntl =3D aty_ld_le32(CRTC_GEN_CNTL, par);
+
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (par->lcd_table !=3D 0) {
+		/* switch to shadow registers */
+		aty_st_lcd(LCD_GEN_CNTL, (crtc->lcd_gen_cntl & ~CRTC_RW_SELECT) |
+			SHADOW_EN | SHADOW_RW_EN, par);
+
+		crtc->shadow_h_tot_disp =3D aty_ld_le32(CRTC_H_TOTAL_DISP, par);
+		crtc->shadow_h_sync_strt_wid =3D aty_ld_le32(CRTC_H_SYNC_STRT_WID, par);
+		crtc->shadow_v_tot_disp =3D aty_ld_le32(CRTC_V_TOTAL_DISP, par);
+		crtc->shadow_v_sync_strt_wid =3D aty_ld_le32(CRTC_V_SYNC_STRT_WID, par);
+
+		aty_st_le32(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);
+	}
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
+}
+
+static void aty_set_crtc(const struct atyfb_par *par, const struct crtc *c=
rtc)
+{
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (par->lcd_table !=3D 0) {
+		/* stop CRTC */
+		aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl & ~(CRTC_EXT_DISP_EN | CRTC_EN=
), par);
+
+		/* update non-shadow registers first */
+		aty_st_lcd(CONFIG_PANEL, crtc->lcd_config_panel, par);
+		aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl &
+			~(CRTC_RW_SELECT | SHADOW_EN | SHADOW_RW_EN), par);
+
+		/* temporarily disable stretching */
+		aty_st_lcd(HORZ_STRETCHING,
+			crtc->horz_stretching &
+			~(HORZ_STRETCH_MODE | HORZ_STRETCH_EN), par);
+		aty_st_lcd(VERT_STRETCHING,
+			crtc->vert_stretching &
+			~(VERT_STRETCH_RATIO1 | VERT_STRETCH_RATIO2 |
+			VERT_STRETCH_USE0 | VERT_STRETCH_EN), par);
+	}
+#endif
+	/* turn off CRT */
+	aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl & ~CRTC_EN, par);
+
+	DPRINTK("setting up CRTC\n");
+	PRINTKI("set primary CRT to %ix%i %c%c composite %c\n",
+	    ((((crtc->h_tot_disp>>16) & 0xff) + 1)<<3), (((crtc->v_tot_disp>>16) =
& 0x7ff) + 1),
+	    (crtc->h_sync_strt_wid & 0x200000)?'N':'P', (crtc->v_sync_strt_wid & =
0x200000)?'N':'P',
+	    (crtc->gen_cntl & CRTC_CSYNC_EN)?'P':'N');
+
+	DPRINTK("CRTC_H_TOTAL_DISP: %x\n",crtc->h_tot_disp);
+	DPRINTK("CRTC_H_SYNC_STRT_WID: %x\n",crtc->h_sync_strt_wid);
+	DPRINTK("CRTC_V_TOTAL_DISP: %x\n",crtc->v_tot_disp);
+	DPRINTK("CRTC_V_SYNC_STRT_WID: %x\n",crtc->v_sync_strt_wid);
+	DPRINTK("CRTC_OFF_PITCH: %x\n", crtc->off_pitch);
+	DPRINTK("CRTC_VLINE_CRNT_VLINE: %x\n", crtc->vline_crnt_vline);
+	DPRINTK("CRTC_GEN_CNTL: %x\n",crtc->gen_cntl);
+
 	aty_st_le32(CRTC_H_TOTAL_DISP, crtc->h_tot_disp, par);
 	aty_st_le32(CRTC_H_SYNC_STRT_WID, crtc->h_sync_strt_wid, par);
 	aty_st_le32(CRTC_V_TOTAL_DISP, crtc->v_tot_disp, par);
 	aty_st_le32(CRTC_V_SYNC_STRT_WID, crtc->v_sync_strt_wid, par);
=2D	aty_st_le32(CRTC_VLINE_CRNT_VLINE, 0, par);
 	aty_st_le32(CRTC_OFF_PITCH, crtc->off_pitch, par);
+	aty_st_le32(CRTC_VLINE_CRNT_VLINE, crtc->vline_crnt_vline, par);
+
 	aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl, par);
+#if 0
+	FIXME
+	if (par->accel_flags & FB_ACCELF_TEXT)
+		aty_init_engine(par, info);
+#endif
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	/* after setting the CRTC registers we should set the LCD registers. */
+	if (par->lcd_table !=3D 0) {
+		/* switch to shadow registers */
+		aty_st_lcd(LCD_GEN_CNTL, (crtc->lcd_gen_cntl & ~CRTC_RW_SELECT) |
+			(SHADOW_EN | SHADOW_RW_EN), par);
+
+		PRINTKI("set secondary CRT to %ix%i %c%c\n",
+		    ((((crtc->shadow_h_tot_disp>>16) & 0xff) + 1)<<3), (((crtc->shadow_v=
_tot_disp>>16) & 0x7ff) + 1),
+		    (crtc->shadow_h_sync_strt_wid & 0x200000)?'N':'P', (crtc->shadow_v_s=
ync_strt_wid & 0x200000)?'N':'P');
+
+		DPRINTK("SHADOW CRTC_H_TOTAL_DISP: %x\n", crtc->shadow_h_tot_disp);
+		DPRINTK("SHADOW CRTC_H_SYNC_STRT_WID: %x\n", crtc->shadow_h_sync_strt_wi=
d);
+		DPRINTK("SHADOW CRTC_V_TOTAL_DISP: %x\n", crtc->shadow_v_tot_disp);
+		DPRINTK("SHADOW CRTC_V_SYNC_STRT_WID: %x\n", crtc->shadow_v_sync_strt_wi=
d);
+
+		aty_st_le32(CRTC_H_TOTAL_DISP, crtc->shadow_h_tot_disp, par);
+		aty_st_le32(CRTC_H_SYNC_STRT_WID, crtc->shadow_h_sync_strt_wid, par);
+		aty_st_le32(CRTC_V_TOTAL_DISP, crtc->shadow_v_tot_disp, par);
+		aty_st_le32(CRTC_V_SYNC_STRT_WID, crtc->shadow_v_sync_strt_wid, par);
+
+		/* restore CRTC selection & shadow state and enable stretching */
+		DPRINTK("LCD_GEN_CNTL: %x\n", crtc->lcd_gen_cntl);
+		DPRINTK("HORZ_STRETCHING: %x\n", crtc->horz_stretching);
+		DPRINTK("VERT_STRETCHING: %x\n", crtc->vert_stretching);
+		if(!M64_HAS(LT_LCD_REGS))
+		    DPRINTK("EXT_VERT_STRETCH: %x\n", crtc->ext_vert_stretch);
+
+		aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);
+		aty_st_lcd(HORZ_STRETCHING, crtc->horz_stretching, par);
+		aty_st_lcd(VERT_STRETCHING, crtc->vert_stretching, par);
+		if(!M64_HAS(LT_LCD_REGS)) {
+		    aty_st_lcd(EXT_VERT_STRETCH, crtc->ext_vert_stretch, par);
+		    aty_ld_le32(LCD_INDEX, par);
+		    aty_st_le32(LCD_INDEX, crtc->lcd_index, par);
+		}
+	}
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
 }
=20
 static int aty_var_to_crtc(const struct fb_info *info,
=2D			   const struct fb_var_screeninfo *var,
=2D			   struct crtc *crtc)
+	const struct fb_var_screeninfo *var, struct crtc *crtc)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	u32 xres, yres, vxres, vyres, xoffset, yoffset, bpp;
=2D	u32 left, right, upper, lower, hslen, vslen, sync, vmode;
=2D	u32 h_total, h_disp, h_sync_strt, h_sync_dly, h_sync_wid,
=2D	    h_sync_pol;
=2D	u32 v_total, v_disp, v_sync_strt, v_sync_wid, v_sync_pol, c_sync;
+	u32 sync, vmode, vdisplay;
+	u32 h_total, h_disp, h_sync_strt, h_sync_end, h_sync_dly, h_sync_wid, h_s=
ync_pol;
+	u32 v_total, v_disp, v_sync_strt, v_sync_end, v_sync_wid, v_sync_pol, c_s=
ync;
 	u32 pix_width, dp_pix_width, dp_chain_mask;
=20
 	/* input */
@@ -523,53 +738,19 @@
 	xoffset =3D var->xoffset;
 	yoffset =3D var->yoffset;
 	bpp =3D var->bits_per_pixel;
=2D	left =3D var->left_margin;
=2D	right =3D var->right_margin;
=2D	upper =3D var->upper_margin;
=2D	lower =3D var->lower_margin;
=2D	hslen =3D var->hsync_len;
=2D	vslen =3D var->vsync_len;
+	if (bpp =3D=3D 16)
+		bpp =3D (var->green.length =3D=3D 5) ? 15 : 16;
 	sync =3D var->sync;
 	vmode =3D var->vmode;
=20
 	/* convert (and round up) and validate */
=2D	xres =3D (xres + 7) & ~7;
=2D	xoffset =3D (xoffset + 7) & ~7;
=2D	vxres =3D (vxres + 7) & ~7;
 	if (vxres < xres + xoffset)
 		vxres =3D xres + xoffset;
=2D	h_disp =3D xres / 8 - 1;
=2D	if (h_disp > 0xff)
=2D		FAIL("h_disp too large");
=2D	h_sync_strt =3D h_disp + (right / 8);
=2D	if (h_sync_strt > 0x1ff)
=2D		FAIL("h_sync_start too large");
=2D	h_sync_dly =3D right & 7;
=2D	h_sync_wid =3D (hslen + 7) / 8;
=2D	if (h_sync_wid > 0x1f)
=2D		FAIL("h_sync_wid too large");
=2D	h_total =3D h_sync_strt + h_sync_wid + (h_sync_dly + left + 7) / 8;
=2D	if (h_total > 0x1ff)
=2D		FAIL("h_total too large");
=2D	h_sync_pol =3D sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
+	h_disp =3D xres;
=20
 	if (vyres < yres + yoffset)
 		vyres =3D yres + yoffset;
=2D	v_disp =3D yres - 1;
=2D	if (v_disp > 0x7ff)
=2D		FAIL("v_disp too large");
=2D	v_sync_strt =3D v_disp + lower;
=2D	if (v_sync_strt > 0x7ff)
=2D		FAIL("v_sync_strt too large");
=2D	v_sync_wid =3D vslen;
=2D	if (v_sync_wid > 0x1f)
=2D		FAIL("v_sync_wid too large");
=2D	v_total =3D v_sync_strt + v_sync_wid + upper;
=2D	if (v_total > 0x7ff)
=2D		FAIL("v_total too large");
=2D	v_sync_pol =3D sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
=2D
=2D	c_sync =3D sync & FB_SYNC_COMP_HIGH_ACT ? CRTC_CSYNC_EN : 0;
+	v_disp =3D yres;
=20
 	if (bpp <=3D 8) {
 		bpp =3D 8;
@@ -577,54 +758,325 @@
 		dp_pix_width =3D
 		    HOST_8BPP | SRC_8BPP | DST_8BPP |
 		    BYTE_ORDER_LSB_TO_MSB;
=2D		dp_chain_mask =3D 0x8080;
=2D	} else if (bpp <=3D 16) {
+		dp_chain_mask =3D DP_CHAIN_8BPP;
+	} else if (bpp <=3D 15) {
 		bpp =3D 16;
 		pix_width =3D CRTC_PIX_WIDTH_15BPP;
 		dp_pix_width =3D HOST_15BPP | SRC_15BPP | DST_15BPP |
 		    BYTE_ORDER_LSB_TO_MSB;
=2D		dp_chain_mask =3D 0x4210;
+		dp_chain_mask =3D DP_CHAIN_15BPP;
+	} else if (bpp <=3D 16) {
+		bpp =3D 16;
+		pix_width =3D CRTC_PIX_WIDTH_16BPP;
+		dp_pix_width =3D HOST_16BPP | SRC_16BPP | DST_16BPP |
+		    BYTE_ORDER_LSB_TO_MSB;
+		dp_chain_mask =3D DP_CHAIN_16BPP;
 	} else if (bpp <=3D 24 && M64_HAS(INTEGRATED)) {
 		bpp =3D 24;
 		pix_width =3D CRTC_PIX_WIDTH_24BPP;
 		dp_pix_width =3D
 		    HOST_8BPP | SRC_8BPP | DST_8BPP |
 		    BYTE_ORDER_LSB_TO_MSB;
=2D		dp_chain_mask =3D 0x8080;
+		dp_chain_mask =3D DP_CHAIN_24BPP;
 	} else if (bpp <=3D 32) {
 		bpp =3D 32;
 		pix_width =3D CRTC_PIX_WIDTH_32BPP;
 		dp_pix_width =3D HOST_32BPP | SRC_32BPP | DST_32BPP |
 		    BYTE_ORDER_LSB_TO_MSB;
=2D		dp_chain_mask =3D 0x8080;
+		dp_chain_mask =3D DP_CHAIN_32BPP;
 	} else
 		FAIL("invalid bpp");
=20
 	if (vxres * vyres * bpp / 8 > info->fix.smem_len)
 		FAIL("not enough video RAM");
=20
=2D	if ((vmode & FB_VMODE_MASK) !=3D FB_VMODE_NONINTERLACED)
=2D		FAIL("invalid vmode");
+	h_sync_pol =3D sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
+	v_sync_pol =3D sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
+
+	if((xres > 1600) || (yres > 1200)) {
+		FAIL("MACH64 chips are designed for max 1600x1200\n"
+		"select anoter resolution.");
+	}
+	h_sync_strt =3D h_disp + var->right_margin;
+	h_sync_end =3D h_sync_strt + var->hsync_len;
+	h_sync_dly  =3D var->right_margin & 7;
+	h_total =3D h_sync_end + h_sync_dly + var->left_margin;
+
+	v_sync_strt =3D v_disp + var->lower_margin;
+	v_sync_end =3D v_sync_strt + var->vsync_len;
+	v_total =3D v_sync_end + var->upper_margin;
+
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (par->lcd_table !=3D 0) {
+		if(!M64_HAS(LT_LCD_REGS)) {
+		    u32 lcd_index =3D aty_ld_le32(LCD_INDEX, par);
+		    crtc->lcd_index =3D lcd_index &
+			~(LCD_INDEX_MASK | LCD_DISPLAY_DIS | LCD_SRC_SEL | CRTC2_DISPLAY_DIS);
+		    aty_st_le32(LCD_INDEX, lcd_index, par);
+		}
+
+		if (!M64_HAS(MOBIL_BUS))
+			crtc->lcd_index |=3D CRTC2_DISPLAY_DIS;
+
+		crtc->lcd_config_panel =3D aty_ld_lcd(CONFIG_PANEL, par) | 0x4000;
+		crtc->lcd_gen_cntl =3D aty_ld_lcd(LCD_GEN_CNTL, par) & ~CRTC_RW_SELECT;
+
+		crtc->lcd_gen_cntl &=3D
+			~(HORZ_DIVBY2_EN | DIS_HOR_CRT_DIVBY2 | TVCLK_PM_EN |
+			/*VCLK_DAC_PM_EN | USE_SHADOWED_VEND |*/
+			USE_SHADOWED_ROWCUR | SHADOW_EN | SHADOW_RW_EN);
+		crtc->lcd_gen_cntl |=3D DONT_SHADOW_VPAR | LOCK_8DOT;
+
+		if((crtc->lcd_gen_cntl & LCD_ON) &&
+			((xres > par->lcd_width) || (yres > par->lcd_height))) {
+			/* We cannot display the mode on the LCD. If the CRT is enabled
+			   we can turn off the LCD.
+			   If the CRT is off, it isn't a good idea to switch it on; we don't
+			   know if one is connected. So it's better to fail then.
+			 */
+			if (crtc->lcd_gen_cntl & CRT_ON) {
+				PRINTKI("Disable lcd panel, because video mode does not fit.\n");
+				crtc->lcd_gen_cntl &=3D ~LCD_ON;
+				/*aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);*/
+			} else {
+				FAIL("Video mode exceeds size of lcd panel.\nConnect this computer to =
a conventional monitor if you really need this mode.");
+			}
+		}
+	}
+
+	if ((par->lcd_table !=3D 0) && (crtc->lcd_gen_cntl & LCD_ON)) {
+		int VScan =3D 1;
+		/* bpp -> bytespp, 1,4 -> 0; 8 -> 2; 15,16 -> 1; 24 -> 6; 32 -> 5
+		const u8 DFP_h_sync_dly_LT[] =3D { 0, 2, 1, 6, 5 };
+		const u8 ADD_to_strt_wid_and_dly_LT_DAC[] =3D { 0, 5, 6, 9, 9, 12, 12 };=
  */
+
+		vmode &=3D ~(FB_VMODE_DOUBLE | FB_VMODE_INTERLACED);
+
+		/* This is horror! When we simulate, say 640x480 on an 800x600
+		   lcd monitor, the CRTC should be programmed 800x600 values for
+		   the non visible part, but 640x480 for the visible part.
+		   This code has been tested on a laptop with it's 1400x1050 lcd
+		   monitor and a conventional monitor both switched on.
+		   Tested modes: 1280x1024, 1152x864, 1024x768, 800x600,
+		    works with little glitches also with DOUBLESCAN modes
+		 */
+		if (yres < par->lcd_height) {
+			VScan =3D par->lcd_height / yres;
+			if(VScan > 1) {
+				VScan =3D 2;
+				vmode |=3D FB_VMODE_DOUBLE;
+			}
+		}
+
+		h_sync_strt =3D h_disp + par->lcd_right_margin;
+		h_sync_end =3D h_sync_strt + par->lcd_hsync_len;
+		h_sync_dly =3D /*DFP_h_sync_dly[ ( bpp + 1 ) / 3 ]; */par->lcd_hsync_dly;
+		h_total =3D h_disp + par->lcd_hblank_len;
+
+		v_sync_strt =3D v_disp + par->lcd_lower_margin / VScan;
+		v_sync_end =3D v_sync_strt + par->lcd_vsync_len / VScan;
+		v_total =3D v_disp + par->lcd_vblank_len / VScan;
+	}
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
+
+	h_disp =3D (h_disp >> 3) - 1;
+	h_sync_strt =3D (h_sync_strt >> 3) - 1;
+	h_sync_end =3D (h_sync_end >> 3) - 1;
+	h_total =3D (h_total >> 3) - 1;
+	h_sync_wid =3D h_sync_end - h_sync_strt;
+
+	FAIL_MAX("h_disp too large", h_disp, 0xff);
+	FAIL_MAX("h_sync_strt too large", h_sync_strt, 0x1ff);
+	/*FAIL_MAX("h_sync_wid too large", h_sync_wid, 0x1f);*/
+	if(h_sync_wid > 0x1f)
+		h_sync_wid =3D 0x1f;
+	FAIL_MAX("h_total too large", h_total, 0x1ff);
+
+	if (vmode & FB_VMODE_DOUBLE) {
+		v_disp <<=3D 1;
+		v_sync_strt <<=3D 1;
+		v_sync_end <<=3D 1;
+		v_total <<=3D 1;
+	}
+
+	vdisplay =3D yres;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if ((par->lcd_table !=3D 0) && (crtc->lcd_gen_cntl & LCD_ON))
+		vdisplay  =3D par->lcd_height;
+#endif
+
+	if(vdisplay < 400) {
+		h_sync_pol =3D 1;
+		v_sync_pol =3D 0;
+	} else if(vdisplay < 480) {
+		h_sync_pol =3D 0;
+		v_sync_pol =3D 1;
+	} else if(vdisplay < 768) {
+		h_sync_pol =3D 0;
+		v_sync_pol =3D 0;
+	} else {
+		h_sync_pol =3D 1;
+		v_sync_pol =3D 1;
+	}
+
+	v_disp--;
+	v_sync_strt--;
+	v_sync_end--;
+	v_total--;
+	v_sync_wid =3D v_sync_end - v_sync_strt;
+
+	FAIL_MAX("v_disp too large", v_disp, 0x7ff);
+	FAIL_MAX("v_sync_stsrt too large", v_sync_strt, 0x7ff);
+	/*FAIL_MAX("v_sync_wid too large", v_sync_wid, 0x1f);*/
+	if(v_sync_wid > 0x1f)
+		v_sync_wid =3D 0x1f;
+	FAIL_MAX("v_total too large", v_total, 0x7ff);
+
+	c_sync =3D sync & FB_SYNC_COMP_HIGH_ACT ? CRTC_CSYNC_EN : 0;
=20
 	/* output */
 	crtc->vxres =3D vxres;
 	crtc->vyres =3D vyres;
=2D	crtc->h_tot_disp =3D h_total | (h_disp << 16);
=2D	crtc->h_sync_strt_wid =3D (h_sync_strt & 0xff) | (h_sync_dly << 8) |
=2D	    ((h_sync_strt & 0x100) << 4) | (h_sync_wid << 16) |
=2D	    (h_sync_pol << 21);
=2D	crtc->v_tot_disp =3D v_total | (v_disp << 16);
=2D	crtc->v_sync_strt_wid =3D
=2D	    v_sync_strt | (v_sync_wid << 16) | (v_sync_pol << 21);
=2D	crtc->off_pitch =3D
=2D	    ((yoffset * vxres + xoffset) * bpp / 64) | (vxres << 19);
=2D	crtc->gen_cntl =3D
=2D	    pix_width | c_sync | CRTC_EXT_DISP_EN | CRTC_ENABLE;
+	crtc->xoffset =3D xoffset;
+	crtc->yoffset =3D yoffset;
+	crtc->bpp =3D bpp;
+	crtc->off_pitch =3D ((yoffset*vxres+xoffset)*bpp/64) | (vxres<<19);
+	crtc->vline_crnt_vline =3D 0;
+
+	crtc->h_tot_disp =3D h_total | (h_disp<<16);
+	crtc->h_sync_strt_wid =3D (h_sync_strt & 0xff) | (h_sync_dly<<8) |
+		((h_sync_strt & 0x100)<<4) | (h_sync_wid<<16) | (h_sync_pol<<21);
+	crtc->v_tot_disp =3D v_total | (v_disp<<16);
+	crtc->v_sync_strt_wid =3D v_sync_strt | (v_sync_wid<<16) | (v_sync_pol<<2=
1);
+
+	/* crtc->gen_cntl =3D aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_PRESERVED_MA=
SK; */
+	crtc->gen_cntl =3D CRTC_EXT_DISP_EN | CRTC_EN | pix_width | c_sync;
+	crtc->gen_cntl |=3D CRTC_VGA_LINEAR;
+
+	/* Enable doublescan mode if requested */
+	if (vmode & FB_VMODE_DOUBLE)
+		crtc->gen_cntl |=3D CRTC_DBL_SCAN_EN;
+	/* Enable interlaced mode if requested */
+	if (vmode & FB_VMODE_INTERLACED)
+		crtc->gen_cntl |=3D CRTC_INTERLACE_EN;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (par->lcd_table !=3D 0) {
+		vdisplay =3D yres;
+		if(vmode & FB_VMODE_DOUBLE)
+			vdisplay <<=3D 1;
+		if(vmode & FB_VMODE_INTERLACED) {
+			vdisplay >>=3D 1;
+
+			/* The prefered mode for the lcd is not interlaced, so disable it if
+			   it was enabled. For doublescan there is no problem, because we can
+			   compensate for it in the hardware stretching (we stretch half as muc=
h)
+			 */
+			vmode &=3D ~FB_VMODE_INTERLACED;
+			/*crtc->gen_cntl &=3D ~CRTC_INTERLACE_EN;*/
+		}
+		crtc->gen_cntl &=3D ~(CRTC2_EN | CRTC2_PIX_WIDTH);
+		crtc->lcd_gen_cntl &=3D ~(HORZ_DIVBY2_EN | DIS_HOR_CRT_DIVBY2 |
+			/*TVCLK_PM_EN | VCLK_DAC_PM_EN |*/
+			USE_SHADOWED_VEND | USE_SHADOWED_ROWCUR | SHADOW_EN | SHADOW_RW_EN);
+		crtc->lcd_gen_cntl |=3D (DONT_SHADOW_VPAR/* | LOCK_8DOT*/);
+
+		/* MOBILITY M1 tested, FIXME: LT */
+		crtc->horz_stretching =3D aty_ld_lcd(HORZ_STRETCHING, par);
+		if (!M64_HAS(LT_LCD_REGS))
+			crtc->ext_vert_stretch =3D aty_ld_lcd(EXT_VERT_STRETCH, par) &
+				~(AUTO_VERT_RATIO | VERT_STRETCH_MODE | VERT_STRETCH_RATIO3);
+
+		crtc->horz_stretching &=3D
+			~(HORZ_STRETCH_RATIO | HORZ_STRETCH_LOOP | AUTO_HORZ_RATIO |
+			HORZ_STRETCH_MODE | HORZ_STRETCH_EN);
+		if (xres < par->lcd_width) {
+			do {
+				/*
+				* The horizontal blender misbehaves when HDisplay is less than a
+				* a certain threshold (440 for a 1024-wide panel).  It doesn't
+				* stretch such modes enough.  Use pixel replication instead of
+				* blending to stretch modes that can be made to exactly fit the
+				* panel width.  The undocumented "NoLCDBlend" option allows the
+				* pixel-replicated mode to be slightly wider or narrower than the
+				* panel width.  It also causes a mode that is exactly half as wide
+				* as the panel to be pixel-replicated, rather than blended.
+				*/
+				int HDisplay  =3D xres & ~7;
+				int nStretch  =3D par->lcd_width / HDisplay;
+				int Remainder =3D par->lcd_width % HDisplay;
+
+				if ((!Remainder && ((nStretch > 2))) ||
+					(((HDisplay * 16) / par->lcd_width) < 7)) {
+					static const char StretchLoops[] =3D {10, 12, 13, 15, 16};
+					int horz_stretch_loop =3D -1, BestRemainder;
+					int Numerator =3D HDisplay, Denominator =3D par->lcd_width;
+					int Index =3D 5;
+					ATIReduceRatio(&Numerator, &Denominator);
+
+					BestRemainder =3D (Numerator * 16) / Denominator;
+					while (--Index >=3D 0) {
+						Remainder =3D ((Denominator - Numerator) * StretchLoops[Index]) %
+							Denominator;
+						if (Remainder < BestRemainder) {
+							horz_stretch_loop =3D Index;
+							if (!(BestRemainder =3D Remainder))
+								break;
+						}
+					}
+
+					if ((horz_stretch_loop >=3D 0) && !BestRemainder) {
+						int horz_stretch_ratio =3D 0, Accumulator =3D 0;
+						int reuse_previous =3D 1;
+
+						Index =3D StretchLoops[horz_stretch_loop];
+
+						while (--Index >=3D 0) {
+							if (Accumulator > 0)
+								horz_stretch_ratio |=3D reuse_previous;
+							else
+								Accumulator +=3D Denominator;
+							Accumulator -=3D Numerator;
+							reuse_previous <<=3D 1;
+						}
+
+						crtc->horz_stretching |=3D (HORZ_STRETCH_EN |
+							((horz_stretch_loop & HORZ_STRETCH_LOOP) << 16) |
+							(horz_stretch_ratio & HORZ_STRETCH_RATIO));
+						break;      /* Out of the do { ... } while (0) */
+					}
+				}
+
+				crtc->horz_stretching |=3D (HORZ_STRETCH_MODE | HORZ_STRETCH_EN |
+					(((HDisplay * (HORZ_STRETCH_BLEND + 1)) / par->lcd_width) & HORZ_STRE=
TCH_BLEND));
+			} while (0);
+		}
+
+		if (vdisplay < par->lcd_height) {
+			crtc->vert_stretching =3D (VERT_STRETCH_USE0 | VERT_STRETCH_EN |
+				(((vdisplay * (VERT_STRETCH_RATIO0 + 1)) / par->lcd_height) & VERT_STR=
ETCH_RATIO0));
+
+			if (!M64_HAS(LT_LCD_REGS) &&
+			    xres <=3D (M64_HAS(MOBIL_BUS)?1024:800))
+				crtc->ext_vert_stretch |=3D VERT_STRETCH_MODE;
+		} else {
+			/*
+			 * Don't use vertical blending if the mode is too wide or not
+			 * vertically stretched.
+			 */
+			crtc->vert_stretching =3D 0;
+		}
+		/* copy to shadow crtc */
+		crtc->shadow_h_tot_disp =3D crtc->h_tot_disp;
+		crtc->shadow_h_sync_strt_wid =3D crtc->h_sync_strt_wid;
+		crtc->shadow_v_tot_disp =3D crtc->v_tot_disp;
+		crtc->shadow_v_sync_strt_wid =3D crtc->v_sync_strt_wid;
+	}
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
+
 	if (M64_HAS(MAGIC_FIFO)) {
 		/* Not VTB/GTB */
 		/* FIXME: magic FIFO values */
=2D		crtc->gen_cntl |=3D
=2D		    aty_ld_le32(CRTC_GEN_CNTL, par) & 0x000e0000;
+		crtc->gen_cntl |=3D (aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC2_PIX_WIDTH);
 	}
 	crtc->dp_pix_width =3D dp_pix_width;
 	crtc->dp_chain_mask =3D dp_chain_mask;
@@ -632,21 +1084,19 @@
 	return 0;
 }
=20
=2D
=2Dstatic int aty_crtc_to_var(const struct crtc *crtc,
=2D			   struct fb_var_screeninfo *var)
+static int aty_crtc_to_var(const struct crtc *crtc, struct fb_var_screenin=
fo *var)
 {
 	u32 xres, yres, bpp, left, right, upper, lower, hslen, vslen, sync;
 	u32 h_total, h_disp, h_sync_strt, h_sync_dly, h_sync_wid,
 	    h_sync_pol;
 	u32 v_total, v_disp, v_sync_strt, v_sync_wid, v_sync_pol, c_sync;
 	u32 pix_width;
+	u32 double_scan, interlace;
=20
 	/* input */
 	h_total =3D crtc->h_tot_disp & 0x1ff;
 	h_disp =3D (crtc->h_tot_disp >> 16) & 0xff;
=2D	h_sync_strt =3D (crtc->h_sync_strt_wid & 0xff) |
=2D	    ((crtc->h_sync_strt_wid >> 4) & 0x100);
+	h_sync_strt =3D (crtc->h_sync_strt_wid & 0xff) | ((crtc->h_sync_strt_wid =
>> 4) & 0x100);
 	h_sync_dly =3D (crtc->h_sync_strt_wid >> 8) & 0x7;
 	h_sync_wid =3D (crtc->h_sync_strt_wid >> 16) & 0x1f;
 	h_sync_pol =3D (crtc->h_sync_strt_wid >> 21) & 0x1;
@@ -657,6 +1107,8 @@
 	v_sync_pol =3D (crtc->v_sync_strt_wid >> 21) & 0x1;
 	c_sync =3D crtc->gen_cntl & CRTC_CSYNC_EN ? 1 : 0;
 	pix_width =3D crtc->gen_cntl & CRTC_PIX_WIDTH_MASK;
+	double_scan =3D crtc->gen_cntl & CRTC_DBL_SCAN_EN;
+	interlace =3D crtc->gen_cntl & CRTC_INTERLACE_EN;
=20
 	/* convert */
 	xres =3D (h_disp + 1) * 8;
@@ -707,7 +1159,6 @@
 		var->transp.offset =3D 0;
 		var->transp.length =3D 0;
 		break;
=2D#if 0
 	case CRTC_PIX_WIDTH_16BPP:	/* RGB 565 */
 		bpp =3D 16;
 		var->red.offset =3D 11;
@@ -719,7 +1170,6 @@
 		var->transp.offset =3D 0;
 		var->transp.length =3D 0;
 		break;
=2D#endif
 	case CRTC_PIX_WIDTH_24BPP:	/* RGB 888 */
 		bpp =3D 24;
 		var->red.offset =3D 16;
@@ -760,6 +1210,21 @@
 	var->vsync_len =3D vslen;
 	var->sync =3D sync;
 	var->vmode =3D FB_VMODE_NONINTERLACED;
+	/* In double scan mode, the vertical parameters are doubled, so we need to
+	   half them to get the right values.
+	   In interlaced mode the values are already correct, so no correction is
+	   necessary.
+	 */
+	if (interlace)
+		var->vmode =3D FB_VMODE_INTERLACED;
+
+	if (double_scan) {
+		var->vmode =3D FB_VMODE_DOUBLE;
+		var->yres>>=3D1;
+		var->upper_margin>>=3D1;
+		var->lower_margin>>=3D1;
+		var->vsync_len>>=3D1;
+	}
=20
 	return 0;
 }
@@ -770,58 +1235,116 @@
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	struct fb_var_screeninfo *var =3D &info->var;
=2D	u8 tmp;
=2D	u32 i;
+	u32 tmp, pixclock;
 	int err;
+#ifdef DEBUG
+	struct fb_var_screeninfo debug;
+	u32 pixclock_in_ps;
+#endif
+	if (par->asleep)
+		return 0;
=20
=2D	if ((err =3D aty_var_to_crtc(info, var, &par->crtc)) ||
=2D	    (err =3D par->pll_ops->var_to_pll(info, var->pixclock,
=2D					var->bits_per_pixel, &par->pll)))
+	if ((err =3D aty_var_to_crtc(info, var, &par->crtc)))
 		return err;
=20
=2D	par->accel_flags =3D var->accel_flags;	/* hack */
+	pixclock =3D atyfb_get_pixclock(var, par);
+
+	if (pixclock =3D=3D 0) {
+		FAIL("Invalid pixclock");
+	} else {
+		if((err =3D par->pll_ops->var_to_pll(info, pixclock, var->bits_per_pixel=
, &par->pll)))
+			return err;
+	}
+
+	par->accel_flags =3D var->accel_flags; /* hack */
=20
 	if (par->blitter_may_be_busy)
 		wait_for_idle(par);
=2D	tmp =3D aty_ld_8(CRTC_GEN_CNTL + 3, par);
=2D	aty_set_crtc(par, &par->crtc);
=2D	aty_st_8(CLOCK_CNTL + par->clk_wr_offset, 0, par);
=2D	/* better call aty_StrobeClock ?? */
=2D	aty_st_8(CLOCK_CNTL + par->clk_wr_offset, CLOCK_STROBE, par);
=20
=2D	par->dac_ops->set_dac(info, &par->pll, var->bits_per_pixel,
=2D			      par->accel_flags);
+	aty_set_crtc(par, &par->crtc);
+	par->dac_ops->set_dac(info, &par->pll, var->bits_per_pixel, par->accel_fl=
ags);
 	par->pll_ops->set_pll(info, &par->pll);
=20
+#ifdef DEBUG
+	if(par->pll_ops && par->pll_ops->pll_to_var)
+		pixclock_in_ps =3D par->pll_ops->pll_to_var(info, &(par->pll));
+	else
+		pixclock_in_ps =3D 0;
+
+	if(0 =3D=3D pixclock_in_ps) {
+		PRINTKE("ALERT ops->pll_to_var get 0\n");
+		pixclock_in_ps =3D pixclock;
+	}
+
+	memset(&debug, 0, sizeof(debug));
+	if(!aty_crtc_to_var(&(par->crtc), &debug)) {
+		u32 hSync, vRefresh;
+		u32 h_disp, h_sync_strt, h_sync_end, h_total;
+		u32 v_disp, v_sync_strt, v_sync_end, v_total;
+
+		h_disp =3D debug.xres;
+		h_sync_strt =3D h_disp + debug.right_margin;
+		h_sync_end =3D h_sync_strt + debug.hsync_len;
+		h_total =3D h_sync_end + debug.left_margin;
+		v_disp =3D debug.yres;
+		v_sync_strt =3D v_disp + debug.lower_margin;
+		v_sync_end =3D v_sync_strt + debug.vsync_len;
+		v_total =3D v_sync_end + debug.upper_margin;
+
+		hSync =3D 1000000000 / (pixclock_in_ps * h_total);
+		vRefresh =3D (hSync * 1000) / v_total;
+        	if (par->crtc.gen_cntl & CRTC_INTERLACE_EN)
+            	vRefresh *=3D 2;
+        	if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
+            	vRefresh /=3D 2;
+
+		DPRINTK("atyfb_set_par\n");
+		DPRINTK(" Set Visible Mode to %ix%i-%i\n", var->xres, var->yres, var->bi=
ts_per_pixel);
+		DPRINTK(" Virtual resolution %ix%i, pixclock_in_ps %i (calculated %i)\n",
+			var->xres_virtual, var->yres_virtual, pixclock, pixclock_in_ps);
+		DPRINTK(" Dot clock:           %i MHz\n", 1000000 / pixclock_in_ps);
+		DPRINTK(" Horizontal sync:     %i kHz\n", hSync);
+		DPRINTK(" Vertical refresh:    %i Hz\n", vRefresh);
+		DPRINTK(" x  style: %i.%03i %i %i %i %i   %i %i %i %i\n",
+			1000000 / pixclock_in_ps, 1000000 % pixclock_in_ps,
+			h_disp, h_sync_strt, h_sync_end, h_total,
+			v_disp, v_sync_strt, v_sync_end, v_total);
+		DPRINTK(" fb style: %i  %i %i %i %i %i %i %i %i\n",
+			pixclock_in_ps,
+			debug.left_margin, h_disp, debug.right_margin, debug.hsync_len,
+			debug.upper_margin, v_disp, debug.lower_margin, debug.vsync_len);
+	}
+#endif /* DEBUG */
+
 	if (!M64_HAS(INTEGRATED)) {
 		/* Don't forget MEM_CNTL */
=2D		i =3D aty_ld_le32(MEM_CNTL, par) & 0xf0ffffff;
+		tmp =3D aty_ld_le32(MEM_CNTL, par) & 0xf0ffffff;
 		switch (var->bits_per_pixel) {
 		case 8:
=2D			i |=3D 0x02000000;
+			tmp |=3D 0x02000000;
 			break;
 		case 16:
=2D			i |=3D 0x03000000;
+			tmp |=3D 0x03000000;
 			break;
 		case 32:
=2D			i |=3D 0x06000000;
+			tmp |=3D 0x06000000;
 			break;
 		}
=2D		aty_st_le32(MEM_CNTL, i, par);
+		aty_st_le32(MEM_CNTL, tmp, par);
 	} else {
=2D		i =3D aty_ld_le32(MEM_CNTL, par) & 0xf00fffff;
+		tmp =3D aty_ld_le32(MEM_CNTL, par) & 0xf00fffff;
 		if (!M64_HAS(MAGIC_POSTDIV))
=2D			i |=3D par->mem_refresh_rate << 20;
+			tmp |=3D par->mem_refresh_rate << 20;
 		switch (var->bits_per_pixel) {
 		case 8:
 		case 24:
=2D			i |=3D 0x00000000;
+			tmp |=3D 0x00000000;
 			break;
 		case 16:
=2D			i |=3D 0x04000000;
+			tmp |=3D 0x04000000;
 			break;
 		case 32:
=2D			i |=3D 0x08000000;
+			tmp |=3D 0x08000000;
 			break;
 		}
 		if (M64_HAS(CT_BUS)) {
@@ -832,16 +1355,14 @@
 			aty_st_le32(BUS_CNTL, 0x680000f9, par);
 		} else if (M64_HAS(MOBIL_BUS)) {
 			aty_st_le32(DAC_CNTL, 0x80010102, par);
=2D			aty_st_le32(BUS_CNTL, 0x7b33a040, par);
+			aty_st_le32(BUS_CNTL, 0x7b33a040 | (par->aux_start ? BUS_APER_REG_DIS :=
 0), par);
 		} else {
 			/* GT */
 			aty_st_le32(DAC_CNTL, 0x86010102, par);
=2D			aty_st_le32(BUS_CNTL, 0x7b23a040, par);
=2D			aty_st_le32(EXT_MEM_CNTL,
=2D				    aty_ld_le32(EXT_MEM_CNTL,
=2D						par) | 0x5000001, par);
+			aty_st_le32(BUS_CNTL, 0x7b23a040 | (par->aux_start ? BUS_APER_REG_DIS :=
 0), par);
+			aty_st_le32(EXT_MEM_CNTL, aty_ld_le32(EXT_MEM_CNTL, par) | 0x5000001, p=
ar);
 		}
=2D		aty_st_le32(MEM_CNTL, i, par);
+		aty_st_le32(MEM_CNTL, tmp, par);
 	}
 	aty_st_8(DAC_MASK, 0xff, par);
=20
@@ -855,29 +1376,98 @@
=20
 #ifdef CONFIG_BOOTX_TEXT
 	btext_update_display(info->fix.smem_start,
=2D			     (((par->crtc.h_tot_disp >> 16) & 0xff) + 1) * 8,
=2D			     ((par->crtc.v_tot_disp >> 16) & 0x7ff) + 1,
=2D			     var->bits_per_pixel,
=2D			     par->crtc.vxres * var->bits_per_pixel / 8);
=2D#endif				/* CONFIG_BOOTX_TEXT */
+		(((par->crtc.h_tot_disp >> 16) & 0xff) + 1) * 8,
+		((par->crtc.v_tot_disp >> 16) & 0x7ff) + 1,
+		var->bits_per_pixel,
+		par->crtc.vxres * var->bits_per_pixel / 8);
+#endif /* CONFIG_BOOTX_TEXT */
+#if 0
+	/* switch to accelerator mode */
+	if (!(par->crtc.gen_cntl & CRTC_EXT_DISP_EN))
+		aty_st_le32(CRTC_GEN_CNTL, par->crtc.gen_cntl | CRTC_EXT_DISP_EN, par);
+#endif
+#ifdef DEBUG
+{
+	/* dump non shadow CRTC, pll, LCD registers */
+	int i; u32 base;
+
+	/* CRTC registers */
+	base =3D 0x2000;
+	printk("debug atyfb: Mach64 non-shadow register values:");
+	for (i =3D 0; i < 256; i =3D i+4) {
+		if(i%16 =3D=3D 0) printk("\ndebug atyfb: 0x%04X: ", base + i);
+		printk(" %08X", aty_ld_le32(i, par));
+	}
+	printk("\n\n");
+
+#ifdef CONFIG_FB_ATY_CT
+	/* PLL registers */
+	base =3D 0x00;
+	printk("debug atyfb: Mach64 PLL register values:");
+	for (i =3D 0; i < 64; i++) {
+		if(i%16 =3D=3D 0) printk("\ndebug atyfb: 0x%02X: ", base + i);
+		if(i%4 =3D=3D 0)  printk(" ");
+		printk("%02X", aty_ld_pll_ct(i, par));
+	}
+	printk("\n\n");
+#endif	/* CONFIG_FB_ATY_CT */
+
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (par->lcd_table !=3D 0) {
+		/* LCD registers */
+		base =3D 0x00;
+		printk("debug atyfb: LCD register values:");
+		if(M64_HAS(LT_LCD_REGS)) {
+		    for(i =3D 0; i <=3D POWER_MANAGEMENT; i++) {
+			if(i =3D=3D EXT_VERT_STRETCH)
+			    continue;
+			printk("\ndebug atyfb: 0x%04X: ", lt_lcd_regs[i]);
+			printk(" %08X", aty_ld_lcd(i, par));
+		    }
+
+		} else {
+		    for (i =3D 0; i < 64; i++) {
+			if(i%4 =3D=3D 0) printk("\ndebug atyfb: 0x%02X: ", base + i);
+			printk(" %08X", aty_ld_lcd(i, par));
+		    }
+		}
+		printk("\n\n");
+	}
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
+}
+#endif /* DEBUG */
 	return 0;
 }
=20
=2Dstatic int atyfb_check_var(struct fb_var_screeninfo *var,
=2D			   struct fb_info *info)
+static int atyfb_check_var(struct fb_var_screeninfo *var, struct fb_info *=
info)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+	int err;
 	struct crtc crtc;
 	union aty_pll pll;
=2D	int err;
+	u32 pixclock;
=20
=2D	if ((err =3D aty_var_to_crtc(info, var, &crtc)) ||
=2D	    (err =3D par->pll_ops->var_to_pll(info, var->pixclock,
=2D					var->bits_per_pixel, &pll)))
+	memcpy(&pll, &(par->pll), sizeof(pll));
+
+	if((err =3D aty_var_to_crtc(info, var, &crtc)))
 		return err;
=20
=2D#if 0	/* fbmon is not done. uncomment for 2.5.x -brad */
=2D	if (!fbmon_valid_timings(var->pixclock, htotal, vtotal, info))
+	pixclock =3D atyfb_get_pixclock(var, par);
+
+	if (pixclock =3D=3D 0) {
+		FAIL("Invalid pixclock");
+	} else {
+		if((err =3D par->pll_ops->var_to_pll(info, pixclock, var->bits_per_pixel=
, &pll)))
+			return err;
+	}
+
+	if (var->accel_flags & FB_ACCELF_TEXT)
+		info->var.accel_flags =3D FB_ACCELF_TEXT;
+	else
+		info->var.accel_flags =3D 0;
+
+#if 0 /* fbmon is not done. uncomment for 2.5.x -brad */
+	if (!fbmon_valid_timings(pixclock, htotal, vtotal, info))
 		return -EINVAL;
 #endif
 	aty_crtc_to_var(&crtc, var);
@@ -885,17 +1475,14 @@
 	return 0;
 }
=20
=2Dstatic void set_off_pitch(struct atyfb_par *par,
=2D			  const struct fb_info *info)
+static void set_off_pitch(struct atyfb_par *par, const struct fb_info *inf=
o)
 {
 	u32 xoffset =3D info->var.xoffset;
 	u32 yoffset =3D info->var.yoffset;
 	u32 vxres =3D par->crtc.vxres;
 	u32 bpp =3D info->var.bits_per_pixel;
=20
=2D	par->crtc.off_pitch =3D
=2D	    ((yoffset * vxres + xoffset) * bpp / 64) | (vxres << 19);
=2D	aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+	par->crtc.off_pitch =3D ((yoffset * vxres + xoffset) * bpp / 64) | (vxres=
 << 19);
 }
=20
=20
@@ -905,35 +1492,103 @@
=20
 static int atyfb_open(struct fb_info *info, int user)
 {
=2D#ifdef __sparc__
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=20
 	if (user) {
 		par->open++;
+#ifdef __sparc__
 		par->mmaped =3D 0;
=2D	}
 #endif
+	}
 	return (0);
 }
=20
=2Dstruct fb_var_screeninfo default_var =3D {
=2D	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
=2D	640, 480, 640, 480, 0, 0, 8, 0,
=2D	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
=2D	0, 0, -1, -1, 0, 39722, 48, 16, 33, 10, 96, 2,
=2D	0, FB_VMODE_NONINTERLACED
=2D};
+static irqreturn_t aty_irq(int irq, void *dev_id, struct pt_regs *fp)
+{
+	struct atyfb_par *par =3D dev_id;
+	int handled =3D 0;
+	u32 int_cntl;
=20
=2Dstatic int atyfb_release(struct fb_info *info, int user)
+	spin_lock(&par->int_lock);
+
+	int_cntl =3D aty_ld_le32(CRTC_INT_CNTL, par);
+
+	if (int_cntl & CRTC_VBLANK_INT) {
+		/* clear interrupt */
+		aty_st_le32(CRTC_INT_CNTL, (int_cntl & CRTC_INT_EN_MASK) | CRTC_VBLANK_I=
NT_AK, par);
+		par->vblank.count++;
+		if (par->vblank.pan_display) {
+			par->vblank.pan_display =3D 0;
+			aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+		}
+		wake_up_interruptible(&par->vblank.wait);
+		handled =3D 1;
+	}
+
+	spin_unlock(&par->int_lock);
+
+	return IRQ_RETVAL(handled);
+}
+
+static int aty_enable_irq(struct atyfb_par *par, int reenable)
 {
=2D#ifdef __sparc__
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;=09
+	u32 int_cntl;
=20
+	if (!test_and_set_bit(0, &par->irq_flags)) {
+		if (request_irq(par->irq, aty_irq, SA_SHIRQ, "atyfb", par)) {
+			clear_bit(0, &par->irq_flags);
+			return -EINVAL;
+		}
+		spin_lock_irq(&par->int_lock);
+		int_cntl =3D aty_ld_le32(CRTC_INT_CNTL, par) & CRTC_INT_EN_MASK;
+		/* clear interrupt */
+		aty_st_le32(CRTC_INT_CNTL, int_cntl | CRTC_VBLANK_INT_AK, par);
+		/* enable interrupt */
+		aty_st_le32(CRTC_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN, par);
+		spin_unlock_irq(&par->int_lock);
+	} else if (reenable) {
+		spin_lock_irq(&par->int_lock);
+		int_cntl =3D aty_ld_le32(CRTC_INT_CNTL, par) & CRTC_INT_EN_MASK;
+		if (!(int_cntl & CRTC_VBLANK_INT_EN)) {
+			printk("atyfb: someone disabled IRQ [%08x]\n", int_cntl);
+			/* re-enable interrupt */
+			aty_st_le32(CRTC_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN, par );
+		}
+		spin_unlock_irq(&par->int_lock);
+	}
+
+	return 0;
+}
+
+static int aty_disable_irq(struct atyfb_par *par)
+{
+	u32 int_cntl;
+
+	if (test_and_clear_bit(0, &par->irq_flags)) {
+		if (par->vblank.pan_display) {
+			par->vblank.pan_display =3D 0;
+			aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+		}
+		spin_lock_irq(&par->int_lock);
+		int_cntl =3D aty_ld_le32(CRTC_INT_CNTL, par) & CRTC_INT_EN_MASK;
+		/* disable interrupt */
+		aty_st_le32(CRTC_INT_CNTL, int_cntl & ~CRTC_VBLANK_INT_EN, par );
+		spin_unlock_irq(&par->int_lock);
+		free_irq(par->irq, par);
+	}
+
+	return 0;
+}
+
+static int atyfb_release(struct fb_info *info, int user)
+{
+	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	if (user) {
 		par->open--;
 		mdelay(1);
 		wait_for_idle(par);
 		if (!par->open) {
+#ifdef __sparc__
 			int was_mmaped =3D par->mmaped;
=20
 			par->mmaped =3D 0;
@@ -952,21 +1607,16 @@
 				else
 					var.accel_flags |=3D FB_ACCELF_TEXT;
 				if (var.yres =3D=3D var.yres_virtual) {
=2D					u32 vram =3D
=2D					    (info->fix.smem_len -
=2D					     (PAGE_SIZE << 2));
=2D					var.yres_virtual =3D
=2D					    ((vram * 8) /
=2D					     var.bits_per_pixel) /
=2D					    var.xres_virtual;
+					u32 videoram =3D (info->fix.smem_len - (PAGE_SIZE << 2));
+					var.yres_virtual =3D ((videoram * 8) / var.bits_per_pixel) / var.xres=
_virtual;
 					if (var.yres_virtual < var.yres)
=2D						var.yres_virtual =3D
=2D						    var.yres;
+						var.yres_virtual =3D var.yres;
 				}
 			}
=2D		}
=2D	}=20
 #endif
+			aty_disable_irq(par);
+		}
+	}
 	return (0);
 }
=20
@@ -976,25 +1626,67 @@
      *  This call looks only at xoffset, yoffset and the FB_VMODE_YWRAP fl=
ag
      */
=20
=2Dstatic int atyfb_pan_display(struct fb_var_screeninfo *var,
=2D			     struct fb_info *info)
+static int atyfb_pan_display(struct fb_var_screeninfo *var, struct fb_info=
 *info)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	u32 xres, yres, xoffset, yoffset;
=20
 	xres =3D (((par->crtc.h_tot_disp >> 16) & 0xff) + 1) * 8;
 	yres =3D ((par->crtc.v_tot_disp >> 16) & 0x7ff) + 1;
+	if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
+		yres >>=3D 1;
 	xoffset =3D (var->xoffset + 7) & ~7;
 	yoffset =3D var->yoffset;
=2D	if (xoffset + xres > par->crtc.vxres
=2D	    || yoffset + yres > par->crtc.vyres)
+	if (xoffset + xres > par->crtc.vxres || yoffset + yres > par->crtc.vyres)
 		return -EINVAL;
 	info->var.xoffset =3D xoffset;
 	info->var.yoffset =3D yoffset;
+	if (par->asleep)
+		return 0;
+
 	set_off_pitch(par, info);
+	if ((var->activate & FB_ACTIVATE_VBL) && !aty_enable_irq(par, 0)) {
+		par->vblank.pan_display =3D 1;
+	} else {
+		par->vblank.pan_display =3D 0;
+		aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+	}
+
 	return 0;
 }
=20
+static int aty_waitforvblank(struct atyfb_par *par, u32 crtc)
+{
+	struct aty_interrupt *vbl;
+	unsigned int count;
+	int ret;
+
+	switch (crtc) {
+	case 0:
+		vbl =3D &par->vblank;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret =3D aty_enable_irq(par, 0);
+	if (ret)
+		return ret;
+
+	count =3D vbl->count;
+	ret =3D wait_event_interruptible_timeout(vbl->wait, count !=3D vbl->count=
, HZ/10);
+	if (ret < 0) {
+		return ret;
+	}
+	if (ret =3D=3D 0) {
+		aty_enable_irq(par, 1);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+
 #ifdef DEBUG
 #define ATYIO_CLKR		0x41545900	/* ATY\00 */
 #define ATYIO_CLKW		0x41545901	/* ATY\01 */
@@ -1004,6 +1696,8 @@
 	u8 pll_ref_div;
 	u8 mclk_fb_div;
 	u8 mclk_post_div;	/* 1,2,3,4,8 */
+	u8 mclk_fb_mult;	/* 2 or 4 */
+	u8 xclk_post_div;	/* 1,2,3,4,8 */
 	u8 vclk_fb_div;
 	u8 vclk_post_div;	/* 1,2,3,4,6,8,12 */
 	u32 dsp_xclks_per_row;	/* 0-16383 */
@@ -1017,12 +1711,14 @@
 #define ATYIO_FEATW		0x41545903	/* ATY\03 */
 #endif
=20
+#ifndef FBIO_WAITFORVSYNC
+#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
+#endif
+
 static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
=2D		       u_long arg, struct fb_info *info)
+	u_long arg, struct fb_info *info)
 {
=2D#if defined(__sparc__) || (defined(DEBUG) && defined(CONFIG_FB_ATY_CT))
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D#endif				/* __sparc__ || DEBUG */
 #ifdef __sparc__
 	struct fbtype fbtyp;
 #endif
@@ -1036,31 +1732,43 @@
 		fbtyp.fb_depth =3D info->var.bits_per_pixel;
 		fbtyp.fb_cmsize =3D info->cmap.len;
 		fbtyp.fb_size =3D info->fix.smem_len;
=2D		if (copy_to_user
=2D		    ((struct fbtype __user *) arg, &fbtyp, sizeof(fbtyp)))
+		if (copy_to_user((struct fbtype __user *) arg, &fbtyp, sizeof(fbtyp)))
 			return -EFAULT;
 		break;
=2D#endif				/* __sparc__ */
+#endif /* __sparc__ */
+
+	case FBIO_WAITFORVSYNC:
+		{
+			u32 crtc;
+
+			if (get_user(crtc, (__u32 *) arg))
+				return -EFAULT;
+
+			return aty_waitforvblank(par, crtc);
+		}
+		break;
+
 #if defined(DEBUG) && defined(CONFIG_FB_ATY_CT)
 	case ATYIO_CLKR:
 		if (M64_HAS(INTEGRATED)) {
 			struct atyclk clk;
=2D			union aty_pll *pll =3D par->pll;
+			union aty_pll *pll =3D &(par->pll);
 			u32 dsp_config =3D pll->ct.dsp_config;
 			u32 dsp_on_off =3D pll->ct.dsp_on_off;
 			clk.ref_clk_per =3D par->ref_clk_per;
 			clk.pll_ref_div =3D pll->ct.pll_ref_div;
 			clk.mclk_fb_div =3D pll->ct.mclk_fb_div;
 			clk.mclk_post_div =3D pll->ct.mclk_post_div_real;
+			clk.mclk_fb_mult =3D pll->ct.mclk_fb_mult;
+			clk.xclk_post_div =3D pll->ct.xclk_post_div_real;
 			clk.vclk_fb_div =3D pll->ct.vclk_fb_div;
 			clk.vclk_post_div =3D pll->ct.vclk_post_div_real;
 			clk.dsp_xclks_per_row =3D dsp_config & 0x3fff;
 			clk.dsp_loop_latency =3D (dsp_config >> 16) & 0xf;
 			clk.dsp_precision =3D (dsp_config >> 20) & 7;
=2D			clk.dsp_on =3D dsp_on_off & 0x7ff;
=2D			clk.dsp_off =3D (dsp_on_off >> 16) & 0x7ff;
=2D			if (copy_to_user
=2D			    ((struct atyclk *) arg, &clk, sizeof(clk)))
+			clk.dsp_off =3D dsp_on_off & 0x7ff;
+			clk.dsp_on =3D (dsp_on_off >> 16) & 0x7ff;
+			if (copy_to_user((struct atyclk *) arg, &clk, sizeof(clk)))
 				return -EFAULT;
 		} else
 			return -EINVAL;
@@ -1068,27 +1776,21 @@
 	case ATYIO_CLKW:
 		if (M64_HAS(INTEGRATED)) {
 			struct atyclk clk;
=2D			union aty_pll *pll =3D par->pll;
=2D			if (copy_from_user
=2D			    (&clk, (struct atyclk *) arg, sizeof(clk)))
+			union aty_pll *pll =3D &(par->pll);
+			if (copy_from_user(&clk, (struct atyclk *) arg, sizeof(clk)))
 				return -EFAULT;
 			par->ref_clk_per =3D clk.ref_clk_per;
 			pll->ct.pll_ref_div =3D clk.pll_ref_div;
 			pll->ct.mclk_fb_div =3D clk.mclk_fb_div;
 			pll->ct.mclk_post_div_real =3D clk.mclk_post_div;
+			pll->ct.mclk_fb_mult =3D clk.mclk_fb_mult;
+			pll->ct.xclk_post_div_real =3D clk.xclk_post_div;
 			pll->ct.vclk_fb_div =3D clk.vclk_fb_div;
 			pll->ct.vclk_post_div_real =3D clk.vclk_post_div;
=2D			pll->ct.dsp_config =3D
=2D			    (clk.
=2D			     dsp_xclks_per_row & 0x3fff) | ((clk.
=2D							     dsp_loop_latency
=2D							     & 0xf) << 16)
=2D			    | ((clk.dsp_precision & 7) << 20);
=2D			pll->ct.dsp_on_off =3D
=2D			    (clk.
=2D			     dsp_on & 0x7ff) | ((clk.
=2D						 dsp_off & 0x7ff) << 16);
=2D			aty_calc_pll_ct(info, &pll->ct);
+			pll->ct.dsp_config =3D (clk.dsp_xclks_per_row & 0x3fff) |
+				((clk.dsp_loop_latency & 0xf)<<16)| ((clk.dsp_precision & 7)<<20);
+			pll->ct.dsp_on_off =3D (clk.dsp_off & 0x7ff) | ((clk.dsp_on & 0x7ff)<<1=
6);
+			/*aty_calc_pll_ct(info, &pll->ct);*/
 			aty_set_pll_ct(info, pll);
 		} else
 			return -EINVAL;
@@ -1101,7 +1803,7 @@
 		if (put_user(par->features, (u32 *) arg))
 			return -EFAULT;
 		break;
=2D#endif				/* DEBUG && CONFIG_FB_ATY_CT */
+#endif /* DEBUG && CONFIG_FB_ATY_CT */
 	default:
 		return -EINVAL;
 	}
@@ -1118,8 +1820,7 @@
 }
=20
 #ifdef __sparc__
=2Dstatic int atyfb_mmap(struct fb_info *info, struct file *file,
=2D		      struct vm_area_struct *vma)
+static int atyfb_mmap(struct fb_info *info, struct file *file, struct vm_a=
rea_struct *vma)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	unsigned int size, page, map_size =3D 0;
@@ -1243,83 +1944,22 @@
 				info->var.yoffset =3D atyfb_save.yoffset;
 				set_off_pitch(par, info);
 			}
+			aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
 			break;
 		}
 	}
 }
=2D#endif				/* __sparc__ */
=2D
+#endif /* __sparc__ */
=20
=20
=2D#ifdef CONFIG_PMAC_PBOOK
=20
=2Dstatic struct fb_info *first_display =3D NULL;
+#if defined(CONFIG_PM) && defined(CONFIG_PCI)
=20
 /* Power management routines. Those are used for PowerBook sleep.
=2D *
=2D * It appears that Rage LT and Rage LT Pro have different power
=2D * management registers. There's is some confusion about which
=2D * chipID is a Rage LT or LT pro :(
  */
=2Dstatic int aty_power_mgmt_LT(int sleep, struct atyfb_par *par)
=2D{
=2D	unsigned int pm;
=2D	int timeout;
=2D
=2D	pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D	pm =3D (pm & ~PWR_MGT_MODE_MASK) | PWR_MGT_MODE_REG;
=2D	aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D	pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D
=2D	timeout =3D 200000;
=2D	if (sleep) {
=2D		/* Sleep */
=2D		pm &=3D ~PWR_MGT_ON;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D		udelay(10);
=2D		pm &=3D ~(PWR_BLON | AUTO_PWR_UP);
=2D		pm |=3D SUSPEND_NOW;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D		udelay(10);
=2D		pm |=3D PWR_MGT_ON;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		do {
=2D			pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D			udelay(10);
=2D			if ((--timeout) =3D=3D 0)
=2D				break;
=2D		} while ((pm & PWR_MGT_STATUS_MASK) !=3D
=2D			 PWR_MGT_STATUS_SUSPEND);
=2D	} else {
=2D		/* Wakeup */
=2D		pm &=3D ~PWR_MGT_ON;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D		udelay(10);
=2D		pm |=3D (PWR_BLON | AUTO_PWR_UP);
=2D		pm &=3D ~SUSPEND_NOW;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D		udelay(10);
=2D		pm |=3D PWR_MGT_ON;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		do {
=2D			pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D			udelay(10);
=2D			if ((--timeout) =3D=3D 0)
=2D				break;
=2D		} while ((pm & PWR_MGT_STATUS_MASK) !=3D 0);
=2D	}
=2D	mdelay(500);
=2D
=2D	return timeout ? PBOOK_SLEEP_OK : PBOOK_SLEEP_REFUSE;
=2D}
=2D
=2Dstatic int aty_power_mgmt_LTPro(int sleep, struct atyfb_par *par)
+static int aty_power_mgmt(int sleep, struct atyfb_par *par)
 {
=2D	unsigned int pm;
+	u32 pm;
 	int timeout;
=20
 	pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
@@ -1327,7 +1967,7 @@
 	aty_st_lcd(POWER_MANAGEMENT, pm, par);
 	pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
=20
=2D	timeout =3D 200;
+	timeout =3D 2000;
 	if (sleep) {
 		/* Sleep */
 		pm &=3D ~PWR_MGT_ON;
@@ -1346,8 +1986,7 @@
 			mdelay(1);
 			if ((--timeout) =3D=3D 0)
 				break;
=2D		} while ((pm & PWR_MGT_STATUS_MASK) !=3D
=2D			 PWR_MGT_STATUS_SUSPEND);
+		} while ((pm & PWR_MGT_STATUS_MASK) !=3D PWR_MGT_STATUS_SUSPEND);
 	} else {
 		/* Wakeup */
 		pm &=3D ~PWR_MGT_ON;
@@ -1368,88 +2007,92 @@
 				break;
 		} while ((pm & PWR_MGT_STATUS_MASK) !=3D 0);
 	}
+	mdelay(500);
=20
=2D	return timeout ? PBOOK_SLEEP_OK : PBOOK_SLEEP_REFUSE;
+	return timeout ? -1 : 0;
 }
=20
=2Dstatic int aty_power_mgmt(int sleep, struct atyfb_par *par)
+static int atyfb_pci_suspend(struct pci_dev *pdev, u32 state)
 {
=2D	return M64_HAS(LT_SLEEP) ? aty_power_mgmt_LT(sleep, par)
=2D	    : aty_power_mgmt_LTPro(sleep, par);
+	struct fb_info *info =3D pci_get_drvdata(pdev);
+	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+
+#ifdef CONFIG_PPC_PMAC
+	/* HACK ALERT ! Once I find a proper way to say to each driver
+	 * individually what will happen with it's PCI slot, I'll change
+	 * that. On laptops, the AGP slot is just unclocked, so D2 is
+	 * expected, while on desktops, the card is powered off
+	 */
+	if (state >=3D 3)
+		state =3D 2;
+#endif /* CONFIG_PPC_PMAC */
+
+	if (state !=3D 2 || state =3D=3D pdev->dev.power_state)
+		return 0;
+
+	acquire_console_sem();
+
+	fb_set_suspend(info, 1);
+
+	/* Idle & reset engine */
+	wait_for_idle(par);
+	aty_reset_engine(par);
+
+	/* Blank display and LCD */
+	atyfb_blank(VESA_POWERDOWN + 1, info);
+
+	par->asleep =3D 1;
+	par->lock_blank =3D 1;
+
+	/* Set chip to "suspend" mode */
+	if (aty_power_mgmt(1, par)) {
+		par->asleep =3D 0;
+		par->lock_blank =3D 0;
+		atyfb_blank(0, info);
+		fb_set_suspend(info, 0);
+		release_console_sem();
+		return -EIO;
+	}
+
+	release_console_sem();
+
+	pdev->dev.power_state =3D state;
+
+	return 0;
 }
=20
=2D/*
=2D * Save the contents of the frame buffer when we go to sleep,
=2D * and restore it when we wake up again.
=2D */
=2Dstatic int aty_sleep_notify(struct pmu_sleep_notifier *self, int when)
+static int atyfb_pci_resume(struct pci_dev *pdev)
 {
=2D	struct fb_info *info;
=2D	struct atyfb_par *par;=20
=2D	int result;
+	struct fb_info *info =3D pci_get_drvdata(pdev);
+	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+
+	if (pdev->dev.power_state =3D=3D 0)
+		return 0;
=20
=2D	result =3D PBOOK_SLEEP_OK;
+	acquire_console_sem();
=20
=2D	for (info =3D first_display; info !=3D NULL; info =3D par->next) {
=2D		int nb;
+	if (pdev->dev.power_state =3D=3D 2)
+		aty_power_mgmt(0, par);
+	par->asleep =3D 0;
=20
=2D		par =3D (struct atyfb_par *) info->par;
=2D		nb =3D info->var.yres * info->fix.line_length;
=2D
=2D		switch (when) {
=2D		case PBOOK_SLEEP_REQUEST:
=2D			par->save_framebuffer =3D vmalloc(nb);
=2D			if (par->save_framebuffer =3D=3D NULL)
=2D				return PBOOK_SLEEP_REFUSE;
=2D			break;
=2D		case PBOOK_SLEEP_REJECT:
=2D			if (par->save_framebuffer) {
=2D				vfree(par->save_framebuffer);
=2D				par->save_framebuffer =3D NULL;
=2D			}
=2D			break;
=2D		case PBOOK_SLEEP_NOW:
=2D			if (par->blitter_may_be_busy)
=2D				wait_for_idle(par);
=2D			/* Stop accel engine (stop bus mastering) */
=2D			if (par->accel_flags & FB_ACCELF_TEXT)
=2D				aty_reset_engine(par);
=2D
=2D			/* Backup fb content */
=2D			if (par->save_framebuffer)
=2D				memcpy_fromio(par->save_framebuffer,
=2D					      (void *) info->screen_base, nb);
=2D
=2D			/* Blank display and LCD */
=2D			atyfb_blank(VESA_POWERDOWN + 1, info);
=2D
=2D			/* Set chip to "suspend" mode */
=2D			result =3D aty_power_mgmt(1, par);
=2D			break;
=2D		case PBOOK_WAKE:
=2D			/* Wakeup chip */
=2D			result =3D aty_power_mgmt(0, par);
=2D
=2D			/* Restore fb content */
=2D			if (par->save_framebuffer) {
=2D				memcpy_toio((void *) info->screen_base,
=2D					    par->save_framebuffer, nb);
=2D				vfree(par->save_framebuffer);
=2D				par->save_framebuffer =3D NULL;
=2D			}
=2D			/* Restore display */
=2D			atyfb_set_par(info);
=2D			atyfb_blank(0, info);
=2D			break;
=2D		}
=2D	}
=2D	return result;
+	/* Restore display */
+	atyfb_set_par(info);
+
+	/* Refresh */
+	fb_set_suspend(info, 0);
+
+	/* Unblank */
+	par->lock_blank =3D 0;
+	atyfb_blank(0, info);
+
+	release_console_sem();
+
+	pdev->dev.power_state =3D 0;
+
+	return 0;
 }
=20
=2Dstatic struct pmu_sleep_notifier aty_sleep_notifier =3D {
=2D	aty_sleep_notify, SLEEP_LEVEL_VIDEO,
=2D};
=2D#endif				/* CONFIG_PMAC_PBOOK */
+#endif /*  defined(CONFIG_PM) && defined(CONFIG_PCI) */
=20
 #ifdef CONFIG_PMAC_BACKLIGHT
=20
@@ -1489,9 +2132,34 @@
 	aty_set_backlight_enable,
 	aty_set_backlight_level
 };
=2D#endif				/* CONFIG_PMAC_BACKLIGHT */
+#endif /* CONFIG_PMAC_BACKLIGHT */
=20
+static void __init aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
+{
+	const int ragepro_tbl[] =3D {
+		44, 50, 55, 66, 75, 80, 100
+	};
+	const int ragexl_tbl[] =3D {
+		50, 66, 75, 83, 90, 95, 100, 105,
+		110, 115, 120, 125, 133, 143, 166
+	};
+	const int *refresh_tbl;
+	int i, size;
+
+	if (IS_XL(par->pci_id) || IS_MOBILITY(par->pci_id)) {
+		refresh_tbl =3D ragexl_tbl;
+		size =3D sizeof(ragexl_tbl)/sizeof(int);
+	} else {
+		refresh_tbl =3D ragepro_tbl;
+		size =3D sizeof(ragepro_tbl)/sizeof(int);
+	}
=20
+	for (i=3D0; i < size; i++) {
+		if (xclk < refresh_tbl[i])
+		break;
+	}
+	par->mem_refresh_rate =3D i;
+}
=20
     /*
      *  Initialisation
@@ -1502,37 +2170,36 @@
 static int __init aty_init(struct fb_info *info, const char *name)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	const char *chipname =3D NULL, *ramname =3D NULL, *xtal;
=2D	int j, pll, mclk, gtb_memsize;
+	const char *ramname =3D NULL, *xtal;
+	int gtb_memsize;
 	struct fb_var_screeninfo var;
=2D	u32 chip_id, i;
=2D	u16 type;
=2D	u8 rev;
+	u8 pll_ref_div;
+	u32 i;
 #if defined(CONFIG_PPC)
 	int sense;
 #endif
=2D	u8 pll_ref_div;
+
+	init_waitqueue_head(&par->vblank.wait);
+	spin_lock_init(&par->int_lock);
=20
 	par->aty_cmap_regs =3D
 	    (struct aty_cmap_regs *) (par->ati_regbase + 0xc0);
=2D	chip_id =3D aty_ld_le32(CONFIG_CHIP_ID, par);
=2D	type =3D chip_id & CFG_CHIP_TYPE;
=2D	rev =3D (chip_id & CFG_CHIP_REV) >> 24;
=2D	for (j =3D 0; j < (sizeof(aty_chips) / sizeof(*aty_chips)); j++)
=2D		if (type =3D=3D aty_chips[j].chip_type &&
=2D		    (rev & aty_chips[j].rev_mask) =3D=3D
=2D		    aty_chips[j].rev_val) {
=2D			chipname =3D aty_chips[j].name;
=2D			pll =3D aty_chips[j].pll;
=2D			mclk =3D aty_chips[j].mclk;
=2D			par->features =3D aty_chips[j].features;
=2D			goto found;
=2D		}
=2D	printk("atyfb: Unknown mach64 0x%04x rev 0x%04x\n", type, rev);
=2D	return 0;
=20
=2D      found:
=2D	printk("atyfb: %s [0x%04x rev 0x%02x] ", chipname, type, rev);
+	if (pll)
+		par->pll_limits.pll_max =3D pll;
+	if (mclk)
+		par->pll_limits.mclk =3D mclk;
+	if (xclk)
+		par->pll_limits.xclk =3D xclk;
+
+	aty_calc_mem_refresh(par, par->pll_limits.xclk);
+	par->pll_per =3D 1000000/par->pll_limits.pll_max;
+	par->mclk_per =3D 1000000/par->pll_limits.mclk;
+	par->xclk_per =3D 1000000/par->pll_limits.xclk;
+
+	par->ref_clk_per =3D 1000000000000ULL / 14318180;
+	xtal =3D "14.31818";
+
 #ifdef CONFIG_FB_ATY_GX
 	if (!M64_HAS(INTEGRATED)) {
 		u32 stat0;
@@ -1549,9 +2216,7 @@
 		if (dac_type =3D=3D 0x07)
 			dac_subtype =3D DAC_ATT20C408;
 		else
=2D			dac_subtype =3D
=2D			    (aty_ld_8(SCRATCH_REG1 + 1, par) & 0xF0) |
=2D			    dac_type;
+			dac_subtype =3D (aty_ld_8(SCRATCH_REG1 + 1, par) & 0xF0) | dac_type;
 #else
 		dac_type =3D DAC_IBMRGB514;
 		dac_subtype =3D DAC_IBMRGB514;
@@ -1570,8 +2235,7 @@
 			par->dac_ops =3D &aty_dac_att21c498;
 			break;
 		default:
=2D			printk
=2D			    (" atyfb_set_par: DAC type not implemented yet!\n");
+			PRINTKI("aty_init: DAC type not implemented yet!\n");
 			par->dac_ops =3D &aty_dac_unsupported;
 			break;
 		}
@@ -1592,33 +2256,30 @@
 			par->pll_ops =3D &aty_pll_ibm514;
 			break;
 		default:
=2D			printk
=2D			    (" atyfb_set_par: CLK type not implemented yet!");
+			PRINTKI("aty_init: CLK type not implemented yet!");
 			par->pll_ops =3D &aty_pll_unsupported;
 			break;
 		}
 	}
=2D#endif				/* CONFIG_FB_ATY_GX */
+#endif /* CONFIG_FB_ATY_GX */
 #ifdef CONFIG_FB_ATY_CT
 	if (M64_HAS(INTEGRATED)) {
+		par->dac_ops =3D &aty_dac_ct;
+		par->pll_ops =3D &aty_pll_ct;
 		par->bus_type =3D PCI;
 		par->ram_type =3D (aty_ld_le32(CONFIG_STAT0, par) & 0x07);
 		ramname =3D aty_ct_ram[par->ram_type];
=2D		par->dac_ops =3D &aty_dac_ct;
=2D		par->pll_ops =3D &aty_pll_ct;
+
 		/* for many chips, the mclk is 67 MHz for SDRAM, 63 MHz otherwise */
=2D		if (mclk =3D=3D 67 && par->ram_type < SDRAM)
=2D			mclk =3D 63;
+		if (par->pll_limits.mclk =3D=3D 67 && par->ram_type < SDRAM)
+			par->pll_limits.mclk =3D 63;
 	}
=2D#endif				/* CONFIG_FB_ATY_CT */
=20
=2D	par->ref_clk_per =3D 1000000000000ULL / 14318180;
=2D	xtal =3D "14.31818";
 	if (M64_HAS(GTB_DSP)
=2D	    && (pll_ref_div =3D aty_ld_pll(PLL_REF_DIV, par))) {
+	    && (pll_ref_div =3D aty_ld_pll_ct(PLL_REF_DIV, par))) {
 		int diff1, diff2;
=2D		diff1 =3D 510 * 14 / pll_ref_div - pll;
=2D		diff2 =3D 510 * 29 / pll_ref_div - pll;
+		diff1 =3D 510 * 14 / pll_ref_div - par->pll_limits.pll_max;
+		diff2 =3D 510 * 29 / pll_ref_div - par->pll_limits.pll_max;
 		if (diff1 < 0)
 			diff1 =3D -diff1;
 		if (diff2 < 0)
@@ -1628,6 +2289,12 @@
 			xtal =3D "29.498928";
 		}
 	}
+#endif /* CONFIG_FB_ATY_CT */
+
+	/* save previous video mode */
+	aty_get_crtc(par, &saved_crtc);
+	if(par->pll_ops->get_pll)
+		par->pll_ops->get_pll(info, &saved_pll);
=20
 	i =3D aty_ld_le32(MEM_CNTL, par);
 	gtb_memsize =3D M64_HAS(GTB_DSP);
@@ -1682,8 +2349,8 @@
 			info->fix.smem_len +=3D 0x400000;
 	}
=20
=2D	if (default_vram) {
=2D		info->fix.smem_len =3D default_vram * 1024;
+	if (vram) {
+		info->fix.smem_len =3D vram * 1024;
 		i =3D i & ~(gtb_memsize ? 0xF : MEM_SIZE_ALIAS);
 		if (info->fix.smem_len <=3D 0x80000)
 			i |=3D MEM_SIZE_512K;
@@ -1701,7 +2368,7 @@
 	}
=20
 	/*
=2D	 *  Reg Block 0 (CT-compatible block) is at mmio_start=20
+	 *  Reg Block 0 (CT-compatible block) is at mmio_start
 	 *  Reg Block 1 (multimedia extensions) is at mmio_start - 0x400
 	 */
 	if (M64_HAS(GX)) {
@@ -1711,79 +2378,77 @@
 		info->fix.mmio_len =3D 0x400;
 		info->fix.accel =3D FB_ACCEL_ATI_MACH64CT;
 	} else if (M64_HAS(VT)) {
=2D		info->fix.mmio_start =3D -0x400;
+		info->fix.mmio_start -=3D 0x400;
 		info->fix.mmio_len =3D 0x800;
 		info->fix.accel =3D FB_ACCEL_ATI_MACH64VT;
=2D	} else {		/* if (M64_HAS(GT)) */
=2D
=2D		info->fix.mmio_start =3D -0x400;
+	} else {/* GT */
+		info->fix.mmio_start -=3D 0x400;
 		info->fix.mmio_len =3D 0x800;
 		info->fix.accel =3D FB_ACCEL_ATI_MACH64GT;
 	}
=20
=2D	if (default_pll)
=2D		pll =3D default_pll;
=2D	if (default_mclk)
=2D		mclk =3D default_mclk;
=2D
=2D	printk("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK\n",
=2D	       info->fix.smem_len =3D=3D
=2D	       0x80000 ? 512 : (info->fix.smem_len >> 20),
=2D	       info->fix.smem_len =3D=3D 0x80000 ? 'K' : 'M', ramname,
=2D	       xtal, pll, mclk);
=2D
=2D	if (mclk < 44)
=2D		par->mem_refresh_rate =3D 0;	/* 000 =3D 10 Mhz - 43 Mhz */
=2D	else if (mclk < 50)
=2D		par->mem_refresh_rate =3D 1;	/* 001 =3D 44 Mhz - 49 Mhz */
=2D	else if (mclk < 55)
=2D		par->mem_refresh_rate =3D 2;	/* 010 =3D 50 Mhz - 54 Mhz */
=2D	else if (mclk < 66)
=2D		par->mem_refresh_rate =3D 3;	/* 011 =3D 55 Mhz - 65 Mhz */
=2D	else if (mclk < 75)
=2D		par->mem_refresh_rate =3D 4;	/* 100 =3D 66 Mhz - 74 Mhz */
=2D	else if (mclk < 80)
=2D		par->mem_refresh_rate =3D 5;	/* 101 =3D 75 Mhz - 79 Mhz */
=2D	else if (mclk < 100)
=2D		par->mem_refresh_rate =3D 6;	/* 110 =3D 80 Mhz - 100 Mhz */
=2D	else
=2D		par->mem_refresh_rate =3D 7;	/* 111 =3D 100 Mhz and above */
=2D	par->pll_per =3D 1000000 / pll;
=2D	par->mclk_per =3D 1000000 / mclk;
+	PRINTKI("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK, %d MHz XCLK\n",
+	       info->fix.smem_len =3D=3D 0x80000 ? 512 : (info->fix.smem_len >> 2=
0),
+	       info->fix.smem_len =3D=3D 0x80000 ? 'K' : 'M', ramname, xtal, par-=
>pll_limits.pll_max,
+	       par->pll_limits.mclk, par->pll_limits.xclk);
=20
=2D#ifdef DEBUG
+#if defined(DEBUG) && defined(CONFIG_ATY_CT)
 	if (M64_HAS(INTEGRATED)) {
 		int i;
=2D		printk
=2D		    ("BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL "
=2D		     "DSP_CONFIG DSP_ON_OFF\n"
=2D		     "%08x %08x %08x %08x     %08x      %08x   %08x\n"
=2D		     "PLL", aty_ld_le32(BUS_CNTL, par),
=2D		     aty_ld_le32(DAC_CNTL, par), aty_ld_le32(MEM_CNTL,
=2D							     par),
=2D		     aty_ld_le32(EXT_MEM_CNTL, par),
=2D		     aty_ld_le32(CRTC_GEN_CNTL, par),
=2D		     aty_ld_le32(DSP_CONFIG, par), aty_ld_le32(DSP_ON_OFF,
=2D							       par));
=2D		for (i =3D 0; i < 16; i++)
=2D			printk(" %02x", aty_ld_pll(i, par));
+		printk("debug atyfb: BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CN=
TL "
+		       "DSP_CONFIG DSP_ON_OFF CLOCK_CNTL\n"
+		       "debug atyfb: %08x %08x %08x %08x     %08x      %08x   %08x   %08=
x\n"
+		       "debug atyfb: PLL",
+			aty_ld_le32(BUS_CNTL, par), aty_ld_le32(DAC_CNTL, par),
+			aty_ld_le32(MEM_CNTL, par), aty_ld_le32(EXT_MEM_CNTL, par),
+			aty_ld_le32(CRTC_GEN_CNTL, par), aty_ld_le32(DSP_CONFIG, par),
+			aty_ld_le32(DSP_ON_OFF, par), aty_ld_le32(CLOCK_CNTL, par));
+		for (i =3D 0; i < 40; i++)
+			printk(" %02x", aty_ld_pll_ct(i, par));
 		printk("\n");
 	}
 #endif
+	if(par->pll_ops->init_pll)
+		par->pll_ops->init_pll(info, &par->pll);
=20
 	/*
 	 *  Last page of 8 MB (4 MB on ISA) aperture is MMIO
 	 *  FIXME: we should use the auxiliary aperture instead so we can access
 	 *  the full 8 MB of video RAM on 8 MB boards
 	 */
=2D	if (info->fix.smem_len =3D=3D 0x800000 ||
=2D	    (par->bus_type =3D=3D ISA=20
=2D	     && info->fix.smem_len =3D=3D 0x400000))
+
+	if (!par->aux_start &&
+		(info->fix.smem_len =3D=3D 0x800000 || (par->bus_type =3D=3D ISA && info=
=2D>fix.smem_len =3D=3D 0x400000)))
 		info->fix.smem_len -=3D GUI_RESERVE;
=20
+	/*
+	 *  Disable register access through the linear aperture
+	 *  if the auxiliary aperture is used so we can access
+	 *  the full 8 MB of video RAM on 8 MB boards.
+	 */
+	if (par->aux_start)
+		aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL, par) | BUS_APER_REG_DIS, par=
);
+
+#ifdef CONFIG_MTRR
+	par->mtrr_aper =3D -1;
+	par->mtrr_reg =3D -1;
+	if (!nomtrr) {
+		/* Cover the whole resource. */
+		 par->mtrr_aper =3D mtrr_add(par->res_start, par->res_size, MTRR_TYPE_WR=
COMB, 1);
+		 if (par->mtrr_aper >=3D 0 && !par->aux_start) {
+			/* Make a hole for mmio. */
+			par->mtrr_reg =3D mtrr_add(par->res_start + 0x800000 - GUI_RESERVE,
+				GUI_RESERVE, MTRR_TYPE_UNCACHABLE, 1);
+			if (par->mtrr_reg < 0) {
+				mtrr_del(par->mtrr_aper, 0, 0);
+				par->mtrr_aper =3D -1;
+			}
+		 }
+	}
+#endif
+
 	/* Clear the video memory */
=2D	fb_memset((void *) info->screen_base, 0,
=2D		  info->fix.smem_len);
+	fb_memset((void *) info->screen_base, 0, info->fix.smem_len);
=20
 	info->fbops =3D &atyfb_ops;
 	info->pseudo_palette =3D pseudo_palette;
@@ -1792,18 +2457,12 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if (M64_HAS(G3_PB_1_1) && machine_is_compatible("PowerBook1,1")) {
 		/* these bits let the 101 powerbook wake up from sleep -- paulus */
=2D		aty_st_lcd(POWER_MANAGEMENT,
=2D			   aty_ld_lcd(POWER_MANAGEMENT, par)
+		aty_st_lcd(POWER_MANAGEMENT, aty_ld_lcd(POWER_MANAGEMENT, par)
 			   | (USE_F32KHZ | TRISTATE_MEM_EN), par);
=2D	}
=2D	if (M64_HAS(MOBIL_BUS))
=2D		register_backlight_controller(&aty_backlight_controller,
=2D					      info, "ati");
=2D#endif				/* CONFIG_PMAC_BACKLIGHT */
+	} else if (M64_HAS(MOBIL_BUS))
+		register_backlight_controller(&aty_backlight_controller, info, "ati");
+#endif /* CONFIG_PMAC_BACKLIGHT */
=20
=2D#ifdef MODULE
=2D	var =3D default_var;
=2D#else				/* !MODULE */
 	memset(&var, 0, sizeof(var));
 #ifdef CONFIG_PPC
 	if (_machine =3D=3D _MACH_Pmac) {
@@ -1811,9 +2470,8 @@
 		 *  FIXME: The NVRAM stuff should be put in a Mac-specific file, as it
 		 *         applies to all Mac video cards
 		 */
=2D		if (mode_option) {
=2D			if (!mac_find_mode
=2D			    (&var, info, mode_option, 8))
+		if (mode) {
+			if (!mac_find_mode(&var, info, mode, 8))
 				var =3D default_var;
 		} else {
 			if (default_vmode =3D=3D VMODE_CHOOSE) {
@@ -1829,484 +2487,948 @@
 				else
 					default_vmode =3D VMODE_640_480_67;
 				sense =3D read_aty_sense(par);
=2D				printk(KERN_INFO
=2D				       "atyfb: monitor sense=3D%x, mode %d\n",
=2D				       sense,
=2D				       mac_map_monitor_sense(sense));
+				PRINTKI("monitor sense=3D%x, mode %d\n",
+					sense,  mac_map_monitor_sense(sense));
 			}
=2D			if (default_vmode <=3D 0
=2D			    || default_vmode > VMODE_MAX)
+			if (default_vmode <=3D 0 || default_vmode > VMODE_MAX)
 				default_vmode =3D VMODE_640_480_60;
=2D			if (default_cmode < CMODE_8
=2D			    || default_cmode > CMODE_32)
+			if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 				default_cmode =3D CMODE_8;
=2D			if (mac_vmode_to_var
=2D			    (default_vmode, default_cmode, &var))
+			if (mac_vmode_to_var(default_vmode, default_cmode, &var))
 				var =3D default_var;
 		}
 	} else
=2D	    if (!fb_find_mode
=2D		(&var, info, mode_option, NULL, 0, NULL, 8))
=2D		var =3D default_var;
=2D#else				/* !CONFIG_PPC */
=2D#ifdef __sparc__
=2D	if (mode_option) {
=2D		if (!fb_find_mode
=2D		    (&var, info, mode_option, NULL, 0, NULL, 8))
=2D			var =3D default_var;
=2D	} else
+#endif /* !CONFIG_PPC */
+	if (!fb_find_mode(&var, info, mode, NULL, 0, &defmode, 8))
 		var =3D default_var;
=2D#else
=2D	if (!fb_find_mode
=2D	    (&var, info, mode_option, NULL, 0, NULL, 8))
=2D		var =3D default_var;
=2D#endif				/* !__sparc__ */
=2D#endif				/* !CONFIG_PPC */
=2D#endif				/* !MODULE */
+
 	if (noaccel)
 		var.accel_flags &=3D ~FB_ACCELF_TEXT;
 	else
 		var.accel_flags |=3D FB_ACCELF_TEXT;
=20
 	if (var.yres =3D=3D var.yres_virtual) {
=2D		u32 vram =3D (info->fix.smem_len - (PAGE_SIZE << 2));
=2D		var.yres_virtual =3D
=2D		    ((vram * 8) / var.bits_per_pixel) / var.xres_virtual;
+		u32 videoram =3D (info->fix.smem_len - (PAGE_SIZE << 2));
+		var.yres_virtual =3D ((videoram * 8) / var.bits_per_pixel) / var.xres_vi=
rtual;
 		if (var.yres_virtual < var.yres)
 			var.yres_virtual =3D var.yres;
 	}
=20
 	if (atyfb_check_var(&var, info)) {
=2D		printk("atyfb: can't set default video mode\n");
=2D		return 0;
+		PRINTKE("can't set default video mode\n");
+		goto aty_init_exit;
 	}
+
 #ifdef __sparc__
 	atyfb_save_palette(par, 0);
 #endif
=20
 #ifdef CONFIG_FB_ATY_CT
=2D	if (curblink && M64_HAS(INTEGRATED))
=2D		par->cursor =3D aty_init_cursor(info);
=2D#endif				/* CONFIG_FB_ATY_CT */
+	if (!noaccel && M64_HAS(INTEGRATED))
+		aty_init_cursor(info);
+#endif /* CONFIG_FB_ATY_CT */
 	info->var =3D var;
=20
 	fb_alloc_cmap(&info->cmap, 256, 0);
=20
 	if (register_framebuffer(info) < 0)
=2D		return 0;
+		goto aty_init_exit;
=20
 	fb_list =3D info;
=20
=2D	printk("fb%d: %s frame buffer device on %s\n",
+	PRINTKI("fb%d: %s frame buffer device on %s\n",
 	       info->node, info->fix.id, name);
=2D	return 1;
+	return 0;
+
+aty_init_exit:
+	/* restore video mode */
+	aty_set_crtc(par, &saved_crtc);
+	par->pll_ops->set_pll(info, &saved_pll);
+
+#ifdef CONFIG_MTRR
+	if (par->mtrr_reg >=3D 0) {
+	    mtrr_del(par->mtrr_reg, 0, 0);
+	    par->mtrr_reg =3D -1;
+	}
+	if (par->mtrr_aper >=3D 0) {
+	    mtrr_del(par->mtrr_aper, 0, 0);
+	    par->mtrr_aper =3D -1;
+	}
+#endif
+	return -1;
 }
=20
=2Dint __init atyfb_do_init(void)
+#ifdef CONFIG_ATARI
+static int __init store_video_par(char *video_str, unsigned char m64_num)
 {
=2D#if defined(CONFIG_PCI)
=2D	unsigned long addr, res_start, res_size;
=2D	struct atyfb_par *default_par;
=2D	struct pci_dev *pdev =3D NULL;
=2D	struct fb_info *info;
=2D	int i;
+	char *p;
+	unsigned long vmembase, size, guiregbase;
+
+	PRINTKI("store_video_par() '%s' \n", video_str);
+
+	if (!(p =3D strsep(&video_str, ";")) || !*p)
+		goto mach64_invalid;
+	vmembase =3D simple_strtoul(p, NULL, 0);
+	if (!(p =3D strsep(&video_str, ";")) || !*p)
+		goto mach64_invalid;
+	size =3D simple_strtoul(p, NULL, 0);
+	if (!(p =3D strsep(&video_str, ";")) || !*p)
+		goto mach64_invalid;
+	guiregbase =3D simple_strtoul(p, NULL, 0);
+
+	phys_vmembase[m64_num] =3D vmembase;
+	phys_size[m64_num] =3D size;
+	phys_guiregbase[m64_num] =3D guiregbase;
+	PRINTKI("stored them all: $%08lX $%08lX $%08lX \n", vmembase, size,
+	       guiregbase);
+	return 0;
+
+      mach64_invalid:
+	phys_vmembase[m64_num] =3D 0;
+	return -1;
+}
+#endif /* CONFIG_ATARI */
+
+    /*
+     *  Blank the display.
+     */
+
+static int atyfb_blank(int blank, struct fb_info *info)
+{
+	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+	u8 gen_cntl;
+
+	if (par->lock_blank || par->asleep)
+		return 0;
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if ((_machine =3D=3D _MACH_Pmac) && blank)
+		set_backlight_enable(0);
+#elif defined(CONFIG_FB_ATY_GENERIC_LCD)
+	if (par->lcd_table && blank &&
+	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
+		u32 pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
+		pm &=3D ~PWR_BLON;
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+	}
+#endif
+
+	gen_cntl =3D aty_ld_8(CRTC_GEN_CNTL, par);
+	if (blank > 0)
+		switch (blank - 1) {
+		case VESA_NO_BLANKING:
+			gen_cntl |=3D 0x40;
+			break;
+		case VESA_VSYNC_SUSPEND:
+			gen_cntl |=3D 0x8;
+			break;
+		case VESA_HSYNC_SUSPEND:
+			gen_cntl |=3D 0x4;
+			break;
+		case VESA_POWERDOWN:
+			gen_cntl |=3D 0x4c;
+			break;
+	} else
+		gen_cntl &=3D ~(0x4c);
+	aty_st_8(CRTC_GEN_CNTL, gen_cntl, par);
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if ((_machine =3D=3D _MACH_Pmac) && !blank)
+		set_backlight_enable(1);
+#elif defined(CONFIG_FB_ATY_GENERIC_LCD)
+	if (par->lcd_table && !blank &&
+	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
+		u32 pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
+		pm |=3D PWR_BLON;
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+	}
+#endif
+
+	return 0;
+}
+
+static void aty_st_pal(u_int regno, u_int red, u_int green, u_int blue,
+		       const struct atyfb_par *par)
+{
+#ifdef CONFIG_ATARI
+	out_8(&par->aty_cmap_regs->windex, regno);
+	out_8(&par->aty_cmap_regs->lut, red);
+	out_8(&par->aty_cmap_regs->lut, green);
+	out_8(&par->aty_cmap_regs->lut, blue);
+#else
+	writeb(regno, &par->aty_cmap_regs->windex);
+	writeb(red, &par->aty_cmap_regs->lut);
+	writeb(green, &par->aty_cmap_regs->lut);
+	writeb(blue, &par->aty_cmap_regs->lut);
+#endif
+}
+
+    /*
+     *  Set a single color register. The values supplied are already
+     *  rounded down to the hardware's capabilities (according to the
+     *  entries in the var structure). Return !=3D 0 for invalid regno.
+     *  !! 4 & 8 =3D  PSEUDO, > 8 =3D DIRECTCOLOR
+     */
+
+static int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+	u_int transp, struct fb_info *info)
+{
+	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+	int i, depth;
+	u32 *pal =3D info->pseudo_palette;
+
+	depth =3D info->var.bits_per_pixel;
+	if (depth =3D=3D 16)
+		depth =3D (info->var.green.length =3D=3D 5) ? 15 : 16;
+
+	if (par->asleep)
+		return 0;
+
+	if (regno > 255 ||
+	    (depth =3D=3D 16 && regno > 63) ||
+	    (depth =3D=3D 15 && regno > 31))
+		return 1;
+
+	red >>=3D 8;
+	green >>=3D 8;
+	blue >>=3D 8;
+
+	par->palette[regno].red =3D red;
+	par->palette[regno].green =3D green;
+	par->palette[regno].blue =3D blue;
+
+	if (regno < 16) {
+		switch (depth) {
+		case 15:
+			pal[regno] =3D (regno << 10) | (regno << 5) | regno;
+			break;
+		case 16:
+			pal[regno] =3D (regno << 11) | (regno << 5) | regno;
+			break;
+		case 24:
+			pal[regno] =3D (regno << 16) | (regno << 8) | regno;
+			break;
+		case 32:
+			i =3D (regno << 8) | regno;
+			pal[regno] =3D (i << 16) | i;
+			break;
+		}
+	}
+
+	i =3D aty_ld_8(DAC_CNTL, par) & 0xfc;
+	if (M64_HAS(EXTRA_BRIGHT))
+		i |=3D 0x2; /* DAC_CNTL | 0x2 turns off the extra brightness for gt */
+	aty_st_8(DAC_CNTL, i, par);
+	aty_st_8(DAC_MASK, 0xff, par);
+
+	if (M64_HAS(INTEGRATED)) {
+		if (depth =3D=3D 16) {
+			if (regno < 32)
+				aty_st_pal(regno << 3, red,
+					   par->palette[regno<<1].green,
+					   blue, par);
+			red =3D par->palette[regno>>1].red;
+			blue =3D par->palette[regno>>1].blue;
+			regno <<=3D 2;
+		} else if (depth =3D=3D 15) {
+			regno <<=3D 3;
+			for(i =3D 0; i < 8; i++) {
+			    aty_st_pal(regno + i, red, green, blue, par);
+			}
+		}
+	}
+	aty_st_pal(regno, red, green, blue, par);
+
+	return 0;
+}
+
+#ifdef CONFIG_PCI
+
 #ifdef __sparc__
+
+static int __devinit atyfb_setup_sparc(struct pci_dev *pdev, struct fb_ind=
o *info, unsigned long addr)
+{
 	extern void (*prom_palette) (int);
 	extern int con_is_present(void);
+
+	struct atyfb_par *par =3D info->par;
 	struct pcidev_cookie *pcp;
 	char prop[128];
=2D	int node, len, j;
+	int node, len, i, j, ret;
 	u32 mem, chip_id;
=2D#else
=2D	u16 tmp;
=2D#endif
=20
=2D#ifdef __sparc__
 	/* Do not attach when we have a serial console. */
 	if (!con_is_present())
 		return -ENXIO;
=2D#endif
=20
=2D	while ((pdev =3D
=2D		pci_find_device(PCI_VENDOR_ID_ATI, PCI_ANY_ID, pdev))) {
=2D		if ((pdev->class >> 16) =3D=3D PCI_BASE_CLASS_DISPLAY) {
=2D			struct resource *rp;
=2D
=2D			for (i =3D
=2D			     sizeof(aty_chips) / sizeof(*aty_chips) - 1;
=2D			     i >=3D 0; i--)
=2D				if (pdev->device =3D=3D aty_chips[i].pci_id)
=2D					break;
=2D			if (i < 0)
=2D				continue;
+	/*
+	 * Map memory-mapped registers.
+	 */
+	par->ati_regbase =3D addr + 0x7ffc00UL;
+	info->fix.mmio_start =3D addr + 0x7ffc00UL;
=20
=2D			rp =3D &pdev->resource[0];
=2D			if (rp->flags & IORESOURCE_IO)
=2D				rp =3D &pdev->resource[1];
=2D			addr =3D rp->start;
=2D			if (!addr)
=2D				continue;
+	/*
+	 * Map in big-endian aperture.
+	 */
+	info->screen_base =3D (char *) (addr + 0x800000UL);
+	info->fix.smem_start =3D addr + 0x800000UL;
=20
=2D			res_start =3D rp->start;
=2D			res_size =3D rp->end - rp->start + 1;
=2D			if (!request_mem_region
=2D			    (res_start, res_size, "atyfb"))
=2D				continue;
+	/*
+	 * Figure mmap addresses from PCI config space.
+	 * Split Framebuffer in big- and little-endian halfs.
+	 */
+	for (i =3D 0; i < 6 && pdev->resource[i].start; i++)
+		/* nothing */ ;
+	j =3D i + 4;
=20
=2D			info =3D
=2D			    kmalloc(sizeof(struct fb_info), GFP_ATOMIC);
=2D			if (!info) {
=2D				printk
=2D				    ("atyfb_init: can't alloc fb_info\n");
=2D				return -ENXIO;
=2D			}
=2D			memset(info, 0, sizeof(struct fb_info));
+	par->mmap_map =3D kmalloc(j * sizeof(*par->mmap_map), GFP_ATOMIC);
+	if (!_par->mmap_map) {
+		PRINTKE("atyfb_setup_sparc() can't alloc mmap_map\n");
+		return -ENOMEM;
+	}
+	memset(par->mmap_map, 0, j * sizeof(*par->mmap_map));
=20
=2D			default_par =3D
=2D			    kmalloc(sizeof(struct atyfb_par), GFP_ATOMIC);
=2D			if (!default_par) {
=2D				printk
=2D				    ("atyfb_init: can't alloc atyfb_par\n");
=2D				kfree(info);
=2D				return -ENXIO;
=2D			}
=2D			memset(default_par, 0, sizeof(struct atyfb_par));
+	for (i =3D 0, j =3D 2; i < 6 && pdev->resource[i].start; i++) {
+		struct resource *rp =3D &pdev->resource[i];
+		int io, breg =3D PCI_BASE_ADDRESS_0 + (i << 2);
+		unsigned long base;
+		u32 size, pbase;
=20
=2D			info->fix =3D atyfb_fix;
=2D			info->par =3D default_par;
=2D			info->device =3D &pdev->dev;
=2D#ifdef __sparc__
=2D			/*
=2D			 * Map memory-mapped registers.
=2D			 */
=2D			default_par->ati_regbase =3D addr + 0x7ffc00UL;
=2D			info->fix.mmio_start =3D addr + 0x7ffc00UL;
+		base =3D rp->start;
=20
=2D			/*
=2D			 * Map in big-endian aperture.
=2D			 */
=2D			info->screen_base =3D (char *) (addr + 0x800000UL);
=2D			info->fix.smem_start =3D addr + 0x800000UL;
+		io =3D (rp->flags & IORESOURCE_IO);
=20
=2D			/*
=2D			 * Figure mmap addresses from PCI config space.
=2D			 * Split Framebuffer in big- and little-endian halfs.
=2D			 */
=2D			for (i =3D 0; i < 6 && pdev->resource[i].start; i++)
=2D				/* nothing */ ;
=2D			j =3D i + 4;
=2D
=2D			default_par->mmap_map =3D
=2D			    kmalloc(j * sizeof(*default_par->mmap_map),
=2D				    GFP_ATOMIC);
=2D			if (!default_par->mmap_map) {
=2D				printk
=2D				    ("atyfb_init: can't alloc mmap_map\n");
=2D				kfree(default_par);
=2D				kfree(info);
=2D				release_mem_region(res_start, res_size);
=2D				return -ENXIO;
+		size =3D rp->end - base + 1;
+
+		pci_read_config_dword(pdev, breg, &pbase);
+
+		if (io)
+			size &=3D ~1;
+
+		/*
+		 * Map the framebuffer a second time, this time without
+		 * the braindead _PAGE_IE setting. This is used by the
+		 * fixed Xserver, but we need to maintain the old mapping
+		 * to stay compatible with older ones...
+		 */
+		if (base =3D=3D addr) {
+			par->mmap_map[j].voff =3D (pbase + 0x10000000) & PAGE_MASK;
+			par->mmap_map[j].poff =3D base & PAGE_MASK;
+			par->mmap_map[j].size =3D (size + ~PAGE_MASK) & PAGE_MASK;
+			par->mmap_map[j].prot_mask =3D _PAGE_CACHE;
+			par->mmap_map[j].prot_flag =3D _PAGE_E;
+			j++;
+		}
+
+		/*
+		 * Here comes the old framebuffer mapping with _PAGE_IE
+		 * set for the big endian half of the framebuffer...
+		 */
+		if (base =3D=3D addr) {
+			par->mmap_map[j].voff =3D (pbase + 0x800000) & PAGE_MASK;
+			par->mmap_map[j].poff =3D (base + 0x800000) & PAGE_MASK;
+			par->mmap_map[j].size =3D 0x800000;
+			par->mmap_map[j].prot_mask =3D _PAGE_CACHE;
+			par->mmap_map[j].prot_flag =3D _PAGE_E | _PAGE_IE;
+			size -=3D 0x800000;
+			j++;
+		}
+
+		par->mmap_map[j].voff =3D pbase & PAGE_MASK;
+		par->mmap_map[j].poff =3D base & PAGE_MASK;
+		par->mmap_map[j].size =3D (size + ~PAGE_MASK) & PAGE_MASK;
+		par->mmap_map[j].prot_mask =3D _PAGE_CACHE;
+		par->mmap_map[j].prot_flag =3D _PAGE_E;
+		j++;
+	}
+
+	if((ret =3D correct_chipset(par)))
+		return ret;
+
+	if (IS_XL(pdev->device)) {
+		/*
+		 * Fix PROMs idea of MEM_CNTL settings...
+		 */
+		mem =3D aty_ld_le32(MEM_CNTL, par);
+		chip_id =3D aty_ld_le32(CONFIG_CHIP_ID, par);
+		if (((chip_id & CFG_CHIP_TYPE) =3D=3D VT_CHIP_ID) && !((chip_id >> 24) &=
 1)) {
+			switch (mem & 0x0f) {
+			case 3:
+				mem =3D (mem & ~(0x0f)) | 2;
+				break;
+			case 7:
+				mem =3D (mem & ~(0x0f)) | 3;
+				break;
+			case 9:
+				mem =3D (mem & ~(0x0f)) | 4;
+				break;
+			case 11:
+				mem =3D (mem & ~(0x0f)) | 5;
+				break;
+			default:
+				break;
 			}
=2D			memset(default_par->mmap_map, 0,
=2D			       j * sizeof(*default_par->mmap_map));
+			if ((aty_ld_le32(CONFIG_STAT0, par) & 7) >=3D SDRAM)
+				mem &=3D ~(0x00700000);
+		}
+		mem &=3D ~(0xcf80e000);	/* Turn off all undocumented bits. */
+		aty_st_le32(MEM_CNTL, mem, par);
+	}
=20
=2D			for (i =3D 0, j =3D 2;
=2D			     i < 6 && pdev->resource[i].start; i++) {
=2D				struct resource *rp =3D &pdev->resource[i];
=2D				int io, breg =3D
=2D				    PCI_BASE_ADDRESS_0 + (i << 2);
=2D				unsigned long base;
=2D				u32 size, pbase;
+	/*
+	 * If this is the console device, we will set default video
+	 * settings to what the PROM left us with.
+	 */
+	node =3D prom_getchild(prom_root_node);
+	node =3D prom_searchsiblings(node, "aliases");
+	if (node) {
+		len =3D prom_getproperty(node, "screen", prop, sizeof(prop));
+		if (len > 0) {
+			prop[len] =3D '\0';
+			node =3D prom_finddevice(prop);
+		} else
+			node =3D 0;
+	}
=20
=2D				base =3D rp->start;
+	pcp =3D pdev->sysdata;
+	if (node =3D=3D pcp->prom_node) {
+		struct fb_var_screeninfo *var =3D &default_var;
+		unsigned int N, P, Q, M, T, R;
+		u32 v_total, h_total;
+		struct crtc crtc;
+		u8 pll_regs[16];
+		u8 clock_cntl;
+
+		crtc.vxres =3D prom_getintdefault(node, "width", 1024);
+		crtc.vyres =3D prom_getintdefault(node, "height", 768);
+		var->bits_per_pixel =3D prom_getintdefault(node, "depth", 8);
+		var->xoffset =3D var->yoffset =3D 0;
+		crtc.h_tot_disp =3D aty_ld_le32(CRTC_H_TOTAL_DISP, par);
+		crtc.h_sync_strt_wid =3D aty_ld_le32(CRTC_H_SYNC_STRT_WID, par);
+		crtc.v_tot_disp =3D aty_ld_le32(CRTC_V_TOTAL_DISP, par);
+		crtc.v_sync_strt_wid =3D aty_ld_le32(CRTC_V_SYNC_STRT_WID, par);
+		crtc.gen_cntl =3D aty_ld_le32(CRTC_GEN_CNTL, par);
+		aty_crtc_to_var(&crtc, var);
=20
=2D				io =3D (rp->flags & IORESOURCE_IO);
+		h_total =3D var->xres + var->right_margin + var->hsync_len + var->left_m=
argin;
+		v_total =3D var->yres + var->lower_margin + var->vsync_len + var->upper_=
margin;
=20
=2D				size =3D rp->end - base + 1;
+		/*
+		 * Read the PLL to figure actual Refresh Rate.
+		 */
+		clock_cntl =3D aty_ld_8(CLOCK_CNTL, par);
+		/* DPRINTK("CLOCK_CNTL %02x\n", clock_cntl); */
+		for (i =3D 0; i < 16; i++)
+			pll_regs[i] =3D aty_ld_pll_ct(i, par);
=20
=2D				pci_read_config_dword(pdev, breg, &pbase);
+		/*
+		 * PLL Reference Divider M:
+		 */
+		M =3D pll_regs[2];
=20
=2D				if (io)
=2D					size &=3D ~1;
+		/*
+		 * PLL Feedback Divider N (Dependant on CLOCK_CNTL):
+		 */
+		N =3D pll_regs[7 + (clock_cntl & 3)];
=20
=2D				/*
=2D				 * Map the framebuffer a second time, this time without
=2D				 * the braindead _PAGE_IE setting. This is used by the
=2D				 * fixed Xserver, but we need to maintain the old mapping
=2D				 * to stay compatible with older ones...
=2D				 */
=2D				if (base =3D=3D addr) {
=2D					default_par->mmap_map[j].voff =3D
=2D					    (pbase +
=2D					     0x10000000) & PAGE_MASK;
=2D					default_par->mmap_map[j].poff =3D
=2D					    base & PAGE_MASK;
=2D					default_par->mmap_map[j].size =3D
=2D					    (size +
=2D					     ~PAGE_MASK) & PAGE_MASK;
=2D					default_par->mmap_map[j].prot_mask =3D
=2D					    _PAGE_CACHE;
=2D					default_par->mmap_map[j].prot_flag =3D
=2D					    _PAGE_E;
=2D					j++;
=2D				}
+		/*
+		 * PLL Post Divider P (Dependant on CLOCK_CNTL):
+		 */
+		P =3D 1 << (pll_regs[6] >> ((clock_cntl & 3) << 1));
=20
=2D				/*
=2D				 * Here comes the old framebuffer mapping with _PAGE_IE
=2D				 * set for the big endian half of the framebuffer...
=2D				 */
=2D				if (base =3D=3D addr) {
=2D					default_par->mmap_map[j].voff =3D
=2D					    (pbase + 0x800000) & PAGE_MASK;
=2D					default_par->mmap_map[j].poff =3D
=2D					    (base + 0x800000) & PAGE_MASK;
=2D					default_par->mmap_map[j].size =3D 0x800000;
=2D					default_par->mmap_map[j].prot_mask =3D
=2D					    _PAGE_CACHE;
=2D					default_par->mmap_map[j].prot_flag =3D
=2D					    _PAGE_E | _PAGE_IE;
=2D					size -=3D 0x800000;
=2D					j++;
=2D				}
+		/*
+		 * PLL Divider Q:
+		 */
+		Q =3D N / P;
=20
=2D				default_par->mmap_map[j].voff =3D pbase & PAGE_MASK;
=2D				default_par->mmap_map[j].poff =3D base & PAGE_MASK;
=2D				default_par->mmap_map[j].size =3D
=2D				    (size + ~PAGE_MASK) & PAGE_MASK;
=2D				default_par->mmap_map[j].prot_mask =3D _PAGE_CACHE;
=2D				default_par->mmap_map[j].prot_flag =3D _PAGE_E;
=2D				j++;
=2D			}
+		/*
+		 * Target Frequency:
+		 *
+		 *      T * M
+		 * Q =3D -------
+		 *      2 * R
+		 *
+		 * where R is XTALIN (=3D 14318 or 29498 kHz).
+		 */
+		if (IS_XL(pdev->device))
+			R =3D 29498;
+		else
+			R =3D 14318;
=20
=2D			if (pdev->device !=3D XL_CHIP_ID) {
=2D				/*
=2D				 * Fix PROMs idea of MEM_CNTL settings...
=2D				 */
=2D				mem =3D aty_ld_le32(MEM_CNTL, default_par);
=2D				chip_id =3D aty_ld_le32(CONFIG_CHIP_ID, default_par);
=2D				if (((chip_id & CFG_CHIP_TYPE) =3D=3D VT_CHIP_ID)
=2D				    && !((chip_id >> 24) & 1)) {
=2D					switch (mem & 0x0f) {
=2D					case 3:
=2D						mem =3D (mem & ~(0x0f)) | 2;
=2D						break;
=2D					case 7:
=2D						mem =3D (mem & ~(0x0f)) | 3;
=2D						break;
=2D					case 9:
=2D						mem =3D (mem & ~(0x0f)) | 4;
=2D						break;
=2D					case 11:
=2D						mem =3D (mem & ~(0x0f)) | 5;
=2D						break;
=2D					default:
=2D						break;
=2D					}
=2D					if ((aty_ld_le32(CONFIG_STAT0, default_par) & 7) >=3D SDRAM)
=2D						mem &=3D ~(0x00700000);
=2D				}
=2D				mem &=3D ~(0xcf80e000);	/* Turn off all undocumented bits. */
=2D				aty_st_le32(MEM_CNTL, mem, default_par);
=2D			}
+		T =3D 2 * Q * R / M;
=20
=2D			/*
=2D			 * If this is the console device, we will set default video
=2D			 * settings to what the PROM left us with.
=2D			 */
=2D			node =3D prom_getchild(prom_root_node);
=2D			node =3D prom_searchsiblings(node, "aliases");
=2D			if (node) {
=2D				len =3D
=2D				    prom_getproperty(node, "screen", prop,
=2D						     sizeof(prop));
=2D				if (len > 0) {
=2D					prop[len] =3D '\0';
=2D					node =3D prom_finddevice(prop);
+		default_var.pixclock =3D 1000000000 / T;
+	}
+
+	return 0;
+}
+
+#else /* __sparc__ */
+
+#ifdef __i386__
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
+{
+	u32 driv_inf_tab, sig;
+	u16 lcd_ofs;
+
+	/* To support an LCD panel, we should know it's dimensions and
+	 *  it's desired pixel clock.
+	 * There are two ways to do it:
+	 *  - Check the startup video mode and calculate the panel
+	 *    size from it. This is unreliable.
+	 *  - Read it from the driver information table in the video BIOS.
+	*/
+	/* Address of driver information table is at offset 0x78. */
+	driv_inf_tab =3D bios_base + *((u16 *)(bios_base+0x78));
+
+	/* Check for the driver information table signature. */
+	sig =3D (*(u32 *)driv_inf_tab);
+	if ((sig =3D=3D 0x54504c24) || /* Rage LT pro */
+		(sig =3D=3D 0x544d5224) || /* Rage mobility */
+		(sig =3D=3D 0x54435824) || /* Rage XC */
+		(sig =3D=3D 0x544c5824)) { /* Rage XL */
+		PRINTKI("BIOS contains driver information table.\n");
+		lcd_ofs =3D (*(u16 *)(driv_inf_tab + 10));
+		par->lcd_table =3D 0;
+		if (lcd_ofs !=3D 0) {
+			par->lcd_table =3D bios_base + lcd_ofs;
+		}
+	}
+
+	if (par->lcd_table !=3D 0) {
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
+		u8 lcd_refresh_rates[16] =3D {50,56,60,67,70,72,75,76,85,90,100,120,140,=
150,160,200};
+		/* The most important information is the panel size at
+		 * offset 25 and 27, but there's some other nice information
+		 * which we print to the screen.
+		 */
+		id =3D *(u8 *)par->lcd_table;
+		strncpy(model,(char *)par->lcd_table+1,24);
+		model[23]=3D0;
+
+		width =3D par->lcd_width =3D *(u16 *)(par->lcd_table+25);
+		height =3D par->lcd_height =3D *(u16 *)(par->lcd_table+27);
+		panel_type =3D *(u16 *)(par->lcd_table+29);
+		if (panel_type & 1)
+			txtcolour =3D "colour";
+		else
+			txtcolour =3D "monochrome";
+		if (panel_type & 2)
+			txtdual =3D "dual (split) ";
+		else
+			txtdual =3D "";
+		tech =3D (panel_type>>2) & 63;
+		switch (tech) {
+		case 0:
+			txtmonitor =3D "passive matrix";
+			break;
+		case 1:
+			txtmonitor =3D "active matrix";
+			break;
+		case 2:
+			txtmonitor =3D "active addressed STN";
+			break;
+		case 3:
+			txtmonitor =3D "EL";
+			break;
+		case 4:
+			txtmonitor =3D "plasma";
+			break;
+		default:
+			txtmonitor =3D "unknown";
+		}
+		format =3D *(u32 *)(par->lcd_table+57);
+		if (tech =3D=3D 0 || tech =3D=3D 2) {
+			switch (format & 7) {
+			case 0:
+				txtformat =3D "12 bit interface";
+				break;
+			case 1:
+				txtformat =3D "16 bit interface";
+				break;
+			case 2:
+				txtformat =3D "24 bit interface";
+				break;
+			default:
+				txtformat =3D "unkown format";
+			}
+		} else {
+			switch (format & 7) {
+			case 0:
+				txtformat =3D "8 colours";
+				break;
+			case 1:
+				txtformat =3D "512 colours";
+				break;
+			case 2:
+				txtformat =3D "4096 colours";
+				break;
+			case 4:
+				txtformat =3D "262144 colours (LT mode)";
+				break;
+			case 5:
+				txtformat =3D "16777216 colours";
+				break;
+			case 6:
+				txtformat =3D "262144 colours (FDPI-2 mode)";
+				break;
+			default:
+				txtformat =3D "unkown format";
+			}
+		}
+		PRINTKI("%s%s %s monitor detected: %s\n",
+			txtdual ,txtcolour, txtmonitor, model);
+		PRINTKI("       id=3D%d, %dx%d pixels, %s\n",
+			id, width, height, txtformat);
+		refresh_rates_buf[0] =3D 0;
+		refresh_rates =3D *(u16 *)(par->lcd_table+62);
+		m =3D 1;
+		f =3D 0;
+		for (i=3D0;i<16;i++) {
+			if (refresh_rates & m) {
+				if (f =3D=3D 0) {
+					sprintf(strbuf, "%d", lcd_refresh_rates[i]);
+					f++;
 				} else {
=2D					node =3D 0;
+					sprintf(strbuf, ",%d", lcd_refresh_rates[i]);
 				}
+				strcat(refresh_rates_buf,strbuf);
+			}
+			m =3D m << 1;
+		}
+		default_refresh_rate =3D (*(u8 *)(par->lcd_table+61) & 0xf0) >> 4;
+		PRINTKI("       supports refresh rates [%s], default %d Hz\n",
+			refresh_rates_buf, lcd_refresh_rates[default_refresh_rate]);
+		par->lcd_refreshrate =3D lcd_refresh_rates[default_refresh_rate];
+		/* We now need to determine the crtc parameters for the
+		 * lcd monitor. This is tricky, because they are not stored
+		 * individually in the BIOS. Instead, the BIOS contains a
+		 * table of display modes that work for this monitor.
+		 *
+		 * The idea is that we search for a mode of the same dimensions
+		 * as the dimensions of the lcd monitor. Say our lcd monitor
+		 * is 800x600 pixels, we search for a 800x600 monitor.
+		 * The CRTC parameters we find here are the ones that we need
+		 * to use to simulate other resolutions on the lcd screen.
+		 */
+		lcdmodeptr =3D (u16 *)(par->lcd_table + 64);
+		while (*lcdmodeptr !=3D 0) {
+			u32 modeptr;
+			u16 mwidth, mheight, lcd_hsync_start, lcd_vsync_start;
+			modeptr =3D bios_base + *lcdmodeptr;
+
+			mwidth =3D *((u16 *)(modeptr+0));
+			mheight =3D *((u16 *)(modeptr+2));
+
+			if (mwidth =3D=3D width && mheight =3D=3D height) {
+				par->lcd_pixclock =3D 100000000 / *((u16 *)(modeptr+9));
+				par->lcd_htotal =3D *((u16 *)(modeptr+17)) & 511;
+				par->lcd_hdisp =3D *((u16 *)(modeptr+19)) & 511;
+				lcd_hsync_start =3D *((u16 *)(modeptr+21)) & 511;
+				par->lcd_hsync_dly =3D (*((u16 *)(modeptr+21)) >> 9) & 7;
+				par->lcd_hsync_len =3D *((u8 *)(modeptr+23)) & 63;
+
+				par->lcd_vtotal =3D *((u16 *)(modeptr+24)) & 2047;
+				par->lcd_vdisp =3D *((u16 *)(modeptr+26)) & 2047;
+				lcd_vsync_start =3D *((u16 *)(modeptr+28)) & 2047;
+				par->lcd_vsync_len =3D (*((u16 *)(modeptr+28)) >> 11) & 31;
+
+				par->lcd_htotal =3D (par->lcd_htotal + 1) * 8;
+				par->lcd_hdisp =3D (par->lcd_hdisp + 1) * 8;
+				lcd_hsync_start =3D (lcd_hsync_start + 1) * 8;
+				par->lcd_hsync_len =3D par->lcd_hsync_len * 8;
+
+				par->lcd_vtotal++;
+				par->lcd_vdisp++;
+				lcd_vsync_start++;
+
+				par->lcd_right_margin =3D lcd_hsync_start - par->lcd_hdisp;
+				par->lcd_lower_margin =3D lcd_vsync_start - par->lcd_vdisp;
+				par->lcd_hblank_len =3D par->lcd_htotal - par->lcd_hdisp;
+				par->lcd_vblank_len =3D par->lcd_vtotal - par->lcd_vdisp;
+				break;
 			}
=20
=2D			pcp =3D pdev->sysdata;
=2D			if (node =3D=3D pcp->prom_node) {
+			lcdmodeptr++;
+		}
+		if (*lcdmodeptr =3D=3D 0) {
+			PRINTKE("LCD monitor CRTC parameters not found!!!\n");
+			/* To do: Switch to CRT if possible. */
+		} else {
+			PRINTKI("       LCD CRTC parameters: %d.%d  %d %d %d %d  %d %d %d %d\n",
+				1000000 / par->lcd_pixclock, 1000000 % par->lcd_pixclock,
+				par->lcd_hdisp,
+				par->lcd_hdisp + par->lcd_right_margin,
+				par->lcd_hdisp + par->lcd_right_margin
+					+ par->lcd_hsync_dly + par->lcd_hsync_len,
+				par->lcd_htotal,
+				par->lcd_vdisp,
+				par->lcd_vdisp + par->lcd_lower_margin,
+				par->lcd_vdisp + par->lcd_lower_margin + par->lcd_vsync_len,
+				par->lcd_vtotal);
+			PRINTKI("                          : %d %d %d %d %d %d %d %d %d\n",
+				par->lcd_pixclock,
+				par->lcd_hblank_len - (par->lcd_right_margin +
+					par->lcd_hsync_dly + par->lcd_hsync_len),
+				par->lcd_hdisp,
+				par->lcd_right_margin,
+				par->lcd_hsync_len,
+				par->lcd_vblank_len - (par->lcd_lower_margin + par->lcd_vsync_len),
+				par->lcd_vdisp,
+				par->lcd_lower_margin,
+				par->lcd_vsync_len);
+		}
+	}
+}
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
+
+static int __devinit init_from_bios(struct atyfb_par *par)
+{
+	u32 bios_base, rom_addr;
+	int ret;
+
+	rom_addr =3D 0xc0000 + ((aty_ld_le32(SCRATCH_REG1, par) & 0x7f) << 11);
+	bios_base =3D (unsigned long)ioremap(rom_addr, 0x10000);
+
+	/* The BIOS starts with 0xaa55. */
+	if (*((u16 *)bios_base) =3D=3D 0xaa55) {
+
+		u8 *bios_ptr;
+		u16 rom_table_offset, freq_table_offset;
+		PLL_BLOCK_MACH64 pll_block;
+
+		PRINTKI("Mach64 BIOS is located at %x, mapped at %x.\n", rom_addr, bios_=
base);
+
+		/* check for frequncy table */
+		bios_ptr =3D (u8*)bios_base;
+		rom_table_offset =3D (u16)(bios_ptr[0x48] | (bios_ptr[0x49] << 8));
+		freq_table_offset =3D bios_ptr[rom_table_offset + 16] | (bios_ptr[rom_ta=
ble_offset + 17] << 8);
+		memcpy(&pll_block, bios_ptr + freq_table_offset, sizeof(PLL_BLOCK_MACH64=
));
+
+		PRINTKI("BIOS frequency table:\n");
+		PRINTKI("PCLK_min_freq %d, PCLK_max_freq %d, ref_freq %d, ref_divider %d=
\n",
+			pll_block.PCLK_min_freq, pll_block.PCLK_max_freq,
+			pll_block.ref_freq, pll_block.ref_divider);
+		PRINTKI("MCLK_pwd %d, MCLK_max_freq %d, XCLK_max_freq %d, SCLK_freq %d\n=
",
+			pll_block.MCLK_pwd, pll_block.MCLK_max_freq,
+			pll_block.XCLK_max_freq, pll_block.SCLK_freq);
+
+		par->pll_limits.pll_min =3D pll_block.PCLK_min_freq/100;
+		par->pll_limits.pll_max =3D pll_block.PCLK_max_freq/100;
+		par->pll_limits.ref_clk =3D pll_block.ref_freq/100;
+		par->pll_limits.ref_div =3D pll_block.ref_divider;
+		par->pll_limits.sclk =3D pll_block.SCLK_freq/100;
+		par->pll_limits.mclk =3D pll_block.MCLK_max_freq/100;
+		par->pll_limits.mclk_pm =3D pll_block.MCLK_pwd/100;
+		par->pll_limits.xclk =3D pll_block.XCLK_max_freq/100;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+		aty_init_lcd(par, bios_base);
+#endif
+		ret =3D 0;
+	} else {
+		PRINTKE("no BIOS frequency table found, use parameters\n");
+		ret =3D -ENXIO;
+	}
+	iounmap((void*)bios_base);
=20
=2D				struct fb_var_screeninfo *var =3D
=2D				    &default_var;
=2D				unsigned int N, P, Q, M, T, R;
=2D				u32 v_total, h_total;
=2D				struct crtc crtc;
=2D				u8 pll_regs[16];
=2D				u8 clock_cntl;
=2D
=2D				crtc.vxres =3D
=2D				    prom_getintdefault(node, "width",
=2D						       1024);
=2D				crtc.vyres =3D
=2D				    prom_getintdefault(node, "height",
=2D						       768);
=2D				var->bits_per_pixel =3D
=2D				    prom_getintdefault(node, "depth", 8);
=2D				var->xoffset =3D var->yoffset =3D 0;
=2D				crtc.h_tot_disp =3D
=2D				    aty_ld_le32(CRTC_H_TOTAL_DISP, default_par);
=2D				crtc.h_sync_strt_wid =3D
=2D				    aty_ld_le32(CRTC_H_SYNC_STRT_WID,
=2D						default_par);
=2D				crtc.v_tot_disp =3D
=2D				    aty_ld_le32(CRTC_V_TOTAL_DISP, default_par);
=2D				crtc.v_sync_strt_wid =3D
=2D				    aty_ld_le32(CRTC_V_SYNC_STRT_WID,
=2D						default_par);
=2D				crtc.gen_cntl =3D
=2D				    aty_ld_le32(CRTC_GEN_CNTL, default_par);
=2D				aty_crtc_to_var(&crtc, var);
=2D
=2D				h_total =3D var->xres + var->right_margin +
=2D				    var->hsync_len + var->left_margin;
=2D				v_total =3D var->yres + var->lower_margin +
=2D				    var->vsync_len + var->upper_margin;
+	return ret;
+}
+#endif /* __i386__ */
=20
=2D				/*
=2D				 * Read the PLL to figure actual Refresh Rate.
=2D				 */
=2D				clock_cntl =3D aty_ld_8(CLOCK_CNTL, default_par);
=2D				/* printk("atyfb: CLOCK_CNTL: %02x\n", clock_cntl); */
=2D				for (i =3D 0; i < 16; i++)
=2D					pll_regs[i] =3D aty_ld_pll(i, default_par);
+static int __devinit atyfb_setup_generic(struct pci_dev *pdev, struct fb_i=
nfo *info, unsigned long addr)
+{
+	struct atyfb_par *par =3D info->par;
+	u16 tmp;
+	unsigned long raddr;
+	struct resource *rrp;
+	int ret =3D 0;
+
+	raddr =3D addr + 0x7ff000UL;
+	rrp =3D &pdev->resource[2];
+	if ((rrp->flags & IORESOURCE_MEM) && request_mem_region(rrp->start, rrp->=
end - rrp->start + 1, "atyfb")) {
+		par->aux_start =3D rrp->start;
+		par->aux_size =3D rrp->end - rrp->start + 1;
+		raddr =3D rrp->start;
+		PRINTKI("using auxiliary register aperture\n");
+	}
+
+	info->fix.mmio_start =3D raddr;
+	par->ati_regbase =3D ioremap(info->fix.mmio_start, 0x1000);
+	if (par->ati_regbase =3D=3D 0)
+		return -ENOMEM;
=20
=2D				/*
=2D				 * PLL Reference Divider M:
=2D				 */
=2D				M =3D pll_regs[2];
+	info->fix.mmio_start +=3D par->aux_start ? 0x400 : 0xc00;
+	par->ati_regbase +=3D par->aux_start ? 0x400 : 0xc00;
=20
=2D				/*
=2D				 * PLL Feedback Divider N (Dependant on CLOCK_CNTL):
=2D				 */
=2D				N =3D pll_regs[7 + (clock_cntl & 3)];
+	/*
+	 * Enable memory-space accesses using config-space
+	 * command register.
+	 */
+	pci_read_config_word(pdev, PCI_COMMAND, &tmp);
+	if (!(tmp & PCI_COMMAND_MEMORY)) {
+		tmp |=3D PCI_COMMAND_MEMORY;
+		pci_write_config_word(pdev, PCI_COMMAND, tmp);
+	}
+#ifdef __BIG_ENDIAN
+	/* Use the big-endian aperture */
+	addr +=3D 0x800000;
+#endif
=20
=2D				/*
=2D				 * PLL Post Divider P (Dependant on CLOCK_CNTL):
=2D				 */
=2D				P =3D 1 << (pll_regs[6] >>
=2D					  ((clock_cntl & 3) << 1));
+	/* Map in frame buffer */
+	info->fix.smem_start =3D addr;
+	info->screen_base =3D ioremap(addr, 0x800000);
+	if (info->screen_base =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		goto atyfb_setup_generic_fail;
+	}
+
+	if((ret =3D correct_chipset(par)))
+		goto atyfb_setup_generic_fail;
+#ifdef __i386__
+	if((ret =3D init_from_bios(par)))
+		goto atyfb_setup_generic_fail;
+#endif
+	if (!(aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_EXT_DISP_EN))
+		par->clk_wr_offset =3D (inb(R_GENMO) & 0x0CU) >> 2;
+	else
+		par->clk_wr_offset =3D aty_ld_8(CLOCK_CNTL, par) & 0x03U;
=20
=2D				/*
=2D				 * PLL Divider Q:
=2D				 */
=2D				Q =3D N / P;
+	/* according to ATI, we should use clock 3 for acelerated mode */
+	par->clk_wr_offset =3D 3;
=20
=2D				/*
=2D				 * Target Frequency:
=2D				 *
=2D				 *      T * M
=2D				 * Q =3D -------
=2D				 *      2 * R
=2D				 *
=2D				 * where R is XTALIN (=3D 14318 or 29498 kHz).
=2D				 */
=2D				if (pdev->device =3D=3D XL_CHIP_ID)
=2D					R =3D 29498;
=2D				else
=2D					R =3D 14318;
+	return 0;
=20
=2D				T =3D 2 * Q * R / M;
+atyfb_setup_generic_fail:
+	iounmap(par->ati_regbase);
+	par->ati_regbase =3D 0;
+	return ret;
+}
=20
=2D				default_var.pixclock =3D 1000000000 / T;
=2D			}
=2D#else				/* __sparc__ */
+#endif /* !__sparc__ */
=20
=2D			info->fix.mmio_start =3D 0x7ff000 + addr;
=2D			default_par->ati_regbase =3D (unsigned long)
=2D			    ioremap(info->fix.mmio_start, 0x1000);
+static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pc=
i_device_id *ent)
+{
+	unsigned long addr, res_start, res_size;
+	struct fb_info *info;
+	struct resource *rp;
+	struct atyfb_par *par;
+	int i, rc =3D -ENOMEM;
=20
=2D			if (!default_par->ati_regbase) {
=2D#ifdef __sparc__
=2D				kfree(default_par->mmap_map);
=2D#endif
=2D				kfree(default_par);
=2D				kfree(info);
=2D				release_mem_region(res_start, res_size);
=2D				return -ENOMEM;
=2D			}
+	for (i =3D sizeof(aty_chips) / sizeof(*aty_chips) - 1; i >=3D 0; i--)
+		if (pdev->device =3D=3D aty_chips[i].pci_id)
+			break;
=20
=2D			info->fix.mmio_start +=3D 0xc00;
=2D			default_par->ati_regbase +=3D 0xc00;
+	if (i < 0)
+		return -ENODEV;
=20
=2D			/*
=2D			 * Enable memory-space accesses using config-space
=2D			 * command register.
=2D			 */
=2D			pci_read_config_word(pdev, PCI_COMMAND, &tmp);
=2D			if (!(tmp & PCI_COMMAND_MEMORY)) {
=2D				tmp |=3D PCI_COMMAND_MEMORY;
=2D				pci_write_config_word(pdev, PCI_COMMAND,
=2D						      tmp);
=2D			}
=2D#ifdef __BIG_ENDIAN
=2D			/* Use the big-endian aperture */
=2D			addr +=3D 0x800000;
=2D#endif
+	/* Enable device in PCI config */
+	if (pci_enable_device(pdev)) {
+		PRINTKE("Cannot enable PCI device\n");
+		return -ENXIO;
+	}
+
+	/* Find which resource to use */
+	rp =3D &pdev->resource[0];
+	if (rp->flags & IORESOURCE_IO)
+		rp =3D &pdev->resource[1];
+	addr =3D rp->start;
+	if (!addr)
+		return -ENXIO;
=20
=2D			/* Map in frame buffer */
=2D			info->fix.smem_start =3D addr;
=2D			info->screen_base =3D
=2D			    (char *) ioremap(addr, 0x800000);
+	/* Reserve space */
+	res_start =3D rp->start;
+	res_size =3D rp->end - rp->start + 1;
+	if (!request_mem_region (res_start, res_size, "atyfb"))
+		return -EBUSY;
+
+        /* Allocate framebuffer */
+	info =3D framebuffer_alloc(sizeof(struct atyfb_par), &pdev->dev);
+	if (!info) {
+		PRINTKE("atyfb_pci_probe() can't alloc fb_info\n");
+		return -ENOMEM;
+	}
+	par =3D info->par;
+	info->fix =3D atyfb_fix;
+	info->device =3D &pdev->dev;
+	par->pci_id =3D aty_chips[i].pci_id;
+	par->res_start =3D res_start;
+	par->res_size =3D res_size;
+	par->irq =3D pdev->irq;
=20
=2D			if (!info->screen_base) {
+	/* Setup "info" structure */
 #ifdef __sparc__
=2D				kfree(default_par->mmap_map);
+	rc =3D atyfb_setup_sparc(pdev, info, addr);
+#else
+	rc =3D atyfb_setup_generic(pdev, info, addr);
 #endif
=2D				kfree(default_par);
=2D				kfree(info);
=2D				release_mem_region(res_start, res_size);
=2D				return -ENXIO;
=2D			}
=2D#endif				/* __sparc__ */
+	if (rc)
+		goto err_release_mem;
+
+	pci_set_drvdata(pdev, info);
+
+	/* Init chip & register framebuffer */
+	if (aty_init(info, "PCI"))
+		goto err_release_io;
=20
=2D			if (!aty_init(info, "PCI")) {
=2D#ifdef __sparc__=09
=2D				if (default_par->mmap_map)
=2D					kfree(default_par->mmap_map);
=2D#endif
=2D				kfree(default_par);
=2D				kfree(info);
=2D				release_mem_region(res_start, res_size);
=2D				return -ENXIO;
=2D			}
 #ifdef __sparc__
=2D			if (!prom_palette)
=2D				prom_palette =3D atyfb_palette;
+	if (!prom_palette)
+		prom_palette =3D atyfb_palette;
=20
=2D			/*
=2D			 * Add /dev/fb mmap values.
=2D			 */
=2D			default_par->mmap_map[0].voff =3D 0x8000000000000000UL;
=2D			default_par->mmap_map[0].poff =3D
=2D			    (unsigned long) info->screen_base & PAGE_MASK;
=2D			default_par->mmap_map[0].size =3D
=2D			    info->fix.smem_len;
=2D			default_par->mmap_map[0].prot_mask =3D _PAGE_CACHE;
=2D			default_par->mmap_map[0].prot_flag =3D _PAGE_E;
=2D			default_par->mmap_map[1].voff =3D
=2D			    default_par->mmap_map[0].voff +
=2D			    info->fix.smem_len;
=2D			default_par->mmap_map[1].poff =3D
=2D			    default_par->ati_regbase & PAGE_MASK;
=2D			default_par->mmap_map[1].size =3D PAGE_SIZE;
=2D			default_par->mmap_map[1].prot_mask =3D _PAGE_CACHE;
=2D			default_par->mmap_map[1].prot_flag =3D _PAGE_E;
=2D#endif				/* __sparc__ */
=2D
=2D#ifdef CONFIG_PMAC_PBOOK
=2D			if (first_display =3D=3D NULL)
=2D				pmu_register_sleep_notifier(&aty_sleep_notifier);
=2D			default_par->next =3D first_display;
+	/*
+	 * Add /dev/fb mmap values.
+	 */
+	par->mmap_map[0].voff =3D 0x8000000000000000UL;
+	par->mmap_map[0].poff =3D (unsigned long) info->screen_base & PAGE_MASK;
+	par->mmap_map[0].size =3D info->fix.smem_len;
+	par->mmap_map[0].prot_mask =3D _PAGE_CACHE;
+	par->mmap_map[0].prot_flag =3D _PAGE_E;
+	par->mmap_map[1].voff =3D par->mmap_map[0].voff + info->fix.smem_len;
+	par->mmap_map[1].poff =3D par->ati_regbase & PAGE_MASK;
+	par->mmap_map[1].size =3D PAGE_SIZE;
+	par->mmap_map[1].prot_mask =3D _PAGE_CACHE;
+	par->mmap_map[1].prot_flag =3D _PAGE_E;
+#endif /* __sparc__ */
+
+	return 0;
+
+err_release_io:
+#ifdef __sparc__
+	if (par->mmap_map)
+		kfree(par->mmap_map);
+#else
+	if (par->ati_regbase)
+		iounmap(par->ati_regbase);
+	if (info->screen_base)
+		iounmap(info->screen_base);
 #endif
=2D		}
=2D	}
+err_release_mem:
+	if(par->aux_start)
+		release_mem_region(par->aux_start, par->aux_size);
+
+	release_mem_region(par->res_start, par->res_size);
+	framebuffer_release(info);
+
+	return rc;
+}
+
+#endif /* CONFIG_PCI */
+
+#ifdef CONFIG_ATARI
=20
=2D#elif defined(CONFIG_ATARI)
=2D	struct atyfb_par *default_par;
+static int __devinit atyfb_atari_probe(void)
+{
+	struct aty_par *par;
 	struct fb_info *info;
 	int m64_num;
 	u32 clock_r;
@@ -2314,85 +3436,135 @@
 	for (m64_num =3D 0; m64_num < mach64_count; m64_num++) {
 		if (!phys_vmembase[m64_num] || !phys_size[m64_num] ||
 		    !phys_guiregbase[m64_num]) {
=2D			printk
=2D			    (" phys_*[%d] parameters not set =3D> returning early. \n",
=2D			     m64_num);
+		    PRINTKI("phys_*[%d] parameters not set =3D> returning early. \n", m6=
4_num);
 			continue;
 		}
=20
=2D		info =3D kmalloc(sizeof(struct fb_info), GFP_ATOMIC);
+		info =3D framebuffer_alloc(sizeof(struct atyfb_par), NULL);
 		if (!info) {
=2D			printk("atyfb_init: can't alloc fb_info\n");
+			PRINTKE("atyfb_atari_probe() can't alloc fb_info\n");
 			return -ENOMEM;
 		}
=2D		memset(info, 0, sizeof(struct fb_info));
=2D
=2D		default_par =3D kmalloc(sizeof(struct atyfb_par), GFP_ATOMIC);
=2D		if (!default_par) {
=2D			printk
=2D			    ("atyfb_init: can't alloc atyfb_par\n");
=2D			kfree(info);
=2D			return -ENXIO;
=2D		}
=2D		memset(default_par, 0, sizeof(struct atyfb_par));
+		par =3D info->par;
=20
 		info->fix =3D atyfb_fix;
=2D		info->par =3D default_par;
+
+		par->irq =3D (unsigned int) -1; /* something invalid */
=20
 		/*
 		 *  Map the video memory (physical address given) to somewhere in the
 		 *  kernel address space.
 		 */
=2D		info->screen_base =3D ioremap(phys_vmembase[m64_num],
=2D					 		   phys_size[m64_num]);=09
=2D		info->fix.smem_start =3D (unsigned long)info->screen_base;	/* Fake! */
=2D		default_par->ati_regbase =3D (unsigned long)ioremap(phys_guiregbase[m6=
4_num],
=2D							  0x10000) + 0xFC00ul;
=2D		info->fix.mmio_start =3D default_par->ati_regbase; /* Fake! */
+		info->screen_base =3D ioremap(phys_vmembase[m64_num], phys_size[m64_num]=
);
+		info->fix.smem_start =3D (unsigned long)info->screen_base; /* Fake! */
+		par->ati_regbase =3D ioremap(phys_guiregbase[m64_num], 0x10000) + 0xFC00=
ul;
+		info->fix.mmio_start =3D par->ati_regbase; /* Fake! */
=20
=2D		aty_st_le32(CLOCK_CNTL, 0x12345678, default_par);
=2D		clock_r =3D aty_ld_le32(CLOCK_CNTL, default_par);
+		aty_st_le32(CLOCK_CNTL, 0x12345678, par);
+		clock_r =3D aty_ld_le32(CLOCK_CNTL, par);
=20
 		switch (clock_r & 0x003F) {
 		case 0x12:
=2D			default_par->clk_wr_offset =3D 3;	/*  */
+			par->clk_wr_offset =3D 3; /*  */
 			break;
 		case 0x34:
=2D			default_par->clk_wr_offset =3D 2;	/* Medusa ST-IO ISA Adapter etc. */
+			par->clk_wr_offset =3D 2; /* Medusa ST-IO ISA Adapter etc. */
 			break;
 		case 0x16:
=2D			default_par->clk_wr_offset =3D 1;	/*  */
+			par->clk_wr_offset =3D 1; /*  */
 			break;
 		case 0x38:
=2D			default_par->clk_wr_offset =3D 0;	/* Panther 1 ISA Adapter (Gerald) */
+			par->clk_wr_offset =3D 0; /* Panther 1 ISA Adapter (Gerald) */
 			break;
 		}
=20
=2D		if (!aty_init(info, "ISA bus")) {
=2D			kfree(default_par);
=2D			kfree(info);
+		if (aty_init(info, "ISA bus")) {
+			framebuffer_release(info);
 			/* This is insufficient! kernel_map has added two large chunks!! */
 			return -ENXIO;
 		}
 	}
=2D#endif				/* CONFIG_ATARI */
=2D	return 0;
 }
=20
=2Dint __init atyfb_init(void)
+#endif /* CONFIG_ATARI */
+
+static void __devexit atyfb_remove(struct fb_info *info)
 {
=2D#ifndef MODULE
=2D	char *option =3D NULL;
+	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=20
=2D	if (fb_get_options("atyfb", &option))
=2D		return -ENODEV;
=2D	atyfb_setup(option);
+	/* restore video mode */
+	aty_set_crtc(par, &saved_crtc);
+	par->pll_ops->set_pll(info, &saved_pll);
+
+	unregister_framebuffer(info);
+
+#ifdef CONFIG_MTRR
+	if (par->mtrr_reg >=3D 0) {
+	    mtrr_del(par->mtrr_reg, 0, 0);
+	    par->mtrr_reg =3D -1;
+	}
+	if (par->mtrr_aper >=3D 0) {
+	    mtrr_del(par->mtrr_aper, 0, 0);
+	    par->mtrr_aper =3D -1;
+	}
 #endif
=2D	return atyfb_do_init();
+#ifndef __sparc__
+	if (par->ati_regbase)
+		iounmap(par->ati_regbase);
+	if (info->screen_base)
+		iounmap(info->screen_base);
+#ifdef __BIG_ENDIAN
+	if (info->sprite.addr)
+		iounmap(info->sprite.addr);
+#endif
+#endif
+#ifdef __sparc__
+	if (par->mmap_map)
+		kfree(par->mmap_map);
+#endif
+	if (par->aux_start)
+		release_mem_region(par->aux_start, par->aux_size);
+
+	if (par->res_start)
+		release_mem_region(par->res_start, par->res_size);
+
+	framebuffer_release(info);
 }
=20
+#ifdef CONFIG_PCI
+
+static void __devexit atyfb_pci_remove(struct pci_dev *pdev)
+{
+	struct fb_info *info =3D pci_get_drvdata(pdev);
+
+	atyfb_remove(info);
+}
+
+/*
+ * This driver uses its own matching table. That will be more difficult
+ * to fix, so for now, we just match against any ATI ID and let the
+ * probe() function find out what's up. That also mean we don't have
+ * a module ID table though.
+ */
+static struct pci_device_id atyfb_pci_tbl[] =3D {
+	{ PCI_VENDOR_ID_ATI, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_BASE_CLASS_DISPLAY << 16, 0xff0000, 0 },
+	{ 0, }
+};
+
+static struct pci_driver atyfb_driver =3D {
+	.name		=3D "atyfb",
+	.id_table	=3D atyfb_pci_tbl,
+	.probe		=3D atyfb_pci_probe,
+	.remove		=3D __devexit_p(atyfb_pci_remove),
+#ifdef CONFIG_PM
+	.suspend	=3D atyfb_pci_suspend,
+	.resume		=3D atyfb_pci_resume,
+#endif /* CONFIG_PM */
+};
+
+#endif /* CONFIG_PCI */
=20
=2D#ifndef MODULE
 int __init atyfb_setup(char *options)
 {
 	char *this_opt;
@@ -2401,19 +3573,20 @@
 		return 0;
=20
 	while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {
=2D		if (!strncmp(this_opt, "noblink", 7)) {
=2D			curblink =3D 0;
=2D		} else if (!strncmp(this_opt, "noaccel", 7)) {
+		if (!strncmp(this_opt, "noaccel", 7)) {
 			noaccel =3D 1;
+#ifdef CONFIG_MTRR
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+			nomtrr =3D 1;
+#endif
 		} else if (!strncmp(this_opt, "vram:", 5))
=2D			default_vram =3D
=2D			    simple_strtoul(this_opt + 5, NULL, 0);
+			vram =3D simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "pll:", 4))
=2D			default_pll =3D
=2D			    simple_strtoul(this_opt + 4, NULL, 0);
+			pll =3D simple_strtoul(this_opt + 4, NULL, 0);
 		else if (!strncmp(this_opt, "mclk:", 5))
=2D			default_mclk =3D
=2D			    simple_strtoul(this_opt + 5, NULL, 0);
+			mclk =3D simple_strtoul(this_opt + 5, NULL, 0);
+		else if (!strncmp(this_opt, "xclk:", 5))
+			xclk =3D simple_strtoul(this_opt+5, NULL, 0);
 #ifdef CONFIG_PPC
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			unsigned int vmode =3D
@@ -2456,182 +3629,63 @@
 		}
 #endif
 		else
=2D			mode_option =3D this_opt;
+			mode =3D this_opt;
 	}
 	return 0;
 }
=2Dmodule_init(atyfb_init);
=2D#endif				/* !MODULE */
=2D
=2D#ifdef CONFIG_ATARI
=2Dstatic int __init store_video_par(char *video_str, unsigned char m64_num)
=2D{
=2D	char *p;
=2D	unsigned long vmembase, size, guiregbase;
=2D
=2D	printk("store_video_par() '%s' \n", video_str);
=2D
=2D	if (!(p =3D strsep(&video_str, ";")) || !*p)
=2D		goto mach64_invalid;
=2D	vmembase =3D simple_strtoul(p, NULL, 0);
=2D	if (!(p =3D strsep(&video_str, ";")) || !*p)
=2D		goto mach64_invalid;
=2D	size =3D simple_strtoul(p, NULL, 0);
=2D	if (!(p =3D strsep(&video_str, ";")) || !*p)
=2D		goto mach64_invalid;
=2D	guiregbase =3D simple_strtoul(p, NULL, 0);
=2D
=2D	phys_vmembase[m64_num] =3D vmembase;
=2D	phys_size[m64_num] =3D size;
=2D	phys_guiregbase[m64_num] =3D guiregbase;
=2D	printk(" stored them all: $%08lX $%08lX $%08lX \n", vmembase, size,
=2D	       guiregbase);
=2D	return 0;
=2D
=2D      mach64_invalid:
=2D	phys_vmembase[m64_num] =3D 0;
=2D	return -1;
=2D}
=2D#endif				/* CONFIG_ATARI */
=2D
=2D/*
=2D#ifdef CONFIG_FB_ATY_CT
=2D   * Erase HW Cursor *
=2D    if (par->cursor && (info->currcon >=3D 0))
=2D	atyfb_cursor(&fb_display[par->currcon], CM_ERASE,
=2D		     par->cursor->pos.x, par->cursor->pos.y);
=2D#endif * CONFIG_FB_ATY_CT *
=20
=2D#ifdef CONFIG_FB_ATY_CT
=2D    * Install hw cursor *
=2D    if (par->cursor) {
=2D	aty_set_cursor_color(info);
=2D	aty_set_cursor_shape(info);
=2D    }
=2D#endif * CONFIG_FB_ATY_CT */
=2D
=2D    /*
=2D     *  Blank the display.
=2D     */
=2D
=2Dstatic int atyfb_blank(int blank, struct fb_info *info)
+int __init atyfb_init(void)
 {
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	u8 gen_cntl;
=2D
=2D#ifdef CONFIG_PMAC_BACKLIGHT
=2D	if ((_machine =3D=3D _MACH_Pmac) && blank)
=2D		set_backlight_enable(0);
=2D#endif				/* CONFIG_PMAC_BACKLIGHT */
=2D
=2D	gen_cntl =3D aty_ld_8(CRTC_GEN_CNTL, par);
=2D	if (blank > 0)
=2D		switch (blank - 1) {
=2D		case VESA_NO_BLANKING:
=2D			gen_cntl |=3D 0x40;
=2D			break;
=2D		case VESA_VSYNC_SUSPEND:
=2D			gen_cntl |=3D 0x8;
=2D			break;
=2D		case VESA_HSYNC_SUSPEND:
=2D			gen_cntl |=3D 0x4;
=2D			break;
=2D		case VESA_POWERDOWN:
=2D			gen_cntl |=3D 0x4c;
=2D			break;
=2D	} else
=2D		gen_cntl &=3D ~(0x4c);
=2D	aty_st_8(CRTC_GEN_CNTL, gen_cntl, par);
=2D
=2D#ifdef CONFIG_PMAC_BACKLIGHT
=2D	if ((_machine =3D=3D _MACH_Pmac) && !blank)
=2D		set_backlight_enable(1);
=2D#endif				/* CONFIG_PMAC_BACKLIGHT */
=2D	return 0;
=2D}
=2D
=2D    /*
=2D     *  Set a single color register. The values supplied are already
=2D     *  rounded down to the hardware's capabilities (according to the
=2D     *  entries in the var structure). Return !=3D 0 for invalid regno.
=2D     */
+#ifndef MODULE
+    char *option =3D NULL;
=20
=2Dstatic int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int bl=
ue,
=2D			   u_int transp, struct fb_info *info)
=2D{
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	int i, scale;
=2D	u32 *pal =3D info->pseudo_palette;
+    if (fb_get_options("atyfb", &option))
+	return -ENODEV;
+    atyfb_setup(option);
+#endif
=20
=2D	if (regno > 255)
=2D		return 1;
=2D	red >>=3D 8;
=2D	green >>=3D 8;
=2D	blue >>=3D 8;
=2D	i =3D aty_ld_8(DAC_CNTL, par) & 0xfc;
=2D	if (M64_HAS(EXTRA_BRIGHT))
=2D		i |=3D 0x2;	/*DAC_CNTL|0x2 turns off the extra brightness for gt */
=2D	aty_st_8(DAC_CNTL, i, par);
=2D	aty_st_8(DAC_MASK, 0xff, par);
=2D	scale =3D (M64_HAS(INTEGRATED) && info->var.bits_per_pixel =3D=3D 16) ?=
 3 : 0;
+#ifdef CONFIG_PCI
+    pci_module_init(&atyfb_driver);
+#endif
 #ifdef CONFIG_ATARI
=2D	out_8(&par->aty_cmap_regs->windex, regno << scale);
=2D	out_8(&par->aty_cmap_regs->lut, red);
=2D	out_8(&par->aty_cmap_regs->lut, green);
=2D	out_8(&par->aty_cmap_regs->lut, blue);
=2D#else
=2D	writeb(regno << scale, &par->aty_cmap_regs->windex);
=2D	writeb(red, &par->aty_cmap_regs->lut);
=2D	writeb(green, &par->aty_cmap_regs->lut);
=2D	writeb(blue, &par->aty_cmap_regs->lut);
+    atyfb_atari_probe();
 #endif
=2D	if (regno < 16)
=2D		switch (info->var.bits_per_pixel) {
=2D		case 16:
=2D			pal[regno] =3D (regno << 10) | (regno << 5) | regno;
=2D			break;
=2D		case 24:
=2D			pal[regno] =3D (regno << 16) | (regno << 8) | regno;
=2D			break;
=2D		case 32:
=2D			i =3D (regno << 8) | regno;
=2D			pal[regno] =3D (i << 16) | i;
=2D			break;
=2D		}
=2D	return 0;
+    return 0;
 }
=20
=2D#ifdef MODULE
=2Dint __init init_module(void)
+void __exit atyfb_exit(void)
 {
=2D	atyfb_init();
=2D	return fb_list ? 0 : -ENXIO;
=2D}
=2D
=2Dvoid cleanup_module(void)
=2D{
=2D	struct fb_info *info =3D fb_list;
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;	=09
=2D	unregister_framebuffer(info);
=2D
=2D#ifndef __sparc__
=2D	if (par->ati_regbase)
=2D		iounmap((void *) par->ati_regbase);
=2D	if (info->screen_base)
=2D		iounmap((void *) info->screen_base);
=2D#ifdef __BIG_ENDIAN
=2D	if (par->cursor && par->cursor->ram)
=2D		iounmap(par->cursor->ram);
=2D#endif
=2D#endif
=2D	if (par->cursor)
=2D		kfree(par->cursor);
=2D#ifdef __sparc__
=2D	if (par->mmap_map)
=2D		kfree(par->mmap_map);
+#ifdef CONFIG_PCI
+	pci_unregister_driver(&atyfb_driver);
 #endif
=2D	kfree(info);
 }
=20
+module_init(atyfb_init);
+#ifdef MODULE
+module_exit(atyfb_exit);
 #endif
+
+MODULE_DESCRIPTION("FBDev driver for ATI Mach64 cards");
 MODULE_LICENSE("GPL");
+module_param(noaccel, bool, 0);
+MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
+module_param(vram, int, 0);
+MODULE_PARM_DESC(vram, "int: override size of video ram");
+module_param(pll, int, 0);
+MODULE_PARM_DESC(pll, "int: override video clock");
+module_param(mclk, int, 0);
+MODULE_PARM_DESC(mclk, "int: override memory clock");
+module_param(xclk, int, 0);
+MODULE_PARM_DESC(xclk, "int: override accelerated engine clock");
+#ifdef CONFIG_PPC
+module_param(vmode, int, 0);
+MODULE_PARM_DESC(vmode, "int: video mode for mac");
+module_param(cmode, int, 0);
+MODULE_PARM_DESC(cmode, "int: color mode for mac");
+#endif
+module_param(mode, charp, 0);
+MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<re=
fresh>]\" ");
+#ifdef CONFIG_MTRR
+module_param(nomtrr, bool, 0);
+MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
+#endif
diff -Nru a/drivers/video/aty/mach64_accel.c b/drivers/video/aty/mach64_acc=
el.c
=2D-- a/drivers/video/aty/mach64_accel.c	2004-10-19 20:22:42 +08:00
+++ b/drivers/video/aty/mach64_accel.c	2004-10-07 06:18:18 +08:00
@@ -13,22 +13,41 @@
      *  Generic Mach64 routines
      */
=20
+/* this is for DMA GUI engine! work in progress */
+typedef struct {
+	u32 frame_buf_offset;
+	u32 system_mem_addr;
+	u32 command;
+	u32 reserved;
+} BM_DESCRIPTOR_ENTRY;
+
+#define LAST_DESCRIPTOR (1 << 31)
+#define SYSTEM_TO_FRAME_BUFFER 0
+
+static u32 rotation24bpp(u32 dx, u32 direction)
+{
+	u32 rotation;
+	if (direction & DST_X_LEFT_TO_RIGHT) {
+		rotation =3D (dx / 4) % 6;
+	} else {
+		rotation =3D ((dx + 2) / 4) % 6;
+	}
+
+	return ((rotation << 8) | DST_24_ROTATION_ENABLE);
+}
+
 void aty_reset_engine(const struct atyfb_par *par)
 {
 	/* reset engine */
 	aty_st_le32(GEN_TEST_CNTL,
=2D		    aty_ld_le32(GEN_TEST_CNTL, par) & ~GUI_ENGINE_ENABLE,
=2D		    par);
+		aty_ld_le32(GEN_TEST_CNTL, par) & ~GUI_ENGINE_ENABLE, par);
 	/* enable engine */
 	aty_st_le32(GEN_TEST_CNTL,
=2D		    aty_ld_le32(GEN_TEST_CNTL, par) | GUI_ENGINE_ENABLE,
=2D		    par);
+		aty_ld_le32(GEN_TEST_CNTL, par) | GUI_ENGINE_ENABLE, par);
 	/* ensure engine is not locked up by clearing any FIFO or */
 	/* HOST errors */
 	aty_st_le32(BUS_CNTL,
=2D		    aty_ld_le32(BUS_CNTL,
=2D				par) | BUS_HOST_ERR_ACK | BUS_FIFO_ERR_ACK,
=2D		    par);
+		aty_ld_le32(BUS_CNTL, par) | BUS_HOST_ERR_ACK | BUS_FIFO_ERR_ACK, par);
 }
=20
 static void reset_GTC_3D_engine(const struct atyfb_par *par)
@@ -51,7 +70,7 @@
 	if (info->var.bits_per_pixel =3D=3D 24) {
 		/* In 24 bpp, the engine is in 8 bpp - this requires that all */
 		/* horizontal coordinates and widths must be adjusted */
=2D		pitch_value =3D pitch_value * 3;
+		pitch_value *=3D 3;
 	}
=20
 	/* On GTC (RagePro), we need to reset the 3D engine before */
@@ -146,7 +165,7 @@
 	aty_st_le32(DP_CHAIN_MASK, par->crtc.dp_chain_mask, par);
=20
 	wait_for_fifo(5, par);
=2D	aty_st_le32(SCALE_3D_CNTL, 0, par);
+ 	aty_st_le32(SCALE_3D_CNTL, 0, par);
 	aty_st_le32(Z_CNTL, 0, par);
 	aty_st_le32(CRTC_INT_CNTL, aty_ld_le32(CRTC_INT_CNTL, par) & ~0x20,
 		    par);
@@ -174,9 +193,10 @@
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	u32 dy =3D area->dy, sy =3D area->sy, direction =3D DST_LAST_PEL;
=2D	u32 sx =3D area->sx, dx =3D area->dx, width =3D area->width;=09
=2D	u32 pitch_value;
+	u32 sx =3D area->sx, dx =3D area->dx, width =3D area->width, rotation =3D=
 0;
=20
+	if (par->asleep)
+		return;
 	if (!area->width || !area->height)
 		return;
 	if (!par->accel_flags) {
@@ -186,11 +206,9 @@
 		return;
 	}
=20
=2D	pitch_value =3D info->var.xres_virtual;
 	if (info->var.bits_per_pixel =3D=3D 24) {
 		/* In 24 bpp, the engine is in 8 bpp - this requires that all */
 		/* horizontal coordinates and widths must be adjusted */
=2D		pitch_value *=3D 3;
 		sx *=3D 3;
 		dx *=3D 3;
 		width *=3D 3;
@@ -208,19 +226,25 @@
 	} else
 		direction |=3D DST_X_LEFT_TO_RIGHT;
=20
+	if (info->var.bits_per_pixel =3D=3D 24) {
+		rotation =3D rotation24bpp(dx, direction);
+	}
+
 	wait_for_fifo(4, par);
 	aty_st_le32(DP_SRC, FRGD_SRC_BLIT, par);
 	aty_st_le32(SRC_Y_X, (sx << 16) | sy, par);
 	aty_st_le32(SRC_HEIGHT1_WIDTH1, (width << 16) | area->height, par);
=2D	aty_st_le32(DST_CNTL, direction, par);
+	aty_st_le32(DST_CNTL, direction | rotation, par);
 	draw_rect(dx, dy, width, area->height, par);
 }
=20
 void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	u32 color =3D rect->color, dx =3D rect->dx, width =3D rect->width;
+	u32 color =3D rect->color, dx =3D rect->dx, width =3D rect->width, rotati=
on =3D 0;
=20
+	if (par->asleep)
+		return;
 	if (!rect->width || !rect->height)
 		return;
 	if (!par->accel_flags) {
@@ -238,6 +262,7 @@
 		/* horizontal coordinates and widths must be adjusted */
 		dx *=3D 3;
 		width *=3D 3;
+		rotation =3D rotation24bpp(dx, DST_X_LEFT_TO_RIGHT);
 	}
=20
 	wait_for_fifo(3, par);
@@ -247,15 +272,162 @@
 		    par);
 	aty_st_le32(DST_CNTL,
 		    DST_LAST_PEL | DST_Y_TOP_TO_BOTTOM |
=2D		    DST_X_LEFT_TO_RIGHT, par);
+		    DST_X_LEFT_TO_RIGHT | rotation, par);
 	draw_rect(dx, rect->dy, width, rect->height, par);
 }
=20
 void atyfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D   =20
=2D	if (par->blitter_may_be_busy)
=2D		wait_for_idle(par);
=2D	cfb_imageblit(info, image);
+	u32 src_bytes, dx =3D image->dx, dy =3D image->dy, width =3D image->width;
+	u32 pix_width_save, pix_width, host_cntl, rotation =3D 0, src, mix;
+
+	if (par->asleep)
+		return;
+	if (!image->width || !image->height)
+		return;
+	if (!par->accel_flags ||
+	    (image->depth !=3D 1 && info->var.bits_per_pixel !=3D image->depth)) {
+		if (par->blitter_may_be_busy)
+			wait_for_idle(par);
+
+		cfb_imageblit(info, image);
+		return;
+	}
+
+	wait_for_idle(par);
+	pix_width =3D pix_width_save =3D aty_ld_le32(DP_PIX_WIDTH, par);
+	host_cntl =3D aty_ld_le32(HOST_CNTL, par) | HOST_BYTE_ALIGN;
+
+	switch (image->depth) {
+	case 1:
+	    pix_width &=3D ~(BYTE_ORDER_MASK | HOST_MASK);
+	    pix_width |=3D (BYTE_ORDER_MSB_TO_LSB | HOST_1BPP);
+	    break;
+	case 4:
+	    pix_width &=3D ~(BYTE_ORDER_MASK | HOST_MASK);
+	    pix_width |=3D (BYTE_ORDER_MSB_TO_LSB | HOST_4BPP);
+	    break;
+	case 8:
+	    pix_width &=3D ~HOST_MASK;
+	    pix_width |=3D HOST_8BPP;
+	    break;
+	case 15:
+	    pix_width &=3D ~HOST_MASK;
+	    pix_width |=3D HOST_15BPP;
+	    break;
+	case 16:
+	    pix_width &=3D ~HOST_MASK;
+	    pix_width |=3D HOST_16BPP;
+	    break;
+	case 24:
+	    pix_width &=3D ~HOST_MASK;
+	    pix_width |=3D HOST_24BPP;
+	    break;
+	case 32:
+	    pix_width &=3D ~HOST_MASK;
+	    pix_width |=3D HOST_32BPP;
+	    break;
+	}
+
+	if (info->var.bits_per_pixel =3D=3D 24) {
+		/* In 24 bpp, the engine is in 8 bpp - this requires that all */
+		/* horizontal coordinates and widths must be adjusted */
+		dx *=3D 3;
+		width *=3D 3;
+
+		rotation =3D rotation24bpp(dx, DST_X_LEFT_TO_RIGHT);
+
+		pix_width &=3D ~DST_MASK;
+		pix_width |=3D DST_8BPP;
+
+		/*
+		 * since Rage 3D IIc we have DP_HOST_TRIPLE_EN bit
+		 * this hwaccelerated triple has an issue with not aligned data
+		 */
+		if (M64_HAS(HW_TRIPLE) && image->width % 8 =3D=3D 0)
+			pix_width |=3D DP_HOST_TRIPLE_EN;
+	}
+
+	if (image->depth =3D=3D 1) {
+		u32 fg, bg;
+		if (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
+		    info->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR) {
+			fg =3D ((u32*)(info->pseudo_palette))[image->fg_color];
+			bg =3D ((u32*)(info->pseudo_palette))[image->bg_color];
+		} else {
+			fg =3D image->fg_color;
+			bg =3D image->bg_color;
+		}
+
+		wait_for_fifo(2, par);
+		aty_st_le32(DP_BKGD_CLR, bg, par);
+		aty_st_le32(DP_FRGD_CLR, fg, par);
+		src =3D MONO_SRC_HOST | FRGD_SRC_FRGD_CLR | BKGD_SRC_BKGD_CLR;
+		mix =3D FRGD_MIX_S | BKGD_MIX_S;
+	} else {
+		src =3D MONO_SRC_ONE | FRGD_SRC_HOST;
+		mix =3D FRGD_MIX_D_XOR_S | BKGD_MIX_D;
+	}
+
+	wait_for_fifo(6, par);
+	aty_st_le32(DP_WRITE_MASK, 0xFFFFFFFF, par);
+	aty_st_le32(DP_PIX_WIDTH, pix_width, par);
+	aty_st_le32(DP_MIX, mix, par);
+	aty_st_le32(DP_SRC, src, par);
+	aty_st_le32(HOST_CNTL, host_cntl, par);
+	aty_st_le32(DST_CNTL, DST_Y_TOP_TO_BOTTOM | DST_X_LEFT_TO_RIGHT | rotatio=
n, par);
+
+	draw_rect(dx, dy, width, image->height, par);
+	src_bytes =3D (((image->width * image->depth) + 7) / 8) * image->height;
+
+	/* manual triple each pixel */
+	if (info->var.bits_per_pixel =3D=3D 24 && !(pix_width & DP_HOST_TRIPLE_EN=
)) {
+		int inbit, outbit, mult24, byte_id_in_dword, width;
+		u8 *pbitmapin =3D (u8*)image->data, *pbitmapout;
+		u32 hostdword;
+
+		for (width =3D image->width, inbit =3D 7, mult24 =3D 0; src_bytes; ) {
+			for (hostdword =3D 0, pbitmapout =3D (u8*)&hostdword, byte_id_in_dword =
=3D 0;
+				byte_id_in_dword < 4 && src_bytes;
+				byte_id_in_dword++, pbitmapout++) {
+				for (outbit =3D 7; outbit >=3D 0; outbit--) {
+					*pbitmapout |=3D (((*pbitmapin >> inbit) & 1) << outbit);
+					mult24++;
+					/* next bit */
+					if (mult24 =3D=3D 3) {
+						mult24 =3D 0;
+						inbit--;
+						width--;
+					}
+
+					/* next byte */
+					if (inbit < 0 || width =3D=3D 0) {
+						src_bytes--;
+						pbitmapin++;
+						inbit =3D 7;
+
+						if (width =3D=3D 0) {
+						    width =3D image->width;
+						    outbit =3D 0;
+						}
+					}
+				}
+			}
+			wait_for_fifo(1, par);
+			aty_st_le32(HOST_DATA0, hostdword, par);
+		}
+	} else {
+		u32 *pbitmap, dwords =3D (src_bytes + 3) / 4;
+		for (pbitmap =3D (u32*)(image->data); dwords; dwords--, pbitmap++) {
+			wait_for_fifo(1, par);
+			aty_st_le32(HOST_DATA0, le32_to_cpup(pbitmap), par);
+		}
+	}
+
+	wait_for_idle(par);
+
+	/* restore pix_width */
+	wait_for_fifo(1, par);
+	aty_st_le32(DP_PIX_WIDTH, pix_width_save, par);
 }
diff -Nru a/drivers/video/aty/mach64_ct.c b/drivers/video/aty/mach64_ct.c
=2D-- a/drivers/video/aty/mach64_ct.c	2004-10-19 20:22:43 +08:00
+++ b/drivers/video/aty/mach64_ct.c	2004-10-07 06:18:18 +08:00
@@ -4,214 +4,236 @@
  */
=20
 #include <linux/fb.h>
=2D
+#include <linux/delay.h>
 #include <asm/io.h>
=2D
 #include <video/mach64.h>
 #include "atyfb.h"
=20
+#undef DEBUG
=20
=2D/* FIXME: remove the FAIL definition */
=2D#define FAIL(x) do { printk(x "\n"); return -EINVAL; } while (0)
=2D
=2Dstatic void aty_st_pll(int offset, u8 val, const struct atyfb_par *par);
=2Dstatic int aty_valid_pll_ct(const struct fb_info *info, u32 vclk_per,
=2D			    struct pll_ct *pll);
=2Dstatic int aty_dsp_gt(const struct fb_info *info, u8 bpp,
=2D		      struct pll_ct *pll);
=2Dstatic int aty_var_to_pll_ct(const struct fb_info *info, u32 vclk_per,
=2D			     u8 bpp, union aty_pll *pll);
=2Dstatic u32 aty_pll_ct_to_var(const struct fb_info *info,
=2D			     const union aty_pll *pll);
+static int aty_valid_pll_ct (const struct fb_info *info, u32 vclk_per, str=
uct pll_ct *pll);
+static int aty_dsp_gt       (const struct fb_info *info, u32 bpp, struct p=
ll_ct *pll);
+static int aty_var_to_pll_ct(const struct fb_info *info, u32 vclk_per, u32=
 bpp, union aty_pll *pll);
+static u32 aty_pll_to_var_ct(const struct fb_info *info, const union aty_p=
ll *pll);
=20
+u8 aty_ld_pll_ct(int offset, const struct atyfb_par *par)
+{
+	u8 res;
=20
+	/* write addr byte */
+	aty_st_8(CLOCK_CNTL_ADDR, (offset << 2) & PLL_ADDR, par);
+	/* read the register value */
+	res =3D aty_ld_8(CLOCK_CNTL_DATA, par);
+	return res;
+}
=20
=2Dstatic void aty_st_pll(int offset, u8 val, const struct atyfb_par *par)
+void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par)
 {
 	/* write addr byte */
=2D	aty_st_8(CLOCK_CNTL + 1, (offset << 2) | PLL_WR_EN, par);
+	aty_st_8(CLOCK_CNTL_ADDR, ((offset << 2) & PLL_ADDR) | PLL_WR_EN, par);
 	/* write the register value */
=2D	aty_st_8(CLOCK_CNTL + 2, val, par);
=2D	aty_st_8(CLOCK_CNTL + 1, (offset << 2) & ~PLL_WR_EN, par);
+	aty_st_8(CLOCK_CNTL_DATA, val & PLL_DATA, par);
+	aty_st_8(CLOCK_CNTL_ADDR, ((offset << 2) & PLL_ADDR) & ~PLL_WR_EN, par);
 }
=20
+/*
+ * by Daniel Mantione
+ *                                  <daniel.mantione@freepascal.org>
+ *
+ *
+ * ATI Mach64 CT clock synthesis description.
+ *
+ * All clocks on the Mach64 can be calculated using the same principle:
+ *
+ *       XTALIN * x * FB_DIV
+ * CLK =3D ----------------------
+ *       PLL_REF_DIV * POST_DIV
+ *
+ * XTALIN is a fixed speed clock. Common speeds are 14.31 MHz and 29.50 MH=
z.
+ * PLL_REF_DIV can be set by the user, but is the same for all clocks.
+ * FB_DIV can be set by the user for each clock individually, it should be=
 set
+ * between 128 and 255, the chip will generate a bad clock signal for too =
low
+ * values.
+ * x depends on the type of clock; usually it is 2, but for the MCLK it ca=
n also
+ * be set to 4.
+ * POST_DIV can be set by the user for each clock individually, Possible v=
alues
+ * are 1,2,4,8 and for some clocks other values are available too.
+ * CLK is of course the clock speed that is generated.
+ *
+ * The Mach64 has these clocks:
+ *
+ * MCLK			The clock rate of the chip
+ * XCLK			The clock rate of the on-chip memory
+ * VCLK0		First pixel clock of first CRT controller
+ * VCLK1    Second pixel clock of first CRT controller
+ * VCLK2		Third pixel clock of first CRT controller
+ * VCLK3    Fourth pixel clock of first CRT controller
+ * VCLK			Selected pixel clock, one of VCLK0, VCLK1, VCLK2, VCLK3
+ * V2CLK		Pixel clock of the second CRT controller.
+ * SCLK			Multi-purpose clock
+ *
+ * - MCLK and XCLK use the same FB_DIV
+ * - VCLK0 .. VCLK3 use the same FB_DIV
+ * - V2CLK is needed when the second CRTC is used (can be used for dualhea=
d);
+ *   i.e. CRT monitor connected to laptop has different resolution than bu=
ilt
+ *   in LCD monitor.
+ * - SCLK is not available on all cards; it is know to exist on the Rage L=
T-PRO,
+ *   Rage XL and Rage Mobility. It is know not to exist on the Mach64 VT.
+ * - V2CLK is not available on all cards, most likely only the Rage LT-PRO,
+ *   the Rage XL and the Rage Mobility
+ *
+ * SCLK can be used to:
+ * - Clock the chip instead of MCLK
+ * - Replace XTALIN with a user defined frequency
+ * - Generate the pixel clock for the LCD monitor (instead of VCLK)
+ */
+
+ /*
+  * It can be quite hard to calculate XCLK and MCLK if they don't run at t=
he
+  * same frequency. Luckily, until now all cards that need asynchrone clock
+  * speeds seem to have SCLK.
+  * So this driver uses SCLK to clock the chip and XCLK to clock the memor=
y.
+  */
=20
 /* -----------------------------------------------------------------------=
=2D- */
=20
=2D    /*
=2D     *  PLL programming (Mach64 CT family)
=2D     */
+/*
+ *  PLL programming (Mach64 CT family)
+ *
+ *
+ * This procedure sets the display fifo. The display fifo is a buffer that
+ * contains data read from the video memory that waits to be processed by
+ * the CRT controller.
+ *
+ * On the more modern Mach64 variants, the chip doesn't calculate the
+ * interval after which the display fifo has to be reloaded from memory
+ * automatically, the driver has to do it instead.
+ */
+
+#define Maximum_DSP_PRECISION 7
+static u8 postdividers[] =3D {1,2,4,8,3};
=20
=2Dstatic int aty_dsp_gt(const struct fb_info *info, u8 bpp,
=2D		      struct pll_ct *pll)
+static int aty_dsp_gt(const struct fb_info *info, u32 bpp, struct pll_ct *=
pll)
 {
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	u32 dsp_xclks_per_row, dsp_loop_latency, dsp_precision, dsp_off,
=2D	    dsp_on;
=2D	u32 xclks_per_row, fifo_off, fifo_on, y, fifo_size, page_size;
=2D
=2D	/* xclocks_per_row<<11 */
=2D	xclks_per_row =3D
=2D	    (pll->mclk_fb_div * pll->vclk_post_div_real * 64 << 11) /
=2D	    (pll->vclk_fb_div * pll->mclk_post_div_real * bpp);
=2D	if (xclks_per_row < (1 << 11))
=2D		FAIL("Dotclock to high");
=2D	if (M64_HAS(FIFO_24)) {
=2D		fifo_size =3D 24;
=2D		dsp_loop_latency =3D 0;
=2D	} else {
=2D		fifo_size =3D 32;
=2D		dsp_loop_latency =3D 2;
+	u32 dsp_off, dsp_on, dsp_xclks;
+	u32 multiplier, divider, ras_multiplier, ras_divider, tmp;
+	u8 vshift, xshift;
+	s8 dsp_precision;
+
+	multiplier =3D ((u32)pll->mclk_fb_div) * pll->vclk_post_div_real;
+	divider =3D ((u32)pll->vclk_fb_div) * pll->xclk_ref_div;
+
+	ras_multiplier =3D pll->xclkmaxrasdelay;
+	ras_divider =3D 1;
+
+	if (bpp>=3D8)
+		divider =3D divider * (bpp >> 2);
+
+	vshift =3D (6 - 2) - pll->xclk_post_div;	/* FIFO is 64 bits wide in accel=
erator mode ... */
+
+	if (bpp =3D=3D 0)
+		vshift--;	/* ... but only 32 bits in VGA mode. */
+
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (pll->xres !=3D 0) {
+		struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+
+		multiplier =3D multiplier * par->lcd_width;
+		divider =3D divider * pll->xres & ~7;
+
+		ras_multiplier =3D ras_multiplier * par->lcd_width;
+		ras_divider =3D ras_divider * pll->xres & ~7;
 	}
=2D	dsp_precision =3D 0;
=2D	y =3D (xclks_per_row * fifo_size) >> 11;
=2D	while (y) {
=2D		y >>=3D 1;
=2D		dsp_precision++;
=2D	}
=2D	dsp_precision -=3D 5;
=2D	/* fifo_off<<6 */
=2D	fifo_off =3D ((xclks_per_row * (fifo_size - 1)) >> 5) + (3 << 6);
=2D
=2D	if (info->fix.smem_len > 1 * 1024 * 1024) {
=2D		if (par->ram_type >=3D SDRAM) {
=2D			/* >1 MB SDRAM */
=2D			dsp_loop_latency +=3D 8;
=2D			page_size =3D 8;
=2D		} else {
=2D			/* >1 MB DRAM */
=2D			dsp_loop_latency +=3D 6;
=2D			page_size =3D 9;
=2D		}
=2D	} else {
=2D		if (par->ram_type >=3D SDRAM) {
=2D			/* <2 MB SDRAM */
=2D			dsp_loop_latency +=3D 9;
=2D			page_size =3D 10;
=2D		} else {
=2D			/* <2 MB DRAM */
=2D			dsp_loop_latency +=3D 8;
=2D			page_size =3D 10;
=2D		}
+#endif
+	/* If we don't do this, 32 bits for multiplier & divider won't be
+	enough in certain situations! */
+	while (((multiplier | divider) & 1) =3D=3D 0) {
+		multiplier =3D multiplier >> 1;
+		divider =3D divider >> 1;
 	}
=2D	/* fifo_on<<6 */
=2D	if (xclks_per_row >=3D (page_size << 11))
=2D		fifo_on =3D
=2D		    ((2 * page_size + 1) << 6) + (xclks_per_row >> 5);
=2D	else
=2D		fifo_on =3D (3 * page_size + 2) << 6;
=20
=2D	dsp_xclks_per_row =3D xclks_per_row >> dsp_precision;
=2D	dsp_on =3D fifo_on >> dsp_precision;
=2D	dsp_off =3D fifo_off >> dsp_precision;
=2D
=2D	pll->dsp_config =3D (dsp_xclks_per_row & 0x3fff) |
=2D	    ((dsp_loop_latency & 0xf) << 16) | ((dsp_precision & 7) << 20);
=2D	pll->dsp_on_off =3D (dsp_on & 0x7ff) | ((dsp_off & 0x7ff) << 16);
=2D	return 0;
=2D}
+	/* Determine DSP precision first */
+	tmp =3D ((multiplier * pll->fifo_size) << vshift) / divider;
=20
=2Dstatic int aty_valid_pll_ct(const struct fb_info *info, u32 vclk_per,
=2D			    struct pll_ct *pll)
=2D{
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	u32 q, x;		/* x is a workaround for sparc64-linux-gcc */
=2D	x =3D x;			/* x is a workaround for sparc64-linux-gcc */
+	for (dsp_precision =3D -5;  tmp;  dsp_precision++)
+		tmp >>=3D 1;
+	if (dsp_precision < 0)
+		dsp_precision =3D 0;
+	else if (dsp_precision > Maximum_DSP_PRECISION)
+		dsp_precision =3D Maximum_DSP_PRECISION;
+
+	xshift =3D 6 - dsp_precision;
+	vshift +=3D xshift;
+
+	/* Move on to dsp_off */
+	dsp_off =3D ((multiplier * (pll->fifo_size - 1)) << vshift) / divider -
+		(1 << (vshift - xshift));
+
+/*    if (bpp =3D=3D 0)
+        dsp_on =3D ((multiplier * 20 << vshift) + divider) / divider;
+    else */
+	{
+		dsp_on =3D ((multiplier << vshift) + divider) / divider;
+		tmp =3D ((ras_multiplier << xshift) + ras_divider) / ras_divider;
+		if (dsp_on < tmp)
+		dsp_on =3D tmp;
+		dsp_on =3D dsp_on + (tmp * 2) + (pll->xclkpagefaultdelay << xshift);
+	}
=20
=2D	pll->pll_ref_div =3D par->pll_per * 2 * 255 / par->ref_clk_per;
+	/* Calculate rounding factor and apply it to dsp_on */
+	tmp =3D ((1 << (Maximum_DSP_PRECISION - dsp_precision)) - 1) >> 1;
+	dsp_on =3D ((dsp_on + tmp) / (tmp + 1)) * (tmp + 1);
+
+	if (dsp_on >=3D ((dsp_off / (tmp + 1)) * (tmp + 1))) {
+		dsp_on =3D dsp_off - (multiplier << vshift) / divider;
+		dsp_on =3D (dsp_on / (tmp + 1)) * (tmp + 1);
+	}
=20
=2D	/* FIXME: use the VTB/GTB /3 post divider if it's better suited */
=2D	q =3D par->ref_clk_per * pll->pll_ref_div * 4 / par->mclk_per;	/* actua=
lly 8*q */
=2D	if (q < 16 * 8 || q > 255 * 8)
=2D		FAIL("mclk out of range");
=2D	else if (q < 32 * 8)
=2D		pll->mclk_post_div_real =3D 8;
=2D	else if (q < 64 * 8)
=2D		pll->mclk_post_div_real =3D 4;
=2D	else if (q < 128 * 8)
=2D		pll->mclk_post_div_real =3D 2;
=2D	else
=2D		pll->mclk_post_div_real =3D 1;
=2D	pll->mclk_fb_div =3D q * pll->mclk_post_div_real / 8;
+	/* Last but not least:  dsp_xclks */
+	dsp_xclks =3D ((multiplier << (vshift + 5)) + divider) / divider;
=20
=2D	/* FIXME: use the VTB/GTB /{3,6,12} post dividers if they're better sui=
ted */
=2D	q =3D par->ref_clk_per * pll->pll_ref_div * 4 / vclk_per;	/* actually 8=
*q */
=2D	if (q < 16 * 8 || q > 255 * 8)
=2D		FAIL("vclk out of range");
=2D	else if (q < 32 * 8)
=2D		pll->vclk_post_div_real =3D 8;
=2D	else if (q < 64 * 8)
=2D		pll->vclk_post_div_real =3D 4;
=2D	else if (q < 128 * 8)
=2D		pll->vclk_post_div_real =3D 2;
=2D	else
=2D		pll->vclk_post_div_real =3D 1;
=2D	pll->vclk_fb_div =3D q * pll->vclk_post_div_real / 8;
+	/* Get register values. */
+	pll->dsp_on_off =3D (dsp_on << 16) + dsp_off;
+	pll->dsp_config =3D (dsp_precision << 20) | (pll->dsp_loop_latency << 16)=
 | dsp_xclks;
+#ifdef DEBUG
+	printk("atyfb(%s): dsp_config 0x%08x, dsp_on_off 0x%08x\n",
+		__FUNCTION__, pll->dsp_config, pll->dsp_on_off);
+#endif
 	return 0;
 }
=20
=2Dvoid aty_calc_pll_ct(const struct fb_info *info, struct pll_ct *pll)
+static int aty_valid_pll_ct(const struct fb_info *info, u32 vclk_per, stru=
ct pll_ct *pll)
 {
+	u32 q;
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	u8 mpostdiv =3D 0;
=2D	u8 vpostdiv =3D 0;
=2D
=2D	if (M64_HAS(SDRAM_MAGIC_PLL) && (par->ram_type >=3D SDRAM))
=2D		pll->pll_gen_cntl =3D 0x04;
=2D	else
=2D		pll->pll_gen_cntl =3D 0x84;
=2D
=2D	switch (pll->mclk_post_div_real) {
=2D	case 1:
=2D		mpostdiv =3D 0;
=2D		break;
=2D	case 2:
=2D		mpostdiv =3D 1;
=2D		break;
=2D	case 3:
=2D		mpostdiv =3D 4;
=2D		break;
=2D	case 4:
=2D		mpostdiv =3D 2;
=2D		break;
=2D	case 8:
=2D		mpostdiv =3D 3;
=2D		break;
=2D	}
=2D	pll->pll_gen_cntl |=3D mpostdiv << 4;	/* mclk */
+#ifdef DEBUG
+	int pllvclk;
+#endif
=20
=2D	if (M64_HAS(MAGIC_POSTDIV))
=2D		pll->pll_ext_cntl =3D 0;
=2D	else
=2D		pll->pll_ext_cntl =3D mpostdiv;	/* xclk =3D=3D mclk */
=2D
=2D	switch (pll->vclk_post_div_real) {
=2D	case 2:
=2D		vpostdiv =3D 1;
=2D		break;
=2D	case 3:
=2D		pll->pll_ext_cntl |=3D 0x10;
=2D	case 1:
=2D		vpostdiv =3D 0;
=2D		break;
=2D	case 6:
=2D		pll->pll_ext_cntl |=3D 0x10;
=2D	case 4:
=2D		vpostdiv =3D 2;
=2D		break;
=2D	case 12:
=2D		pll->pll_ext_cntl |=3D 0x10;
=2D	case 8:
=2D		vpostdiv =3D 3;
=2D		break;
+	/* FIXME: use the VTB/GTB /{3,6,12} post dividers if they're better suite=
d */
+	q =3D par->ref_clk_per * pll->pll_ref_div * 4 / vclk_per;
+	if (q < 16*8 || q > 255*8) {
+		printk(KERN_CRIT "atyfb: vclk out of range\n");
+		return -EINVAL;
+	} else {
+		pll->vclk_post_div  =3D (q < 128*8);
+		pll->vclk_post_div +=3D (q <  64*8);
+		pll->vclk_post_div +=3D (q <  32*8);
 	}
=2D
=2D	pll->pll_vclk_cntl =3D 0x03;	/* VCLK =3D PLL_VCLK/VCLKx_POST */
=2D	pll->vclk_post_div =3D vpostdiv;
+	pll->vclk_post_div_real =3D postdividers[pll->vclk_post_div];
+	//    pll->vclk_post_div <<=3D 6;
+	pll->vclk_fb_div =3D q * pll->vclk_post_div_real / 8;
+#ifdef DEBUG
+	pllvclk =3D (1000000 * 2 * pll->vclk_fb_div) /
+		(par->ref_clk_per * pll->pll_ref_div);
+	printk("atyfb(%s): pllvclk=3D%d MHz, vclk=3D%d MHz\n",
+		__FUNCTION__, pllvclk, pllvclk / pll->vclk_post_div_real);
+#endif
+	pll->pll_vclk_cntl =3D 0x03; /* VCLK =3D PLL_VCLK/VCLKx_POST */
+	return 0;
 }
=20
=2Dstatic int aty_var_to_pll_ct(const struct fb_info *info, u32 vclk_per,
=2D			     u8 bpp, union aty_pll *pll)
+static int aty_var_to_pll_ct(const struct fb_info *info, u32 vclk_per, u32=
 bpp, union aty_pll *pll)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	int err;
@@ -220,47 +242,358 @@
 		return err;
 	if (M64_HAS(GTB_DSP) && (err =3D aty_dsp_gt(info, bpp, &pll->ct)))
 		return err;
=2D	aty_calc_pll_ct(info, &pll->ct);
+	/*aty_calc_pll_ct(info, &pll->ct);*/
 	return 0;
 }
=20
=2Dstatic u32 aty_pll_ct_to_var(const struct fb_info *info,
=2D			     const union aty_pll *pll)
+static u32 aty_pll_to_var_ct(const struct fb_info *info, const union aty_p=
ll *pll)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D
=2D	u32 ref_clk_per =3D par->ref_clk_per;
=2D	u8 pll_ref_div =3D pll->ct.pll_ref_div;
=2D	u8 vclk_fb_div =3D pll->ct.vclk_fb_div;
=2D	u8 vclk_post_div =3D pll->ct.vclk_post_div_real;
=2D
=2D	return ref_clk_per * pll_ref_div * vclk_post_div / vclk_fb_div / 2;
+	u32 ret;
+	ret =3D par->ref_clk_per * pll->ct.pll_ref_div * pll->ct.vclk_post_div_re=
al / pll->ct.vclk_fb_div / 2;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if(pll->ct.xres > 0) {
+		ret *=3D par->lcd_width;
+		ret /=3D pll->ct.xres;
+	}
+#endif
+#ifdef DEBUG
+	printk("atyfb(%s): calculated 0x%08X(%i)\n", __FUNCTION__, ret, ret);
+#endif
+	return ret;
 }
=20
=2Dvoid aty_set_pll_ct(const struct fb_info *info,
=2D		    const union aty_pll *pll)
+void aty_set_pll_ct(const struct fb_info *info, const union aty_pll *pll)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+	u32 crtc_gen_cntl, lcd_gen_cntrl =3D 0;
+	u8 tmp, tmp2;
+#ifdef DEBUG
+	printk("atyfb(%s): about to program:\n"
+		"pll_ext_cntl=3D0x%02x pll_gen_cntl=3D0x%02x pll_vclk_cntl=3D0x%02x\n",
+		__FUNCTION__,
+		pll->ct.pll_ext_cntl, pll->ct.pll_gen_cntl, pll->ct.pll_vclk_cntl);
+
+	printk("atyfb(%s): setting clock %lu for FeedBackDivider %i, ReferenceDiv=
ider %i, PostDivider %i(%i)\n",
+		__FUNCTION__,
+		par->clk_wr_offset, pll->ct.vclk_fb_div,
+		pll->ct.pll_ref_div, pll->ct.vclk_post_div, pll->ct.vclk_post_div_real);
+#endif
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (par->lcd_table !=3D 0) {
+		/* turn off LCD */
+		lcd_gen_cntrl =3D aty_ld_lcd(LCD_GEN_CNTL, par);
+		aty_st_lcd(LCD_GEN_CNTL, lcd_gen_cntrl & ~LCD_ON, par);
+	}
+#endif
+	aty_st_8(CLOCK_CNTL, par->clk_wr_offset | CLOCK_STROBE, par);
=20
=2D	aty_st_pll(PLL_REF_DIV, pll->ct.pll_ref_div, par);
=2D	aty_st_pll(PLL_GEN_CNTL, pll->ct.pll_gen_cntl, par);
=2D	aty_st_pll(MCLK_FB_DIV, pll->ct.mclk_fb_div, par);
=2D	aty_st_pll(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl, par);
=2D	aty_st_pll(VCLK_POST_DIV, pll->ct.vclk_post_div, par);
=2D	aty_st_pll(VCLK0_FB_DIV, pll->ct.vclk_fb_div, par);
=2D	aty_st_pll(PLL_EXT_CNTL, pll->ct.pll_ext_cntl, par);
+	/* Temporarily switch to accelerator mode */
+	crtc_gen_cntl =3D aty_ld_le32(CRTC_GEN_CNTL, par);
+	if (!(crtc_gen_cntl & CRTC_EXT_DISP_EN))
+		aty_st_le32(CRTC_GEN_CNTL, crtc_gen_cntl | CRTC_EXT_DISP_EN, par);
+
+	/* Reset VCLK generator */
+	aty_st_pll_ct(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl, par);
+
+	/* Set post-divider */
+	tmp2 =3D par->clk_wr_offset << 1;
+	tmp =3D aty_ld_pll_ct(VCLK_POST_DIV, par);
+	tmp &=3D ~(0x03U << tmp2);
+	tmp |=3D ((pll->ct.vclk_post_div & 0x03U) << tmp2);
+	aty_st_pll_ct(VCLK_POST_DIV, tmp, par);
+
+	/* Set extended post-divider */
+	tmp =3D aty_ld_pll_ct(PLL_EXT_CNTL, par);
+	tmp &=3D ~(0x10U << par->clk_wr_offset);
+	tmp &=3D 0xF0U;
+	tmp |=3D pll->ct.pll_ext_cntl;
+	aty_st_pll_ct(PLL_EXT_CNTL, tmp, par);
+
+	/* Set feedback divider */
+	tmp =3D VCLK0_FB_DIV + par->clk_wr_offset;
+	aty_st_pll_ct(tmp, (pll->ct.vclk_fb_div & 0xFFU), par);
+
+	aty_st_pll_ct(PLL_GEN_CNTL, (pll->ct.pll_gen_cntl & (~(PLL_OVERRIDE | PLL=
_MCLK_RST))) | OSC_EN, par);
+
+	/* End VCLK generator reset */
+	aty_st_pll_ct(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl & ~(PLL_VCLK_RST), par=
);
+	mdelay(5);
+
+	aty_st_pll_ct(PLL_GEN_CNTL, pll->ct.pll_gen_cntl, par);
+	aty_st_pll_ct(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl, par);
+	mdelay(1);
+
+	/* Restore mode register */
+	if (!(crtc_gen_cntl & CRTC_EXT_DISP_EN))
+		aty_st_le32(CRTC_GEN_CNTL, crtc_gen_cntl, par);
=20
 	if (M64_HAS(GTB_DSP)) {
+		u8 dll_cntl;
+
 		if (M64_HAS(XL_DLL))
=2D			aty_st_pll(DLL_CNTL, 0x80, par);
+			dll_cntl =3D 0x80;
 		else if (par->ram_type >=3D SDRAM)
=2D			aty_st_pll(DLL_CNTL, 0xa6, par);
+			dll_cntl =3D 0xa6;
 		else
=2D			aty_st_pll(DLL_CNTL, 0xa0, par);
=2D		aty_st_pll(VFC_CNTL, 0x1b, par);
+			dll_cntl =3D 0xa0;
+		aty_st_pll_ct(DLL_CNTL, dll_cntl, par);
+		aty_st_pll_ct(VFC_CNTL, 0x1b, par);
 		aty_st_le32(DSP_CONFIG, pll->ct.dsp_config, par);
 		aty_st_le32(DSP_ON_OFF, pll->ct.dsp_on_off, par);
+
+		mdelay(10);
+		aty_st_pll_ct(DLL_CNTL, dll_cntl, par);
+		mdelay(10);
+		aty_st_pll_ct(DLL_CNTL, dll_cntl | 0x40, par);
+		mdelay(10);
+		aty_st_pll_ct(DLL_CNTL, dll_cntl & ~0x40, par);
+	}
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (par->lcd_table !=3D 0) {
+		/* restore LCD */
+		aty_st_lcd(LCD_GEN_CNTL, lcd_gen_cntrl, par);
 	}
+#endif
+}
+
+void __init aty_get_pll_ct(const struct fb_info *info, union aty_pll *pll)
+{
+	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+	u8 tmp, clock;
+
+	clock =3D aty_ld_8(CLOCK_CNTL, par) & 0x03U;
+	tmp =3D clock << 1;
+	pll->ct.vclk_post_div =3D (aty_ld_pll_ct(VCLK_POST_DIV, par) >> tmp) & 0x=
03U;
+
+	pll->ct.pll_ext_cntl =3D aty_ld_pll_ct(PLL_EXT_CNTL, par) & 0x0FU;
+	pll->ct.vclk_fb_div =3D aty_ld_pll_ct(VCLK0_FB_DIV + clock, par) & 0xFFU;
+	pll->ct.pll_ref_div =3D aty_ld_pll_ct(PLL_REF_DIV, par);
+	pll->ct.mclk_fb_div =3D aty_ld_pll_ct(MCLK_FB_DIV, par);
+
+	pll->ct.pll_gen_cntl =3D aty_ld_pll_ct(PLL_GEN_CNTL, par);
+	pll->ct.pll_vclk_cntl =3D aty_ld_pll_ct(PLL_VCLK_CNTL, par);
+
+	if (M64_HAS(GTB_DSP)) {
+		pll->ct.dsp_config =3D aty_ld_le32(DSP_CONFIG, par);
+		pll->ct.dsp_on_off =3D aty_ld_le32(DSP_ON_OFF, par);
+	}
+}
+
+int __init aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)=
 {
+	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+	u8 mpost_div, xpost_div, sclk_post_div_real, sclk_fb_div, spll_cntl2;
+	u32 q, i, memcntl, trp;
+	u32 dsp_config, dsp_on_off, vga_dsp_config, vga_dsp_on_off;
+#ifdef DEBUG
+	int pllmclk, pllsclk;
+#endif
+	pll->ct.pll_ext_cntl =3D aty_ld_pll_ct(PLL_EXT_CNTL, par);
+	pll->ct.xclk_post_div =3D pll->ct.pll_ext_cntl & 0x07;
+	pll->ct.xclk_ref_div =3D 1;
+	switch (pll->ct.xclk_post_div) {
+	case 0:  case 1:  case 2:  case 3:
+		break;
+
+	case 4:
+		pll->ct.xclk_ref_div =3D 3;
+		pll->ct.xclk_post_div =3D 0;
+		break;
+
+	default:
+		printk(KERN_CRIT "atyfb: Unsupported xclk source:  %d.\n", pll->ct.xclk_=
post_div);
+		return -EINVAL;
+	}
+	pll->ct.mclk_fb_mult =3D 2;
+	if(pll->ct.pll_ext_cntl & PLL_MFB_TIMES_4_2B) {
+		pll->ct.mclk_fb_mult =3D 4;
+		pll->ct.xclk_post_div -=3D 1;
+	}
+
+#ifdef DEBUG
+	printk("atyfb(%s): mclk_fb_mult=3D%d, xclk_post_div=3D%d\n",
+		__FUNCTION__, pll->ct.mclk_fb_mult, pll->ct.xclk_post_div);
+#endif
+
+	memcntl =3D aty_ld_le32(MEM_CNTL, par);
+	trp =3D (memcntl & 0x300) >> 8;
+
+	pll->ct.xclkpagefaultdelay =3D ((memcntl & 0xc00) >> 10) + ((memcntl & 0x=
1000) >> 12) + trp + 2;
+	pll->ct.xclkmaxrasdelay =3D ((memcntl & 0x70000) >> 16) + trp + 2;
+
+	if (M64_HAS(FIFO_32)) {
+		pll->ct.fifo_size =3D 32;
+	} else {
+		pll->ct.fifo_size =3D 24;
+		pll->ct.xclkpagefaultdelay +=3D 2;
+		pll->ct.xclkmaxrasdelay +=3D 3;
+	}
+
+	switch (par->ram_type) {
+	case DRAM:
+		if (info->fix.smem_len<=3DONE_MB) {
+			pll->ct.dsp_loop_latency =3D 10;
+		} else {
+			pll->ct.dsp_loop_latency =3D 8;
+			pll->ct.xclkpagefaultdelay +=3D 2;
+		}
+		break;
+	case EDO:
+	case PSEUDO_EDO:
+		if (info->fix.smem_len<=3DONE_MB) {
+			pll->ct.dsp_loop_latency =3D 9;
+		} else {
+			pll->ct.dsp_loop_latency =3D 8;
+			pll->ct.xclkpagefaultdelay +=3D 1;
+		}
+		break;
+	case SDRAM:
+		if (info->fix.smem_len<=3DONE_MB) {
+			pll->ct.dsp_loop_latency =3D 11;
+		} else {
+			pll->ct.dsp_loop_latency =3D 10;
+			pll->ct.xclkpagefaultdelay +=3D 1;
+		}
+		break;
+	case SGRAM:
+		pll->ct.dsp_loop_latency =3D 8;
+		pll->ct.xclkpagefaultdelay +=3D 3;
+		break;
+	default:
+		pll->ct.dsp_loop_latency =3D 11;
+		pll->ct.xclkpagefaultdelay +=3D 3;
+		break;
+	}
+
+	if (pll->ct.xclkmaxrasdelay <=3D pll->ct.xclkpagefaultdelay)
+		pll->ct.xclkmaxrasdelay =3D pll->ct.xclkpagefaultdelay + 1;
+
+	/* Allow BIOS to override */
+	dsp_config =3D aty_ld_le32(DSP_CONFIG, par);
+	dsp_on_off =3D aty_ld_le32(DSP_ON_OFF, par);
+	vga_dsp_config =3D aty_ld_le32(VGA_DSP_CONFIG, par);
+	vga_dsp_on_off =3D aty_ld_le32(VGA_DSP_ON_OFF, par);
+
+	if (dsp_config)
+		pll->ct.dsp_loop_latency =3D (dsp_config & DSP_LOOP_LATENCY) >> 16;
+#if 0
+	FIXME: is it relevant for us?
+	if ((!dsp_on_off && !M64_HAS(RESET_3D)) ||
+		((dsp_on_off =3D=3D vga_dsp_on_off) &&
+		(!dsp_config || !((dsp_config ^ vga_dsp_config) & DSP_XCLKS_PER_QW)))) {
+		vga_dsp_on_off &=3D VGA_DSP_OFF;
+		vga_dsp_config &=3D VGA_DSP_XCLKS_PER_QW;
+		if (ATIDivide(vga_dsp_on_off, vga_dsp_config, 5, 1) > 24)
+			pll->ct.fifo_size =3D 32;
+		else
+			pll->ct.fifo_size =3D 24;
+	}
+#endif
+	/* Exit if the user does not want us to tamper with the clock
+	rates of her chip. */
+	if (par->mclk_per =3D=3D 0) {
+		u8 mclk_fb_div, pll_ext_cntl;
+		pll->ct.pll_ref_div =3D aty_ld_pll_ct(PLL_REF_DIV, par);
+		pll_ext_cntl =3D aty_ld_pll_ct(PLL_EXT_CNTL, par);
+		pll->ct.xclk_post_div_real =3D postdividers[pll_ext_cntl & 0x07];
+		mclk_fb_div =3D aty_ld_pll_ct(MCLK_FB_DIV, par);
+		if (pll_ext_cntl & PLL_MFB_TIMES_4_2B)
+			mclk_fb_div <<=3D 1;
+		pll->ct.mclk_fb_div =3D mclk_fb_div;
+		return 0;
+	}
+
+	pll->ct.pll_ref_div =3D par->pll_per * 2 * 255 / par->ref_clk_per;
+
+	/* FIXME: use the VTB/GTB /3 post divider if it's better suited */
+	q =3D par->ref_clk_per * pll->ct.pll_ref_div * 8 /
+		(pll->ct.mclk_fb_mult * par->xclk_per);
+
+	if (q < 16*8 || q > 255*8) {
+		printk(KERN_CRIT "atxfb: xclk out of range\n");
+		return -EINVAL;
+	} else {
+		xpost_div  =3D (q < 128*8);
+		xpost_div +=3D (q <  64*8);
+		xpost_div +=3D (q <  32*8);
+	}
+	pll->ct.xclk_post_div_real =3D postdividers[xpost_div];
+	pll->ct.mclk_fb_div =3D q * pll->ct.xclk_post_div_real / 8;
+
+#ifdef DEBUG
+	pllmclk =3D (1000000 * pll->ct.mclk_fb_mult * pll->ct.mclk_fb_div) /
+			(par->ref_clk_per * pll->ct.pll_ref_div);
+	printk("atyfb(%s): pllmclk=3D%d MHz, xclk=3D%d MHz\n",
+		__FUNCTION__, pllmclk, pllmclk / pll->ct.xclk_post_div_real);
+#endif
+
+	if (M64_HAS(SDRAM_MAGIC_PLL) && (par->ram_type >=3D SDRAM))
+		pll->ct.pll_gen_cntl =3D OSC_EN;
+	else
+		pll->ct.pll_gen_cntl =3D OSC_EN | DLL_PWDN /* | FORCE_DCLK_TRI_STATE */;
+
+	if (M64_HAS(MAGIC_POSTDIV))
+		pll->ct.pll_ext_cntl =3D 0;
+	else
+		pll->ct.pll_ext_cntl =3D xpost_div;
+
+	if (pll->ct.mclk_fb_mult =3D=3D 4)
+		pll->ct.pll_ext_cntl |=3D PLL_MFB_TIMES_4_2B;
+
+	if (par->mclk_per =3D=3D par->xclk_per) {
+		pll->ct.pll_gen_cntl |=3D (xpost_div << 4); /* mclk =3D=3D xclk */
+	} else {
+		/*
+		* The chip clock is not equal to the memory clock.
+		* Therefore we will use sclk to clock the chip.
+		*/
+		pll->ct.pll_gen_cntl |=3D (6 << 4); /* mclk =3D=3D sclk */
+
+		q =3D par->ref_clk_per * pll->ct.pll_ref_div * 4 / par->mclk_per;
+		if (q < 16*8 || q > 255*8) {
+			printk(KERN_CRIT "atyfb: mclk out of range\n");
+			return -EINVAL;
+		} else {
+			mpost_div  =3D (q < 128*8);
+			mpost_div +=3D (q <  64*8);
+			mpost_div +=3D (q <  32*8);
+		}
+		sclk_post_div_real =3D postdividers[mpost_div];
+		sclk_fb_div =3D q * sclk_post_div_real / 8;
+		spll_cntl2 =3D mpost_div << 4;
+#ifdef DEBUG
+		pllsclk =3D (1000000 * 2 * sclk_fb_div) /
+			(par->ref_clk_per * pll->ct.pll_ref_div);
+		printk("atyfb(%s): use sclk, pllsclk=3D%d MHz, sclk=3Dmclk=3D%d MHz\n",
+			__FUNCTION__, pllsclk, pllsclk / sclk_post_div_real);
+#endif
+		/*
+		* This disables the sclk, crashes the computer as reported:
+		* aty_st_pll_ct(SPLL_CNTL2, 3, info);
+		*
+		* So it seems the sclk must be enabled before it is used;
+		* so PLL_GEN_CNTL must be programmed *after* the sclk.
+		*/
+		aty_st_pll_ct(SCLK_FB_DIV, sclk_fb_div, par);
+		aty_st_pll_ct(SPLL_CNTL2, spll_cntl2, par);
+		/*
+		 * The sclk has been started. However, I believe the first clock
+		 * ticks it generates are not very stable. Hope this primitive loop
+		 * helps for Rage Mobilities that sometimes crash when
+		 * we switch to sclk. (Daniel Mantione, 13-05-2003)
+		 */
+		for (i=3D0;i<=3D0x1ffff;i++);
+	}
+
+	aty_st_pll_ct(PLL_REF_DIV, pll->ct.pll_ref_div, par);
+	aty_st_pll_ct(PLL_GEN_CNTL, pll->ct.pll_gen_cntl, par);
+	aty_st_pll_ct(MCLK_FB_DIV, pll->ct.mclk_fb_div, par);
+	aty_st_pll_ct(PLL_EXT_CNTL, pll->ct.pll_ext_cntl, par);
+	/* Disable the extra precision pixel clock controls since we do not use t=
hem. */
+	aty_st_pll_ct(EXT_VPLL_CNTL, aty_ld_pll_ct(EXT_VPLL_CNTL, par) &
+		~(EXT_VPLL_EN | EXT_VPLL_VGA_EN | EXT_VPLL_INSYNC), par);
+
+	return 0;
 }
=20
 static int dummy(void)
@@ -274,6 +607,8 @@
=20
 const struct aty_pll_ops aty_pll_ct =3D {
 	.var_to_pll	=3D aty_var_to_pll_ct,
=2D	.pll_to_var	=3D aty_pll_ct_to_var,
+	.pll_to_var	=3D aty_pll_to_var_ct,
 	.set_pll	=3D aty_set_pll_ct,
+	.get_pll	=3D aty_get_pll_ct,
+	.init_pll       =3D aty_init_pll_ct
 };
diff -Nru a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cu=
rsor.c
=2D-- a/drivers/video/aty/mach64_cursor.c	2004-10-19 20:22:44 +08:00
+++ b/drivers/video/aty/mach64_cursor.c	2004-10-09 00:22:38 +08:00
@@ -1,12 +1,11 @@
=2D
 /*
  *  ATI Mach64 CT/VT/GT/LT Cursor Support
  */
=20
 #include <linux/slab.h>
=2D#include <linux/console.h>
 #include <linux/fb.h>
 #include <linux/init.h>
+#include <linux/string.h>
=20
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -19,13 +18,49 @@
 #include <video/mach64.h>
 #include "atyfb.h"
=20
+/*
+ * The hardware cursor definition requires 2 bits per pixel. The
+ * Cursor size reguardless of the visible cursor size is 64 pixels
+ * by 64 lines. The total memory required to define the cursor is
+ * 16 bytes / line for 64 lines or 1024 bytes of data. The data
+ * must be in a contigiuos format. The 2 bit cursor code values are
+ * as follows:
+ *
+ *	00 - pixel colour =3D CURSOR_CLR_0
+ *	01 - pixel colour =3D CURSOR_CLR_1
+ *	10 - pixel colour =3D transparent (current display pixel)
+ *	11 - pixel colour =3D 1's complement of current display pixel
+ *
+ *	Cursor Offset        64 pixels		 Actual Displayed Area
+ *            \_________________________/
+ *	      |			|	|	|
+ *	      |<--------------->|	|	|
+ *	      | CURS_HORZ_OFFSET|	|	|
+ *	      |			|_______|	|  64 Lines
+ *	      |			   ^	|	|
+ *	      |			   |	|	|
+ *	      |		CURS_VERT_OFFSET|	|
+ *	      |			   |	|	|
+ *	      |____________________|____|	|
+ *
+ *
+ * The Screen position of the top left corner of the displayed
+ * cursor is specificed by CURS_HORZ_VERT_POSN. Care must be taken
+ * when the cursor hot spot is not the top left corner and the
+ * physical cursor position becomes negative. It will be be displayed
+ * if either the horizontal or vertical cursor position is negative
+ *
+ * If x becomes negative the cursor manager must adjust the CURS_HORZ_OFFS=
ET
+ * to a larger number and saturate CUR_HORZ_POSN to zero.
+ *
+ * if Y becomes negative, CUR_VERT_OFFSET must be adjusted to a larger num=
ber,
+ * CUR_OFFSET must be adjusted to a point to the appropraite line in the c=
ursor
+ * definitation and CUR_VERT_POSN must be saturated to zero.
+ */
+
     /*
      *  Hardware Cursor support.
      */
=2D
=2Dstatic const u8 cursor_pixel_map[2] =3D { 0, 15 };
=2Dstatic const u8 cursor_color_map[2] =3D { 0, 0xff };
=2D
 static const u8 cursor_bits_lookup[16] =3D {
 	0x00, 0x40, 0x10, 0x50, 0x04, 0x44, 0x14, 0x54,
 	0x01, 0x41, 0x11, 0x51, 0x05, 0x45, 0x15, 0x55
@@ -36,90 +71,39 @@
 	0xa8, 0x28, 0x88, 0x08, 0xa0, 0x20, 0x80, 0x00
 };
=20
=2Dvoid aty_set_cursor_color(struct fb_info *info)
=2D{
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	struct aty_cursor *c =3D par->cursor;
=2D	const u8 *pixel =3D cursor_pixel_map;	/* ++Geert: Why?? */
=2D	const u8 *red =3D cursor_color_map;
=2D	const u8 *green =3D cursor_color_map;
=2D	const u8 *blue =3D cursor_color_map;
=2D	u32 fg_color, bg_color;
=2D
=2D	if (!c)
=2D		return;
=2D
=2D#ifdef __sparc__
=2D	if (par->mmaped)
=2D		return;
=2D#endif
=2D	fg_color =3D (u32) red[0] << 24;
=2D	fg_color |=3D (u32) green[0] << 16;
=2D	fg_color |=3D (u32) blue[0] << 8;
=2D	fg_color |=3D (u32) pixel[0];
=2D
=2D	bg_color =3D (u32) red[1] << 24;
=2D	bg_color |=3D (u32) green[1] << 16;
=2D	bg_color |=3D (u32) blue[1] << 8;
=2D	bg_color |=3D (u32) pixel[1];
=2D
=2D	wait_for_fifo(2, par);
=2D	aty_st_le32(CUR_CLR0, fg_color, par);
=2D	aty_st_le32(CUR_CLR1, bg_color, par);
=2D}
=2D
=2Dvoid aty_set_cursor_shape(struct fb_info *info)
+int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	struct fb_cursor *cursor =3D &info->cursor;
=2D	struct aty_cursor *c =3D par->cursor;
=2D	u8 *ram, m, b;
+	u16 xoff, yoff;
 	int x, y;
=20
=2D	if (!c)
=2D		return;
 #ifdef __sparc__
 	if (par->mmaped)
=2D		return;
+		return -EPERM;
 #endif
+	if (par->asleep)
+		return -EPERM;
=20
=2D	ram =3D c->ram;
=2D	for (y =3D 0; y < cursor->image.height; y++) {
=2D		for (x =3D 0; x < cursor->image.width >> 2; x++) {
=2D			m =3D c->mask[x][y];
=2D			b =3D c->bits[x][y];
=2D			fb_writeb(cursor_mask_lookup[m >> 4] |
=2D				  cursor_bits_lookup[(b & m) >> 4], ram++);
=2D			fb_writeb(cursor_mask_lookup[m & 0x0f] |
=2D				  cursor_bits_lookup[(b & m) & 0x0f],
=2D				  ram++);
=2D		}
=2D		for (; x < 8; x++) {
=2D			fb_writeb(0xaa, ram++);
=2D			fb_writeb(0xaa, ram++);
=2D		}
+	/* Hide cursor */
+	wait_for_fifo(1, par);
+	aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par) & ~HWCURSOR_EN=
ABLE, par);
+
+	/* Set size */
+	if (cursor->set & FB_CUR_SETSIZE) {
+		info->cursor.image.height =3D cursor->image.height;
+		info->cursor.image.width =3D cursor->image.width;
 	}
=2D	fb_memset(ram, 0xaa, (64 - cursor->image.height) * 16);
=2D}
=20
=2Dstatic void aty_set_cursor(struct fb_info *info)
=2D{
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	struct fb_cursor *cursor =3D &info->cursor;
=2D	struct aty_cursor *c =3D par->cursor;
=2D	u16 xoff, yoff;
=2D	int x, y;
+	/* Set hot spot */
+	if  (cursor->set & FB_CUR_SETHOT)
+		info->cursor.hot =3D cursor->hot;
+
+	/* set position */
+	if (cursor->set & FB_CUR_SETPOS) {
+		info->cursor.image.dx =3D cursor->image.dx;
+		info->cursor.image.dy =3D cursor->image.dy;
=20
=2D	if (!c)
=2D		return;
=2D
=2D#ifdef __sparc__
=2D	if (par->mmaped)
=2D		return;
=2D#endif
=2D
=2D	if (cursor->enable) {
=2D		x =3D cursor->image.dx - cursor->hot.x - info->var.xoffset;
+		x =3D info->cursor.image.dx - info->cursor.hot.x - info->var.xoffset;
 		if (x < 0) {
 			xoff =3D -x;
 			x =3D 0;
@@ -127,7 +111,7 @@
 			xoff =3D 0;
 		}
=20
=2D		y =3D cursor->image.dy - cursor->hot.y - info->var.yoffset;
+		y =3D info->cursor.image.dy - info->cursor.hot.y - info->var.yoffset;
 		if (y < 0) {
 			yoff =3D -y;
 			y =3D 0;
@@ -135,107 +119,120 @@
 			yoff =3D 0;
 		}
=20
+		/*
+		 * In doublescan mode, the cursor location also needs to be
+		 * doubled.
+		 */
+                if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
+			y<<=3D1;
 		wait_for_fifo(4, par);
=2D		aty_st_le32(CUR_OFFSET, (info->fix.smem_len >> 3) + (yoff << 1),
=2D			    par);
+		aty_st_le32(CUR_OFFSET, (info->fix.smem_len >> 3) + (yoff << 1), par);
 		aty_st_le32(CUR_HORZ_VERT_OFF,
=2D			    ((u32) (64 - cursor->image.height + yoff) << 16) | xoff,
+			    ((u32) (64 - info->cursor.image.height + yoff) << 16) | xoff,
 			    par);
 		aty_st_le32(CUR_HORZ_VERT_POSN, ((u32) y << 16) | x, par);
=2D		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
=2D			    | HWCURSOR_ENABLE, par);
=2D	} else {
=2D		wait_for_fifo(1, par);
=2D		aty_st_le32(GEN_TEST_CNTL,
=2D			    aty_ld_le32(GEN_TEST_CNTL,
=2D					par) & ~HWCURSOR_ENABLE, par);
 	}
=2D	if (par->blitter_may_be_busy)
=2D		wait_for_idle(par);
=2D}
=2D
=2Dint atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
=2D{
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	struct aty_cursor *c =3D par->cursor;
=20
=2D	if (!c)
=2D		return -1;
=2D
=2D#ifdef __sparc__
=2D	if (par->mmaped)
=2D		return 0;
=2D#endif
+	/* Set color map */
+	if (cursor->set & FB_CUR_SETCMAP) {
+		u32 fg_idx, bg_idx, fg, bg;
+
+		info->cursor.image.fg_color =3D cursor->image.fg_color;
+		info->cursor.image.bg_color =3D cursor->image.bg_color;
+		fg_idx =3D info->cursor.image.fg_color;
+		bg_idx =3D info->cursor.image.bg_color;
+
+		fg =3D (info->cmap.red[fg_idx] << 24) |
+		     (info->cmap.green[fg_idx] << 16) |
+		     (info->cmap.blue[fg_idx] << 8) | 15;
+
+		bg =3D (info->cmap.red[bg_idx] << 24) |
+		     (info->cmap.green[bg_idx] << 16) |
+		     (info->cmap.blue[bg_idx] << 8);
+
+		wait_for_fifo(2, par);
+		aty_st_le32(CUR_CLR0, bg, par);
+		aty_st_le32(CUR_CLR1, fg, par);
+	}
=20
=2D	aty_set_cursor(info);
=2D	cursor->image.dx =3D info->cursor.image.dx;
=2D	cursor->image.dy =3D info->cursor.image.dy;
+	if (cursor->set & FB_CUR_SETSHAPE) {
+	    u8 *src =3D (u8 *)cursor->image.data;
+	    u8 *msk =3D (u8 *)info->cursor.mask;
+	    u8 *dst =3D (u8 *)info->sprite.addr;
+	    unsigned int width =3D (info->cursor.image.width + 7) >> 3;
+	    unsigned int height =3D info->cursor.image.height;
+	    unsigned int align =3D info->sprite.scan_align;
+
+	    unsigned int i, j, offset;
+	    u8 m, b;
+
+	    // Clear cursor image with 1010101010...
+	    fb_memset(dst, 0xaa, 1024);
+
+	    offset =3D align - width*2;
+
+	    for (i =3D 0; i < height; i++) {
+		for (j =3D 0; j < width; j++) {
+			b =3D *src++;
+			m =3D *msk++;
+			switch (info->cursor.rop) {
+			case ROP_XOR:
+			    // Upper 4 bits of mask data
+			    fb_writeb(cursor_mask_lookup[m >> 4 ] |
+				cursor_bits_lookup[(b ^ m) >> 4], dst++);
+			    // Lower 4 bits of mask
+			    fb_writeb(cursor_mask_lookup[m & 0x0f ] |
+				cursor_bits_lookup[(b ^ m) & 0x0f], dst++);
+			    break;
+			case ROP_COPY:
+			    // Upper 4 bits of mask data
+			    fb_writeb(cursor_mask_lookup[m >> 4 ] |
+				cursor_bits_lookup[(b & m) >> 4], dst++);
+			    // Lower 4 bits of mask
+			    fb_writeb(cursor_mask_lookup[m & 0x0f ] |
+				cursor_bits_lookup[(b & m) & 0x0f], dst++);
+			    break;
+			}
+		}
+		dst +=3D offset;
+	    }
+	}
=20
=2D	aty_set_cursor(info);
+	if (cursor->enable) {
+		wait_for_fifo(1, par);
+		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
+			    | HWCURSOR_ENABLE, par);
+	}
 	return 0;
 }
=20
=2Dstruct aty_cursor *__init aty_init_cursor(struct fb_info *info)
+int __init aty_init_cursor(struct fb_info *info)
 {
=2D	struct aty_cursor *cursor;
 	unsigned long addr;
=20
=2D	cursor =3D kmalloc(sizeof(struct aty_cursor), GFP_ATOMIC);
=2D	if (!cursor)
=2D		return NULL;
=2D	memset(cursor, 0, sizeof(*cursor));
=2D
 	info->fix.smem_len -=3D PAGE_SIZE;
=20
 #ifdef __sparc__
 	addr =3D (unsigned long) info->screen_base - 0x800000 + info->fix.smem_le=
n;
=2D	cursor->ram =3D (u8 *) addr;
+	info->sprite.addr =3D (u8 *) addr;
 #else
 #ifdef __BIG_ENDIAN
 	addr =3D info->fix.smem_start - 0x800000 + info->fix.smem_len;
=2D	cursor->ram =3D (u8 *) ioremap(addr, 1024);
+	info->sprite.addr =3D (u8 *) ioremap(addr, 1024);
 #else
 	addr =3D (unsigned long) info->screen_base + info->fix.smem_len;
=2D	cursor->ram =3D (u8 *) addr;
+	info->sprite.addr =3D (u8 *) addr;
 #endif
 #endif
=2D	if (!cursor->ram) {
=2D		kfree(cursor);
=2D		return NULL;
=2D	}
=2D	return cursor;
=2D}
+	if (!info->sprite.addr)
+		return -ENXIO;
+	info->sprite.size =3D PAGE_SIZE;
+	info->sprite.scan_align =3D 16;	/* Scratch pad 64 bytes wide */
+	info->sprite.buf_align =3D 16; 	/* and 64 lines tall. */
+	info->sprite.flags =3D FB_PIXMAP_IO;
=20
=2Dint atyfb_set_font(struct fb_info *info, int width, int height)
=2D{
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	struct fb_cursor *cursor =3D &info->cursor;
=2D	struct aty_cursor *c =3D par->cursor;
=2D	int i, j;
=2D
=2D	if (c) {
=2D		if (!width || !height) {
=2D			width =3D 8;
=2D			height =3D 16;
=2D		}
=2D
=2D		cursor->hot.x =3D 0;
=2D		cursor->hot.y =3D 0;
=2D		cursor->image.width =3D width;
=2D		cursor->image.height =3D height;
=2D
=2D		memset(c->bits, 0xff, sizeof(c->bits));
=2D		memset(c->mask, 0, sizeof(c->mask));
=2D
=2D		for (i =3D 0, j =3D width; j >=3D 0; j -=3D 8, i++) {
=2D			c->mask[i][height - 2] =3D
=2D			    (j >=3D 8) ? 0xff : (0xff << (8 - j));
=2D			c->mask[i][height - 1] =3D
=2D			    (j >=3D 8) ? 0xff : (0xff << (8 - j));
=2D		}
+	info->fbops->fb_cursor =3D atyfb_cursor;
=20
=2D		aty_set_cursor_color(info);
=2D		aty_set_cursor_shape(info);
=2D	}
=2D	return 1;
+	return 0;
 }
+
diff -Nru a/drivers/video/aty/mach64_gx.c b/drivers/video/aty/mach64_gx.c
=2D-- a/drivers/video/aty/mach64_gx.c	2004-10-19 20:22:45 +08:00
+++ b/drivers/video/aty/mach64_gx.c	2004-10-07 06:18:18 +08:00
@@ -121,7 +121,7 @@
 }
=20
 static int aty_var_to_pll_514(const struct fb_info *info, u32 vclk_per,
=2D			      u8 bpp, union aty_pll *pll)
+			      u32 bpp, union aty_pll *pll)
 {
 	/*
 	 *  FIXME: use real calculations instead of using fixed values from the o=
ld
@@ -253,9 +253,9 @@
 	temp =3D aty_ld_8(DAC_CNTL, par);
 	aty_st_8(DAC_CNTL, temp | DAC_EXT_SEL_RS2 | DAC_EXT_SEL_RS3, par);
=20
=2D	if (info->fix.smem_len < MEM_SIZE_1M)
+	if (info->fix.smem_len < ONE_MB)
 		mask =3D 0x04;
=2D	else if (info->fix.smem_len =3D=3D MEM_SIZE_1M)
+	else if (info->fix.smem_len =3D=3D ONE_MB)
 		mask =3D 0x08;
 	else
 		mask =3D 0x0C;
@@ -339,8 +339,8 @@
      *  ATI 18818 / ICS 2595 Clock Chip
      */
=20
=2Dstatic int aty_var_to_pll_18818(const struct fb_info *info,
=2D				u32 vclk_per, u8 bpp, union aty_pll *pll)
+static int aty_var_to_pll_18818(const struct fb_info *info, u32 vclk_per,
+				u32 bpp, union aty_pll *pll)
 {
 	u32 MHz100;		/* in 0.01 MHz */
 	u32 program_bits;
@@ -495,8 +495,8 @@
      *  STG 1703 Clock Chip
      */
=20
=2Dstatic int aty_var_to_pll_1703(const struct fb_info *info,
=2D			       u32 vclk_per, u8 bpp, union aty_pll *pll)
+static int aty_var_to_pll_1703(const struct fb_info *info, u32 vclk_per,
+			       u32 bpp, union aty_pll *pll)
 {
 	u32 mhz100;		/* in 0.01 MHz */
 	u32 program_bits;
@@ -611,8 +611,8 @@
      *  Chrontel 8398 Clock Chip
      */
=20
=2Dstatic int aty_var_to_pll_8398(const struct fb_info *info,
=2D			       u32 vclk_per, u8 bpp, union aty_pll *pll)
+static int aty_var_to_pll_8398(const struct fb_info *info, u32 vclk_per,
+			       u32 bpp, union aty_pll *pll)
 {
 	u32 tempA, tempB, fOut, longMHz100, diff, preDiff;
=20
@@ -736,7 +736,7 @@
      */
=20
 static int aty_var_to_pll_408(const struct fb_info *info, u32 vclk_per,
=2D			      u8 bpp, union aty_pll *pll)
+			      u32 bpp, union aty_pll *pll)
 {
 	u32 mhz100;		/* in 0.01 MHz */
 	u32 program_bits;
diff -Nru a/drivers/video/aty/xlinit.c b/drivers/video/aty/xlinit.c
=2D-- a/drivers/video/aty/xlinit.c	2004-10-19 20:22:54 +08:00
+++ b/drivers/video/aty/xlinit.c	2004-10-07 06:18:18 +08:00
@@ -148,15 +148,15 @@
 static void init_dll(struct atyfb_par *par)
 {
 	// enable DLL
=2D	aty_st_pll(PLL_GEN_CNTL,
=2D		   aty_ld_pll(PLL_GEN_CNTL, par) & 0x7f,
+	aty_st_pll_ct(PLL_GEN_CNTL,
+		   aty_ld_pll_ct(PLL_GEN_CNTL, par) & 0x7f,
 		   par);
=20
 	// reset DLL
=2D	aty_st_pll(DLL_CNTL, 0x82, par);
=2D	aty_st_pll(DLL_CNTL, 0xE2, par);
+	aty_st_pll_ct(DLL_CNTL, 0x82, par);
+	aty_st_pll_ct(DLL_CNTL, 0xE2, par);
 	mdelay(5);
=2D	aty_st_pll(DLL_CNTL, 0x82, par);
+	aty_st_pll_ct(DLL_CNTL, 0x82, par);
 	mdelay(6);
 }
=20
@@ -164,8 +164,8 @@
 			 int hsync_enb)
 {
 	reset_gui(par);
=2D	aty_st_pll(MCLK_FB_DIV, pll->mclk_fb_div, par);
=2D	aty_st_pll(SCLK_FB_DIV, pll->sclk_fb_div, par);
+	aty_st_pll_ct(MCLK_FB_DIV, pll->mclk_fb_div, par);
+	aty_st_pll_ct(SCLK_FB_DIV, pll->sclk_fb_div, par);
=20
 	mdelay(15);
 	init_dll(par);
@@ -177,9 +177,9 @@
 	aty_st_8(CRTC_GEN_CNTL+3,
 		 hsync_enb ? 0x00 : 0x04, par);
=20
=2D	aty_st_pll(SPLL_CNTL2, pll->spll_cntl2, par);
=2D	aty_st_pll(PLL_GEN_CNTL, pll->pll_gen_cntl, par);
=2D	aty_st_pll(PLL_VCLK_CNTL, pll->pll_vclk_cntl, par);
+	aty_st_pll_ct(SPLL_CNTL2, pll->spll_cntl2, par);
+	aty_st_pll_ct(PLL_GEN_CNTL, pll->pll_gen_cntl, par);
+	aty_st_pll_ct(PLL_VCLK_CNTL, pll->pll_vclk_cntl, par);
 }
=20
 int atyfb_xl_init(struct fb_info *info)
@@ -216,31 +216,31 @@
 	if ((err =3D aty_pll_ct.var_to_pll(info, 39726, 8, &pll)))
 		return err;
=20
=2D	aty_st_pll(LVDS_CNTL0, 0x00, par);
=2D	aty_st_pll(DLL2_CNTL, card->dll2_cntl, par);
=2D	aty_st_pll(V2PLL_CNTL, 0x10, par);
=2D	aty_st_pll(MPLL_CNTL, MPLL_GAIN, par);
=2D	aty_st_pll(VPLL_CNTL, VPLL_GAIN, par);
=2D	aty_st_pll(PLL_VCLK_CNTL, 0x00, par);
=2D	aty_st_pll(VFC_CNTL, 0x1B, par);
=2D	aty_st_pll(PLL_REF_DIV, pll.ct.pll_ref_div, par);
=2D	aty_st_pll(PLL_EXT_CNTL, pll.ct.pll_ext_cntl, par);
=2D	aty_st_pll(SPLL_CNTL2, 0x03, par);
=2D	aty_st_pll(PLL_GEN_CNTL, 0x44, par);
+	aty_st_pll_ct(LVDS_CNTL0, 0x00, par);
+	aty_st_pll_ct(DLL2_CNTL, card->dll2_cntl, par);
+	aty_st_pll_ct(V2PLL_CNTL, 0x10, par);
+	aty_st_pll_ct(MPLL_CNTL, MPLL_GAIN, par);
+	aty_st_pll_ct(VPLL_CNTL, VPLL_GAIN, par);
+	aty_st_pll_ct(PLL_VCLK_CNTL, 0x00, par);
+	aty_st_pll_ct(VFC_CNTL, 0x1B, par);
+	aty_st_pll_ct(PLL_REF_DIV, pll.ct.pll_ref_div, par);
+	aty_st_pll_ct(PLL_EXT_CNTL, pll.ct.pll_ext_cntl, par);
+	aty_st_pll_ct(SPLL_CNTL2, 0x03, par);
+	aty_st_pll_ct(PLL_GEN_CNTL, 0x44, par);
=20
 	reset_clocks(par, &pll.ct, 0);
 	mdelay(10);
=20
=2D	aty_st_pll(VCLK_POST_DIV, 0x03, par);
=2D	aty_st_pll(VCLK0_FB_DIV, 0xDA, par);
=2D	aty_st_pll(VCLK_POST_DIV, 0x0F, par);
=2D	aty_st_pll(VCLK1_FB_DIV, 0xF5, par);
=2D	aty_st_pll(VCLK_POST_DIV, 0x3F, par);
=2D	aty_st_pll(PLL_EXT_CNTL, 0x40 | pll.ct.pll_ext_cntl, par);
=2D	aty_st_pll(VCLK2_FB_DIV, 0x00, par);
=2D	aty_st_pll(VCLK_POST_DIV, 0xFF, par);
=2D	aty_st_pll(PLL_EXT_CNTL, 0xC0 | pll.ct.pll_ext_cntl, par);
=2D	aty_st_pll(VCLK3_FB_DIV, 0x00, par);
+	aty_st_pll_ct(VCLK_POST_DIV, 0x03, par);
+	aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par);
+	aty_st_pll_ct(VCLK_POST_DIV, 0x0F, par);
+	aty_st_pll_ct(VCLK1_FB_DIV, 0xF5, par);
+	aty_st_pll_ct(VCLK_POST_DIV, 0x3F, par);
+	aty_st_pll_ct(PLL_EXT_CNTL, 0x40 | pll.ct.pll_ext_cntl, par);
+	aty_st_pll_ct(VCLK2_FB_DIV, 0x00, par);
+	aty_st_pll_ct(VCLK_POST_DIV, 0xFF, par);
+	aty_st_pll_ct(PLL_EXT_CNTL, 0xC0 | pll.ct.pll_ext_cntl, par);
+	aty_st_pll_ct(VCLK3_FB_DIV, 0x00, par);
=20
 	aty_st_8(BUS_CNTL, 0x01, par);
 	aty_st_le32(BUS_CNTL, card->bus_cntl | 0x08000000, par);
@@ -295,7 +295,7 @@
 	aty_st_8(CRTC_GEN_CNTL+3, 0x04, par);
 	mdelay(10);
=20
=2D	aty_st_pll(PLL_YCLK_CNTL, 0x25, par);
+	aty_st_pll_ct(PLL_YCLK_CNTL, 0x25, par);
=20
 	aty_st_le16(CUSTOM_MACRO_CNTL, 0x0179, par);
 	aty_st_le16(CUSTOM_MACRO_CNTL+2, 0x005E, par);
@@ -309,9 +309,9 @@
=20
 	aty_st_8(CONFIG_STAT0, 0xA0 | card->mem_type, par);
=20
=2D	aty_st_pll(PLL_YCLK_CNTL, 0x01, par);
+	aty_st_pll_ct(PLL_YCLK_CNTL, 0x01, par);
 	mdelay(15);
=2D	aty_st_pll(PLL_YCLK_CNTL, card->pll_yclk_cntl, par);
+	aty_st_pll_ct(PLL_YCLK_CNTL, card->pll_yclk_cntl, par);
 	mdelay(1);
 =09
 	reset_clocks(par, &pll.ct, 0);
diff -Nru a/include/video/mach64.h b/include/video/mach64.h
=2D-- a/include/video/mach64.h	2004-10-19 22:44:44 +08:00
+++ b/include/video/mach64.h	2004-10-07 06:18:18 +08:00
@@ -68,6 +68,8 @@
=20
 #define I2C_CNTL_0		0x003C	/* Dword offset 0_0F */
=20
+#define DSTN_CONTROL_LG		0x003C	/* Dword offset 0_0F (LG) */
+
 /* Overscan */
 #define OVR_CLR			0x0040	/* Dword offset 0_10 */
 #define OVR2_CLR		0x0040	/* Dword offset 0_10 */
@@ -101,7 +103,7 @@
 #define CUR_HORZ_VERT_OFF	0x0070	/* Dword offset 0_1C */
 #define CUR2_HORZ_VERT_OFF	0x0070	/* Dword offset 0_1C */
=20
=2D#define CONFIG_PANEL_LG		0x0074	/* Dword offset 0_1D */
+#define CONFIG_PANEL_LG		0x0074	/* Dword offset 0_1D (LG) */
=20
 /* General I/O Control */
 #define GP_IO			0x0078	/* Dword offset 0_1E */
@@ -116,7 +118,31 @@
 #define SCRATCH_REG3		0x008C	/* Dword offset 0_23 */
=20
 /* Clock Control */
=2D#define CLOCK_CNTL		0x0090	/* Dword offset 0_24 */
+#define CLOCK_CNTL			0x0090	/* Dword offset 0_24 */
+/* CLOCK_CNTL register constants CT LAYOUT */
+#define CLOCK_SEL			0x0f
+#define CLOCK_SEL_INTERNAL		0x03
+#define CLOCK_SEL_EXTERNAL		0x0c
+#define CLOCK_DIV			0x30
+#define CLOCK_DIV1			0x00
+#define CLOCK_DIV2			0x10
+#define CLOCK_DIV4			0x20
+#define CLOCK_STROBE			0x40
+/*  ?					0x80 */
+/* CLOCK_CNTL register constants GX LAYOUT */
+#define CLOCK_BIT			0x04	/* For ICS2595 */
+#define CLOCK_PULSE			0x08	/* For ICS2595 */
+/*#define CLOCK_STROBE			0x40 dito as CT */
+#define CLOCK_DATA			0x80
+
+/* For internal PLL(CT) start */
+#define CLOCK_CNTL_ADDR			CLOCK_CNTL + 1
+#define PLL_WR_EN			0x02
+#define PLL_ADDR			0xfc
+#define CLOCK_CNTL_DATA			CLOCK_CNTL + 2
+#define PLL_DATA			0xff
+/* For internal PLL(CT) end */
+
 #define CLOCK_SEL_CNTL		0x0090	/* Dword offset 0_24 */
=20
 /* Configuration */
@@ -129,6 +155,8 @@
 #define LCD_INDEX		0x00A4	/* Dword offset 0_29 */
 #define LCD_DATA		0x00A8	/* Dword offset 0_2A */
=20
+#define HFB_PITCH_ADDR_LG	0x00A8	/* Dword offset 0_2A (LG) */
+
 /* Memory Control */
 #define EXT_MEM_CNTL		0x00AC	/* Dword offset 0_2B */
 #define MEM_CNTL		0x00B0	/* Dword offset 0_2C */
@@ -137,6 +165,8 @@
=20
 #define I2C_CNTL_1		0x00BC	/* Dword offset 0_2F */
=20
+#define LT_GIO_LG		0x00BC	/* Dword offset 0_2F (LG) */
+
 /* DAC Control */
 #define DAC_REGS		0x00C0	/* Dword offset 0_30 */
 #define DAC_W_INDEX		0x00C0	/* Dword offset 0_30 */
@@ -147,14 +177,16 @@
=20
 #define EXT_DAC_REGS		0x00C8	/* Dword offset 0_32 */
=20
+#define HORZ_STRETCHING_LG	0x00C8	/* Dword offset 0_32 (LG) */
+#define VERT_STRETCHING_LG	0x00CC	/* Dword offset 0_33 (LG) */
+
 /* Test and Debug */
 #define GEN_TEST_CNTL		0x00D0	/* Dword offset 0_34 */
=20
 /* Custom Macros */
 #define CUSTOM_MACRO_CNTL	0x00D4	/* Dword offset 0_35 */
=20
=2D#define LCD_GEN_CNTL_LG		0x00D4	/* Dword offset 0_35 */
=2D
+#define LCD_GEN_CNTL_LG		0x00D4	/* Dword offset 0_35 (LG) */
 #define POWER_MANAGEMENT_LG	0x00D8	/* Dword offset 0_36 (LG) */
=20
 /* Configuration */
@@ -558,7 +590,7 @@
 #define CRTC_CSYNC_EN		0x00000010
 #define CRTC_PIX_BY_2_EN	0x00000020	/* unused on RAGE */
 #define CRTC_DISPLAY_DIS	0x00000040
=2D#define CRTC_VGA_XOVERSCAN	0x00000040
+#define CRTC_VGA_XOVERSCAN	0x00000080
=20
 #define CRTC_PIX_WIDTH_MASK	0x00000700
 #define CRTC_PIX_WIDTH_4BPP	0x00000100
@@ -572,25 +604,95 @@
 #define CRTC_PIX_ORDER_MSN_LSN	0x00000000
 #define CRTC_PIX_ORDER_LSN_MSN	0x00000800
=20
+#define CRTC_VSYNC_INT_EN	0x00001000ul	/* XC/XL */
+#define CRTC_VSYNC_INT		0x00002000ul	/* XC/XL */
+#define CRTC_FIFO_OVERFILL	0x0000c000ul	/* VT/GT */
+#define CRTC2_VSYNC_INT_EN	0x00004000ul	/* XC/XL */
+#define CRTC2_VSYNC_INT		0x00008000ul	/* XC/XL */
+
 #define CRTC_FIFO_LWM		0x000f0000
+#define CRTC_HVSYNC_IO_DRIVE	0x00010000	/* XC/XL */
+#define CRTC2_PIX_WIDTH		0x000e0000	/* LTPro */
=20
=2D#define VGA_128KAP_PAGING	0x00100000
=2D#define VFC_SYNC_TRISTATE	0x00200000
+#define CRTC_VGA_128KAP_PAGING	0x00100000
+#define CRTC_VFC_SYNC_TRISTATE	0x00200000	/* VTB/GTB/LT */
+#define CRTC2_EN		0x00200000	/* LTPro */
 #define CRTC_LOCK_REGS		0x00400000
 #define CRTC_SYNC_TRISTATE	0x00800000
=20
 #define CRTC_EXT_DISP_EN	0x01000000
=2D#define CRTC_ENABLE		0x02000000
=2D#define CRTC_DISP_REQ_ENB	0x04000000
=2D#define VGA_ATI_LINEAR		0x08000000
+#define CRTC_EN			0x02000000
+#define CRTC_DISP_REQ_EN	0x04000000
+#define CRTC_VGA_LINEAR		0x08000000
 #define CRTC_VSYNC_FALL_EDGE	0x10000000
=2D#define VGA_TEXT_132		0x20000000
=2D#define VGA_XCRT_CNT_EN		0x40000000
=2D#define VGA_CUR_B_TEST		0x80000000
+#define CRTC_VGA_TEXT_132	0x20000000
+#define CRTC_CNT_EN		0x40000000
+#define CRTC_CUR_B_TEST		0x80000000
=20
 #define CRTC_CRNT_VLINE		0x07f00000
=2D#define CRTC_VBLANK		0x00000001
=20
+#define CRTC_PRESERVED_MASK	0x0001f000
+
+#define CRTC_VBLANK		0x00000001
+#define CRTC_VBLANK_INT_EN	0x00000002
+#define CRTC_VBLANK_INT		0x00000004
+#define CRTC_VBLANK_INT_AK	CRTC_VBLANK_INT
+#define CRTC_VLINE_INT_EN	0x00000008
+#define CRTC_VLINE_INT		0x00000010
+#define CRTC_VLINE_INT_AK	CRTC_VLINE_INT
+#define CRTC_VLINE_SYNC		0x00000020
+#define CRTC_FRAME		0x00000040
+#define SNAPSHOT_INT_EN		0x00000080
+#define SNAPSHOT_INT		0x00000100
+#define SNAPSHOT_INT_AK		SNAPSHOT_INT
+#define I2C_INT_EN		0x00000200
+#define I2C_INT			0x00000400
+#define I2C_INT_AK		I2C_INT
+#define CRTC2_VBLANK		0x00000800
+#define CRTC2_VBLANK_INT_EN	0x00001000
+#define CRTC2_VBLANK_INT	0x00002000
+#define CRTC2_VBLANK_INT_AK	CRTC2_VBLANK_INT
+#define CRTC2_VLINE_INT_EN	0x00004000
+#define CRTC2_VLINE_INT		0x00008000
+#define CRTC2_VLINE_INT_AK	CRTC2_VLINE_INT
+#define CAPBUF0_INT_EN		0x00010000
+#define CAPBUF0_INT		0x00020000
+#define CAPBUF0_INT_AK		CAPBUF0_INT
+#define CAPBUF1_INT_EN		0x00040000
+#define CAPBUF1_INT		0x00080000
+#define CAPBUF1_INT_AK		CAPBUF1_INT
+#define OVERLAY_EOF_INT_EN	0x00100000
+#define OVERLAY_EOF_INT		0x00200000
+#define OVERLAY_EOF_INT_AK	OVERLAY_EOF_INT
+#define ONESHOT_CAP_INT_EN	0x00400000
+#define ONESHOT_CAP_INT		0x00800000
+#define ONESHOT_CAP_INT_AK	ONESHOT_CAP_INT
+#define BUSMASTER_EOL_INT_EN	0x01000000
+#define BUSMASTER_EOL_INT	0x02000000
+#define BUSMASTER_EOL_INT_AK	BUSMASTER_EOL_INT
+#define GP_INT_EN		0x04000000
+#define GP_INT			0x08000000
+#define GP_INT_AK		GP_INT
+#define CRTC2_VLINE_SYNC	0x10000000
+#define SNAPSHOT2_INT_EN	0x20000000
+#define SNAPSHOT2_INT		0x40000000
+#define SNAPSHOT2_INT_AK	SNAPSHOT2_INT
+#define VBLANK_BIT2_INT		0x80000000
+#define VBLANK_BIT2_INT_AK	VBLANK_BIT2_INT
+
+#define CRTC_INT_EN_MASK	(CRTC_VBLANK_INT_EN |	\
+				 CRTC_VLINE_INT_EN |	\
+				 SNAPSHOT_INT_EN |	\
+				 I2C_INT_EN |		\
+				 CRTC2_VBLANK_INT_EN |	\
+				 CRTC2_VLINE_INT_EN |	\
+				 CAPBUF0_INT_EN |	\
+				 CAPBUF1_INT_EN |	\
+				 OVERLAY_EOF_INT_EN |	\
+				 ONESHOT_CAP_INT_EN |	\
+				 BUSMASTER_EOL_INT_EN |	\
+				 GP_INT_EN |		\
+				 SNAPSHOT2_INT_EN)
=20
 /* DAC control values */
=20
@@ -606,6 +708,24 @@
 #define DAC_BLANK_ADJ_1		0x00000800
 #define DAC_BLANK_ADJ_2		0x00001000
=20
+/* DAC control values (my source XL/XC Register reference) */
+#define DAC_OUTPUT_MASK         0x00000001  /* 0 - PAL, 1 - NTSC */
+#define DAC_MISTERY_BIT         0x00000002  /* PS2 ? RS343 ?, EXTRA_BRIGHT=
 for GT */
+#define DAC_BLANKING            0x00000004
+#define DAC_CMP_DISABLE         0x00000008
+#define DAC1_CLK_SEL            0x00000010
+#define PALETTE_ACCESS_CNTL     0x00000020
+#define PALETTE2_SNOOP_EN       0x00000040
+#define DAC_CMP_OUTPUT          0x00000080 /* read only */
+/* #define DAC_8BIT_EN is ok */
+#define CRT_SENSE               0x00000800 /* read only */
+#define CRT_DETECTION_ON        0x00001000
+#define DAC_VGA_ADR_EN          0x00002000
+#define DAC_FEA_CON_EN          0x00004000
+#define DAC_PDWN                0x00008000
+#define DAC_TYPE_MASK           0x00070000 /* read only */
+
+
=20
 /* Mix control values */
=20
@@ -635,6 +755,7 @@
 /* Mach64 engine bit constants - these are typically ORed together */
=20
 /* BUS_CNTL register constants */
+#define BUS_APER_REG_DIS	0x00000010
 #define BUS_FIFO_ERR_ACK	0x00200000
 #define BUS_HOST_ERR_ACK	0x00800000
=20
@@ -652,29 +773,48 @@
 /* DSP_ON_OFF register constants */
 #define DSP_OFF			0x000007ff
 #define DSP_ON			0x07ff0000
+#define VGA_DSP_OFF		DSP_OFF
+#define VGA_DSP_ON		DSP_ON
+#define VGA_DSP_XCLKS_PER_QW	DSP_XCLKS_PER_QW
=20
=2D/* CLOCK_CNTL register constants */
=2D#define CLOCK_SEL		0x0f
=2D#define CLOCK_DIV		0x30
=2D#define CLOCK_DIV1		0x00
=2D#define CLOCK_DIV2		0x10
=2D#define CLOCK_DIV4		0x20
=2D#define CLOCK_STROBE		0x40
=2D#define PLL_WR_EN		0x02
=2D
=2D/* PLL register indices */
+/* PLL register indices and fields */
 #define MPLL_CNTL		0x00
+#define PLL_PC_GAIN		0x07
+#define PLL_VC_GAIN		0x18
+#define PLL_DUTY_CYC		0xE0
 #define VPLL_CNTL		0x01
 #define PLL_REF_DIV		0x02
 #define PLL_GEN_CNTL		0x03
+#define PLL_OVERRIDE		0x01	/* PLL_SLEEP */
+#define PLL_MCLK_RST		0x02	/* PLL_MRESET */
+#define OSC_EN			0x04
+#define EXT_CLK_EN		0x08
+#define FORCE_DCLK_TRI_STATE	0x08    /* VT4 -> */
+#define MCLK_SRC_SEL		0x70
+#define EXT_CLK_CNTL		0x80
+#define DLL_PWDN		0x80    /* VT4 -> */
 #define MCLK_FB_DIV		0x04
 #define PLL_VCLK_CNTL		0x05
+#define PLL_VCLK_SRC_SEL	0x03
+#define PLL_VCLK_RST		0x04
+#define PLL_VCLK_INVERT		0x08
 #define VCLK_POST_DIV		0x06
+#define VCLK0_POST		0x03
+#define VCLK1_POST		0x0C
+#define VCLK2_POST		0x30
+#define VCLK3_POST		0xC0
 #define VCLK0_FB_DIV		0x07
 #define VCLK1_FB_DIV		0x08
 #define VCLK2_FB_DIV		0x09
 #define VCLK3_FB_DIV		0x0A
 #define PLL_EXT_CNTL		0x0B
+#define PLL_XCLK_MCLK_RATIO	0x03
+#define PLL_XCLK_SRC_SEL	0x07
+#define PLL_MFB_TIMES_4_2B	0x08
+#define PLL_VCLK0_XDIV		0x10
+#define PLL_VCLK1_XDIV		0x20
+#define PLL_VCLK2_XDIV		0x40
+#define PLL_VCLK3_XDIV		0x80
 #define DLL_CNTL		0x0C
 #define DLL1_CNTL		0x0C
 #define VFC_CNTL		0x0D
@@ -690,6 +830,9 @@
 #define SPLL_CNTL2		0x17
 #define APLL_STRAPS		0x18
 #define EXT_VPLL_CNTL		0x19
+#define EXT_VPLL_EN		0x04
+#define EXT_VPLL_VGA_EN		0x08
+#define EXT_VPLL_INSYNC		0x10
 #define EXT_VPLL_REF_DIV	0x1A
 #define EXT_VPLL_FB_DIV		0x1B
 #define EXT_VPLL_MSB		0x1C
@@ -708,24 +851,6 @@
 #define PLL_YCLK_CNTL		0x29
 #define PM_DYN_CLK_CNTL		0x2A
=20
=2D/* Fields in PLL registers */
=2D#define PLL_PC_GAIN		0x07
=2D#define PLL_VC_GAIN		0x18
=2D#define PLL_DUTY_CYC		0xE0
=2D#define PLL_OVERRIDE		0x01
=2D#define PLL_MCLK_RST		0x02
=2D#define OSC_EN			0x04
=2D#define EXT_CLK_EN		0x08
=2D#define MCLK_SRC_SEL		0x70
=2D#define EXT_CLK_CNTL		0x80
=2D#define VCLK_SRC_SEL		0x03
=2D#define PLL_VCLK_RST		0x04
=2D#define VCLK_INVERT		0x08
=2D#define VCLK0_POST		0x03
=2D#define VCLK1_POST		0x0C
=2D#define VCLK2_POST		0x30
=2D#define VCLK3_POST		0xC0
=2D
 /* CONFIG_CNTL register constants */
 #define APERTURE_4M_ENABLE	1
 #define APERTURE_8M_ENABLE	2
@@ -811,6 +936,7 @@
 #define MEM_BNDRY_1M		0x00030000
 #define MEM_BNDRY_EN		0x00040000
=20
+#define ONE_MB			0x100000
 /* ATI PCI constants */
 #define PCI_ATI_VENDOR_ID	0x1002
=20
@@ -849,7 +975,19 @@
 #define LI_CHIP_ID	0x4c49	/* RAGE LT PRO */
 #define LP_CHIP_ID	0x4c50	/* RAGE LT PRO */
 #define LT_CHIP_ID	0x4c54	/* RAGE LT */
=2D#define XL_CHIP_ID	0x4752	/* RAGE (XL) */
+
+/* mach64CT family / (Rage XL) class */
+#define GR_CHIP_ID	0x4752	/* RAGE XL, BGA, PCI33 */
+#define GS_CHIP_ID	0x4753	/* RAGE XL, PQFP, PCI33 */
+#define GM_CHIP_ID	0x474d	/* RAGE XL, BGA, AGP 1x,2x */
+#define GN_CHIP_ID	0x474e	/* RAGE XL, PQFP,AGP 1x,2x */
+#define GO_CHIP_ID	0x474f	/* RAGE XL, BGA, PCI66 */
+#define GL_CHIP_ID	0x474c	/* RAGE XL, PQFP, PCI66 */
+
+#define IS_XL(id) ((id)=3D=3DGR_CHIP_ID || (id)=3D=3DGS_CHIP_ID || \
+		   (id)=3D=3DGM_CHIP_ID || (id)=3D=3DGN_CHIP_ID || \
+		   (id)=3D=3DGO_CHIP_ID || (id)=3D=3DGL_CHIP_ID)
+
 #define GT_CHIP_ID	0x4754	/* RAGE (GT) */
 #define GU_CHIP_ID	0x4755	/* RAGE II/II+ (GTB) */
 #define GV_CHIP_ID	0x4756	/* RAGE IIC, PCI */
@@ -860,10 +998,14 @@
 #define GI_CHIP_ID	0x4749	/* RAGE PRO, BGA, PCI33 only */
 #define GP_CHIP_ID	0x4750	/* RAGE PRO, PQFP, PCI33, full 3D */
 #define GQ_CHIP_ID	0x4751	/* RAGE PRO, PQFP, PCI33, limited 3D */
=2D#define LM_CHIP_ID	0x4c4d	/* RAGE Mobility PCI */
=2D#define LN_CHIP_ID	0x4c4e	/* RAGE Mobility AGP */
=20
+#define LM_CHIP_ID	0x4c4d	/* RAGE Mobility AGP, full function */
+#define LN_CHIP_ID	0x4c4e	/* RAGE Mobility AGP */
+#define LR_CHIP_ID	0x4c52	/* RAGE Mobility PCI, full function */
+#define LS_CHIP_ID	0x4c53	/* RAGE Mobility PCI */
=20
+#define IS_MOBILITY(id) ((id)=3D=3DLM_CHIP_ID || (id)=3D=3DLN_CHIP_ID || \
+			(id)=3D=3DLR_CHIP_ID || (id)=3D=3DLS_CHIP_ID)
 /* Mach64 major ASIC revisions */
 #define MACH64_ASIC_NEC_VT_A3		0x08
 #define MACH64_ASIC_NEC_VT_A4		0x48
@@ -889,7 +1031,7 @@
 #define MACH64_UNKNOWN		0
 #define MACH64_GX		1
 #define MACH64_CX		2
=2D#define MACH64_CT		3
+#define MACH64_CT		3Restore
 #define MACH64_ET		4
 #define MACH64_VT		5
 #define MACH64_GT		6
@@ -934,26 +1076,34 @@
 #define DP_CHAIN_32BPP		0x8080
=20
 /* DP_PIX_WIDTH register constants */
=2D#define DST_1BPP		0
=2D#define DST_4BPP		1
=2D#define DST_8BPP		2
=2D#define DST_15BPP		3
=2D#define DST_16BPP		4
=2D#define DST_32BPP		6
=2D#define SRC_1BPP		0
+#define DST_1BPP		0x0
+#define DST_4BPP		0x1
+#define DST_8BPP		0x2
+#define DST_15BPP		0x3
+#define DST_16BPP		0x4
+#define DST_24BPP		0x5
+#define DST_32BPP		0x6
+#define DST_MASK		0xF
+#define SRC_1BPP		0x000
 #define SRC_4BPP		0x100
 #define SRC_8BPP		0x200
 #define SRC_15BPP		0x300
 #define SRC_16BPP		0x400
+#define SRC_24BPP		0x500
 #define SRC_32BPP		0x600
=2D#define HOST_1BPP		0
+#define SRC_MASK		0xF00
+#define DP_HOST_TRIPLE_EN	0x2000
+#define HOST_1BPP		0x00000
 #define HOST_4BPP		0x10000
 #define HOST_8BPP		0x20000
 #define HOST_15BPP		0x30000
 #define HOST_16BPP		0x40000
+#define HOST_24BPP		0x50000
 #define HOST_32BPP		0x60000
+#define HOST_MASK		0xF0000
 #define BYTE_ORDER_MSB_TO_LSB	0
 #define BYTE_ORDER_LSB_TO_MSB	0x1000000
+#define BYTE_ORDER_MASK		0x1000000
=20
 /* DP_MIX register constants */
 #define BKGD_MIX_NOT_D			0
@@ -1027,12 +1177,12 @@
 #define CONTEXT_CMD_DISABLE		0x80000000
=20
 /* GUI_STAT register constants */
=2D#define ENGINE_IDLE		0
=2D#define ENGINE_BUSY		1
=2D#define SCISSOR_LEFT_FLAG	0x10
=2D#define SCISSOR_RIGHT_FLAG	0x20
=2D#define SCISSOR_TOP_FLAG	0x40
=2D#define SCISSOR_BOTTOM_FLAG	0x80
+#define ENGINE_IDLE			0
+#define ENGINE_BUSY			1
+#define SCISSOR_LEFT_FLAG		0x10
+#define SCISSOR_RIGHT_FLAG		0x20
+#define SCISSOR_TOP_FLAG		0x40
+#define SCISSOR_BOTTOM_FLAG		0x80
=20
 /* ATI VGA Extended Regsiters */
 #define sioATIEXT		0x1ce
@@ -1043,6 +1193,7 @@
 #define ATI36			0xb6
=20
 /* VGA Graphics Controller Registers */
+#define R_GENMO			0x3cc
 #define VGAGRA			0x3ce
 #define GRA06			0x06
=20
@@ -1103,7 +1254,7 @@
=20
 /* LCD register indices */
 #define CONFIG_PANEL		0x00
=2D#define LCD_GEN_CTRL		0x01
+#define LCD_GEN_CNTL		0x01
 #define DSTN_CONTROL		0x02
 #define HFB_PITCH_ADDR		0x03
 #define HORZ_STRETCHING		0x04
@@ -1148,11 +1299,79 @@
 #define APC_LUT_MN		0x39
 #define APC_LUT_OP		0x3A
=20
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
+#define DISABLE_PCLK_RESET              0x00000200ul	/* XC/XL */
+#define DIS_HOR_CRT_DIVBY2              0x00000400ul
+#define SCLK_SEL                        0x00000800ul
+#define SCLK_DELAY                      0x0000f000ul
+#define TVCLK_PM_EN                     0x00010000ul
+#define VCLK_DAC_PM_EN                  0x00020000ul
+#define VCLK_LCD_OFF                    0x00040000ul
+#define SELECT_WAIT_4MS                 0x00080000ul
+#define XTALIN_PM_EN                    0x00080000ul	/* XC/XL */
+#define V2CLK_DAC_PM_EN                 0x00100000ul
+#define LVDS_EN                         0x00200000ul
+#define LVDS_PLL_EN                     0x00400000ul
+#define LVDS_PLL_RESET                  0x00800000ul
+#define LVDS_RESERVED_BITS              0x07000000ul
+#define CRTC_RW_SELECT                  0x08000000ul	/* LTPro */
+#define USE_SHADOWED_VEND               0x10000000ul
+#define USE_SHADOWED_ROWCUR             0x20000000ul
+#define SHADOW_EN                       0x40000000ul
+#define SHADOW_RW_EN                  	0x80000000ul
+
+#define LCD_SET_PRIMARY_MASK            0x07FFFBFBul
+
+/* Values in HORZ_STRETCHING */
+#define HORZ_STRETCH_BLEND		0x00000ffful
+#define HORZ_STRETCH_RATIO		0x0000fffful
+#define HORZ_STRETCH_LOOP		0x00070000ul
+#define HORZ_STRETCH_LOOP09		0x00000000ul
+#define HORZ_STRETCH_LOOP11		0x00010000ul
+#define HORZ_STRETCH_LOOP12		0x00020000ul
+#define HORZ_STRETCH_LOOP14		0x00030000ul
+#define HORZ_STRETCH_LOOP15		0x00040000ul
+/*	?				0x00050000ul */
+/*	?				0x00060000ul */
+/*	?				0x00070000ul */
+/*	?				0x00080000ul */
+#define HORZ_PANEL_SIZE			0x0ff00000ul	/* XC/XL */
+/*	?				0x10000000ul */
+#define AUTO_HORZ_RATIO			0x20000000ul	/* XC/XL */
+#define HORZ_STRETCH_MODE		0x40000000ul
+#define HORZ_STRETCH_EN			0x80000000ul
+
+/* Values in VERT_STRETCHING */
+#define VERT_STRETCH_RATIO0		0x000003fful
+#define VERT_STRETCH_RATIO1		0x000ffc00ul
+#define VERT_STRETCH_RATIO2		0x3ff00000ul
+#define VERT_STRETCH_USE0		0x40000000ul
+#define VERT_STRETCH_EN			0x80000000ul
+
+/* Values in EXT_VERT_STRETCH */
+#define VERT_STRETCH_RATIO3		0x000003fful
+#define FORCE_DAC_DATA			0x000000fful
+#define FORCE_DAC_DATA_SEL		0x00000300ul
+#define VERT_STRETCH_MODE		0x00000400ul
+#define VERT_PANEL_SIZE			0x003ff800ul
+#define AUTO_VERT_RATIO			0x00400000ul
+#define USE_AUTO_FP_POS			0x00800000ul
+#define USE_AUTO_LCD_VSYNC		0x01000000ul
+/*	?				0xfe000000ul */
=20
 /* Values in LCD_MISC_CNTL */
=2D#define BIAS_MOD_LEVEL_MASK	0x0000ff00
=2D#define BIAS_MOD_LEVEL_SHIFT	8
=2D#define BLMOD_EN		0x00010000
=2D#define BIASMOD_EN		0x00020000
+#define BIAS_MOD_LEVEL_MASK		0x0000ff00
+#define BIAS_MOD_LEVEL_SHIFT		8
+#define BLMOD_EN			0x00010000
+#define BIASMOD_EN			0x00020000
=20
=2D#endif /* REGMACH64_H */
+#endif				/* REGMACH64_H */






-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
