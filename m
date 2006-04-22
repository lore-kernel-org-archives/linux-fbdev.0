From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/4] savagefb: Allocate space for current and saved register
 states
Date: Sat, 22 Apr 2006 10:40:33 +0800
Message-ID: <444997A1.3030005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX8Ep-0003cF-MM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 19:52:47 -0700
Received: from pproxy.gmail.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FX8Eo-0001zL-CJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 19:52:47 -0700
Received: by pproxy.gmail.com with SMTP id i49so647147pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Apr 2006 19:52:44 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, rich@hq.vsaa.lv

Allocate space for  2 register states: 'current' for the current state of the
hardware, and 'saved', to be used for restoring the hardware to a sane state.
This is in preparation for the addition of state save and restore hooks to make
savagefb work together with the latest Xorg savage driver.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/savage/savagefb.h        |   45 +--
 drivers/video/savage/savagefb_driver.c |  513 ++++++++++++++++----------------
 2 files changed, 281 insertions(+), 277 deletions(-)

diff --git a/drivers/video/savage/savagefb.h b/drivers/video/savage/savagefb.h
index 58cfdfb..e648a6c 100644
--- a/drivers/video/savage/savagefb.h
+++ b/drivers/video/savage/savagefb.h
@@ -147,7 +147,27 @@ struct xtimings {
 	int	       interlaced;
 };
 
+struct savage_reg {
+	unsigned char MiscOutReg;     /* Misc */
+	unsigned char CRTC[25];       /* Crtc Controller */
+	unsigned char Sequencer[5];   /* Video Sequencer */
+	unsigned char Graphics[9];    /* Video Graphics */
+	unsigned char Attribute[21];  /* Video Atribute */
 
+	unsigned int mode, refresh;
+	unsigned char SR08, SR0E, SR0F;
+	unsigned char SR10, SR11, SR12, SR13, SR15, SR18, SR29, SR30;
+	unsigned char SR54[8];
+	unsigned char Clock;
+	unsigned char CR31, CR32, CR33, CR34, CR36, CR3A, CR3B, CR3C;
+	unsigned char CR40, CR41, CR42, CR43, CR45;
+	unsigned char CR50, CR51, CR53, CR55, CR58, CR5B, CR5D, CR5E;
+	unsigned char CR60, CR63, CR65, CR66, CR67, CR68, CR69, CR6D, CR6F;
+	unsigned char CR86, CR88;
+	unsigned char CR90, CR91, CRB0;
+	unsigned int  STREAMS[22];	/* yuck, streams regs */
+	unsigned int  MMPR0, MMPR1, MMPR2, MMPR3;
+};
 /* --------------------------------------------------------------------- */
 
 #define NR_PALETTE	256
