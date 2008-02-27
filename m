From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 6/8] pxa: introduce "struct
	pxafb_dma_buff" for palette and dma descriptors
Date: Wed, 27 Feb 2008 10:37:57 +0800
Message-ID: <f17812d70802261837j4b31b4mc1044aa683b38956@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUCBC-0003aS-OP for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:37:58 -0800
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUCBC-0004rJ-66
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:37:58 -0800
Received: by wa-out-1112.google.com with SMTP id k22so3027248waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Feb 2008 18:37:57 -0800 (PST)
Content-Disposition: inline
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
To: linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

From 533bdb5eabe730eec7e18c2b7d8b56c55f1c86dd Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Mon, 25 Feb 2008 16:22:14 +0800
Subject: [PATCH] pxa: introduce "struct pxafb_dma_buff" for palette
and dma descriptors

Use structure and array for palette buffer and dma descriptors to:

1. better organize code for future expansion like overlays
2. separate palette and dma descriptors from frame buffer

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c |  132 ++++++++++++++++++++++--------------------------
 drivers/video/pxafb.h |   46 +++++++++++++-----
 2 files changed, 95 insertions(+), 83 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 5488acf..b7a3304 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -360,7 +360,6 @@ static int pxafb_set_par(struct fb_info *info)
 {
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
 	struct fb_var_screeninfo *var = &info->var;
-	unsigned long palette_mem_size;

 	if (var->bits_per_pixel == 16)
 		fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
@@ -383,13 +382,7 @@ static int pxafb_set_par(struct fb_info *info)
 		fbi->palette_size = var->bits_per_pixel == 1 ?
 					4 : 1 << var->bits_per_pixel;

-	if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) == LCCR4_PAL_FOR_0)
-		palette_mem_size = fbi->palette_size * sizeof(u16);
-	else
-		palette_mem_size = fbi->palette_size * sizeof(u32);
-
-	fbi->palette_cpu = (u16 *)(fbi->map_cpu + PAGE_SIZE - palette_mem_size);
-	fbi->palette_dma = fbi->map_dma + PAGE_SIZE - palette_mem_size;
+	fbi->palette_cpu = (u16 *)&fbi->dma_buff->palette[0];

 	/*
 	 * Set (any) board control register to handle new color depth
@@ -545,6 +538,48 @@ unsigned long pxafb_get_hsync_time(struct device *dev)
 }
 EXPORT_SYMBOL(pxafb_get_hsync_time);

+static int setup_frame_dma(struct pxafb_info *fbi, int dma, int pal,
+		unsigned int offset, size_t size)
+{
+	struct pxafb_dma_descriptor *dma_desc, *pal_desc;
+	unsigned int dma_desc_off, pal_desc_off;
+
+	if (dma < 0 || dma >= DMA_MAX)
+		return -EINVAL;
+
+	dma_desc = &fbi->dma_buff->dma_desc[dma];
+	dma_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[dma]);
+
+	dma_desc->fsadr = fbi->screen_dma + offset;
+	dma_desc->fidr  = 0;
+	dma_desc->ldcmd = size;
+
+	if (pal < 0 || pal >= PAL_MAX) {
+		dma_desc->fdadr = fbi->dma_buff_phys + dma_desc_off;
+		fbi->fdadr[dma] = fbi->dma_buff_phys + dma_desc_off;
+	} else {
+		pal_desc = &fbi->dma_buff->pal_desc[dma];
+		pal_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[pal]);
+
+		pal_desc->fsadr = fbi->dma_buff_phys + pal * PALETTE_SIZE;
+		pal_desc->fidr  = 0;
+
+		if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) == LCCR4_PAL_FOR_0)
+			pal_desc->ldcmd = fbi->palette_size * sizeof(u16);
+		else
+			pal_desc->ldcmd = fbi->palette_size * sizeof(u32);
+
+		pal_desc->ldcmd |= LDCMD_PAL;
+
+		/* flip back and forth between palette and frame buffer */
+		pal_desc->fdadr = fbi->dma_buff_phys + dma_desc_off;
+		dma_desc->fdadr = fbi->dma_buff_phys + pal_desc_off;
+		fbi->fdadr[dma] = fbi->dma_buff_phys + dma_desc_off;
+	}
+
+	return 0;
+}
+
 /*
  * pxafb_activate_var():
  *	Configures LCD Controller based on entries in var parameter.
@@ -556,6 +591,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 	struct pxafb_lcd_reg new_regs;
 	u_long flags;
 	u_int lines_per_panel, pcd = get_pcd(fbi, var->pixclock);
+	size_t nbytes;

 #if DEBUG_VAR
 	if (var->xres < 16 || var->xres > 1024)
@@ -633,54 +669,15 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,
 	/* Update shadow copy atomically */
 	local_irq_save(flags);

