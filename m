From: Steve Longerbeam <stevel@mvista.com>
Subject: Re: Compiling Rage xlinit.c
Date: Fri, 14 May 2004 14:28:14 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40A539EE.5050008@mvista.com>
References: <Pine.LNX.4.44.0405110048330.8016-100000@phoenix.infradead.org> <40A14FFC.102@bitworks.com> <40A520E8.20702@bitworks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000500050307000402050402"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOkEF-0001wB-Jf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 14:28:27 -0700
Received: from gateway-1237.mvista.com ([12.44.186.158] helo=av.mvista.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BOkEE-0003S9-51
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 14:28:26 -0700
In-Reply-To: <40A520E8.20702@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: RSmith@bitworks.com
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, source@mvista.com


This is a multi-part message in MIME format.
--------------000500050307000402050402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Richard Smith wrote:

> Richard Smith wrote:
>
>> How does one get the rage xlinit stuff to work.  I've enabled it in 
>> my kernel build but it dosen't seem to be compiled and I don't see in 
>> the Makefile any attempt to compile it.
>>
>
> Nobody responed to this.  Theres no way xlinit.c would have compiled.
>
> Is it still maintained?
>
> stevel@mvista.com is listed at the original author. 


Hi!

What kernel source tree and rev is this? Xlinit.c only supports the
Xpert98 card, nothing else, although it might be a simple matter
to get it working with other RageXL based cards. It has never been
ported to 2.6 either.

 From the above, it sounds as if the original patch got mangled somehow.
I've attached the original patch for 2.4.18.

Steve


--------------000500050307000402050402
Content-Type: text/plain;
 name="atyfb-xpert98-2.4.18.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atyfb-xpert98-2.4.18.patch"

diff -Nuar -X /home/stevel/dontdiff linux-2.4.18.orig/drivers/video/Config.in linux-2.4.18/drivers/video/Config.in
--- linux-2.4.18.orig/drivers/video/Config.in	Thu Mar 28 14:31:54 2002
+++ linux-2.4.18/drivers/video/Config.in	Fri Mar 29 09:58:02 2002
@@ -135,6 +135,9 @@
 	 if [ "$CONFIG_FB_ATY" != "n" ]; then
 	    bool '    Mach64 GX support (EXPERIMENTAL)' CONFIG_FB_ATY_GX
 	    bool '    Mach64 CT/VT/GT/LT (incl. 3D RAGE) support' CONFIG_FB_ATY_CT
+	    if [ "$CONFIG_FB_ATY_CT" != "n" ]; then
+	       bool '    Xpert98 PCI support' CONFIG_FB_XPERT98
+	    fi
 	 fi
  	 tristate '  ATI Radeon display support (EXPERIMENTAL)' CONFIG_FB_RADEON
 	 tristate '  ATI Rage128 display support (EXPERIMENTAL)' CONFIG_FB_ATY128
diff -Nuar -X /home/stevel/dontdiff linux-2.4.18.orig/drivers/video/aty/Makefile linux-2.4.18/drivers/video/aty/Makefile
--- linux-2.4.18.orig/drivers/video/aty/Makefile	Thu Mar 28 14:31:54 2002
+++ linux-2.4.18/drivers/video/aty/Makefile	Fri Mar 29 10:01:31 2002
@@ -6,6 +6,7 @@
 obj-y				:= atyfb_base.o mach64_accel.o
 obj-$(CONFIG_FB_ATY_GX)		+= mach64_gx.o
 obj-$(CONFIG_FB_ATY_CT)		+= mach64_ct.o mach64_cursor.o
+obj-$(CONFIG_FB_XPERT98)	+= xlinit.o
 obj-m				:= $(O_TARGET)
 
 include $(TOPDIR)/Rules.make
diff -Nuar -X /home/stevel/dontdiff linux-2.4.18.orig/drivers/video/aty/atyfb.h linux-2.4.18/drivers/video/aty/atyfb.h
--- linux-2.4.18.orig/drivers/video/aty/atyfb.h	Thu Mar 28 14:31:54 2002
+++ linux-2.4.18/drivers/video/aty/atyfb.h	Fri Mar 29 10:01:31 2002
@@ -43,13 +43,17 @@
     u8 pll_ref_div;
     u8 pll_gen_cntl;
     u8 mclk_fb_div;
+    u8 mclk_fb_mult;    /* 2 or 4 */
+    u8 sclk_fb_div;
     u8 pll_vclk_cntl;
     u8 vclk_post_div;
     u8 vclk_fb_div;
     u8 pll_ext_cntl;
+    u8 spll_cntl2;
     u32 dsp_config;	/* Mach64 GTB DSP */
     u32 dsp_on_off;	/* Mach64 GTB DSP */
     u8 mclk_post_div_real;
+    u8 xclk_post_div_real;
     u8 vclk_post_div_real;
 };
 
@@ -94,6 +98,7 @@
     unsigned long frame_buffer_phys;
     unsigned long frame_buffer;
     unsigned long clk_wr_offset;
+    struct pci_dev *pdev;
     struct pci_mmap_map *mmap_map;
     struct aty_cursor *cursor;
     struct aty_cmap_regs *aty_cmap_regs;
@@ -105,6 +110,7 @@
     u32 ref_clk_per;
     u32 pll_per;
     u32 mclk_per;
+    u32 xclk_per;
     u8 bus_type;
     u8 ram_type;
     u8 mem_refresh_rate;
@@ -163,6 +169,7 @@
 #define M64F_EXTRA_BRIGHT	0x00020000
 #define M64F_LT_SLEEP		0x00040000
 #define M64F_XL_DLL		0x00080000
+#define M64F_MFB_TIMES_4	0x00100000
 
 
     /*
@@ -197,6 +204,34 @@
 #endif
 }
 
+static inline u16 aty_ld_le16(int regindex,
+			      const struct fb_info_aty *info)
+{
+    /* Hack for bloc 1, should be cleanly optimized by compiler */
+    if (regindex >= 0x400)
+    	regindex -= 0x800;
+
+#if defined(__mc68000__)
+    return le16_to_cpu(*((volatile u16 *)(info->ati_regbase+regindex)));
+#else
+    return readw (info->ati_regbase + regindex);
+#endif
+}
+
+static inline void aty_st_le16(int regindex, u16 val,
+			       const struct fb_info_aty *info)
+{
+    /* Hack for bloc 1, should be cleanly optimized by compiler */
+    if (regindex >= 0x400)
+    	regindex -= 0x800;
+
+#if defined(__mc68000__)
+    *((volatile u16 *)(info->ati_regbase+regindex)) = cpu_to_le16(val);
+#else
+    writew (val, info->ati_regbase + regindex);
+#endif
+}
+
 static inline u8 aty_ld_8(int regindex,
 			  const struct fb_info_aty *info)
 {
@@ -228,6 +263,19 @@
     return res;
 }
 