@@ -167,6 +187,8 @@ struct savagefb_par {
 	struct pci_dev *pcidev;
 	savage_chipset  chip;
 	struct savagefb_i2c_chan chan;
+	struct savage_reg state;
+	struct savage_reg save;
 	unsigned char   *edid;
 	u32 pseudo_palette[16];
 	int paletteEnabled;
@@ -179,6 +201,7 @@ struct savagefb_par {
 	int minClock;
 	int numClocks;
 	int clock[4];
+	int MCLK, REFCLK, LCDclk;
 	struct {
 		u8   __iomem *vbase;
 		u32    pbase;
@@ -196,7 +219,6 @@ struct savagefb_par {
 
 	volatile u32  __iomem *bci_base;
 	unsigned int  bci_ptr;
-
 	u32           cob_offset;
 	u32           cob_size;
 	int           cob_index;
@@ -204,7 +226,6 @@ struct savagefb_par {
 	void (*SavageWaitIdle) (struct savagefb_par *par);
 	void (*SavageWaitFifo) (struct savagefb_par *par, int space);
 
-	int MCLK, REFCLK, LCDclk;
 	int HorizScaleFactor;
 
 	/* Panels size */
@@ -217,26 +238,6 @@ struct savagefb_par {
 
 	int depth;
 	int vwidth;
-
-	unsigned char MiscOutReg;     /* Misc */
-	unsigned char CRTC[25];       /* Crtc Controller */
-	unsigned char Sequencer[5];   /* Video Sequencer */
-	unsigned char Graphics[9];    /* Video Graphics */
-	unsigned char Attribute[21];  /* Video Atribute */
-
-	unsigned int mode, refresh;
-	unsigned char SR08, SR0E, SR0F;
-	unsigned char SR10, SR11, SR12, SR13, SR15, SR18, SR29, SR30;
-	unsigned char SR54[8];
-	unsigned char Clock;
-	unsigned char CR31, CR32, CR33, CR34, CR36, CR3A, CR3B, CR3C;
-	unsigned char CR40, CR41, CR42, CR43, CR45;
-	unsigned char CR50, CR51, CR53, CR55, CR58, CR5B, CR5D, CR5E;
-	unsigned char CR60, CR63, CR65, CR66, CR67, CR68, CR69, CR6D, CR6F;
-	unsigned char CR86, CR88;
-	unsigned char CR90, CR91, CRB0;
-	unsigned int  STREAMS[22];	/* yuck, streams regs */
-	unsigned int  MMPR0, MMPR1, MMPR2, MMPR3;
 };
 
 #define BCI_BD_BW_DISABLE            0x10000000
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 0da624e..267d4e5 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -122,66 +122,67 @@ static void vgaHWProtect (struct savagef
 	}
 }
 
-static void vgaHWRestore (struct savagefb_par  *par)
+static void vgaHWRestore (struct savagefb_par  *par, struct savage_reg *reg)
 {
 	int i;
 
-	VGAwMISC (par->MiscOutReg, par);
+	VGAwMISC (reg->MiscOutReg, par);
 
 	for (i = 1; i < 5; i++)
-		VGAwSEQ (i, par->Sequencer[i], par);
+		VGAwSEQ (i, reg->Sequencer[i], par);
 
 	/* Ensure CRTC registers 0-7 are unlocked by clearing bit 7 or
 	   CRTC[17] */
-	VGAwCR (17, par->CRTC[17] & ~0x80, par);
+	VGAwCR (17, reg->CRTC[17] & ~0x80, par);
 
 	for (i = 0; i < 25; i++)
-		VGAwCR (i, par->CRTC[i], par);
+		VGAwCR (i, reg->CRTC[i], par);
 
 	for (i = 0; i < 9; i++)
-		VGAwGR (i, par->Graphics[i], par);
+		VGAwGR (i, reg->Graphics[i], par);
 
 	VGAenablePalette(par);
 
 	for (i = 0; i < 21; i++)
-		VGAwATTR (i, par->Attribute[i], par);
+		VGAwATTR (i, reg->Attribute[i], par);
 
 	VGAdisablePalette(par);
 }
 
 static void vgaHWInit (struct fb_var_screeninfo *var,
 		       struct savagefb_par            *par,
-		       struct xtimings                *timings)
+		       struct xtimings                *timings,
+		       struct savage_reg              *reg)
 {
-	par->MiscOutReg = 0x23;
+	reg->MiscOutReg = 0x23;
 
 	if (!(timings->sync & FB_SYNC_HOR_HIGH_ACT))
-		par->MiscOutReg |= 0x40;
+		reg->MiscOutReg |= 0x40;
 
 	if (!(timings->sync & FB_SYNC_VERT_HIGH_ACT))
-		par->MiscOutReg |= 0x80;
+		reg->MiscOutReg |= 0x80;
 
 	/*
 	 * Time Sequencer
 	 */
-	par->Sequencer[0x00] = 0x00;
-	par->Sequencer[0x01] = 0x01;
-	par->Sequencer[0x02] = 0x0F;
-	par->Sequencer[0x03] = 0x00;          /* Font select */
-	par->Sequencer[0x04] = 0x0E;          /* Misc */
+	reg->Sequencer[0x00] = 0x00;
+	reg->Sequencer[0x01] = 0x01;
+	reg->Sequencer[0x02] = 0x0F;
+	reg->Sequencer[0x03] = 0x00;          /* Font select */
+	reg->Sequencer[0x04] = 0x0E;          /* Misc */
 
 	/*
 	 * CRTC Controller
 	 */
-	par->CRTC[0x00] = (timings->HTotal >> 3) - 5;
-	par->CRTC[0x01] = (timings->HDisplay >> 3) - 1;
-	par->CRTC[0x02] = (timings->HSyncStart >> 3) - 1;
-	par->CRTC[0x03] = (((timings->HSyncEnd >> 3)  - 1) & 0x1f) | 0x80;
-	par->CRTC[0x04] = (timings->HSyncStart >> 3);
-	par->CRTC[0x05] = ((((timings->HSyncEnd >> 3) - 1) & 0x20) << 2) |
+	reg->CRTC[0x00] = (timings->HTotal >> 3) - 5;
+	reg->CRTC[0x01] = (timings->HDisplay >> 3) - 1;
+	reg->CRTC[0x02] = (timings->HSyncStart >> 3) - 1;
+	reg->CRTC[0x03] = (((timings->HSyncEnd >> 3)  - 1) & 0x1f) | 0x80;
+	reg->CRTC[0x04] = (timings->HSyncStart >> 3);
+	reg->CRTC[0x05] = ((((timings->HSyncEnd >> 3) - 1) & 0x20) << 2) |
 		(((timings->HSyncEnd >> 3)) & 0x1f);
-	par->CRTC[0x06] = (timings->VTotal - 2) & 0xFF;
-	par->CRTC[0x07] = (((timings->VTotal - 2) & 0x100) >> 8) |
+	reg->CRTC[0x06] = (timings->VTotal - 2) & 0xFF;
+	reg->CRTC[0x07] = (((timings->VTotal - 2) & 0x100) >> 8) |
 		(((timings->VDisplay - 1) & 0x100) >> 7) |
 		((timings->VSyncStart & 0x100) >> 6) |
 		(((timings->VSyncStart - 1) & 0x100) >> 5) |
@@ -189,27 +190,27 @@ static void vgaHWInit (struct fb_var_scr
 		(((timings->VTotal - 2) & 0x200) >> 4) |
 		(((timings->VDisplay - 1) & 0x200) >> 3) |
 		((timings->VSyncStart & 0x200) >> 2);
-	par->CRTC[0x08] = 0x00;
-	par->CRTC[0x09] = (((timings->VSyncStart - 1) & 0x200) >> 4) | 0x40;
+	reg->CRTC[0x08] = 0x00;
+	reg->CRTC[0x09] = (((timings->VSyncStart - 1) & 0x200) >> 4) | 0x40;
 
 	if (timings->dblscan)
-		par->CRTC[0x09] |= 0x80;
+		reg->CRTC[0x09] |= 0x80;
 
-	par->CRTC[0x0a] = 0x00;
-	par->CRTC[0x0b] = 0x00;
-	par->CRTC[0x0c] = 0x00;
-	par->CRTC[0x0d] = 0x00;
-	par->CRTC[0x0e] = 0x00;
-	par->CRTC[0x0f] = 0x00;
-	par->CRTC[0x10] = timings->VSyncStart & 0xff;
-	par->CRTC[0x11] = (timings->VSyncEnd & 0x0f) | 0x20;
-	par->CRTC[0x12] = (timings->VDisplay - 1) & 0xff;
-	par->CRTC[0x13] = var->xres_virtual >> 4;
-	par->CRTC[0x14] = 0x00;
-	par->CRTC[0x15] = (timings->VSyncStart - 1) & 0xff;
-	par->CRTC[0x16] = (timings->VSyncEnd - 1) & 0xff;
-	par->CRTC[0x17] = 0xc3;
-	par->CRTC[0x18] = 0xff;
+	reg->CRTC[0x0a] = 0x00;
+	reg->CRTC[0x0b] = 0x00;
+	reg->CRTC[0x0c] = 0x00;
+	reg->CRTC[0x0d] = 0x00;
+	reg->CRTC[0x0e] = 0x00;
+	reg->CRTC[0x0f] = 0x00;
+	reg->CRTC[0x10] = timings->VSyncStart & 0xff;
+	reg->CRTC[0x11] = (timings->VSyncEnd & 0x0f) | 0x20;
+	reg->CRTC[0x12] = (timings->VDisplay - 1) & 0xff;
+	reg->CRTC[0x13] = var->xres_virtual >> 4;
+	reg->CRTC[0x14] = 0x00;
+	reg->CRTC[0x15] = (timings->VSyncStart - 1) & 0xff;
+	reg->CRTC[0x16] = (timings->VSyncEnd - 1) & 0xff;
+	reg->CRTC[0x17] = 0xc3;
+	reg->CRTC[0x18] = 0xff;
 
 	/*
 	 * are these unnecessary?
@@ -220,38 +221,38 @@ static void vgaHWInit (struct fb_var_scr
 	/*
 	 * Graphics Display Controller
 	 */
-	par->Graphics[0x00] = 0x00;
-	par->Graphics[0x01] = 0x00;
-	par->Graphics[0x02] = 0x00;
-	par->Graphics[0x03] = 0x00;
-	par->Graphics[0x04] = 0x00;
-	par->Graphics[0x05] = 0x40;
-	par->Graphics[0x06] = 0x05;   /* only map 64k VGA memory !!!! */
-	par->Graphics[0x07] = 0x0F;
-	par->Graphics[0x08] = 0xFF;
-
-
-	par->Attribute[0x00]  = 0x00; /* standard colormap translation */
-	par->Attribute[0x01]  = 0x01;
-	par->Attribute[0x02]  = 0x02;
-	par->Attribute[0x03]  = 0x03;
-	par->Attribute[0x04]  = 0x04;
-	par->Attribute[0x05]  = 0x05;
-	par->Attribute[0x06]  = 0x06;
-	par->Attribute[0x07]  = 0x07;
-	par->Attribute[0x08]  = 0x08;
-	par->Attribute[0x09]  = 0x09;
-	par->Attribute[0x0a] = 0x0A;
-	par->Attribute[0x0b] = 0x0B;
-	par->Attribute[0x0c] = 0x0C;
-	par->Attribute[0x0d] = 0x0D;
-	par->Attribute[0x0e] = 0x0E;
-	par->Attribute[0x0f] = 0x0F;
-	par->Attribute[0x10] = 0x41;
-	par->Attribute[0x11] = 0xFF;
-	par->Attribute[0x12] = 0x0F;
-	par->Attribute[0x13] = 0x00;
-	par->Attribute[0x14] = 0x00;
+	reg->Graphics[0x00] = 0x00;
+	reg->Graphics[0x01] = 0x00;
+	reg->Graphics[0x02] = 0x00;
+	reg->Graphics[0x03] = 0x00;
+	reg->Graphics[0x04] = 0x00;
+	reg->Graphics[0x05] = 0x40;
+	reg->Graphics[0x06] = 0x05;   /* only map 64k VGA memory !!!! */
+	reg->Graphics[0x07] = 0x0F;
+	reg->Graphics[0x08] = 0xFF;
+
+
+	reg->Attribute[0x00]  = 0x00; /* standard colormap translation */
+	reg->Attribute[0x01]  = 0x01;
+	reg->Attribute[0x02]  = 0x02;
+	reg->Attribute[0x03]  = 0x03;
+	reg->Attribute[0x04]  = 0x04;
+	reg->Attribute[0x05]  = 0x05;
+	reg->Attribute[0x06]  = 0x06;
+	reg->Attribute[0x07]  = 0x07;
+	reg->Attribute[0x08]  = 0x08;
+	reg->Attribute[0x09]  = 0x09;
+	reg->Attribute[0x0a] = 0x0A;
+	reg->Attribute[0x0b] = 0x0B;
+	reg->Attribute[0x0c] = 0x0C;
+	reg->Attribute[0x0d] = 0x0D;
+	reg->Attribute[0x0e] = 0x0E;
+	reg->Attribute[0x0f] = 0x0F;
+	reg->Attribute[0x10] = 0x41;
+	reg->Attribute[0x11] = 0xFF;
+	reg->Attribute[0x12] = 0x0F;
+	reg->Attribute[0x13] = 0x00;
+	reg->Attribute[0x14] = 0x00;
 }
 
 /* -------------------- Hardware specific routines ------------------------- */
@@ -513,7 +514,7 @@ static void SavagePrintRegs(void)
 
 /* --------------------------------------------------------------------- */
 
-static void savage_get_default_par(struct savagefb_par *par)
+static void savage_get_default_par(struct savagefb_par *par, struct savage_reg *reg)
 {
 	unsigned char cr3a, cr53, cr66;
 
@@ -543,96 +544,96 @@ static void savage_get_default_par(struc
 
 	/* unlock extended seq regs */
 	vga_out8 (0x3c4, 0x08, par);
-	par->SR08 = vga_in8 (0x3c5, par);
+	reg->SR08 = vga_in8 (0x3c5, par);
 	vga_out8 (0x3c5, 0x06, par);
 
 	/* now save all the extended regs we need */
 	vga_out8 (0x3d4, 0x31, par);
-	par->CR31 = vga_in8 (0x3d5, par);
+	reg->CR31 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x32, par);
-	par->CR32 = vga_in8 (0x3d5, par);
+	reg->CR32 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x34, par);
-	par->CR34 = vga_in8 (0x3d5, par);
+	reg->CR34 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x36, par);
-	par->CR36 = vga_in8 (0x3d5, par);
+	reg->CR36 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x3a, par);
-	par->CR3A = vga_in8 (0x3d5, par);
+	reg->CR3A = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x40, par);
-	par->CR40 = vga_in8 (0x3d5, par);
+	reg->CR40 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x42, par);
-	par->CR42 = vga_in8 (0x3d5, par);
+	reg->CR42 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x45, par);
-	par->CR45 = vga_in8 (0x3d5, par);
+	reg->CR45 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x50, par);
-	par->CR50 = vga_in8 (0x3d5, par);
+	reg->CR50 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x51, par);
-	par->CR51 = vga_in8 (0x3d5, par);
+	reg->CR51 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x53, par);
-	par->CR53 = vga_in8 (0x3d5, par);
+	reg->CR53 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x58, par);
-	par->CR58 = vga_in8 (0x3d5, par);
+	reg->CR58 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x60, par);
-	par->CR60 = vga_in8 (0x3d5, par);
+	reg->CR60 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x66, par);
-	par->CR66 = vga_in8 (0x3d5, par);
+	reg->CR66 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x67, par);
-	par->CR67 = vga_in8 (0x3d5, par);
+	reg->CR67 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x68, par);
-	par->CR68 = vga_in8 (0x3d5, par);
+	reg->CR68 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x69, par);
-	par->CR69 = vga_in8 (0x3d5, par);
+	reg->CR69 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x6f, par);
-	par->CR6F = vga_in8 (0x3d5, par);
+	reg->CR6F = vga_in8 (0x3d5, par);
 
 	vga_out8 (0x3d4, 0x33, par);