-	/* setup dma descriptors */
-	fbi->dmadesc_fblow_cpu = (struct pxafb_dma_descriptor *)
-				((unsigned int)fbi->palette_cpu - 3*16);
-	fbi->dmadesc_fbhigh_cpu = (struct pxafb_dma_descriptor *)
-				((unsigned int)fbi->palette_cpu - 2*16);
-	fbi->dmadesc_palette_cpu = (struct pxafb_dma_descriptor *)
-				((unsigned int)fbi->palette_cpu - 1*16);
-
-	fbi->dmadesc_fblow_dma = fbi->palette_dma - 3*16;
-	fbi->dmadesc_fbhigh_dma = fbi->palette_dma - 2*16;
-	fbi->dmadesc_palette_dma = fbi->palette_dma - 1*16;
-
-#define BYTES_PER_PANEL (lines_per_panel * fbi->fb.fix.line_length)
-
-	/* populate descriptors */
-	fbi->dmadesc_fblow_cpu->fdadr = fbi->dmadesc_fblow_dma;
-	fbi->dmadesc_fblow_cpu->fsadr = fbi->screen_dma + BYTES_PER_PANEL;
-	fbi->dmadesc_fblow_cpu->fidr  = 0;
-	fbi->dmadesc_fblow_cpu->ldcmd = BYTES_PER_PANEL;
-
-	fbi->fdadr1 = fbi->dmadesc_fblow_dma; /* only used in dual-panel mode */
-
-	fbi->dmadesc_fbhigh_cpu->fsadr = fbi->screen_dma;
-	fbi->dmadesc_fbhigh_cpu->fidr = 0;
-	fbi->dmadesc_fbhigh_cpu->ldcmd = BYTES_PER_PANEL;
-
-	fbi->dmadesc_palette_cpu->fsadr = fbi->palette_dma;
-	fbi->dmadesc_palette_cpu->fidr  = 0;
-	if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) == LCCR4_PAL_FOR_0)
-		fbi->dmadesc_palette_cpu->ldcmd = fbi->palette_size *
-							sizeof(u16);
-	else
-		fbi->dmadesc_palette_cpu->ldcmd = fbi->palette_size *
-							sizeof(u32);
-	fbi->dmadesc_palette_cpu->ldcmd |= LDCMD_PAL;
+	nbytes = lines_per_panel * fbi->fb.fix.line_length;

-	if (var->bits_per_pixel == 16) {
-		/* palette shouldn't be loaded in true-color mode */
-		fbi->dmadesc_fbhigh_cpu->fdadr = fbi->dmadesc_fbhigh_dma;
-		fbi->fdadr0 = fbi->dmadesc_fbhigh_dma; /* no pal just fbhigh */
-		/* init it to something, even though we won't be using it */
-		fbi->dmadesc_palette_cpu->fdadr = fbi->dmadesc_palette_dma;
-	} else {
-		/* flips back and forth between pal and fbhigh */
-		fbi->dmadesc_palette_cpu->fdadr = fbi->dmadesc_fbhigh_dma;
-		fbi->dmadesc_fbhigh_cpu->fdadr = fbi->dmadesc_palette_dma;
-		fbi->fdadr0 = fbi->dmadesc_palette_dma;
-	}
+	if ((fbi->lccr0 & LCCR0_SDS) == LCCR0_Dual)
+		setup_frame_dma(fbi, DMA_LOWER, PAL_NONE, nbytes, nbytes);
+
+	if (var->bits_per_pixel >= 16)
+		setup_frame_dma(fbi, DMA_BASE, PAL_NONE, 0, nbytes);
+	else
+		setup_frame_dma(fbi, DMA_BASE, PAL_BASE, 0, nbytes);

 	fbi->reg_lccr0 = new_regs.lccr0;
 	fbi->reg_lccr1 = new_regs.lccr1;
@@ -700,8 +697,8 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 	    (__raw_readl(fbi->mmio_base + LCCR1) != fbi->reg_lccr1) ||
 	    (__raw_readl(fbi->mmio_base + LCCR2) != fbi->reg_lccr2) ||
 	    (__raw_readl(fbi->mmio_base + LCCR3) != fbi->reg_lccr3) ||
-	    (__raw_readl(fbi->mmio_base + FDADR0) != fbi->fdadr0) ||
-	    (__raw_readl(fbi->mmio_base + FDADR1) != fbi->fdadr1))
+	    (__raw_readl(fbi->mmio_base + FDADR0) != fbi->fdadr[0]) ||
+	    (__raw_readl(fbi->mmio_base + FDADR1) != fbi->fdadr[1]))
 		pxafb_schedule_work(fbi, C_REENABLE);

 	return 0;
