From: David Eger <eger@havoc.gtf.org>
Subject: Re: [PATCH] radeonfb: remove reg_lock nonsense
Date: Wed, 7 Jul 2004 03:24:41 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040707072441.GA13160@havoc.gtf.org>
References: <200407051043.i65AhCG13509@mail.osdl.org> <Pine.LNX.4.58.0407051028250.1764@ppc970.osdl.org> <20040706081037.GA9036@havoc.gtf.org> <1089115727.1899.27.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bi6oE-0006SR-Ke
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jul 2004 00:25:38 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bi6oC-0005cc-Q6
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jul 2004 00:25:37 -0700
Content-Disposition: inline
In-Reply-To: <1089115727.1899.27.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Jul 06, 2004 at 07:08:47AM -0500, Benjamin Herrenschmidt wrote:
> 
> > I agree, the patch is horrid.  In fact, now that I really look at it,
> > it seems that the spinlock is totally bogus.  This patch removes it.
> > Details below.
> > 
> > BenH: thoughts, objections?
> 
> The lock is meant to keep writes to the PLL index register followed
> with a read/write of the PLL data register together. It is necessay
> for OUTPLL/INPLL as long as radeonfb can be re-entered.

Hmmm :-/

In that case, I have a patch which implements both of Linus's suggestions,
making OUTPLL()/INPLL() inlines and making the caller responsible for
taking the register lock when calling OUTPLL()/INPLL().

On the upside, the number of lockings goes down from 159 to 24.  
On the downside, that means about 70 more lines of code via:
from 48 spin lock & unlock lines and 17 'flags' decls

I'll leave it up to your discretion whether to apply.

-dte

