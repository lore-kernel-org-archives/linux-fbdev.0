From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atyfb on Mach64 GX or Atari
Date: Mon, 1 Dec 2003 21:13:14 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0312012108120.25040-100000@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0309191946400.1979-100000@deadlock.et.tudelft.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQuQe-0003Ya-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Dec 2003 12:13:56 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AQuQd-00029j-VP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Dec 2003 12:13:56 -0800
In-Reply-To: <Pine.LNX.4.44.0309191946400.1979-100000@deadlock.et.tudelft.nl>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>


Here's the latest incarnation of the atyfb fix for Mach64 GX (compiles with
warnings and cannot work) and Atari. 

There's only one chance since the last version I sent in September: the probing
for the crystal frequency is now done for all chips with integrated clock
generator.

---snip---

Atyfb: Make Mach64 GX and Atari support build:
  - ram_resv[] is needed for Mach64 GX, too.
  - Move declaration of v, since it's used for generic LCD only.
  - aty_ld_pll() used to be global, but now it's defined for Mach64 CT only,
    causing a link failure if you don't enable Mach64 CT support. Hence make it
    Mach64 CT dependant.
  - Move declaration of pll_ref_div, since it's used for Mach64 CT only.
  - Probe the crystal for all chips with integrated clock generator, not only
    for chips with a GTB-style DSP.
  - Kill warnings when ioremap()ing in the Atari case.
  - Add missing xres parameter to Mach64 GX aty_var_to_pll_*() routines.

Most of these problems show up on other platforms (e.g. PPC) if you enable
support for  Mach64 GX.

--- linux-2.4.23/drivers/video/aty/atyfb_base.c	Mon Sep 22 08:43:06 2003
+++ linux-m68k-2.4.23/drivers/video/aty/atyfb_base.c	Mon Sep 22 21:51:41 2003
@@ -382,6 +382,7 @@
 
 #if defined(CONFIG_FB_ATY_GX) || defined(CONFIG_FB_ATY_CT)
 static char ram_dram[] __initdata = "DRAM";
+static char ram_resv[] __initdata = "RESV";
 #endif /* CONFIG_FB_ATY_GX || CONFIG_FB_ATY_CT */
 
 #ifdef CONFIG_FB_ATY_GX
@@ -394,7 +395,6 @@
 static char ram_sgram[] __initdata = "SGRAM";
 static char ram_wram[] __initdata = "WRAM";
 static char ram_off[] __initdata = "OFF";
-static char ram_resv[] __initdata = "RESV";
 #endif /* CONFIG_FB_ATY_CT */
 
 #ifdef CONFIG_FB_ATY_GX