+/*
+ * CT family only.
+ */
+static inline void aty_st_pll(int offset, u8 val,
+			      const struct fb_info_aty *info)
+{
+    /* write addr byte */
+    aty_st_8(CLOCK_CNTL + 1, (offset << 2) | PLL_WR_EN, info);
+    /* write the register value */
+    aty_st_8(CLOCK_CNTL + 2, val, info);
+    aty_st_8(CLOCK_CNTL + 1, (offset << 2) & ~PLL_WR_EN, info);
+}
+
 
     /*
      *  DAC operations
diff -Nuar -X /home/stevel/dontdiff linux-2.4.18.orig/drivers/video/aty/atyfb_base.c linux-2.4.18/drivers/video/aty/atyfb_base.c
--- linux-2.4.18.orig/drivers/video/aty/atyfb_base.c	Thu Mar 28 14:31:54 2002
+++ linux-2.4.18/drivers/video/aty/atyfb_base.c	Fri Mar 29 10:01:31 2002
@@ -225,6 +225,9 @@
 #ifndef MODULE
 int atyfb_setup(char*);
 #endif
+#ifdef CONFIG_FB_XPERT98
+extern int atyfb_xl_init(struct fb_info_aty *info);
+#endif
 
 static int currcon = 0;
 
@@ -252,6 +255,7 @@
 static u32 default_vram __initdata = 0;
 static int default_pll __initdata = 0;
 static int default_mclk __initdata = 0;
+static int default_xclk __initdata = 0;
 
 #ifndef MODULE
 static char *mode_option __initdata = NULL;
@@ -297,7 +301,8 @@
 static char m64n_gtc_bp[] __initdata = "3D RAGE PRO (BGA, PCI)";
 static char m64n_gtc_pp[] __initdata = "3D RAGE PRO (PQFP, PCI)";
 static char m64n_gtc_ppl[] __initdata = "3D RAGE PRO (PQFP, PCI, limited 3D)";
-static char m64n_xl[] __initdata = "3D RAGE (XL)";
+static char m64n_xl_33[] __initdata = "3D RAGE (XL PCI-33MHz)";
+static char m64n_xl_66[] __initdata = "3D RAGE (XL PCI-66MHz)";
 static char m64n_ltp_a[] __initdata = "3D RAGE LT PRO (AGP)";
 static char m64n_ltp_p[] __initdata = "3D RAGE LT PRO (PCI)";
 static char m64n_mob_p[] __initdata = "3D RAGE Mobility (PCI)";
@@ -308,59 +313,64 @@
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
+    { 0x4758, 0x00d7, 0x00, 0x00, m64n_gx,      135,  50, 50, M64F_GX },
+    { 0x4358, 0x0057, 0x00, 0x00, m64n_cx,      135,  50, 50, M64F_GX },
 #endif /* CONFIG_FB_ATY_GX */
 
 #ifdef CONFIG_FB_ATY_CT
     /* Mach64 CT */