radeonfb: make the PLL locking the responsibility of the caller,
	so as to avoid grabbing rinfo->reg_lock 100 times during
	a sequence of OUTPLL()'s

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
--- a/drivers/video/aty/radeon_accel.c	2004-07-07 09:11:50 +02:00
+++ b/drivers/video/aty/radeon_accel.c	2004-07-07 09:11:50 +02:00
@@ -147,6 +147,7 @@
 {
 	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset;
 	u32 host_path_cntl;
+	unsigned long flags;
 
 	radeon_engine_flush (rinfo);
 
@@ -156,6 +157,7 @@
      	 * We don't do that on macs, things just work here with dynamic
      	 * clocking... --BenH
 	 */
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 #ifdef CONFIG_ALL_PPC
 	if (_machine != _MACH_Pmac && rinfo->hasCRTC2)
 #else
@@ -237,6 +239,7 @@
 	OUTPLL(MCLK_CNTL, mclk_cntl);
 	if (rinfo->R300_cg_workaround)
 		R300_cg_workardound(rinfo);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 void radeonfb_engine_init (struct radeonfb_info *rinfo)
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2004-07-07 09:11:50 +02:00
+++ b/drivers/video/aty/radeon_base.c	2004-07-07 09:11:50 +02:00
@@ -466,6 +466,7 @@
 	struct timeval start_tv, stop_tv;
 	long total_secs, total_usecs;
 	int i;
+	unsigned long flags;
 
 	/* Ugh, we cut interrupts, bad bad bad, but we want some precision
 	 * here, so... --BenH
@@ -507,6 +508,7 @@
 	vTotal = ((INREG(CRTC_V_TOTAL_DISP) & 0x3ff) + 1);
 	vclk = (long long)hTotal * (long long)vTotal * hz;
 
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	switch((INPLL(PPLL_REF_DIV) & 0x30000) >> 16) {
 	case 0:
 	default:
@@ -574,6 +576,7 @@
 
 	tmp = INPLL(X_MPLL_REF_FB_DIV);
 	ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 
 	Ns = (tmp & 0xff0000) >> 16;
 	Nm = (tmp & 0xff00) >> 8;
@@ -595,13 +598,17 @@
  */
 static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
 {
+	unsigned long flags;
+	
 #ifdef CONFIG_PPC_OF
 	/*
 	 * Retreive PLL infos from Open Firmware first
 	 */
        	if (!force_measure_pll && radeon_read_xtal_OF(rinfo) == 0) {
        		printk(KERN_INFO "radeonfb: Retreived PLL infos from Open Firmware\n");
+				spin_lock_irqsave(&rinfo->reg_lock, flags);
        		rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
+				spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 		/* FIXME: Max clock may be higher on newer chips */
        		rinfo->pll.ppll_min = 12000;
        		rinfo->pll.ppll_max = 35000;
@@ -695,7 +702,9 @@
 		rinfo->pll.ref_clk = 2700;
 		break;
 	}
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 
        	printk(KERN_INFO "radeonfb: Used default PLL infos\n");
 
@@ -1004,6 +1013,7 @@
         struct radeonfb_info *rinfo = info->par;
 	u32 pindex;
 	unsigned int i;
+	unsigned long flags;
 	
 	if (regno > 255)
 		return 1;
@@ -1023,8 +1033,10 @@
         	
 		radeon_fifo_wait(9);
 		if (rinfo->is_mobility) {
+			spin_lock_irqsave(&rinfo->reg_lock, flags);
 			vclk_cntl = INPLL(VCLK_ECP_CNTL);
 			OUTPLL(VCLK_ECP_CNTL, vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
+			spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 		}
 
 		/* Make sure we are on first palette */
@@ -1055,8 +1067,11 @@
 			OUTREG(PALETTE_INDEX, pindex);
 			OUTREG(PALETTE_DATA, (red << 16) | (green << 8) | blue);
 		}
-		if (rinfo->is_mobility)
+		if (rinfo->is_mobility) {
+			spin_lock_irqsave(&rinfo->reg_lock, flags);
 			OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
+			spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+		}
 	}
  	if (regno < 16) {
 		u32 *pal = info->pseudo_palette;
@@ -1082,6 +1097,7 @@
 
 static void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save)
 {
+	unsigned long flags;
 	/* CRTC regs */
 	save->crtc_gen_cntl = INREG(CRTC_GEN_CNTL);
 	save->crtc_ext_cntl = INREG(CRTC_EXT_CNTL);
@@ -1105,13 +1121,18 @@
 	save->lvds_gen_cntl = INREG(LVDS_GEN_CNTL);
 	save->lvds_pll_cntl = INREG(LVDS_PLL_CNTL);
 	save->tmds_crc = INREG(TMDS_CRC);	save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL);
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	save->vclk_ecp_cntl = INPLL(VCLK_ECP_CNTL);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 
 static void radeon_write_pll_regs(struct radeonfb_info *rinfo, struct radeon_regs *mode)
 {
 	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 
 	radeon_fifo_wait(20);
 
@@ -1192,6 +1213,7 @@
 
 	/* Switch back VCLK source to PPLL */
 	OUTPLLP(VCLK_ECP_CNTL, VCLK_SRC_SEL_PPLLCLK, ~VCLK_SRC_SEL_MASK);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 /*
@@ -1199,8 +1221,10 @@
  */
 static void radeon_lvds_timer_func(unsigned long data)
 {
+	unsigned long flags;
 	struct radeonfb_info *rinfo = (struct radeonfb_info *)data;
 
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	radeon_fifo_wait(3);
 
 	OUTREG(LVDS_GEN_CNTL, rinfo->pending_lvds_gen_cntl);
@@ -1208,6 +1232,7 @@
 		OUTPLL(PIXCLKS_CNTL, rinfo->pending_pixclks_cntl);
 		rinfo->pending_pixclks_cntl = 0;
 	}
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 /*
@@ -1219,6 +1244,7 @@
 {
 	int i;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
+	unsigned long flags;
 
 	if (nomodeset)
 		return;
@@ -1279,9 +1305,11 @@
 			    (mode->lvds_gen_cntl & (LVDS_ON | LVDS_BLON))) {
 				OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl);
 			} else {
+				spin_lock_irqsave(&rinfo->reg_lock, flags);
 				rinfo->pending_pixclks_cntl = INPLL(PIXCLKS_CNTL);
 				if (rinfo->is_mobility || rinfo->is_IGP)
 					OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
+				spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 				if (!(tmp & (LVDS_ON | LVDS_BLON)))
 					OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl | LVDS_BLON);
 				rinfo->pending_lvds_gen_cntl = mode->lvds_gen_cntl;
@@ -1295,8 +1323,10 @@
 
 	radeon_screen_blank(rinfo, VESA_NO_BLANKING);
 
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	radeon_fifo_wait(2);
 	OUTPLL(VCLK_ECP_CNTL, mode->vclk_ecp_cntl);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 	
 	return;
 }
@@ -1845,12 +1875,17 @@
 {
 	struct radeonfb_info *rinfo = (struct radeonfb_info *)data;
 	unsigned int lvds_gen_cntl = INREG(LVDS_GEN_CNTL);
-	unsigned long tmpPixclksCntl = INPLL(PIXCLKS_CNTL);
+	unsigned long tmpPixclksCntl;
 	int* conv_table;
+	unsigned long flags;
 
 	if (rinfo->mon1_type != MT_LCD)
 		return 0;
 
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	tmpPixclksCntl = INPLL(PIXCLKS_CNTL);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+
 	/* Pardon me for that hack... maybe some day we can figure
 	 * out in what direction backlight should work on a given
 	 * panel ?
@@ -1889,8 +1924,11 @@
 		/* Asic bug, when turning off LVDS_ON, we have to make sure
 		   RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
 		*/
-		if (rinfo->is_mobility || rinfo->is_IGP)
+		if (rinfo->is_mobility || rinfo->is_IGP) {
+			spin_lock_irqsave(&rinfo->reg_lock, flags);
 			OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
+			spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+		}
 		lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
 		lvds_gen_cntl |= (conv_table[0] <<
 				  LVDS_BL_MOD_LEVEL_SHIFT);
@@ -1901,8 +1939,11 @@
 	}
 
 	OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
-	if (rinfo->is_mobility || rinfo->is_IGP)
+	if (rinfo->is_mobility || rinfo->is_IGP) {
+		spin_lock_irqsave(&rinfo->reg_lock, flags);
 		OUTPLL(PIXCLKS_CNTL, tmpPixclksCntl);
+		spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+	}
 	rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
 	rinfo->init_state.lvds_gen_cntl |= (lvds_gen_cntl & LVDS_STATE_MASK);
 
diff -Nru a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeon_monitor.c
--- a/drivers/video/aty/radeon_monitor.c	2004-07-07 09:11:50 +02:00
+++ b/drivers/video/aty/radeon_monitor.c	2004-07-07 09:11:50 +02:00
@@ -293,7 +293,9 @@
 	unsigned long ulOrigCRTC_EXT_CNTL;
 	unsigned long ulData;
 	unsigned long ulMask;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	ulOrigVCLK_ECP_CNTL = INPLL(VCLK_ECP_CNTL);
 
 	ulData              = ulOrigVCLK_ECP_CNTL;
@@ -342,6 +344,7 @@
 	OUTREG(DAC_CNTL,      ulOrigDAC_CNTL     );
 	OUTREG(DAC_EXT_CNTL,  ulOrigDAC_EXT_CNTL );
 	OUTREG(CRTC_EXT_CNTL, ulOrigCRTC_EXT_CNTL);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
     }
 
     return connected ? MT_CRT : MT_NONE;
