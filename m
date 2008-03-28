From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 4/7] lxfb: rearrange/rename MSR bitfields
Date: Thu, 27 Mar 2008 20:09:43 -0400
Message-ID: <20080327200943.32c41bb1@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jf29Z-0002ZS-79 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Mar 2008 17:09:05 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jf29X-0000y7-IS
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Mar 2008 17:09:05 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, info-linux@geode.amd.com


Finally, move the MSR bitfields around in lxfb.h, and rename them.
Alas, most of that crap appears to be undocumented.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/geode/lxfb.h     |   52 ++++++++++++++++++++-------------------
 drivers/video/geode/lxfb_ops.c |   37 ++++++++++++++--------------
 2 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/video/geode/lxfb.h b/drivers/video/geode/lxfb.h
index 0e3cb91..b3fbc56 100644
--- a/drivers/video/geode/lxfb.h
+++ b/drivers/video/geode/lxfb.h
@@ -27,31 +27,6 @@ int lx_blank_display(struct fb_info *, int);
 void lx_set_palette_reg(struct fb_info *, unsigned int, unsigned int,
 			unsigned int, unsigned int);
 
-/* MSRS */
-
-#define GLCP_DOTPLL_RESET    (1 << 0)
-#define GLCP_DOTPLL_BYPASS   (1 << 15)
-#define GLCP_DOTPLL_HALFPIX  (1 << 24)
-#define GLCP_DOTPLL_LOCK     (1 << 25)
-
-#define DF_CONFIG_OUTPUT_MASK       0x38
-#define DF_OUTPUT_PANEL             0x08
-#define DF_OUTPUT_CRT               0x00
-#define DF_SIMULTANEOUS_CRT_AND_FP  (1 << 15)
-
-#define DF_DEFAULT_TFT_PAD_SEL_LOW  0xDFFFFFFF
-#define DF_DEFAULT_TFT_PAD_SEL_HIGH 0x0000003F
-
-#define DC_SPARE_DISABLE_CFIFO_HGO         0x00000800
-#define DC_SPARE_VFIFO_ARB_SELECT          0x00000400
-#define DC_SPARE_WM_LPEN_OVRD              0x00000200
-#define DC_SPARE_LOAD_WM_LPEN_MASK         0x00000100
-#define DC_SPARE_DISABLE_INIT_VID_PRI      0x00000080
-#define DC_SPARE_DISABLE_VFIFO_WM          0x00000040
-#define DC_SPARE_DISABLE_CWD_CHECK         0x00000020
-#define DC_SPARE_PIX8_PAN_FIX              0x00000010
-#define DC_SPARE_FIRST_REQ_MASK            0x00000002
-
 
 /* Graphics Processor registers (table 6-29 from the data book) */
 enum gp_registers {
@@ -390,4 +365,31 @@ static inline void write_fp(struct lxfb_par *par, int reg, uint32_t val)
 	writel(val, par->vp_regs + 8*reg + VP_FP_START);
 }
 
+
+/* MSRs are defined in asm/geode.h; their bitfields are here */
+
+#define MSR_GLCP_DOTPLL_LOCK		(1 << 25)	/* r/o */
+#define MSR_GLCP_DOTPLL_HALFPIX		(1 << 24)
+#define MSR_GLCP_DOTPLL_BYPASS		(1 << 15)
+#define MSR_GLCP_DOTPLL_DOTRESET	(1 << 0)
+
+/* note: this is actually the VP's GLD_MSR_CONFIG */
+#define MSR_LX_GLD_MSR_CONFIG_FMT	((1 << 3) | (1 << 4) | (1 << 5))
+#define MSR_LX_GLD_MSR_CONFIG_FMT_FP	(1 << 3)
+#define MSR_LX_GLD_MSR_CONFIG_FMT_CRT	(0)
+#define MSR_LX_GLD_MSR_CONFIG_FPC	(1 << 15)	/* FP *and* CRT */
+
+#define MSR_LX_MSR_PADSEL_TFT_SEL_LOW	0xDFFFFFFF	/* ??? */
+#define MSR_LX_MSR_PADSEL_TFT_SEL_HIGH	0x0000003F	/* ??? */
+
+#define MSR_LX_SPARE_MSR_DIS_CFIFO_HGO	(1 << 11)	/* undocumented */
+#define MSR_LX_SPARE_MSR_VFIFO_ARB_SEL	(1 << 10)	/* undocumented */
+#define MSR_LX_SPARE_MSR_WM_LPEN_OVRD	(1 << 9)	/* undocumented */
+#define MSR_LX_SPARE_MSR_LOAD_WM_LPEN_M	(1 << 8)	/* undocumented */
+#define MSR_LX_SPARE_MSR_DIS_INIT_V_PRI	(1 << 7)	/* undocumented */
+#define MSR_LX_SPARE_MSR_DIS_VIFO_WM	(1 << 6)
+#define MSR_LX_SPARE_MSR_DIS_CWD_CHECK	(1 << 5)	/* undocumented */
+#define MSR_LX_SPARE_MSR_PIX8_PAN_FIX	(1 << 4)	/* undocumented */
+#define MSR_LX_SPARE_MSR_FIRST_REQ_MASK	(1 << 1)	/* undocumented */
+
 #endif