-    { 0x4354, 0x4354, 0x00, 0x00, m64n_ct,      135,  60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
-    { 0x4554, 0x4554, 0x00, 0x00, m64n_et,      135,  60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
+    { 0x4354, 0x4354, 0x00, 0x00, m64n_ct,      135,  60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
+    { 0x4554, 0x4554, 0x00, 0x00, m64n_et,      135,  60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
 
     /* Mach64 VT */
-    { 0x5654, 0x5654, 0xc7, 0x00, m64n_vta3,    170,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 },
-    { 0x5654, 0x5654, 0xc7, 0x40, m64n_vta4,    200,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_MAGIC_POSTDIV },
-    { 0x5654, 0x5654, 0x00, 0x00, m64n_vtb,     200,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 },
-    { 0x5655, 0x5655, 0x00, 0x00, m64n_vtb,     200,  67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL },
-    { 0x5656, 0x5656, 0x00, 0x00, m64n_vt4,     230,  83, M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP },
+    { 0x5654, 0x5654, 0xc7, 0x00, m64n_vta3,    170,  67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 },
+    { 0x5654, 0x5654, 0xc7, 0x40, m64n_vta4,    200,  67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_MAGIC_POSTDIV },
+    { 0x5654, 0x5654, 0x00, 0x00, m64n_vtb,     200,  67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 },
+    { 0x5655, 0x5655, 0x00, 0x00, m64n_vtb,     200,  67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL },
+    { 0x5656, 0x5656, 0x00, 0x00, m64n_vt4,     230,  83, 83, M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP },
 
     /* Mach64 GT (3D RAGE) */
-    { 0x4754, 0x4754, 0x07, 0x00, m64n_gt,      135,  63, M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT },
-    { 0x4754, 0x4754, 0x07, 0x01, m64n_gt,      170,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4754, 0x4754, 0x07, 0x02, m64n_gt,      200,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4755, 0x4755, 0x00, 0x00, m64n_gtb,     200,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4756, 0x4756, 0x00, 0x00, m64n_iic_p,   230,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4757, 0x4757, 0x00, 0x00, m64n_iic_a,   230,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x475a, 0x475a, 0x00, 0x00, m64n_iic_a,   230,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4754, 0x4754, 0x07, 0x00, m64n_gt,      135,  63, 63, M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT },
+    { 0x4754, 0x4754, 0x07, 0x01, m64n_gt,      170,  67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4754, 0x4754, 0x07, 0x02, m64n_gt,      200,  67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4755, 0x4755, 0x00, 0x00, m64n_gtb,     200,  67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4756, 0x4756, 0x00, 0x00, m64n_iic_p,   230,  83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4757, 0x4757, 0x00, 0x00, m64n_iic_a,   230,  83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x475a, 0x475a, 0x00, 0x00, m64n_iic_a,   230,  83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 
     /* Mach64 LT */
-    { 0x4c54, 0x4c54, 0x00, 0x00, m64n_lt,      135,  63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP },
-    { 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg,     230,  63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },
+    { 0x4c54, 0x4c54, 0x00, 0x00, m64n_lt,      135,  63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP },
+    { 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg,     230,  63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },
 
     /* Mach64 GTC (3D RAGE PRO) */
-    { 0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba,  230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4744, 0x4744, 0x00, 0x00, m64n_gtc_ba1, 230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4749, 0x4749, 0x00, 0x00, m64n_gtc_bp,  230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_MAGIC_VRAM_SIZE },
-    { 0x4750, 0x4750, 0x00, 0x00, m64n_gtc_pp,  230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-    { 0x4751, 0x4751, 0x00, 0x00, m64n_gtc_ppl, 230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-
-    /* 3D RAGE XL */
-    { 0x4752, 0x4752, 0x00, 0x00, m64n_xl, 230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL },
-
+    { 0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba,  230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4744, 0x4744, 0x00, 0x00, m64n_gtc_ba1, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4749, 0x4749, 0x00, 0x00, m64n_gtc_bp,  230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_MAGIC_VRAM_SIZE },
+    { 0x4750, 0x4750, 0x00, 0x00, m64n_gtc_pp,  230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4751, 0x4751, 0x00, 0x00, m64n_gtc_ppl, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+#ifdef CONFIG_FB_XPERT98
+    /* 3D RAGE XL PCI-66/BGA */
+    { 0x474f, 0x474f, 0x00, 0x00, m64n_xl_66, 230, 83, 63, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL | M64F_MFB_TIMES_4 },
+    /* 3D RAGE XL PCI-33/BGA */
+    { 0x4752, 0x4752, 0x00, 0x00, m64n_xl_33, 230, 83, 63, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL | M64F_MFB_TIMES_4 },
+#else
+    /* 3D RAGE XL PCI-33/BGA */
+    { 0x4752, 0x4752, 0x00, 0x00, m64n_xl_33, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL },
+#endif
     /* Mach64 LT PRO */
-    { 0x4c42, 0x4c42, 0x00, 0x00, m64n_ltp_a,   230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
-    { 0x4c44, 0x4c44, 0x00, 0x00, m64n_ltp_p,   230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
-    { 0x4c49, 0x4c49, 0x00, 0x00, m64n_ltp_p,   230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
-    { 0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p,   230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
+    { 0x4c42, 0x4c42, 0x00, 0x00, m64n_ltp_a,   230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
+    { 0x4c44, 0x4c44, 0x00, 0x00, m64n_ltp_p,   230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
+    { 0x4c49, 0x4c49, 0x00, 0x00, m64n_ltp_p,   230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
+    { 0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p,   230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
 
     /* 3D RAGE Mobility */
-    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   230,  50, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
-    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230,  50, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
+    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   230,  50, 50, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
+    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230,  50, 50, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
 #endif /* CONFIG_FB_ATY_CT */
 };
 
@@ -1249,7 +1259,10 @@
     u32 ref_clk_per;
     u8 pll_ref_div;
     u8 mclk_fb_div;
+    u8 sclk_fb_div;
     u8 mclk_post_div;		/* 1,2,3,4,8 */
+    u8 mclk_fb_mult;            /* 2 or 4 */
+    u8 xclk_post_div;		/* 1,2,3,4,8 */
     u8 vclk_fb_div;
     u8 vclk_post_div;		/* 1,2,3,4,6,8,12 */
     u32 dsp_xclks_per_row;	/* 0-16383 */
@@ -1302,14 +1315,17 @@
 	    clk.ref_clk_per = info->ref_clk_per;
 	    clk.pll_ref_div = pll->ct.pll_ref_div;
 	    clk.mclk_fb_div = pll->ct.mclk_fb_div;
+	    clk.sclk_fb_div = pll->ct.sclk_fb_div;
 	    clk.mclk_post_div = pll->ct.mclk_post_div_real;
+	    clk.mclk_fb_mult = pll->ct.mclk_fb_mult;
+	    clk.xclk_post_div = pll->ct.xclk_post_div_real;
 	    clk.vclk_fb_div = pll->ct.vclk_fb_div;
 	    clk.vclk_post_div = pll->ct.vclk_post_div_real;
 	    clk.dsp_xclks_per_row = dsp_config & 0x3fff;
 	    clk.dsp_loop_latency = (dsp_config>>16) & 0xf;
 	    clk.dsp_precision = (dsp_config>>20) & 7;
-	    clk.dsp_on = dsp_on_off & 0x7ff;
-	    clk.dsp_off = (dsp_on_off>>16) & 0x7ff;
+	    clk.dsp_off = dsp_on_off & 0x7ff;
+	    clk.dsp_on = (dsp_on_off>>16) & 0x7ff;
 	    if (copy_to_user((struct atyclk *)arg, &clk, sizeof(clk)))
 		    return -EFAULT;
 	} else
@@ -1324,14 +1340,17 @@
 	    info->ref_clk_per = clk.ref_clk_per;
 	    pll->ct.pll_ref_div = clk.pll_ref_div;
 	    pll->ct.mclk_fb_div = clk.mclk_fb_div;
+	    pll->ct.sclk_fb_div = clk.sclk_fb_div;
 	    pll->ct.mclk_post_div_real = clk.mclk_post_div;
+	    pll->ct.mclk_fb_mult = clk.mclk_fb_mult;
+	    pll->ct.xclk_post_div_real = clk.xclk_post_div;
 	    pll->ct.vclk_fb_div = clk.vclk_fb_div;
 	    pll->ct.vclk_post_div_real = clk.vclk_post_div;
 	    pll->ct.dsp_config = (clk.dsp_xclks_per_row & 0x3fff) |
 				 ((clk.dsp_loop_latency & 0xf)<<16) |
 				 ((clk.dsp_precision & 7)<<20);
-	    pll->ct.dsp_on_off = (clk.dsp_on & 0x7ff) |
-				 ((clk.dsp_off & 0x7ff)<<16);
+	    pll->ct.dsp_on_off = (clk.dsp_off & 0x7ff) |
+				 ((clk.dsp_on & 0x7ff)<<16);
 	    aty_calc_pll_ct(info, &pll->ct);
 	    aty_set_pll_ct(info, pll);
 	} else
@@ -1751,6 +1770,36 @@
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
 
+static void __init aty_calc_mem_refresh(struct fb_info_aty *info,
+					u16 id,
+					int xclk)
+{
+	int i, size;
+	const int ragepro_tbl[] = {
+		44, 50, 55, 66, 75, 80, 100
+	};
+	const int ragexl_tbl[] = {
+		50, 66, 75, 83, 90, 95, 100, 105,
+		110, 115, 120, 125, 133, 143, 166
+	};
+	const int *refresh_tbl;
+
+	if (IS_XL(id)) {
+		refresh_tbl = ragexl_tbl;
+		size = sizeof(ragexl_tbl)/sizeof(int);
+	} else {
+		refresh_tbl = ragepro_tbl;
+		size = sizeof(ragepro_tbl)/sizeof(int);
+	}
+	
+	for (i=0; i < size; i++) {
+		if (xclk < refresh_tbl[i])
+			break;
+	}
+	
+	info->mem_refresh_rate = i;
+}
+
 
     /*
      *  Initialisation
@@ -1768,12 +1817,12 @@
     u16 type;
     u8 rev;
     const char *chipname = NULL, *ramname = NULL, *xtal;
-    int pll, mclk, gtb_memsize;
+    int pll, mclk, xclk, gtb_memsize;
 #if defined(CONFIG_PPC)
     int sense;
 #endif
     u8 pll_ref_div;
-
+    
     info->aty_cmap_regs = (struct aty_cmap_regs *)(info->ati_regbase+0xc0);
     chip_id = aty_ld_le32(CONFIG_CHIP_ID, info);
     type = chip_id & CFG_CHIP_TYPE;
@@ -1784,6 +1833,7 @@
 	    chipname = aty_chips[j].name;
 	    pll = aty_chips[j].pll;
 	    mclk = aty_chips[j].mclk;
+	    xclk = aty_chips[j].xclk;
 	    info->features = aty_chips[j].features;
 	    goto found;
 	}
@@ -1854,17 +1904,39 @@
 	}
     }
 #endif /* CONFIG_FB_ATY_GX */
+
 #ifdef CONFIG_FB_ATY_CT
     if (M64_HAS(INTEGRATED)) {
-	info->bus_type = PCI;
-	info->ram_type = (aty_ld_le32(CONFIG_STAT0, info) & 0x07);
-	ramname = aty_ct_ram[info->ram_type];
-	info->dac_ops = &aty_dac_ct;
-	info->pll_ops = &aty_pll_ct;
 	/* for many chips, the mclk is 67 MHz for SDRAM, 63 MHz otherwise */
 	if (mclk == 67 && info->ram_type < SDRAM)
 	    mclk = 63;
     }
+#endif
+    
+    if (default_pll)
+	pll = default_pll;
+    if (default_mclk)
+	mclk = default_mclk;
+    if (default_xclk)
+	xclk = default_xclk;
+
+    aty_calc_mem_refresh(info, type, xclk);
+    info->pll_per = 1000000/pll;
+    info->mclk_per = 1000000/mclk;
+    info->xclk_per = 1000000/xclk;
+
+#ifdef CONFIG_FB_ATY_CT
+    if (M64_HAS(INTEGRATED)) {
+	info->dac_ops = &aty_dac_ct;
+	info->pll_ops = &aty_pll_ct;
+	info->bus_type = PCI;
+#ifdef CONFIG_FB_XPERT98
+	if (IS_XL(type))
+		atyfb_xl_init(info);
+#endif
+	info->ram_type = (aty_ld_le32(CONFIG_STAT0, info) & 0x07);
+	ramname = aty_ct_ram[info->ram_type];
+    }
 #endif /* CONFIG_FB_ATY_CT */
 
     info->ref_clk_per = 1000000000000ULL/14318180;
@@ -1954,33 +2026,11 @@
 	    i |= gtb_memsize ? MEM_SIZE_8M_GTB : MEM_SIZE_8M;
 	aty_st_le32(MEM_CNTL, i, info);
     }
-    if (default_pll)
-	pll = default_pll;
-    if (default_mclk)
-	mclk = default_mclk;
 
-    printk("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK\n",
+    printk("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK, %d Mhz XCLK\n",
     	   info->total_vram == 0x80000 ? 512 : (info->total_vram >> 20),
-    	   info->total_vram == 0x80000 ? 'K' : 'M', ramname, xtal, pll, mclk);
-
-    if (mclk < 44)
-	info->mem_refresh_rate = 0;	/* 000 = 10 Mhz - 43 Mhz */
-    else if (mclk < 50)
-	info->mem_refresh_rate = 1;	/* 001 = 44 Mhz - 49 Mhz */
-    else if (mclk < 55)
-	info->mem_refresh_rate = 2;	/* 010 = 50 Mhz - 54 Mhz */
-    else if (mclk < 66)
-	info->mem_refresh_rate = 3;	/* 011 = 55 Mhz - 65 Mhz */
-    else if (mclk < 75)
-	info->mem_refresh_rate = 4;	/* 100 = 66 Mhz - 74 Mhz */
-    else if (mclk < 80)
-	info->mem_refresh_rate = 5;	/* 101 = 75 Mhz - 79 Mhz */
-    else if (mclk < 100)
-	info->mem_refresh_rate = 6;	/* 110 = 80 Mhz - 100 Mhz */
-    else
-	info->mem_refresh_rate = 7;	/* 111 = 100 Mhz and above */
-    info->pll_per = 1000000/pll;
-    info->mclk_per = 1000000/mclk;
+    	   info->total_vram == 0x80000 ? 'K' : 'M', ramname, xtal, pll,
+	   mclk, xclk);
 
 #ifdef DEBUG
     if (M64_HAS(INTEGRATED)) {
@@ -2196,6 +2246,8 @@
 	    if (!request_mem_region(res_start, res_size, "atyfb"))
 		continue;
 
+	    info->pdev = pdev;
+
 #ifdef __sparc__
 	    /*
 	     * Map memory-mapped registers.
@@ -2280,7 +2332,7 @@
 		j++;
 	    }
 
-	    if (pdev->device != XL_CHIP_ID) {
+	    if (!IS_XL(pdev->device)) {
 		    /*
 		     * Fix PROMs idea of MEM_CNTL settings...
 		     */
@@ -2390,7 +2442,7 @@
 		 *
 		 * where R is XTALIN (= 14318 or 29498 kHz).
 		 */
-		if (pdev->device == XL_CHIP_ID)
+		if (IS_XL(pdev->device))
 			R = 29498;
 		else
 			R = 14318;
@@ -2578,6 +2630,8 @@
 		default_pll = simple_strtoul(this_opt+4, NULL, 0);
 	else if (!strncmp(this_opt, "mclk:", 5))
 		default_mclk = simple_strtoul(this_opt+5, NULL, 0);
+	else if (!strncmp(this_opt, "xclk:", 5))
+		default_xclk = simple_strtoul(this_opt+5, NULL, 0);
 #ifdef CONFIG_PPC
 	else if (!strncmp(this_opt, "vmode:", 6)) {
 	    unsigned int vmode = simple_strtoul(this_opt+6, NULL, 0);
diff -Nuar -X /home/stevel/dontdiff linux-2.4.18.orig/drivers/video/aty/mach64.h linux-2.4.18/drivers/video/aty/mach64.h
--- linux-2.4.18.orig/drivers/video/aty/mach64.h	Thu Mar 28 14:31:54 2002
+++ linux-2.4.18/drivers/video/aty/mach64.h	Fri Mar 29 10:01:31 2002
@@ -849,7 +849,18 @@
 #define LI_CHIP_ID	0x4c49	/* RAGE LT PRO */
 #define LP_CHIP_ID	0x4c50	/* RAGE LT PRO */
 #define LT_CHIP_ID	0x4c54	/* RAGE LT */
-#define XL_CHIP_ID	0x4752	/* RAGE (XL) */
+
+#define GR_CHIP_ID	0x4752	/* RAGE XL, BGA, PCI33 */
+#define GS_CHIP_ID	0x4753	/* RAGE XL, PQFP, PCI33 */
+#define GM_CHIP_ID	0x474d	/* RAGE XL, BGA, AGP 1x,2x */
+#define GN_CHIP_ID	0x474e	/* RAGE XL, PQFP,AGP 1x,2x */
+#define GO_CHIP_ID	0x474f	/* RAGE XL, BGA, PCI66 */
+#define GL_CHIP_ID	0x474c	/* RAGE XL, PQFP, PCI66 */
+
+#define IS_XL(id) ((id)==GR_CHIP_ID || (id)==GS_CHIP_ID || \
+                   (id)==GM_CHIP_ID || (id)==GN_CHIP_ID || \
+                   (id)==GO_CHIP_ID || (id)==GL_CHIP_ID)
+
 #define GT_CHIP_ID	0x4754	/* RAGE (GT) */
 #define GU_CHIP_ID	0x4755	/* RAGE II/II+ (GTB) */
 #define GV_CHIP_ID	0x4756	/* RAGE IIC, PCI */
diff -Nuar -X /home/stevel/dontdiff linux-2.4.18.orig/drivers/video/aty/mach64_ct.c linux-2.4.18/drivers/video/aty/mach64_ct.c
--- linux-2.4.18.orig/drivers/video/aty/mach64_ct.c	Thu Mar 28 14:31:54 2002
+++ linux-2.4.18/drivers/video/aty/mach64_ct.c	Fri Mar 29 10:01:31 2002
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fb.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 
@@ -12,15 +13,14 @@
 #include "mach64.h"
 #include "atyfb.h"
 
+#undef DEBUG
 
 /* FIXME: remove the FAIL definition */
 #define FAIL(x) do { printk(x "\n"); return -EINVAL; } while (0)
 
-static void aty_st_pll(int offset, u8 val, const struct fb_info_aty *info);
-
 static int aty_valid_pll_ct(const struct fb_info_aty *info, u32 vclk_per,
 			    struct pll_ct *pll);
-static int aty_dsp_gt(const struct fb_info_aty *info, u8 bpp,
+static int aty_dsp_gt(const struct fb_info_aty *info, u32 bpp,
 		      struct pll_ct *pll);
 static int aty_var_to_pll_ct(const struct fb_info_aty *info, u32 vclk_per,
 			     u8 bpp, union aty_pll *pll);
@@ -28,34 +28,30 @@
 			     const union aty_pll *pll);
 
 
-
-static void aty_st_pll(int offset, u8 val, const struct fb_info_aty *info)
-{
-    /* write addr byte */
-    aty_st_8(CLOCK_CNTL + 1, (offset << 2) | PLL_WR_EN, info);
-    /* write the register value */
-    aty_st_8(CLOCK_CNTL + 2, val, info);
-    aty_st_8(CLOCK_CNTL + 1, (offset << 2) & ~PLL_WR_EN, info);
-}
-
-
 /* ------------------------------------------------------------------------- */
 
     /*
      *  PLL programming (Mach64 CT family)
      */
-
-static int aty_dsp_gt(const struct fb_info_aty *info, u8 bpp,
+static int aty_dsp_gt(const struct fb_info_aty *info, u32 bpp,
 		      struct pll_ct *pll)
 {
     u32 dsp_xclks_per_row, dsp_loop_latency, dsp_precision, dsp_off, dsp_on;
-    u32 xclks_per_row, fifo_off, fifo_on, y, fifo_size, page_size;
+    u32 xclks_per_row, fifo_off, fifo_on, y, fifo_size;
+    u32 memcntl, n, t_pfc, t_rp, t_ras, t_rcd, t_crd, t_rcc, t_lat;
+
+#ifdef DEBUG
+    printk(__FUNCTION__ ": mclk_fb_mult=%d\n", pll->mclk_fb_mult);
+#endif
+    
+    /* (64*xclk/vclk/bpp)<<11 = xclocks_per_row<<11 */
+    xclks_per_row = ((u32)pll->mclk_fb_mult * (u32)pll->mclk_fb_div *
+		     (u32)pll->vclk_post_div_real * 64) << 11;
+    xclks_per_row /=
+	    (2 * (u32)pll->vclk_fb_div * (u32)pll->xclk_post_div_real * bpp);
 
-    /* xclocks_per_row<<11 */
-    xclks_per_row = (pll->mclk_fb_div*pll->vclk_post_div_real*64<<11)/
-		    (pll->vclk_fb_div*pll->mclk_post_div_real*bpp);
     if (xclks_per_row < (1<<11))
-	FAIL("Dotclock to high");
+	FAIL("Dotclock too high");
     if (M64_HAS(FIFO_24)) {
 	fifo_size = 24;
 	dsp_loop_latency = 0;
@@ -70,35 +66,54 @@
 	dsp_precision++;
     }
     dsp_precision -= 5;
+
     /* fifo_off<<6 */
-    fifo_off = ((xclks_per_row*(fifo_size-1))>>5)+(3<<6);
+    fifo_off = ((xclks_per_row*(fifo_size-1))>>5); // + (3<<6);
 
     if (info->total_vram > 1*1024*1024) {
-	if (info->ram_type >= SDRAM) {
+	switch (info->ram_type) {
+	case WRAM:
+	    /* >1 MB WRAM */
+	    dsp_loop_latency += 9;
+	    n = 4;
+	    break;
+	case SDRAM:
+	case SGRAM:
 	    /* >1 MB SDRAM */
 	    dsp_loop_latency += 8;
-	    page_size = 8;
-	} else {
+	    n = 2;
+	    break;
+	default:
 	    /* >1 MB DRAM */
 	    dsp_loop_latency += 6;
-	    page_size = 9;
+	    n = 3;
+	    break;
 	}
     } else {
 	if (info->ram_type >= SDRAM) {
 	    /* <2 MB SDRAM */
 	    dsp_loop_latency += 9;
-	    page_size = 10;
+	    n = 2;
 	} else {
 	    /* <2 MB DRAM */
 	    dsp_loop_latency += 8;
-	    page_size = 10;
+	    n = 3;
 	}
     }
+
+    memcntl = aty_ld_le32(MEM_CNTL, info);
+    t_rcd = ((memcntl >> 10) & 0x03) + 1;
+    t_crd = ((memcntl >> 12) & 0x01);
+    t_rp  = ((memcntl >>  8) & 0x03) + 1;
+    t_ras = ((memcntl >> 16) & 0x07) + 1;
+    t_lat =  (memcntl >>  4) & 0x03;
+    
+    t_pfc = t_rp + t_rcd + t_crd;
+    
+    t_rcc = max(t_rp + t_ras, t_pfc + n);
+    
     /* fifo_on<<6 */
-    if (xclks_per_row >= (page_size<<11))
-	fifo_on = ((2*page_size+1)<<6)+(xclks_per_row>>5);
-    else
-	fifo_on = (3*page_size+2)<<6;
+    fifo_on = (2 * t_rcc + t_pfc + n - 1) << 6;
 
     dsp_xclks_per_row = xclks_per_row>>dsp_precision;
     dsp_on = fifo_on>>dsp_precision;
@@ -107,20 +122,27 @@
     pll->dsp_config = (dsp_xclks_per_row & 0x3fff) |
 		      ((dsp_loop_latency & 0xf)<<16) |
 		      ((dsp_precision & 7)<<20);
-    pll->dsp_on_off = (dsp_on & 0x7ff) | ((dsp_off & 0x7ff)<<16);
+    pll->dsp_on_off = (dsp_off & 0x7ff) | ((dsp_on & 0x7ff)<<16);
     return 0;
 }
 
+
 static int aty_valid_pll_ct(const struct fb_info_aty *info, u32 vclk_per,
 			    struct pll_ct *pll)
 {
+#ifdef DEBUG
+    int pllmclk, pllsclk;
+#endif
     u32 q, x;			/* x is a workaround for sparc64-linux-gcc */
     x = x;			/* x is a workaround for sparc64-linux-gcc */
-
+    
     pll->pll_ref_div = info->pll_per*2*255/info->ref_clk_per;
-
+    
     /* FIXME: use the VTB/GTB /3 post divider if it's better suited */
-    q = info->ref_clk_per*pll->pll_ref_div*4/info->mclk_per;	/* actually 8*q */
+
+    /* actually 8*q */
+    q = info->ref_clk_per*pll->pll_ref_div*4/info->mclk_per;
+
     if (q < 16*8 || q > 255*8)
 	FAIL("mclk out of range");
     else if (q < 32*8)
@@ -131,8 +153,40 @@
 	pll->mclk_post_div_real = 2;
     else
 	pll->mclk_post_div_real = 1;
-    pll->mclk_fb_div = q*pll->mclk_post_div_real/8;
+    pll->sclk_fb_div = q*pll->mclk_post_div_real/8;
+    
+#ifdef DEBUG
+    pllsclk = (1000000 * 2 * pll->sclk_fb_div) /
+	    (info->ref_clk_per * pll->pll_ref_div);
+    printk(__FUNCTION__ ": pllsclk=%d MHz, mclk=%d MHz\n",
+	   pllsclk, pllsclk / pll->mclk_post_div_real);
+#endif
+    
+    pll->mclk_fb_mult = M64_HAS(MFB_TIMES_4) ? 4 : 2;
+
+    /* actually 8*q */
+    q = info->ref_clk_per * pll->pll_ref_div * 8 /
+	    (pll->mclk_fb_mult * info->xclk_per);
 
+    if (q < 16*8 || q > 255*8)
+	FAIL("mclk out of range");
+    else if (q < 32*8)
+	pll->xclk_post_div_real = 8;
+    else if (q < 64*8)
+	pll->xclk_post_div_real = 4;
+    else if (q < 128*8)
+	pll->xclk_post_div_real = 2;
+    else
+	pll->xclk_post_div_real = 1;
+    pll->mclk_fb_div = q*pll->xclk_post_div_real/8;
+    
+#ifdef DEBUG
+    pllmclk = (1000000 * pll->mclk_fb_mult * pll->mclk_fb_div) /
+	    (info->ref_clk_per * pll->pll_ref_div);
+    printk(__FUNCTION__ ": pllmclk=%d MHz, xclk=%d MHz\n",
+	   pllmclk, pllmclk / pll->xclk_post_div_real);
+#endif
+    
     /* FIXME: use the VTB/GTB /{3,6,12} post dividers if they're better suited */
     q = info->ref_clk_per*pll->pll_ref_div*4/vclk_per;	/* actually 8*q */
     if (q < 16*8 || q > 255*8)
@@ -151,13 +205,14 @@
 
 void aty_calc_pll_ct(const struct fb_info_aty *info, struct pll_ct *pll)
 {
+    u8 xpostdiv = 0;
     u8 mpostdiv = 0;
     u8 vpostdiv = 0;
-
+    
     if (M64_HAS(SDRAM_MAGIC_PLL) && (info->ram_type >= SDRAM))
-	pll->pll_gen_cntl = 0x04;
+	    pll->pll_gen_cntl = 0x64; /* mclk = sclk */
     else
-	pll->pll_gen_cntl = 0x84;
+	pll->pll_gen_cntl = 0xe4; /* mclk = sclk */
 
     switch (pll->mclk_post_div_real) {
 	case 1:
@@ -166,9 +221,6 @@
 	case 2:
 	    mpostdiv = 1;
 	    break;
-	case 3:
-	    mpostdiv = 4;
-	    break;
 	case 4:
 	    mpostdiv = 2;
 	    break;
@@ -176,12 +228,34 @@
 	    mpostdiv = 3;
 	    break;
     }
-    pll->pll_gen_cntl |= mpostdiv<<4;	/* mclk */
+
+    pll->spll_cntl2 = mpostdiv << 4; /* sclk == pllsclk / mpostdiv */
+    
+    switch (pll->xclk_post_div_real) {
+	case 1:
+	    xpostdiv = 0;
+	    break;
+	case 2:
+	    xpostdiv = 1;
+	    break;
+	case 3:
+	    xpostdiv = 4;
+	    break;
+	case 4:
+	    xpostdiv = 2;
+	    break;
+	case 8:
+	    xpostdiv = 3;
+	    break;
+    }
 
     if (M64_HAS(MAGIC_POSTDIV))
 	pll->pll_ext_cntl = 0;
     else
-    	pll->pll_ext_cntl = mpostdiv;	/* xclk == mclk */
+	pll->pll_ext_cntl = xpostdiv;	/* xclk == pllmclk / xpostdiv */
+
+    if (pll->mclk_fb_mult == 4)
+	    pll->pll_ext_cntl |= 0x08;
 
     switch (pll->vclk_post_div_real) {
 	case 2:
@@ -234,24 +308,54 @@
 
 void aty_set_pll_ct(const struct fb_info_aty *info, const union aty_pll *pll)
 {
+#ifdef DEBUG
+    printk(__FUNCTION__ ": about to program:\n"
+	   "refdiv=%d, extcntl=0x%02x, mfbdiv=%d\n"
+	   "spllcntl2=0x%02x, sfbdiv=%d, gencntl=0x%02x\n"
+	   "vclkcntl=0x%02x, vpostdiv=0x%02x, vfbdiv=%d\n"
+	   "clocksel=%d\n",
+	   pll->ct.pll_ref_div, pll->ct.pll_ext_cntl,
+	   pll->ct.mclk_fb_div, pll->ct.spll_cntl2,
+	   pll->ct.sclk_fb_div, pll->ct.pll_gen_cntl,
+	   pll->ct.pll_vclk_cntl, pll->ct.vclk_post_div,
+	   pll->ct.vclk_fb_div, aty_ld_le32(CLOCK_CNTL, info) & 0x03);
+#endif
+
     aty_st_pll(PLL_REF_DIV, pll->ct.pll_ref_div, info);
+
+    aty_st_pll(PLL_EXT_CNTL, pll->ct.pll_ext_cntl, info);
+    aty_st_pll(MCLK_FB_DIV, pll->ct.mclk_fb_div, info); // for XCLK
+    
+    aty_st_pll(SPLL_CNTL2, pll->ct.spll_cntl2, info);
+    aty_st_pll(SCLK_FB_DIV, pll->ct.sclk_fb_div, info); // for MCLK
+
     aty_st_pll(PLL_GEN_CNTL, pll->ct.pll_gen_cntl, info);
-    aty_st_pll(MCLK_FB_DIV, pll->ct.mclk_fb_div, info);
+    
+    aty_st_pll(EXT_VPLL_CNTL, 0, info);
     aty_st_pll(PLL_VCLK_CNTL, pll->ct.pll_vclk_cntl, info);
     aty_st_pll(VCLK_POST_DIV, pll->ct.vclk_post_div, info);
     aty_st_pll(VCLK0_FB_DIV, pll->ct.vclk_fb_div, info);
-    aty_st_pll(PLL_EXT_CNTL, pll->ct.pll_ext_cntl, info);
 
     if (M64_HAS(GTB_DSP)) {
+	u8 dll_cntl;
+
 	if (M64_HAS(XL_DLL))
-	    aty_st_pll(DLL_CNTL, 0x80, info);
+	    dll_cntl = 0x80;
 	else if (info->ram_type >= SDRAM)
-	    aty_st_pll(DLL_CNTL, 0xa6, info);
+	    dll_cntl = 0xa6;
 	else
-	    aty_st_pll(DLL_CNTL, 0xa0, info);
+	    dll_cntl = 0xa0;
+	aty_st_pll(DLL_CNTL, dll_cntl, info);
 	aty_st_pll(VFC_CNTL, 0x1b, info);
 	aty_st_le32(DSP_CONFIG, pll->ct.dsp_config, info);
 	aty_st_le32(DSP_ON_OFF, pll->ct.dsp_on_off, info);
+
+	mdelay(10);
+	aty_st_pll(DLL_CNTL, dll_cntl, info);
+	mdelay(10);
+	aty_st_pll(DLL_CNTL, dll_cntl | 0x40, info);
+	mdelay(10);
+	aty_st_pll(DLL_CNTL, dll_cntl & ~0x40, info);
     }
 }
 
diff -Nuar -X /home/stevel/dontdiff linux-2.4.18.orig/drivers/video/aty/xlinit.c linux-2.4.18/drivers/video/aty/xlinit.c
--- linux-2.4.18.orig/drivers/video/aty/xlinit.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/drivers/video/aty/xlinit.c	Fri Mar 29 10:01:31 2002
@@ -0,0 +1,391 @@
+/*
+ *  ATI Rage XL Initialization. Support for Xpert98 and Victoria
+ *  PCI cards.
+ *
+ *  Copyright (C) 2002 MontaVista Software Inc.
+ *  Author: MontaVista Software, Inc.
+ *         	stevel@mvista.com or source@mvista.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h> 
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/selection.h>
+#include <linux/console.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/vt_kern.h>
+#include <linux/kd.h> 
+#include <asm/io.h>
+#include <video/fbcon.h>
+#include "mach64.h"
+#include "atyfb.h"
+
+#define MPLL_GAIN       0xad
+#define VPLL_GAIN       0xd5
+
+#define XPERT98_SUB_ID  0x8008
+#define VICTORIA_SUB_ID 0x0000
+
+enum {
+	VICTORIA = 0,
+	XPERT98,
+	NUM_XL_CARDS
+};
+
+extern const struct aty_pll_ops aty_pll_ct;
+
+static const struct xl_card_cfg_t {
+	int ref_crystal; // 10^4 Hz
+	int mem_type;
+	int mem_size;
+	u32 mem_cntl;
+	u32 ext_mem_cntl;
+	u32 mem_addr_config;
+	u32 bus_cntl;
+	u32 dac_cntl;
+	u32 hw_debug;
+	u32 custom_macro_cntl;
+	u8  dll2_cntl;
+	u8  pll_yclk_cntl;
+} card_cfg[NUM_XL_CARDS] = {
+	// VICTORIA
+	{	2700, SDRAM, 0x800000,
+		0x10757A3B, 0x64000C81, 0x00110202, 0x7b33A040,
+		0x82010102, 0x48803800, 0x005E0179,
+		0x50, 0x25
+	},
+	// XPERT98
+	{	1432,  WRAM, 0x800000,
+		0x00165A2B, 0xE0000CF1, 0x00200213, 0x7333A001,
+		0x8000000A, 0x48833800, 0x007F0779,
+		0x10, 0x19
+	}
+};
+	  
+typedef struct {
+	u8 lcd_reg;
+	u32 val;
+} lcd_tbl_t;
+
+static const lcd_tbl_t lcd_tbl[] = {
+	{ 0x01,	0x000520C0 },
+	{ 0x08,	0x02000408 },
+	{ 0x03,	0x00000F00 },
+	{ 0x00,	0x00000000 },
+	{ 0x02,	0x00000000 },
+	{ 0x04,	0x00000000 },
+	{ 0x05,	0x00000000 },
+	{ 0x06,	0x00000000 },
+	{ 0x33,	0x00000000 },
+	{ 0x34,	0x00000000 },
+	{ 0x35,	0x00000000 },
+	{ 0x36,	0x00000000 },
+	{ 0x37,	0x00000000 }
+};
+
+static inline u32 aty_ld_lcd(u8 lcd_reg, struct fb_info_aty *info)
+{
+	aty_st_8(LCD_INDEX, lcd_reg, info);
+	return aty_ld_le32(LCD_DATA, info);
+}
+
+static inline void aty_st_lcd(u8 lcd_reg, u32 val,
+			      struct fb_info_aty *info)
+{
+	aty_st_8(LCD_INDEX, lcd_reg, info);
+	aty_st_le32(LCD_DATA, val, info);
+}
+
+static void reset_gui(struct fb_info_aty *info)
+{
+	aty_st_8(GEN_TEST_CNTL+1, 0x01, info);
+	aty_st_8(GEN_TEST_CNTL+1, 0x00, info);
+	aty_st_8(GEN_TEST_CNTL+1, 0x02, info);
+	mdelay(5);
+}
+
+
+static void reset_sdram(struct fb_info_aty *info)
+{
+	u8 temp;
+
+	temp = aty_ld_8(EXT_MEM_CNTL, info);
+	temp |= 0x02;
+	aty_st_8(EXT_MEM_CNTL, temp, info); // MEM_SDRAM_RESET = 1b
+	temp |= 0x08;
+	aty_st_8(EXT_MEM_CNTL, temp, info); // MEM_CYC_TEST    = 10b
+	temp |= 0x0c;
+	aty_st_8(EXT_MEM_CNTL, temp, info); // MEM_CYC_TEST    = 11b
+	mdelay(5);
+	temp &= 0xf3;
+	aty_st_8(EXT_MEM_CNTL, temp, info); // MEM_CYC_TEST    = 00b
+	temp &= 0xfd;
+	aty_st_8(EXT_MEM_CNTL, temp, info); // MEM_SDRAM_REST  = 0b
+	mdelay(5);
+}
+
+static void init_dll(struct fb_info_aty *info)
+{
+	// enable DLL
+	aty_st_pll(PLL_GEN_CNTL,
+		   aty_ld_pll(PLL_GEN_CNTL, info) & 0x7f,
+		   info);
+
+	// reset DLL
+	aty_st_pll(DLL_CNTL, 0x82, info);
+	aty_st_pll(DLL_CNTL, 0xE2, info);
+	mdelay(5);
+	aty_st_pll(DLL_CNTL, 0x82, info);
+	mdelay(6);
+}
+
+static void reset_clocks(struct fb_info_aty *info, struct pll_ct *pll,
+			 int hsync_enb)
+{
+	reset_gui(info);
+	aty_st_pll(MCLK_FB_DIV, pll->mclk_fb_div, info);
+	aty_st_pll(SCLK_FB_DIV, pll->sclk_fb_div, info);
+
+	mdelay(15);
+	init_dll(info);
+	aty_st_8(GEN_TEST_CNTL+1, 0x00, info);
+	mdelay(5);
+	aty_st_8(CRTC_GEN_CNTL+3, 0x04, info);
+	mdelay(6);
+	reset_sdram(info);
+	aty_st_8(CRTC_GEN_CNTL+3,
+		 hsync_enb ? 0x00 : 0x04, info);
+
+	aty_st_pll(SPLL_CNTL2, pll->spll_cntl2, info);
+	aty_st_pll(PLL_GEN_CNTL, pll->pll_gen_cntl, info);
+	aty_st_pll(PLL_VCLK_CNTL, pll->pll_vclk_cntl, info);
+}
+
+
+int atyfb_xl_init(struct fb_info_aty *info)
+{
+	int i, err, xl_card;
+	u32 temp;
+	u16 temp16;
+	union aty_pll pll;
+	const struct xl_card_cfg_t * card;
+
+	pci_read_config_word(info->pdev, PCI_SUBSYSTEM_ID, &temp16);
+	switch (temp16) {
+	case XPERT98_SUB_ID:
+		xl_card = XPERT98;
+		break;
+	case VICTORIA_SUB_ID:
+		xl_card = VICTORIA;
+		break;
+	default:
+		printk("\n" __FUNCTION__ ": unknown adapter id 0x%04x\n",
+		       temp16);
+		return -ENODEV;
+	}
+	
+	card = &card_cfg[xl_card];
+
+	aty_st_8(CONFIG_STAT0, 0x85, info);
+	mdelay(10);
+
+	/*
+	 * The following needs to be set before the call
+	 * to var_to_pll() below. They'll be re-set again
+	 * to the same values in aty_init().
+	 */
+	info->ref_clk_per = 100000000UL/card->ref_crystal;
+	info->ram_type = card->mem_type;
+	info->total_vram = card->mem_size;
+	if (xl_card == VICTORIA) {
+		// the MCLK, XCLK are 120MHz on victoria card
+		info->mclk_per = 1000000/120;
+		info->xclk_per = 1000000/120;
+		info->features &= ~M64F_MFB_TIMES_4;
+	}
+
+	/*
+	 * Calculate mclk and xclk dividers, etc. The passed
+	 * pixclock and bpp values don't matter yet, the vclk
+	 * isn't programmed until later.
+	 */
+	if ((err = aty_pll_ct.var_to_pll(info, 39726, 8, &pll)))
+		return err;
+
+	aty_st_pll(LVDS_CNTL0, 0x00, info);
+	aty_st_pll(DLL2_CNTL, card->dll2_cntl, info);
+	aty_st_pll(V2PLL_CNTL, 0x10, info);
+	aty_st_pll(MPLL_CNTL, MPLL_GAIN, info);
+	aty_st_pll(VPLL_CNTL, VPLL_GAIN, info);
+	aty_st_pll(PLL_VCLK_CNTL, 0x00, info);
+	aty_st_pll(VFC_CNTL, 0x1B, info);
+	aty_st_pll(PLL_REF_DIV, pll.ct.pll_ref_div, info);
+	aty_st_pll(PLL_EXT_CNTL, pll.ct.pll_ext_cntl, info);
+	aty_st_pll(SPLL_CNTL2, 0x03, info);
+	aty_st_pll(PLL_GEN_CNTL, 0x44, info);
+
+	reset_clocks(info, &pll.ct, 0);
+	mdelay(10);
+
+	aty_st_pll(VCLK_POST_DIV, 0x03, info);
+	aty_st_pll(VCLK0_FB_DIV, 0xDA, info);
+	aty_st_pll(VCLK_POST_DIV, 0x0F, info);
+	aty_st_pll(VCLK1_FB_DIV, 0xF5, info);
+	aty_st_pll(VCLK_POST_DIV, 0x3F, info);
+	aty_st_pll(PLL_EXT_CNTL, 0x40 | pll.ct.pll_ext_cntl, info);
+	aty_st_pll(VCLK2_FB_DIV, 0x00, info);
+	aty_st_pll(VCLK_POST_DIV, 0xFF, info);
+	aty_st_pll(PLL_EXT_CNTL, 0xC0 | pll.ct.pll_ext_cntl, info);
+	aty_st_pll(VCLK3_FB_DIV, 0x00, info);
+
+	aty_st_8(BUS_CNTL, 0x01, info);
+	aty_st_le32(BUS_CNTL, card->bus_cntl | 0x08000000, info);
+
+	aty_st_le32(CRTC_GEN_CNTL, 0x04000200, info);
+	aty_st_le16(CONFIG_STAT0, 0x0020, info);
+	aty_st_le32(MEM_CNTL, 0x10151A33, info);
+	aty_st_le32(EXT_MEM_CNTL, 0xE0000C01, info);
+	aty_st_le16(CRTC_GEN_CNTL+2, 0x0000, info);
+	aty_st_le32(DAC_CNTL, card->dac_cntl, info);
+	aty_st_le16(GEN_TEST_CNTL, 0x0100, info);
+	aty_st_le32(CUSTOM_MACRO_CNTL, 0x003C0171, info);
+	aty_st_le32(MEM_BUF_CNTL, 0x00382848, info);
+
+	aty_st_le32(HW_DEBUG, card->hw_debug, info);
+	aty_st_le16(MEM_ADDR_CONFIG, 0x0000, info);
+	aty_st_le16(GP_IO+2, 0x0000, info);
+	aty_st_le16(GEN_TEST_CNTL, 0x0000, info);
+	aty_st_le16(EXT_DAC_REGS+2, 0x0000, info);
+	aty_st_le32(CRTC_INT_CNTL, 0x00000000, info);
+	aty_st_le32(TIMER_CONFIG, 0x00000000, info);
+	aty_st_le32(0xEC, 0x00000000, info);
+	aty_st_le32(0xFC, 0x00000000, info);
+
+	for (i=0; i<sizeof(lcd_tbl)/sizeof(lcd_tbl_t); i++) {
+		aty_st_lcd(lcd_tbl[i].lcd_reg, lcd_tbl[i].val, info);
+	}
+
+	aty_st_le16(CONFIG_STAT0, 0x00A4, info);
+	mdelay(10);
+
+	aty_st_8(BUS_CNTL+1, 0xA0, info);
+	mdelay(10);
+	
+	reset_clocks(info, &pll.ct, 1);
+	mdelay(10);
+
+	// something about power management
+	aty_st_8(LCD_INDEX, 0x08, info);
+	aty_st_8(LCD_DATA, 0x0A, info);
+	aty_st_8(LCD_INDEX, 0x08, info);
+	aty_st_8(LCD_DATA+3, 0x02, info);
+	aty_st_8(LCD_INDEX, 0x08, info);
+	aty_st_8(LCD_DATA, 0x0B, info);
+	mdelay(2);
+	
+	// enable display requests, enable CRTC
+	aty_st_8(CRTC_GEN_CNTL+3, 0x02, info);
+	// disable display
+	aty_st_8(CRTC_GEN_CNTL, 0x40, info);
+	// disable display requests, disable CRTC
+	aty_st_8(CRTC_GEN_CNTL+3, 0x04, info);
+	mdelay(10);
+
+	aty_st_pll(PLL_YCLK_CNTL, 0x25, info);
+
+	aty_st_le16(CUSTOM_MACRO_CNTL, 0x0179, info);
+	aty_st_le16(CUSTOM_MACRO_CNTL+2, 0x005E, info);
+	aty_st_le16(CUSTOM_MACRO_CNTL+2, card->custom_macro_cntl>>16, info);
+	aty_st_8(CUSTOM_MACRO_CNTL+1,
+		 (card->custom_macro_cntl>>8) & 0xff, info);
+
+	aty_st_le32(MEM_ADDR_CONFIG, card->mem_addr_config, info);
+	aty_st_le32(MEM_CNTL, card->mem_cntl, info);
+	aty_st_le32(EXT_MEM_CNTL, card->ext_mem_cntl, info);
+
+	aty_st_8(CONFIG_STAT0, 0xA0 | card->mem_type, info);
+
+	aty_st_pll(PLL_YCLK_CNTL, 0x01, info);
+	mdelay(15);
+	aty_st_pll(PLL_YCLK_CNTL, card->pll_yclk_cntl, info);
+	mdelay(1);
+	
+	reset_clocks(info, &pll.ct, 0);
+	mdelay(50);
+	reset_clocks(info, &pll.ct, 0);
+	mdelay(50);
+
+	// enable extended register block
+	aty_st_8(BUS_CNTL+3, 0x7B, info);
+	mdelay(1);
+	// disable extended register block
+	aty_st_8(BUS_CNTL+3, 0x73, info);
+
+	aty_st_8(CONFIG_STAT0, 0x80 | card->mem_type, info);
+
+	// disable display requests, disable CRTC
+	aty_st_8(CRTC_GEN_CNTL+3, 0x04, info);
+	// disable mapping registers in VGA aperture
+	aty_st_8(CONFIG_CNTL, aty_ld_8(CONFIG_CNTL, info) & ~0x04, info);
+	mdelay(50);
+	// enable display requests, enable CRTC
+	aty_st_8(CRTC_GEN_CNTL+3, 0x02, info);
+
+	// make GPIO's 14,15,16 all inputs
+	aty_st_8(LCD_INDEX, 0x07, info);
+	aty_st_8(LCD_DATA+3, 0x00, info);
+
+	// enable the display
+	aty_st_8(CRTC_GEN_CNTL, 0x00, info);
+	mdelay(17);
+	// reset the memory controller
+	aty_st_8(GEN_TEST_CNTL+1, 0x02, info);
+	mdelay(15);
+	aty_st_8(GEN_TEST_CNTL+1, 0x00, info);
+	mdelay(30);
+
+	// enable extended register block
+	aty_st_8(BUS_CNTL+3,
+		 (u8)(aty_ld_8(BUS_CNTL+3, info) | 0x08),
+		 info);
+	// set FIFO size to 512 (PIO)
+	aty_st_le32(GUI_CNTL,
+		    aty_ld_le32(GUI_CNTL, info) & ~0x3,
+		    info);
+
+	// enable CRT and disable lcd
+	aty_st_8(LCD_INDEX, 0x01, info);
+	temp = aty_ld_le32(LCD_DATA, info);
+	temp = (temp | 0x01) & ~0x02;
+	aty_st_le32(LCD_DATA, temp, info);
+
+	return 0;
+}
+

--------------000500050307000402050402--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