diff -Nru a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
--- a/drivers/video/aty/radeon_pm.c	2004-07-07 09:11:51 +02:00
+++ b/drivers/video/aty/radeon_pm.c	2004-07-07 09:11:51 +02:00
@@ -38,13 +38,13 @@
 
 void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
 {
-
 	u32 sclk_cntl;
 	u32 mclk_cntl;
 	u32 sclk_more_cntl;
 	
 	u32 vclk_ecp_cntl;
 	u32 pixclks_cntl;
+	unsigned long flags;
 
 	/* Mobility chips only, untested on M9+/M10/11 */
 	if (!rinfo->is_mobility)
@@ -52,6 +52,7 @@
 	if (rinfo->family > CHIP_FAMILY_RV250)
 		return;
 	
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	/* Force Core Clocks */
 	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
 	sclk_cntl |= 	SCLK_CNTL_M6__FORCE_CP|
@@ -106,6 +107,7 @@
 			MCLK_CNTL_M6__FORCE_YCLKA |
 			MCLK_CNTL_M6__FORCE_YCLKB );
     	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
@@ -118,6 +120,7 @@
 	u32 vclk_ecp_cntl;
 	u32 mclk_cntl;
 	u32 mclk_misc;
+	unsigned long flags;
 
 	/* Mobility chips only, untested on M9+/M10/11 */
 	if (!rinfo->is_mobility)
