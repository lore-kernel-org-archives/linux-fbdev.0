From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/9] fbdev: Revive BIOS-less booting for Rage XL cards
Date: Tue, 21 Dec 2004 23:33:54 +0800
Message-ID: <20041221213632.289D41A0273@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cgrgg-0007Vq-FO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:36:58 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cgrgf-0002PJ-UE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:36:58 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A3BD1C14A69
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Dec 2004 21:36:44 +0000 (UTC)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The file drivers/video/aty/xlinit.c is currently unused.  This file might be
useful to boot some types of RageXL cards on non-x86 platforms.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Makefile     |    2 ++
 atyfb.h      |   24 +++++++++++++++++++-----
 atyfb_base.c |    5 ++++-
 xlinit.c     |   15 +--------------
 4 files changed, 26 insertions(+), 20 deletions(-)

diff -Nru a/drivers/video/aty/Makefile b/drivers/video/aty/Makefile
--- a/drivers/video/aty/Makefile	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/aty/Makefile	2004-11-23 21:17:17 +08:00
@@ -5,6 +5,8 @@
 atyfb-y				:= atyfb_base.o mach64_accel.o mach64_cursor.o
 atyfb-$(CONFIG_FB_ATY_GX)	+= mach64_gx.o
 atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o
+atyfb-$(CONFIG_FB_ATY_XL_INIT)  += xlinit.o
+
 atyfb-objs			:= $(atyfb-y)
 
 radeonfb-y			:= radeon_base.o radeon_pm.o radeon_monitor.o radeon_accel.o
diff -Nru a/drivers/video/aty/atyfb.h b/drivers/video/aty/atyfb.h
--- a/drivers/video/aty/atyfb.h	2004-10-27 14:58:07 +08:00
+++ b/drivers/video/aty/atyfb.h	2004-11-23 21:17:17 +08:00
@@ -83,13 +83,13 @@
 	u8 pll_gen_cntl;
 	u8 mclk_fb_div;
 	u8 mclk_fb_mult; /* 2 ro 4 */
-/*	u8 sclk_fb_div;*/
+	u8 sclk_fb_div;
 	u8 pll_vclk_cntl;
 	u8 vclk_post_div;
 	u8 vclk_fb_div;
 	u8 pll_ext_cntl;
-/*	u8 ext_vpll_cntl;
-	u8 spll_cntl2;*/
+	u8 ext_vpll_cntl;
+	u8 spll_cntl2;
 	u32 dsp_config; /* Mach64 GTB DSP */
 	u32 dsp_on_off; /* Mach64 GTB DSP */
 	u32 dsp_loop_latency;
@@ -215,7 +215,6 @@
 #define M64F_XL_DLL		0x00080000
 #define M64F_MFB_FORCE_4	0x00100000
 #define M64F_HW_TRIPLE		0x00200000
-
     /*
      *  Register access
      */
@@ -246,6 +245,19 @@
 #endif
 }
 
+static inline void aty_st_le16(int regindex, u16 val,
+			       const struct atyfb_par *par)
+{
+	/* Hack for bloc 1, should be cleanly optimized by compiler */
+	if (regindex >= 0x400)
+		regindex -= 0x800;
+#ifdef CONFIG_ATARI
+	out_le16((volatile u16 *)(par->ati_regbase + regindex), val);
+#else
+	writel(val, par->ati_regbase + regindex);
+#endif
+}
+
 static inline u8 aty_ld_8(int regindex, const struct atyfb_par *par)
 {
 	/* Hack for bloc 1, should be cleanly optimized by compiler */
@@ -343,4 +355,6 @@
 
 extern void aty_reset_engine(const struct atyfb_par *par);
 extern void aty_init_engine(struct atyfb_par *par, struct fb_info *info);
-
+extern int  atyfb_xl_init(struct fb_info *info);
+extern void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par);
+extern u8   aty_ld_pll_ct(int offset, const struct atyfb_par *par);
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2004-12-01 19:35:50 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2004-11-23 21:17:17 +08:00
@@ -2279,9 +2279,12 @@
 		par->dac_ops = &aty_dac_ct;
 		par->pll_ops = &aty_pll_ct;
 		par->bus_type = PCI;
+#ifdef CONFIG_FB_ATY_XL_INIT
+		if (IS_XL(par->pci_id))
+			atyfb_xl_init(info);
+#endif
 		par->ram_type = (aty_ld_le32(CONFIG_STAT0, par) & 0x07);
 		ramname = aty_ct_ram[par->ram_type];
-
 		/* for many chips, the mclk is 67 MHz for SDRAM, 63 MHz otherwise */
 		if (par->pll_limits.mclk == 67 && par->ram_type < SDRAM)
 			par->pll_limits.mclk = 63;
diff -Nru a/drivers/video/aty/xlinit.c b/drivers/video/aty/xlinit.c
--- a/drivers/video/aty/xlinit.c	2004-10-23 02:52:37 +08:00
+++ b/drivers/video/aty/xlinit.c	2004-11-23 21:17:17 +08:00
@@ -105,19 +105,6 @@
 	{ 0x37,	0x00000000 }
 };
 
-static inline u32 aty_ld_lcd(u8 lcd_reg, struct atyfb_par *par)
-{
-	aty_st_8(LCD_INDEX, lcd_reg, par);
-	return aty_ld_le32(LCD_DATA, par);
-}
-
-static inline void aty_st_lcd(u8 lcd_reg, u32 val,
-			      struct atyfb_par *par)
-{
-	aty_st_8(LCD_INDEX, lcd_reg, par);
-	aty_st_le32(LCD_DATA, val, par);
-}
-
 static void reset_gui(struct atyfb_par *par)
 {
 	aty_st_8(GEN_TEST_CNTL+1, 0x01, par);
@@ -205,7 +192,7 @@
 		// the MCLK, XCLK are 120MHz on victoria card
 		par->mclk_per = 1000000/120;
 		par->xclk_per = 1000000/120;
-		par->features &= ~M64F_MFB_TIMES_4;
+		par->features &= ~M64F_MFB_FORCE_4;
 	}
 	
 	/*




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