diff --git a/drivers/video/geode/lxfb_ops.c b/drivers/video/geode/lxfb_ops.c
index 6659df7..e042ae7 100644
--- a/drivers/video/geode/lxfb_ops.c
+++ b/drivers/video/geode/lxfb_ops.c
@@ -104,12 +104,12 @@ static void lx_set_dotpll(u32 pllval)
 
 	rdmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
 
-	if ((dotpll_lo & GLCP_DOTPLL_LOCK) && (dotpll_hi == pllval))
+	if ((dotpll_lo & MSR_GLCP_DOTPLL_LOCK) && (dotpll_hi == pllval))
 		return;
 
 	dotpll_hi = pllval;
-	dotpll_lo &= ~(GLCP_DOTPLL_BYPASS | GLCP_DOTPLL_HALFPIX);
-	dotpll_lo |= GLCP_DOTPLL_RESET;
+	dotpll_lo &= ~(MSR_GLCP_DOTPLL_BYPASS | MSR_GLCP_DOTPLL_HALFPIX);
+	dotpll_lo |= MSR_GLCP_DOTPLL_DOTRESET;
 
 	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
 
@@ -121,13 +121,13 @@ static void lx_set_dotpll(u32 pllval)
 
 	for (i = 0; i < 1000; i++) {
 		rdmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
-		if (dotpll_lo & GLCP_DOTPLL_LOCK)
+		if (dotpll_lo & MSR_GLCP_DOTPLL_LOCK)
 			break;
 	}
 
 	/* Clear the reset bit */
 
-	dotpll_lo &= ~GLCP_DOTPLL_RESET;
+	dotpll_lo &= ~MSR_GLCP_DOTPLL_DOTRESET;
 	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
 }
 
@@ -249,8 +249,8 @@ static void lx_graphics_enable(struct fb_info *info)
 		write_fp(par, FP_PT2, FP_PT2_SCRC);
 		write_fp(par, FP_DFC, FP_DFC_BC);
 
-		msrlo = DF_DEFAULT_TFT_PAD_SEL_LOW;
-		msrhi = DF_DEFAULT_TFT_PAD_SEL_HIGH;
+		msrlo = MSR_LX_MSR_PADSEL_TFT_SEL_LOW;
+		msrhi = MSR_LX_MSR_PADSEL_TFT_SEL_HIGH;
 
 		wrmsr(MSR_LX_MSR_PADSEL, msrlo, msrhi);
 	}
@@ -316,18 +316,17 @@ void lx_set_mode(struct fb_info *info)
 	/* Set output mode */
 
 	rdmsrl(MSR_LX_GLD_MSR_CONFIG, msrval);
-	msrval &= ~DF_CONFIG_OUTPUT_MASK;
+	msrval &= ~MSR_LX_GLD_MSR_CONFIG_FMT;
 
 	if (par->output & OUTPUT_PANEL) {
-		msrval |= DF_OUTPUT_PANEL;
+		msrval |= MSR_LX_GLD_MSR_CONFIG_FMT_FP;
 
 		if (par->output & OUTPUT_CRT)
-			msrval |= DF_SIMULTANEOUS_CRT_AND_FP;
+			msrval |= MSR_LX_GLD_MSR_CONFIG_FPC;
 		else
-			msrval &= ~DF_SIMULTANEOUS_CRT_AND_FP;
-	} else {
-		msrval |= DF_OUTPUT_CRT;
-	}
+			msrval &= ~MSR_LX_GLD_MSR_CONFIG_FPC;
+	} else
+		msrval |= MSR_LX_GLD_MSR_CONFIG_FMT_CRT;
 
 	wrmsrl(MSR_LX_GLD_MSR_CONFIG, msrval);
 
@@ -379,10 +378,12 @@ void lx_set_mode(struct fb_info *info)
 
 	rdmsrl(MSR_LX_SPARE_MSR, msrval);
 
-	msrval &= ~(DC_SPARE_DISABLE_CFIFO_HGO | DC_SPARE_VFIFO_ARB_SELECT |
-		    DC_SPARE_LOAD_WM_LPEN_MASK | DC_SPARE_WM_LPEN_OVRD |
-		    DC_SPARE_DISABLE_INIT_VID_PRI | DC_SPARE_DISABLE_VFIFO_WM);
-	msrval |= DC_SPARE_DISABLE_VFIFO_WM | DC_SPARE_DISABLE_INIT_VID_PRI;
+	msrval &= ~(MSR_LX_SPARE_MSR_DIS_CFIFO_HGO
+			| MSR_LX_SPARE_MSR_VFIFO_ARB_SEL
+			| MSR_LX_SPARE_MSR_LOAD_WM_LPEN_M
+			| MSR_LX_SPARE_MSR_WM_LPEN_OVRD);
+	msrval |= MSR_LX_SPARE_MSR_DIS_VIFO_WM |
+			MSR_LX_SPARE_MSR_DIS_INIT_V_PRI;
 	wrmsrl(MSR_LX_SPARE_MSR, msrval);
 
 	gcfg = DC_GENERAL_CFG_DFLE;   /* Display fifo enable */
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