-	par->CR33 = vga_in8 (0x3d5, par);
+	reg->CR33 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x86, par);
-	par->CR86 = vga_in8 (0x3d5, par);
+	reg->CR86 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x88, par);
-	par->CR88 = vga_in8 (0x3d5, par);
+	reg->CR88 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x90, par);
-	par->CR90 = vga_in8 (0x3d5, par);
+	reg->CR90 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x91, par);
-	par->CR91 = vga_in8 (0x3d5, par);
+	reg->CR91 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0xb0, par);
-	par->CRB0 = vga_in8 (0x3d5, par) | 0x80;
+	reg->CRB0 = vga_in8 (0x3d5, par) | 0x80;
 
 	/* extended mode timing regs */
 	vga_out8 (0x3d4, 0x3b, par);
-	par->CR3B = vga_in8 (0x3d5, par);
+	reg->CR3B = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x3c, par);
-	par->CR3C = vga_in8 (0x3d5, par);
+	reg->CR3C = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x43, par);
-	par->CR43 = vga_in8 (0x3d5, par);
+	reg->CR43 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x5d, par);
-	par->CR5D = vga_in8 (0x3d5, par);
+	reg->CR5D = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x5e, par);
-	par->CR5E = vga_in8 (0x3d5, par);
+	reg->CR5E = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x65, par);
-	par->CR65 = vga_in8 (0x3d5, par);
+	reg->CR65 = vga_in8 (0x3d5, par);
 
 	/* save seq extended regs for DCLK PLL programming */
 	vga_out8 (0x3c4, 0x0e, par);