@@ -487,8 +487,6 @@
 static void aty_set_crtc(const struct fb_info_aty *info,
                          const struct crtc *crtc)
 {
-    u32 v;
-    
     aty_st_le32(CRTC_H_TOTAL_DISP, crtc->h_tot_disp, info);
     aty_st_le32(CRTC_H_SYNC_STRT_WID, crtc->h_sync_strt_wid, info);
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
@@ -522,6 +520,7 @@
        registers.
      */
     if (info->lcd_table != 0) {
+	u32 v;
         /* Enable/disable horizontal stretching */
         v = aty_ld_lcd(HORZ_STRETCHING, info);
         v = v & ~(HORZ_STRETCH_RATIO | HORZ_STRETCH_EN | AUTO_HORZ_RATIO |
@@ -1984,7 +1983,6 @@
 #if defined(CONFIG_PPC)
     int sense;
 #endif
-    u8 pll_ref_div;
     u32 monitors_enabled;
 
     info->aty_cmap_regs = (struct aty_cmap_regs *)(info->ati_regbase+0xc0);
@@ -2094,19 +2092,24 @@
 
     info->ref_clk_per = 1000000000000ULL/14318180;
     xtal = "14.31818";
-    if (M64_HAS(GTB_DSP) && (pll_ref_div = aty_ld_pll(PLL_REF_DIV, info))) {
-        int diff1, diff2;
-        diff1 = 510*14/pll_ref_div-pll;
-        diff2 = 510*29/pll_ref_div-pll;
-        if (diff1 < 0)
-            diff1 = -diff1;
-        if (diff2 < 0)
-            diff2 = -diff2;
-        if (diff2 < diff1) {
-            info->ref_clk_per = 1000000000000ULL/29498928;
-            xtal = "29.498928";
-        }
+#ifdef CONFIG_FB_ATY_CT
+    if (M64_HAS(INTEGRATED)) {
+	u8 pll_ref_div = aty_ld_pll(PLL_REF_DIV, info);
+	if (pll_ref_div) {
+	    int diff1, diff2;
+	    diff1 = 510*14/pll_ref_div-pll;
+	    diff2 = 510*29/pll_ref_div-pll;
+	    if (diff1 < 0)
+		diff1 = -diff1;
+	    if (diff2 < 0)
+		diff2 = -diff2;
+	    if (diff2 < diff1) {
+		info->ref_clk_per = 1000000000000ULL/29498928;
+		xtal = "29.498928";
+	    }
+	}
     }
+#endif /* CONFIG_FB_ATY_CT */
 
     i = aty_ld_le32(MEM_CNTL, info);
     gtb_memsize = M64_HAS(GTB_DSP);
@@ -2992,9 +2995,11 @@
          *  Map the video memory (physical address given) to somewhere in the
          *  kernel address space.
          */
-        info->frame_buffer = ioremap(phys_vmembase[m64_num], phys_size[m64_num]);
+        info->frame_buffer = (unsigned long)ioremap(phys_vmembase[m64_num],
+						    phys_size[m64_num]);
         info->frame_buffer_phys = info->frame_buffer;  /* Fake! */
-        info->ati_regbase = ioremap(phys_guiregbase[m64_num], 0x10000)+0xFC00ul;
+        info->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
+						   0x10000)+0xFC00ul;
         info->ati_regbase_phys = info->ati_regbase;  /* Fake! */
 
         aty_st_le32(CLOCK_CNTL, 0x12345678, info);
--- linux-2.4.23/drivers/video/aty/mach64_gx.c	Sat Sep 13 16:29:48 2003
+++ linux-m68k-2.4.23/drivers/video/aty/mach64_gx.c	Mon Sep 22 13:01:58 2003
@@ -124,7 +124,7 @@
 }
 
 static int aty_var_to_pll_514(const struct fb_info_aty *info, u32 vclk_per,
-			      u8 bpp, union aty_pll *pll)
+			      u8 bpp, u32 xres, union aty_pll *pll)
 {
     /*
      *  FIXME: use real calculations instead of using fixed values from the old
@@ -325,7 +325,7 @@
      */
 
 static int aty_var_to_pll_18818(const struct fb_info_aty *info, u32 vclk_per,
-				u8 bpp, union aty_pll *pll)
+				u8 bpp, u32 xres, union aty_pll *pll)
 {
     u32 MHz100;		/* in 0.01 MHz */
     u32 program_bits;
@@ -481,7 +481,7 @@
      */
 
 static int aty_var_to_pll_1703(const struct fb_info_aty *info, u32 vclk_per,
-			       u8 bpp, union aty_pll *pll)
+			       u8 bpp, u32 xres, union aty_pll *pll)
 {
     u32 mhz100;			/* in 0.01 MHz */
     u32 program_bits;
@@ -595,7 +595,7 @@
      */
 
 static int aty_var_to_pll_8398(const struct fb_info_aty *info, u32 vclk_per,
-			       u8 bpp, union aty_pll *pll)
+			       u8 bpp, u32 xres, union aty_pll *pll)
 {
     u32 tempA, tempB, fOut, longMHz100, diff, preDiff;
 
@@ -723,7 +723,7 @@
      */
 
 static int aty_var_to_pll_408(const struct fb_info_aty *info, u32 vclk_per,
-			      u8 bpp, union aty_pll *pll)
+			      u8 bpp, u32 xres, union aty_pll *pll)
 {
     u32 mhz100;		/* in 0.01 MHz */
     u32 program_bits;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