@@ -125,6 +128,7 @@
 	if (rinfo->family > CHIP_FAMILY_RV250)
 		return;
 	
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	/* Set Latencies */
 	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL_M6);
 	
@@ -202,6 +206,7 @@
 			MCLK_MISC__IO_MCLK_DYN_ENABLE;	
 	
 	OUTPLL(pllMCLK_MISC, mclk_misc);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 #ifdef CONFIG_PM
@@ -220,6 +225,9 @@
 
 static void radeon_pm_save_regs(struct radeonfb_info *rinfo)
 {
+	unsigned long flags;
+	
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	rinfo->save_regs[0] = INPLL(PLL_PWRMGT_CNTL);
 	rinfo->save_regs[1] = INPLL(CLK_PWRMGT_CNTL);
 	rinfo->save_regs[2] = INPLL(MCLK_CNTL);
@@ -256,10 +264,14 @@
 	rinfo->save_regs[31] = INREG(DISPLAY_BASE_ADDR);
 	rinfo->save_regs[32] = INREG(MC_AGP_LOCATION);
 	rinfo->save_regs[33] = INREG(CRTC2_DISPLAY_BASE_ADDR);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 static void radeon_pm_restore_regs(struct radeonfb_info *rinfo)
 {
+	unsigned long flags;
+	
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	OUTPLL(P2PLL_CNTL, rinfo->save_regs[8] & 0xFFFFFFFE); /* First */
 	
 	OUTPLL(PLL_PWRMGT_CNTL, rinfo->save_regs[0]);
@@ -301,6 +313,7 @@
 	OUTREG(GPIO_DVI_DDC, rinfo->save_regs[26]);
 	OUTREG(GPIO_MONID, rinfo->save_regs[27]);
 	OUTREG(GPIO_CRT2_DDC, rinfo->save_regs[28]);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 static void radeon_pm_disable_iopad(struct radeonfb_info *rinfo)
@@ -319,27 +332,26 @@
 
 static void radeon_pm_program_v2clk(struct radeonfb_info *rinfo)
 {
-	/* we use __INPLL and _OUTPLL and do the locking ourselves... */
 	unsigned long flags;
 	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	/* Set v2clk to 65MHz */
-  	__OUTPLL(pllPIXCLKS_CNTL,
-  		__INPLL(rinfo, pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
+  	OUTPLL(pllPIXCLKS_CNTL,
+  		INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
 	 
-  	__OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
-	__OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
-	__OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);
+  	OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
+	OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
+	OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);
 	
-	__OUTPLL(pllP2PLL_CNTL,
-		__INPLL(rinfo, pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
+	OUTPLL(pllP2PLL_CNTL,
+		INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
 	mdelay(1);
 
-	__OUTPLL(pllP2PLL_CNTL,
-		__INPLL(rinfo, pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET);
+	OUTPLL(pllP2PLL_CNTL,
+		INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET);
 	mdelay( 1);
 
-  	__OUTPLL(pllPIXCLKS_CNTL,
-  		(__INPLL(rinfo, pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
+  	OUTPLL(pllPIXCLKS_CNTL,
+  		(INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
   		| (0x03 << PIXCLKS_CNTL__PIX2CLK_SRC_SEL__SHIFT));
 	mdelay( 1);	
 	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
@@ -348,18 +360,21 @@
 static void radeon_pm_low_current(struct radeonfb_info *rinfo)
 {
 	u32 reg;
+	unsigned long flags;
 
 	reg  = INREG(BUS_CNTL1);
 	reg &= ~BUS_CNTL1_MOBILE_PLATFORM_SEL_MASK;
 	reg |= BUS_CNTL1_AGPCLK_VALID | (1<<BUS_CNTL1_MOBILE_PLATFORM_SEL_SHIFT);
 	OUTREG(BUS_CNTL1, reg);
 	
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	reg  = INPLL(PLL_PWRMGT_CNTL);
 	reg |= PLL_PWRMGT_CNTL_SPLL_TURNOFF | PLL_PWRMGT_CNTL_PPLL_TURNOFF |
 		PLL_PWRMGT_CNTL_P2PLL_TURNOFF | PLL_PWRMGT_CNTL_TVPLL_TURNOFF;
 	reg &= ~PLL_PWRMGT_CNTL_SU_MCLK_USE_BCLK;
 	reg &= ~PLL_PWRMGT_CNTL_MOBILE_SU;
 	OUTPLL(PLL_PWRMGT_CNTL, reg);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 	
 	reg  = INREG(TV_DAC_CNTL);
 	reg &= ~(TV_DAC_CNTL_BGADJ_MASK |TV_DAC_CNTL_DACADJ_MASK);
@@ -397,8 +412,10 @@
 	u32 pixclks_cntl;
 	u32 disp_mis_cntl;
 	u32 disp_pwr_man;
-	u32 tmp;
-	
+
+	unsigned long flags;
+
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	/* Force Core Clocks */
 	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
 	sclk_cntl |= 	SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT|
@@ -503,9 +520,8 @@
 	
 	clk_pin_cntl &= ~CLK_PIN_CNTL__ACCESS_REGS_IN_SUSPEND;
 
-	/* because both INPLL and OUTPLL take the same lock, that's why. */
-	tmp = INPLL( pllMCLK_MISC) | MCLK_MISC__EN_MCLK_TRISTATE_IN_SUSPEND;
-	OUTPLL( pllMCLK_MISC, tmp);
+	OUTPLL( pllMCLK_MISC, 
+		INPLL( pllMCLK_MISC) | MCLK_MISC__EN_MCLK_TRISTATE_IN_SUSPEND);
 	
 	/* AGP PLL control */
 	OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
@@ -525,9 +541,8 @@
 		| (0x20<<AGP_CNTL__MAX_IDLE_CLK__SHIFT));
 
 	/* ACPI mode */
-	/* because both INPLL and OUTPLL take the same lock, that's why. */
-	tmp = INPLL( pllPLL_PWRMGT_CNTL) & ~PLL_PWRMGT_CNTL__PM_MODE_SEL;
-	OUTPLL( pllPLL_PWRMGT_CNTL, tmp);
+	OUTPLL( pllPLL_PWRMGT_CNTL, 
+		INPLL( pllPLL_PWRMGT_CNTL) & ~PLL_PWRMGT_CNTL__PM_MODE_SEL);
 
 
 	disp_mis_cntl = INREG(DISP_MISC_CNTL);
@@ -591,6 +606,8 @@
 	OUTREG( CRTC_GEN_CNTL, (INREG( CRTC_GEN_CNTL) & ~CRTC_GEN_CNTL__CRTC_EN) | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B);
 	OUTREG( CRTC2_GEN_CNTL, (INREG( CRTC2_GEN_CNTL) & ~CRTC2_GEN_CNTL__CRTC2_EN) | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B);
 
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+
 	mdelay(17);				   
 
 }
@@ -648,6 +665,9 @@
 	u32 DLL_CKA_Value = INPLL(pllMDLL_RDCKA) | MDLL_RDCKA__MRDCKA0_SLEEP | MDLL_RDCKA__MRDCKA1_SLEEP | MDLL_RDCKA__MRDCKA0_RESET | MDLL_RDCKA__MRDCKA1_RESET;
 	u32 DLL_CKB_Value = INPLL(pllMDLL_RDCKB) | MDLL_RDCKB__MRDCKB0_SLEEP | MDLL_RDCKB__MRDCKB1_SLEEP | MDLL_RDCKB__MRDCKB0_RESET | MDLL_RDCKB__MRDCKB1_RESET;
 
+	unsigned long flags;
+
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	/* Setting up the DLL range for write */
 	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
 	OUTPLL(pllMDLL_RDCKA,  	DLL_CKA_Value);
@@ -714,6 +734,7 @@
 	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
 	mdelay( DLL_RESET_DELAY);  		
 
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 #undef DLL_RESET_DELAY 
 #undef DLL_SLEEP_DELAY
 }
@@ -778,7 +799,7 @@
 static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 {
 	u16 pwr_cmd;
-	u32 tmp;
+	unsigned long flags;
 
 	if (!rinfo->pm_reg)
 		return;
@@ -814,9 +835,11 @@
 			radeon_pm_setup_for_suspend(rinfo);
 
 			/* Reset the MDLL */
-			/* because both INPLL and OUTPLL take the same lock, that's why. */
-			tmp = INPLL( pllMDLL_CKO) | MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET;
-			OUTPLL( pllMDLL_CKO, tmp );
+			
+			spin_lock_irqsave(&rinfo->reg_lock, flags);
+			OUTPLL( pllMDLL_CKO,
+				INPLL( pllMDLL_CKO) | MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET);
+			spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 		}
 
 		/* Switch PCI power managment to D2. */
diff -Nru a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
--- a/drivers/video/aty/radeonfb.h	2004-07-07 09:11:51 +02:00
+++ b/drivers/video/aty/radeonfb.h	2004-07-07 09:11:51 +02:00
@@ -311,8 +311,8 @@
 	int			asleep;
 	int			lock_blank;
 
-	/* Lock on register access */
-	spinlock_t		reg_lock;
+	/* Lock to keep PLL index + data register sequences together */
+	spinlock_t	reg_lock;
 
 	/* Timer used for delayed LVDS operations */
 	struct timer_list	lvds_timer;
@@ -363,11 +363,11 @@
 	OUTREG(CLOCK_CNTL_INDEX, save);
 }
 
-#define __OUTPLL(addr,val)	\
-	do {	\
-		OUTREG8(CLOCK_CNTL_INDEX, (addr & 0x0000003f) | 0x00000080); \
-		OUTREG(CLOCK_CNTL_DATA, val); \
-} while(0)
+static inline void __OUTPLL(struct radeonfb_info *rinfo, u32 addr, u32 val)
+{
+		OUTREG8(CLOCK_CNTL_INDEX, (addr & 0x0000003f) | 0x00000080);
+		OUTREG(CLOCK_CNTL_DATA, val);
+}
 
 
 static inline u32 __INPLL(struct radeonfb_info *rinfo, u32 addr)
@@ -380,49 +380,27 @@
 	return data;
 }
 
-static inline u32 _INPLL(struct radeonfb_info *rinfo, u32 addr)
-{
-       	unsigned long flags;
-	u32 data;
-
-	spin_lock_irqsave(&rinfo->reg_lock, flags);
-	data = __INPLL(rinfo, addr);
-	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
-	return data;
-}
-
-#define INPLL(addr)		_INPLL(rinfo, addr)
-
-#define OUTPLL(addr,val)	\
-	do {	\
-		unsigned long flags;\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); \
-		__OUTPLL(addr, val); \
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); \
-	} while(0)
+/* WARNING: when calling INPLL() or OUTPLL(), 
+ * you must hold rinfo->reg_lock so the sequencing is not interrupted */
+#define INPLL(addr)       __INPLL(rinfo, addr)
+#define OUTPLL(addr, val) __OUTPLL(rinfo, addr, val)
 
 #define OUTPLLP(addr,val,mask)  					\
 	do {								\
-		unsigned long flags;                                    \
 		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
 		_tmp  = __INPLL(rinfo,addr);				\
 		_tmp &= (mask);						\
 		_tmp |= (val);						\
-		__OUTPLL(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
+		__OUTPLL(rinfo, addr, _tmp);					\
 	} while (0)
 
 #define OUTREGP(addr,val,mask)  					\
 	do {								\
-		unsigned long flags;                                    \
 		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
 		_tmp = INREG(addr);				       	\
 		_tmp &= (mask);						\
 		_tmp |= (val);						\
 		OUTREG(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
 	} while (0)
 
 #define MS_TO_HZ(ms)       ((ms * HZ + 999) / 1000)


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