-	par->SR0E = vga_in8 (0x3c5, par);
+	reg->SR0E = vga_in8 (0x3c5, par);
 	vga_out8 (0x3c4, 0x0f, par);
-	par->SR0F = vga_in8 (0x3c5, par);
+	reg->SR0F = vga_in8 (0x3c5, par);
 	vga_out8 (0x3c4, 0x10, par);
-	par->SR10 = vga_in8 (0x3c5, par);
+	reg->SR10 = vga_in8 (0x3c5, par);
 	vga_out8 (0x3c4, 0x11, par);
-	par->SR11 = vga_in8 (0x3c5, par);
+	reg->SR11 = vga_in8 (0x3c5, par);
 	vga_out8 (0x3c4, 0x12, par);
-	par->SR12 = vga_in8 (0x3c5, par);
+	reg->SR12 = vga_in8 (0x3c5, par);
 	vga_out8 (0x3c4, 0x13, par);
-	par->SR13 = vga_in8 (0x3c5, par);
+	reg->SR13 = vga_in8 (0x3c5, par);
 	vga_out8 (0x3c4, 0x29, par);
-	par->SR29 = vga_in8 (0x3c5, par);
+	reg->SR29 = vga_in8 (0x3c5, par);
 
 	vga_out8 (0x3c4, 0x15, par);
-	par->SR15 = vga_in8 (0x3c5, par);
+	reg->SR15 = vga_in8 (0x3c5, par);
 	vga_out8 (0x3c4, 0x30, par);
-	par->SR30 = vga_in8 (0x3c5, par);
+	reg->SR30 = vga_in8 (0x3c5, par);
 	vga_out8 (0x3c4, 0x18, par);