@@ -776,8 +773,8 @@ static void pxafb_setup_gpio(struct pxafb_info *fbi)
 static void pxafb_enable_controller(struct pxafb_info *fbi)
 {
 	pr_debug("pxafb: Enabling LCD controller\n");
-	pr_debug("fdadr0 0x%08x\n", (unsigned int) fbi->fdadr0);
-	pr_debug("fdadr1 0x%08x\n", (unsigned int) fbi->fdadr1);
+	pr_debug("fdadr0 0x%08x\n", (unsigned int) fbi->fdadr[0]);
+	pr_debug("fdadr1 0x%08x\n", (unsigned int) fbi->fdadr[1]);
 	pr_debug("reg_lccr0 0x%08x\n", (unsigned int) fbi->reg_lccr0);
 	pr_debug("reg_lccr1 0x%08x\n", (unsigned int) fbi->reg_lccr1);
 	pr_debug("reg_lccr2 0x%08x\n", (unsigned int) fbi->reg_lccr2);
@@ -792,8 +789,8 @@ static void pxafb_enable_controller(struct pxafb_info *fbi)
 	__raw_writel(fbi->reg_lccr1, fbi->mmio_base + LCCR1);
 	__raw_writel(fbi->reg_lccr0 & ~LCCR0_ENB, fbi->mmio_base + LCCR0);

-	__raw_writel(fbi->fdadr0, fbi->mmio_base + FDADR0);
-	__raw_writel(fbi->fdadr1, fbi->mmio_base + FDADR1);
+	__raw_writel(fbi->fdadr[0], fbi->mmio_base + FDADR0);
+	__raw_writel(fbi->fdadr[1], fbi->mmio_base + FDADR1);
 	__raw_writel(fbi->reg_lccr0 | LCCR0_ENB, fbi->mmio_base + LCCR0);
 }

@@ -1037,8 +1034,6 @@ static int pxafb_resume(struct platform_device *dev)
  */
 static int __init pxafb_map_video_memory(struct pxafb_info *fbi)
 {
-	u_long palette_mem_size;
-
 	/*
 	 * We reserve one page for the palette, plus the size
 	 * of the framebuffer.
@@ -1061,14 +1056,9 @@ static int __init pxafb_map_video_memory(struct
pxafb_info *fbi)
 		fbi->fb.fix.smem_start = fbi->screen_dma;
 		fbi->palette_size = fbi->fb.var.bits_per_pixel == 8 ? 256 : 16;

-		if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) == LCCR4_PAL_FOR_0)
-			palette_mem_size = fbi->palette_size * sizeof(u16);
-		else
-			palette_mem_size = fbi->palette_size * sizeof(u32);
-
-		fbi->palette_cpu = (u16 *)(fbi->map_cpu + PAGE_SIZE
-						- palette_mem_size);
-		fbi->palette_dma = fbi->map_dma + PAGE_SIZE - palette_mem_size;
+		fbi->dma_buff = (void *)fbi->map_cpu;
+		fbi->dma_buff_phys = fbi->map_dma;
+		fbi->palette_cpu = (u16 *)&fbi->dma_buff->palette[0];
 	}

 	return fbi->map_cpu ? 0 : -ENOMEM;
diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index c7c561d..b777641 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -37,6 +37,36 @@ struct pxafb_dma_descriptor {
 	unsigned int ldcmd;
 };

+enum {
+	PAL_NONE	= -1,
+	PAL_BASE	= 0,
+	PAL_OV1		= 1,
+	PAL_OV2		= 2,
+	PAL_MAX,
+};
+
+enum {
+	DMA_BASE	= 0,
+	DMA_UPPER	= 0,
+	DMA_LOWER	= 1,
+	DMA_OV1		= 1,
+	DMA_OV2_Y	= 2,
+	DMA_OV2_Cb	= 3,
+	DMA_OV2_Cr	= 4,
+	DMA_CURSOR	= 5,
+	DMA_CMD		= 6,
+	DMA_MAX,
+};
+
+/* maximum palette size - 256 entries, each 4 bytes long */
+#define PALETTE_SIZE	(256 * 4)
+
+struct pxafb_dma_buff {
+	unsigned char palette[PAL_MAX * PALETTE_SIZE];
+	struct pxafb_dma_descriptor pal_desc[PAL_MAX];
+	struct pxafb_dma_descriptor dma_desc[DMA_MAX];
+};
+
 struct pxafb_info {
 	struct fb_info		fb;
 	struct device		*dev;
@@ -44,6 +74,10 @@ struct pxafb_info {

 	void __iomem		*mmio_base;

+	struct pxafb_dma_buff	*dma_buff;
+	dma_addr_t		dma_buff_phys;
+	dma_addr_t		fdadr[DMA_MAX];
+
 	/*
 	 * These are the addresses we mapped
 	 * the framebuffer memory region to.
@@ -57,20 +91,8 @@ struct pxafb_info {
 	u_char *		screen_cpu;	/* virtual address of frame buffer */
 	dma_addr_t		screen_dma;	/* physical address of frame buffer */
 	u16 *			palette_cpu;	/* virtual address of palette memory */
-	dma_addr_t		palette_dma;	/* physical address of palette memory */
 	u_int			palette_size;

-	/* DMA descriptors */
-	struct pxafb_dma_descriptor * 	dmadesc_fblow_cpu;
-	dma_addr_t		dmadesc_fblow_dma;
-	struct pxafb_dma_descriptor * 	dmadesc_fbhigh_cpu;
-	dma_addr_t		dmadesc_fbhigh_dma;
-	struct pxafb_dma_descriptor *	dmadesc_palette_cpu;
-	dma_addr_t		dmadesc_palette_dma;
-
-	dma_addr_t		fdadr0;
-	dma_addr_t		fdadr1;
-
 	u_int			lccr0;
 	u_int			lccr3;
 	u_int			lccr4;
-- 
1.5.3.8



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
