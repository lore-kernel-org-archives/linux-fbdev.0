From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 3/3] pxafb: add support for
	FBIOPAN_DISPLAY by dma braching
Date: Wed, 17 Dec 2008 16:59:43 +0800
Message-ID: <f17812d70812170059k3ab9ca00y1245cda34387df0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LCsFv-0002s7-JJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:59:47 +0000
Received: from rv-out-0708.google.com ([209.85.198.243])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LCsFr-0007QO-Tp for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:59:47 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3407104rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 17 Dec 2008 00:59:43 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

dma branching is enabled by extending the current setup_frame_dma()
function to allow a 2nd set of frame/palette dma descriptors to be
used.

As a result, pxafb_dma_buff.dma_desc[], pxafb_dma_buff.pal_desc[]
and pxafb_info.fdadr[] are doubled.

This allows maximum re-use of the current dma setup code, although
the pxafb_info.fdadr[xx] for FBRx register values looks a bit odd.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/include/mach/regs-lcd.h |   10 ++++-
 drivers/video/pxafb.c                     |   61 +++++++++++++++++++++--------
 drivers/video/pxafb.h                     |    9 +++-
 3 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h
b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index f817878..c15df55 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -12,13 +12,19 @@
 #define LCCR3		(0x00C)	/* LCD Controller Control Register 3 */
 #define LCCR4		(0x010)	/* LCD Controller Control Register 4 */
 #define LCCR5		(0x014)	/* LCD Controller Control Register 5 */
-#define DFBR0		(0x020)	/* DMA Channel 0 Frame Branch Register */
-#define DFBR1		(0x024)	/* DMA Channel 1 Frame Branch Register */
 #define LCSR		(0x038)	/* LCD Controller Status Register */
 #define LIIDR		(0x03C)	/* LCD Controller Interrupt ID Register */
 #define TMEDRGBR	(0x040)	/* TMED RGB Seed Register */
 #define TMEDCR		(0x044)	/* TMED Control Register */

+#define FBR0		(0x020)	/* DMA Channel 0 Frame Branch Register */
+#define FBR1		(0x024)	/* DMA Channel 1 Frame Branch Register */
+#define FBR2		(0x028) /* DMA Channel 2 Frame Branch Register */
+#define FBR3		(0x02C) /* DMA Channel 2 Frame Branch Register */
+#define FBR4		(0x030) /* DMA Channel 2 Frame Branch Register */
+#define FBR5		(0x110) /* DMA Channel 2 Frame Branch Register */
+#define FBR6		(0x114) /* DMA Channel 2 Frame Branch Register */
+
 #define CMDCR		(0x100)	/* Command Control Register */
 #define PRSR		(0x104)	/* Panel Read Status Register */

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index d09c804..d9eac3a 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -71,6 +71,7 @@
 static int pxafb_activate_var(struct fb_var_screeninfo *var,
 				struct pxafb_info *);
 static void set_ctrlr_state(struct pxafb_info *fbi, u_int state);
+static void setup_base_frame(struct pxafb_info *fbi, int branch);

 static unsigned long video_mem_size = 0;

@@ -462,6 +463,24 @@ static int pxafb_set_par(struct fb_info *info)
 	return 0;
 }