-	par->SR18 = vga_in8 (0x3c5, par);
+	reg->SR18 = vga_in8 (0x3c5, par);
 
 	/* Save flat panel expansion regsters. */
 	if (par->chip == S3_SAVAGE_MX) {
@@ -640,7 +641,7 @@ static void savage_get_default_par(struc
 
 		for (i = 0; i < 8; i++) {
 			vga_out8 (0x3c4, 0x54+i, par);
-			par->SR54[i] = vga_in8 (0x3c5, par);
+			reg->SR54[i] = vga_in8 (0x3c5, par);
 		}
 	}
 
@@ -653,10 +654,10 @@ static void savage_get_default_par(struc
 
 	/* now save MIU regs */
 	if (par->chip != S3_SAVAGE_MX) {
-		par->MMPR0 = savage_in32(FIFO_CONTROL_REG, par);
-		par->MMPR1 = savage_in32(MIU_CONTROL_REG, par);
-		par->MMPR2 = savage_in32(STREAMS_TIMEOUT_REG, par);
-		par->MMPR3 = savage_in32(MISC_TIMEOUT_REG, par);
+		reg->MMPR0 = savage_in32(FIFO_CONTROL_REG, par);
+		reg->MMPR1 = savage_in32(MIU_CONTROL_REG, par);
+		reg->MMPR2 = savage_in32(STREAMS_TIMEOUT_REG, par);
+		reg->MMPR3 = savage_in32(MISC_TIMEOUT_REG, par);
 	}
 
 	vga_out8 (0x3d4, 0x3a, par);
@@ -789,7 +790,8 @@ static int savagefb_check_var (struct fb
 
 
 static int savagefb_decode_var (struct fb_var_screeninfo   *var,
-				struct savagefb_par        *par)
+				struct savagefb_par        *par,
+				struct savage_reg          *reg)
 {
 	struct xtimings timings;
 	int width, dclk, i, j; /*, refresh; */
@@ -831,39 +833,39 @@ static int savagefb_decode_var (struct f
 	 * This will allocate the datastructure and initialize all of the
 	 * generic VGA registers.
 	 */
-	vgaHWInit (var, par, &timings);
+	vgaHWInit (var, par, &timings, reg);
 
 	/* We need to set CR67 whether or not we use the BIOS. */
 
 	dclk = timings.Clock;
-	par->CR67 = 0x00;
+	reg->CR67 = 0x00;
 
 	switch( var->bits_per_pixel ) {
 	case 8:
 		if( (par->chip == S3_SAVAGE2000) && (dclk >= 230000) )
-			par->CR67 = 0x10;	/* 8bpp, 2 pixels/clock */
+			reg->CR67 = 0x10;	/* 8bpp, 2 pixels/clock */
 		else
-			par->CR67 = 0x00;	/* 8bpp, 1 pixel/clock */
+			reg->CR67 = 0x00;	/* 8bpp, 1 pixel/clock */
 		break;
 	case 15:
 		if ( S3_SAVAGE_MOBILE_SERIES(par->chip) ||
 		     ((par->chip == S3_SAVAGE2000) && (dclk >= 230000)) )
-			par->CR67 = 0x30;	/* 15bpp, 2 pixel/clock */
+			reg->CR67 = 0x30;	/* 15bpp, 2 pixel/clock */
 		else
-			par->CR67 = 0x20;	/* 15bpp, 1 pixels/clock */
+			reg->CR67 = 0x20;	/* 15bpp, 1 pixels/clock */
 		break;
 	case 16:
 		if( S3_SAVAGE_MOBILE_SERIES(par->chip) ||
 		    ((par->chip == S3_SAVAGE2000) && (dclk >= 230000)) )
-			par->CR67 = 0x50;	/* 16bpp, 2 pixel/clock */
+			reg->CR67 = 0x50;	/* 16bpp, 2 pixel/clock */
 		else
-			par->CR67 = 0x40;	/* 16bpp, 1 pixels/clock */
+			reg->CR67 = 0x40;	/* 16bpp, 1 pixels/clock */
 		break;
 	case 24:
-		par->CR67 = 0x70;
+		reg->CR67 = 0x70;
 		break;
 	case 32:
-		par->CR67 = 0xd0;
+		reg->CR67 = 0xd0;
 		break;
 	}
 
@@ -875,58 +877,58 @@ static int savagefb_decode_var (struct f
 	vga_out8 (0x3d4, 0x3a, par);
 	tmp = vga_in8 (0x3d5, par);
 	if (1 /*FIXME:psav->pci_burst*/)
-		par->CR3A = (tmp & 0x7f) | 0x15;
+		reg->CR3A = (tmp & 0x7f) | 0x15;
 	else
-		par->CR3A = tmp | 0x95;
+		reg->CR3A = tmp | 0x95;
 
-	par->CR53 = 0x00;
-	par->CR31 = 0x8c;
-	par->CR66 = 0x89;
+	reg->CR53 = 0x00;
+	reg->CR31 = 0x8c;
+	reg->CR66 = 0x89;
 
 	vga_out8 (0x3d4, 0x58, par);
-	par->CR58 = vga_in8 (0x3d5, par) & 0x80;
-	par->CR58 |= 0x13;
+	reg->CR58 = vga_in8 (0x3d5, par) & 0x80;
+	reg->CR58 |= 0x13;
 
-	par->SR15 = 0x03 | 0x80;
-	par->SR18 = 0x00;
-	par->CR43 = par->CR45 = par->CR65 = 0x00;
+	reg->SR15 = 0x03 | 0x80;
+	reg->SR18 = 0x00;
+	reg->CR43 = reg->CR45 = reg->CR65 = 0x00;
 
 	vga_out8 (0x3d4, 0x40, par);
-	par->CR40 = vga_in8 (0x3d5, par) & ~0x01;
+	reg->CR40 = vga_in8 (0x3d5, par) & ~0x01;
 
-	par->MMPR0 = 0x010400;
-	par->MMPR1 = 0x00;
-	par->MMPR2 = 0x0808;
-	par->MMPR3 = 0x08080810;
+	reg->MMPR0 = 0x010400;
+	reg->MMPR1 = 0x00;
+	reg->MMPR2 = 0x0808;
+	reg->MMPR3 = 0x08080810;
 
 	SavageCalcClock (dclk, 1, 1, 127, 0, 4, 180000, 360000, &m, &n, &r);
 	/* m = 107; n = 4; r = 2; */
 
 	if (par->MCLK <= 0) {
-		par->SR10 = 255;
-		par->SR11 = 255;
+		reg->SR10 = 255;
+		reg->SR11 = 255;
 	} else {
 		common_calc_clock (par->MCLK, 1, 1, 31, 0, 3, 135000, 270000,
-				   &par->SR11, &par->SR10);
-		/*      par->SR10 = 80; // MCLK == 286000 */
-		/*      par->SR11 = 125; */
+				   &reg->SR11, &reg->SR10);
+		/*      reg->SR10 = 80; // MCLK == 286000 */
+		/*      reg->SR11 = 125; */
 	}
 
-	par->SR12 = (r << 6) | (n & 0x3f);
-	par->SR13 = m & 0xff;
-	par->SR29 = (r & 4) | (m & 0x100) >> 5 | (n & 0x40) >> 2;
+	reg->SR12 = (r << 6) | (n & 0x3f);
+	reg->SR13 = m & 0xff;
+	reg->SR29 = (r & 4) | (m & 0x100) >> 5 | (n & 0x40) >> 2;
 
 	if (var->bits_per_pixel < 24)
-		par->MMPR0 -= 0x8000;
+		reg->MMPR0 -= 0x8000;
 	else
-		par->MMPR0 -= 0x4000;
+		reg->MMPR0 -= 0x4000;
 
 	if (timings.interlaced)
-		par->CR42 = 0x20;
+		reg->CR42 = 0x20;
 	else
-		par->CR42 = 0x00;
+		reg->CR42 = 0x00;
 
-	par->CR34 = 0x10; /* display fifo */
+	reg->CR34 = 0x10; /* display fifo */
 
 	i = ((((timings.HTotal >> 3) - 5) & 0x100) >> 8) |
 		((((timings.HDisplay >> 3) - 1) & 0x100) >> 7) |
@@ -938,77 +940,77 @@ static int savagefb_decode_var (struct f
 	if ((timings.HSyncEnd >> 3) - (timings.HSyncStart >> 3) > 32)
 		i |= 0x20;
 
-	j = (par->CRTC[0] + ((i & 0x01) << 8) +
-	     par->CRTC[4] + ((i & 0x10) << 4) + 1) / 2;
+	j = (reg->CRTC[0] + ((i & 0x01) << 8) +
+	     reg->CRTC[4] + ((i & 0x10) << 4) + 1) / 2;
 
-	if (j - (par->CRTC[4] + ((i & 0x10) << 4)) < 4) {
-		if (par->CRTC[4] + ((i & 0x10) << 4) + 4 <=
-		    par->CRTC[0] + ((i & 0x01) << 8))
-			j = par->CRTC[4] + ((i & 0x10) << 4) + 4;
+	if (j - (reg->CRTC[4] + ((i & 0x10) << 4)) < 4) {
+		if (reg->CRTC[4] + ((i & 0x10) << 4) + 4 <=
+		    reg->CRTC[0] + ((i & 0x01) << 8))
+			j = reg->CRTC[4] + ((i & 0x10) << 4) + 4;
 		else
-			j = par->CRTC[0] + ((i & 0x01) << 8) + 1;
+			j = reg->CRTC[0] + ((i & 0x01) << 8) + 1;
 	}
 
-	par->CR3B = j & 0xff;
+	reg->CR3B = j & 0xff;
 	i |= (j & 0x100) >> 2;
-	par->CR3C = (par->CRTC[0] + ((i & 0x01) << 8)) / 2;
-	par->CR5D = i;
-	par->CR5E = (((timings.VTotal - 2) & 0x400) >> 10) |
+	reg->CR3C = (reg->CRTC[0] + ((i & 0x01) << 8)) / 2;
+	reg->CR5D = i;
+	reg->CR5E = (((timings.VTotal - 2) & 0x400) >> 10) |
 		(((timings.VDisplay - 1) & 0x400) >> 9) |
 		(((timings.VSyncStart) & 0x400) >> 8) |
 		(((timings.VSyncStart) & 0x400) >> 6) | 0x40;
 	width = (var->xres_virtual * ((var->bits_per_pixel+7) / 8)) >> 3;
-	par->CR91 = par->CRTC[19] = 0xff & width;
-	par->CR51 = (0x300 & width) >> 4;
-	par->CR90 = 0x80 | (width >> 8);
-	par->MiscOutReg |= 0x0c;
+	reg->CR91 = reg->CRTC[19] = 0xff & width;
+	reg->CR51 = (0x300 & width) >> 4;
+	reg->CR90 = 0x80 | (width >> 8);
+	reg->MiscOutReg |= 0x0c;
 
 	/* Set frame buffer description. */
 
 	if (var->bits_per_pixel <= 8)
-		par->CR50 = 0;
+		reg->CR50 = 0;
 	else if (var->bits_per_pixel <= 16)
-		par->CR50 = 0x10;
+		reg->CR50 = 0x10;
 	else
-		par->CR50 = 0x30;
+		reg->CR50 = 0x30;
 
 	if (var->xres_virtual <= 640)
-		par->CR50 |= 0x40;
+		reg->CR50 |= 0x40;
 	else if (var->xres_virtual == 800)
-		par->CR50 |= 0x80;
+		reg->CR50 |= 0x80;
 	else if (var->xres_virtual == 1024)
-		par->CR50 |= 0x00;
+		reg->CR50 |= 0x00;
 	else if (var->xres_virtual == 1152)
-		par->CR50 |= 0x01;
+		reg->CR50 |= 0x01;
 	else if (var->xres_virtual == 1280)
-		par->CR50 |= 0xc0;
+		reg->CR50 |= 0xc0;
 	else if (var->xres_virtual == 1600)
-		par->CR50 |= 0x81;
+		reg->CR50 |= 0x81;
 	else
-		par->CR50 |= 0xc1;	/* Use GBD */
+		reg->CR50 |= 0xc1;	/* Use GBD */
 
 	if( par->chip == S3_SAVAGE2000 )
-		par->CR33 = 0x08;
+		reg->CR33 = 0x08;
 	else
-		par->CR33 = 0x20;
+		reg->CR33 = 0x20;
 
-	par->CRTC[0x17] = 0xeb;
+	reg->CRTC[0x17] = 0xeb;
 
-	par->CR67 |= 1;
+	reg->CR67 |= 1;
 
 	vga_out8(0x3d4, 0x36, par);
-	par->CR36 = vga_in8 (0x3d5, par);
+	reg->CR36 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x68, par);
-	par->CR68 = vga_in8 (0x3d5, par);
-	par->CR69 = 0;
+	reg->CR68 = vga_in8 (0x3d5, par);
+	reg->CR69 = 0;
 	vga_out8 (0x3d4, 0x6f, par);
-	par->CR6F = vga_in8 (0x3d5, par);
+	reg->CR6F = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x86, par);
-	par->CR86 = vga_in8 (0x3d5, par);
+	reg->CR86 = vga_in8 (0x3d5, par);
 	vga_out8 (0x3d4, 0x88, par);
-	par->CR88 = vga_in8 (0x3d5, par) | 0x08;
+	reg->CR88 = vga_in8 (0x3d5, par) | 0x08;
 	vga_out8 (0x3d4, 0xb0, par);
-	par->CRB0 = vga_in8 (0x3d5, par) | 0x80;
+	reg->CRB0 = vga_in8 (0x3d5, par) | 0x80;
 
 	return 0;
 }
@@ -1075,7 +1077,7 @@ static int savagefb_setcolreg(unsigned  
 	return 0;
 }
 
-static void savagefb_set_par_int (struct savagefb_par  *par)
+static void savagefb_set_par_int (struct savagefb_par  *par, struct savage_reg *reg)
 {
 	unsigned char tmp, cr3a, cr66, cr67;
 
@@ -1110,30 +1112,30 @@ static void savagefb_set_par_int (struct
 
 	/* restore extended regs */
 	vga_out8 (0x3d4, 0x66, par);
-	vga_out8 (0x3d5, par->CR66, par);
+	vga_out8 (0x3d5, reg->CR66, par);
 	vga_out8 (0x3d4, 0x3a, par);
-	vga_out8 (0x3d5, par->CR3A, par);
+	vga_out8 (0x3d5, reg->CR3A, par);
 	vga_out8 (0x3d4, 0x31, par);
-	vga_out8 (0x3d5, par->CR31, par);
+	vga_out8 (0x3d5, reg->CR31, par);
 	vga_out8 (0x3d4, 0x32, par);
-	vga_out8 (0x3d5, par->CR32, par);
+	vga_out8 (0x3d5, reg->CR32, par);
 	vga_out8 (0x3d4, 0x58, par);
-	vga_out8 (0x3d5, par->CR58, par);
+	vga_out8 (0x3d5, reg->CR58, par);
 	vga_out8 (0x3d4, 0x53, par);
-	vga_out8 (0x3d5, par->CR53 & 0x7f, par);
+	vga_out8 (0x3d5, reg->CR53 & 0x7f, par);
 
 	vga_out16 (0x3c4, 0x0608, par);
 
 	/* Restore DCLK registers. */
 
 	vga_out8 (0x3c4, 0x0e, par);
-	vga_out8 (0x3c5, par->SR0E, par);
+	vga_out8 (0x3c5, reg->SR0E, par);
 	vga_out8 (0x3c4, 0x0f, par);
-	vga_out8 (0x3c5, par->SR0F, par);
+	vga_out8 (0x3c5, reg->SR0F, par);
 	vga_out8 (0x3c4, 0x29, par);
-	vga_out8 (0x3c5, par->SR29, par);
+	vga_out8 (0x3c5, reg->SR29, par);
 	vga_out8 (0x3c4, 0x15, par);
-	vga_out8 (0x3c5, par->SR15, par);
+	vga_out8 (0x3c5, reg->SR15, par);
 
 	/* Restore flat panel expansion regsters. */
 	if( par->chip == S3_SAVAGE_MX ) {
@@ -1141,27 +1143,27 @@ static void savagefb_set_par_int (struct
 
 		for( i = 0; i < 8; i++ ) {
 			vga_out8 (0x3c4, 0x54+i, par);
-			vga_out8 (0x3c5, par->SR54[i], par);
+			vga_out8 (0x3c5, reg->SR54[i], par);
 		}
 	}
 
-	vgaHWRestore (par);
+	vgaHWRestore (par, reg);
 
 	/* extended mode timing registers */
 	vga_out8 (0x3d4, 0x53, par);
-	vga_out8 (0x3d5, par->CR53, par);
+	vga_out8 (0x3d5, reg->CR53, par);
 	vga_out8 (0x3d4, 0x5d, par);
-	vga_out8 (0x3d5, par->CR5D, par);
+	vga_out8 (0x3d5, reg->CR5D, par);
 	vga_out8 (0x3d4, 0x5e, par);
-	vga_out8 (0x3d5, par->CR5E, par);
+	vga_out8 (0x3d5, reg->CR5E, par);
 	vga_out8 (0x3d4, 0x3b, par);
-	vga_out8 (0x3d5, par->CR3B, par);
+	vga_out8 (0x3d5, reg->CR3B, par);
 	vga_out8 (0x3d4, 0x3c, par);
-	vga_out8 (0x3d5, par->CR3C, par);
+	vga_out8 (0x3d5, reg->CR3C, par);
 	vga_out8 (0x3d4, 0x43, par);
-	vga_out8 (0x3d5, par->CR43, par);
+	vga_out8 (0x3d5, reg->CR43, par);
 	vga_out8 (0x3d4, 0x65, par);
-	vga_out8 (0x3d5, par->CR65, par);
+	vga_out8 (0x3d5, reg->CR65, par);
 
 	/* restore the desired video mode with cr67 */
 	vga_out8 (0x3d4, 0x67, par);
@@ -1171,52 +1173,52 @@ static void savagefb_set_par_int (struct
 	udelay (10000);
 	vga_out8 (0x3d4, 0x67, par);
 	/* end of part */
-	vga_out8 (0x3d5, par->CR67 & ~0x0c, par);
+	vga_out8 (0x3d5, reg->CR67 & ~0x0c, par);
 
 	/* other mode timing and extended regs */
 	vga_out8 (0x3d4, 0x34, par);
-	vga_out8 (0x3d5, par->CR34, par);
+	vga_out8 (0x3d5, reg->CR34, par);
 	vga_out8 (0x3d4, 0x40, par);
-	vga_out8 (0x3d5, par->CR40, par);
+	vga_out8 (0x3d5, reg->CR40, par);
 	vga_out8 (0x3d4, 0x42, par);
-	vga_out8 (0x3d5, par->CR42, par);
+	vga_out8 (0x3d5, reg->CR42, par);
 	vga_out8 (0x3d4, 0x45, par);
-	vga_out8 (0x3d5, par->CR45, par);
+	vga_out8 (0x3d5, reg->CR45, par);
 	vga_out8 (0x3d4, 0x50, par);
-	vga_out8 (0x3d5, par->CR50, par);
+	vga_out8 (0x3d5, reg->CR50, par);
 	vga_out8 (0x3d4, 0x51, par);
-	vga_out8 (0x3d5, par->CR51, par);
+	vga_out8 (0x3d5, reg->CR51, par);
 
 	/* memory timings */
 	vga_out8 (0x3d4, 0x36, par);
-	vga_out8 (0x3d5, par->CR36, par);
+	vga_out8 (0x3d5, reg->CR36, par);
 	vga_out8 (0x3d4, 0x60, par);
-	vga_out8 (0x3d5, par->CR60, par);
+	vga_out8 (0x3d5, reg->CR60, par);
 	vga_out8 (0x3d4, 0x68, par);
-	vga_out8 (0x3d5, par->CR68, par);
+	vga_out8 (0x3d5, reg->CR68, par);
 	vga_out8 (0x3d4, 0x69, par);
-	vga_out8 (0x3d5, par->CR69, par);
+	vga_out8 (0x3d5, reg->CR69, par);
 	vga_out8 (0x3d4, 0x6f, par);
-	vga_out8 (0x3d5, par->CR6F, par);
+	vga_out8 (0x3d5, reg->CR6F, par);
 
 	vga_out8 (0x3d4, 0x33, par);
-	vga_out8 (0x3d5, par->CR33, par);
+	vga_out8 (0x3d5, reg->CR33, par);
 	vga_out8 (0x3d4, 0x86, par);
-	vga_out8 (0x3d5, par->CR86, par);
+	vga_out8 (0x3d5, reg->CR86, par);
 	vga_out8 (0x3d4, 0x88, par);
-	vga_out8 (0x3d5, par->CR88, par);
+	vga_out8 (0x3d5, reg->CR88, par);
 	vga_out8 (0x3d4, 0x90, par);
-	vga_out8 (0x3d5, par->CR90, par);
+	vga_out8 (0x3d5, reg->CR90, par);
 	vga_out8 (0x3d4, 0x91, par);
-	vga_out8 (0x3d5, par->CR91, par);
+	vga_out8 (0x3d5, reg->CR91, par);
 
 	if (par->chip == S3_SAVAGE4) {
 		vga_out8 (0x3d4, 0xb0, par);
-		vga_out8 (0x3d5, par->CRB0, par);
+		vga_out8 (0x3d5, reg->CRB0, par);
 	}
 
 	vga_out8 (0x3d4, 0x32, par);
-	vga_out8 (0x3d5, par->CR32, par);
+	vga_out8 (0x3d5, reg->CR32, par);
 
 	/* unlock extended seq regs */
 	vga_out8 (0x3c4, 0x08, par);
@@ -1225,27 +1227,27 @@ static void savagefb_set_par_int (struct
 	/* Restore extended sequencer regs for MCLK. SR10 == 255 indicates
 	 * that we should leave the default SR10 and SR11 values there.
 	 */
-	if (par->SR10 != 255) {
+	if (reg->SR10 != 255) {
 		vga_out8 (0x3c4, 0x10, par);
-		vga_out8 (0x3c5, par->SR10, par);
+		vga_out8 (0x3c5, reg->SR10, par);
 		vga_out8 (0x3c4, 0x11, par);
-		vga_out8 (0x3c5, par->SR11, par);
+		vga_out8 (0x3c5, reg->SR11, par);
 	}
 
 	/* restore extended seq regs for dclk */
 	vga_out8 (0x3c4, 0x0e, par);
-	vga_out8 (0x3c5, par->SR0E, par);
+	vga_out8 (0x3c5, reg->SR0E, par);
 	vga_out8 (0x3c4, 0x0f, par);
-	vga_out8 (0x3c5, par->SR0F, par);
+	vga_out8 (0x3c5, reg->SR0F, par);
 	vga_out8 (0x3c4, 0x12, par);
-	vga_out8 (0x3c5, par->SR12, par);
+	vga_out8 (0x3c5, reg->SR12, par);
 	vga_out8 (0x3c4, 0x13, par);
-	vga_out8 (0x3c5, par->SR13, par);
+	vga_out8 (0x3c5, reg->SR13, par);
 	vga_out8 (0x3c4, 0x29, par);
-	vga_out8 (0x3c5, par->SR29, par);
+	vga_out8 (0x3c5, reg->SR29, par);
 
 	vga_out8 (0x3c4, 0x18, par);
-	vga_out8 (0x3c5, par->SR18, par);
+	vga_out8 (0x3c5, reg->SR18, par);
 
 	/* load new m, n pll values for dclk & mclk */
 	vga_out8 (0x3c4, 0x15, par);
@@ -1254,18 +1256,18 @@ static void savagefb_set_par_int (struct
 	vga_out8 (0x3c5, tmp | 0x03, par);
 	vga_out8 (0x3c5, tmp | 0x23, par);
 	vga_out8 (0x3c5, tmp | 0x03, par);
-	vga_out8 (0x3c5, par->SR15, par);
+	vga_out8 (0x3c5, reg->SR15, par);
 	udelay (100);
 
 	vga_out8 (0x3c4, 0x30, par);
-	vga_out8 (0x3c5, par->SR30, par);
+	vga_out8 (0x3c5, reg->SR30, par);
 	vga_out8 (0x3c4, 0x08, par);
-	vga_out8 (0x3c5, par->SR08, par);
+	vga_out8 (0x3c5, reg->SR08, par);
 
 	/* now write out cr67 in full, possibly starting STREAMS */
 	VerticalRetraceWait(par);
 	vga_out8 (0x3d4, 0x67, par);
-	vga_out8 (0x3d5, par->CR67, par);
+	vga_out8 (0x3d5, reg->CR67, par);
 
 	vga_out8 (0x3d4, 0x66, par);
 	cr66 = vga_in8 (0x3d5, par);
@@ -1276,13 +1278,13 @@ static void savagefb_set_par_int (struct
 
 	if (par->chip != S3_SAVAGE_MX) {
 		VerticalRetraceWait(par);
-		savage_out32 (FIFO_CONTROL_REG, par->MMPR0, par);
+		savage_out32 (FIFO_CONTROL_REG, reg->MMPR0, par);
 		par->SavageWaitIdle (par);
-		savage_out32 (MIU_CONTROL_REG, par->MMPR1, par);
+		savage_out32 (MIU_CONTROL_REG, reg->MMPR1, par);
 		par->SavageWaitIdle (par);
-		savage_out32 (STREAMS_TIMEOUT_REG, par->MMPR2, par);
+		savage_out32 (STREAMS_TIMEOUT_REG, reg->MMPR2, par);
 		par->SavageWaitIdle (par);
-		savage_out32 (MISC_TIMEOUT_REG, par->MMPR3, par);
+		savage_out32 (MISC_TIMEOUT_REG, reg->MMPR3, par);
 	}
 
 	vga_out8 (0x3d4, 0x66, par);
@@ -1347,7 +1349,7 @@ static int savagefb_set_par (struct fb_i
 	int err;
 
 	DBG("savagefb_set_par");
-	err = savagefb_decode_var (var, par);
+	err = savagefb_decode_var (var, par, &par->state);
 	if (err)
 		return err;
 
@@ -1366,7 +1368,7 @@ static int savagefb_set_par (struct fb_i
 	par->maxClock = par->dacSpeedBpp;
 	par->minClock = 10000;
 
-	savagefb_set_par_int (par);
+	savagefb_set_par_int (par, &par->state);
 	fb_set_cmap (&info->cmap, info);
 	savagefb_set_fix(info);
 	savagefb_set_clip(info);
@@ -1824,7 +1826,8 @@ static int savage_init_hw (struct savage
 			par->display_type = DISP_CRT;
 	}
 
-	savage_get_default_par (par);
+	savage_get_default_par (par, &par->state);
+	par->save = par->state;
 
 	if( S3_SAVAGE4_SERIES(par->chip) ) {
 		/*



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