+static int pxafb_pan_display(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
+{
+	struct pxafb_info *fbi = (struct pxafb_info *)info;
+	int dma = DMA_MAX + DMA_BASE;
+
+	if (fbi->state != C_ENABLE)
+		return 0;
+
+	setup_base_frame(fbi, 1);
+
+	if (fbi->lccr0 & LCCR0_SDS)
+		lcd_writel(fbi, FBR1, fbi->fdadr[dma + 1] | 0x1);
+
+	lcd_writel(fbi, FBR0, fbi->fdadr[dma] | 0x1);
+	return 0;
+}
+
 /*
  * pxafb_blank():
  *	Blank the display by setting all palette values to zero.  Note, the
@@ -501,6 +520,7 @@ static struct fb_ops pxafb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= pxafb_check_var,
 	.fb_set_par	= pxafb_set_par,
+	.fb_pan_display	= pxafb_pan_display,
 	.fb_setcolreg	= pxafb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
@@ -592,7 +612,7 @@ static int setup_frame_dma(struct pxafb_info *fbi,
int dma, int pal,
 	struct pxafb_dma_descriptor *dma_desc, *pal_desc;
 	unsigned int dma_desc_off, pal_desc_off;

-	if (dma < 0 || dma >= DMA_MAX)
+	if (dma < 0 || dma >= DMA_MAX * 2)
 		return -EINVAL;

 	dma_desc = &fbi->dma_buff->dma_desc[dma];
@@ -602,7 +622,7 @@ static int setup_frame_dma(struct pxafb_info *fbi,
int dma, int pal,
 	dma_desc->fidr  = 0;
 	dma_desc->ldcmd = size;

-	if (pal < 0 || pal >= PAL_MAX) {
+	if (pal < 0 || pal >= PAL_MAX * 2) {
 		dma_desc->fdadr = fbi->dma_buff_phys + dma_desc_off;
 		fbi->fdadr[dma] = fbi->dma_buff_phys + dma_desc_off;
 	} else {
@@ -628,6 +648,27 @@ static int setup_frame_dma(struct pxafb_info
*fbi, int dma, int pal,
 	return 0;
 }

+static void setup_base_frame(struct pxafb_info *fbi, int branch)
+{
+	struct fb_var_screeninfo *var = &fbi->fb.var;
+	struct fb_fix_screeninfo *fix = &fbi->fb.fix;
+	unsigned int nbytes, offset;
+	int dma, pal, bpp = var->bits_per_pixel;
+
+	dma = DMA_BASE + (branch ? DMA_MAX : 0);
+	pal = (bpp >= 16) ? PAL_NONE : PAL_BASE + (branch ? PAL_MAX : 0);
+
+	nbytes = fix->line_length * var->yres;
+	offset = fix->line_length * var->yoffset;
+
+	if (fbi->lccr0 & LCCR0_SDS) {
+		nbytes = nbytes / 2;
+		setup_frame_dma(fbi, dma + 1, PAL_NONE, offset + nbytes, nbytes);
+	}
+
+	setup_frame_dma(fbi, dma, pal, offset, nbytes);
+}
+
 #ifdef CONFIG_FB_PXA_SMARTPANEL
 static int setup_smart_dma(struct pxafb_info *fbi)
 {
@@ -875,7 +916,6 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 			      struct pxafb_info *fbi)
 {
 	u_long flags;
-	size_t nbytes, offset;

 #if DEBUG_VAR
 	if (!(fbi->lccr0 & LCCR0_LCDT)) {
@@ -930,25 +970,14 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,
 #endif
 		setup_parallel_timing(fbi, var);

+	setup_base_frame(fbi, 0);
+
 	fbi->reg_lccr0 = fbi->lccr0 |
 		(LCCR0_LDM | LCCR0_SFM | LCCR0_IUM | LCCR0_EFM |
 		 LCCR0_QDM | LCCR0_BM  | LCCR0_OUM);

 	fbi->reg_lccr3 |= pxafb_bpp_to_lccr3(var);

-	nbytes = fbi->fb.fix.line_length * var->yres;
-	offset = fbi->fb.fix.line_length * var->yoffset;
-
-	if ((fbi->lccr0 & LCCR0_SDS) == LCCR0_Dual) {
-		nbytes = nbytes / 2;
-		setup_frame_dma(fbi, DMA_LOWER, PAL_NONE, offset + nbytes, nbytes);
-	}
-
-	if ((var->bits_per_pixel >= 16) || (fbi->lccr0 & LCCR0_LCDT))
-		setup_frame_dma(fbi, DMA_BASE, PAL_NONE, offset, nbytes);
-	else
-		setup_frame_dma(fbi, DMA_BASE, PAL_BASE, offset, nbytes);
-
 	fbi->reg_lccr4 = lcd_readl(fbi, LCCR4) & ~LCCR4_PAL_FOR_MASK;
 	fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
 	local_irq_restore(flags);
diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index 0981938..e0f90f4 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -54,11 +54,14 @@ enum {
 #define PALETTE_SIZE	(256 * 4)
 #define CMD_BUFF_SIZE	(1024 * 50)

+/* NOTE: the palette and frame dma descriptors are doubled to allow
+ * the 2nd set for branch settings (FBRx)
+ */
 struct pxafb_dma_buff {
 	unsigned char palette[PAL_MAX * PALETTE_SIZE];
 	uint16_t cmd_buff[CMD_BUFF_SIZE];
-	struct pxafb_dma_descriptor pal_desc[PAL_MAX];
-	struct pxafb_dma_descriptor dma_desc[DMA_MAX];
+	struct pxafb_dma_descriptor pal_desc[PAL_MAX * 2];
+	struct pxafb_dma_descriptor dma_desc[DMA_MAX * 2];
 };

 struct pxafb_info {
@@ -71,7 +74,7 @@ struct pxafb_info {
 	struct pxafb_dma_buff	*dma_buff;
 	size_t			dma_buff_size;
 	dma_addr_t		dma_buff_phys;
-	dma_addr_t		fdadr[DMA_MAX];
+	dma_addr_t		fdadr[DMA_MAX * 2];

 	void __iomem		*video_mem;	/* virtual address of frame buffer */
 	unsigned long		video_mem_phys;	/* physical address of frame buffer */
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
