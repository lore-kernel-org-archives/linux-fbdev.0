From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/12] savagefb: Whitespace cleanup
Date: Sat, 29 Apr 2006 08:42:33 +0800
Message-ID: <4452B679.7000100@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdit-0003qE-QM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:54:11 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdig-00017h-Fx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:58 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdig-0006gw-3T
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:58 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:57 -0700 (PDT)
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

Whitespace cleanup

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/savage/savagefb_driver.c | 1003 ++++++++++++++++----------------
 1 files changed, 501 insertions(+), 502 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 3bd0a57..78883cf 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -86,15 +86,15 @@ MODULE_DESCRIPTION("FBDev driver for S3 
 
 /* --------------------------------------------------------------------- */
 
-static void vgaHWSeqReset (struct savagefb_par *par, int start)
+static void vgaHWSeqReset(struct savagefb_par *par, int start)
 {
 	if (start)
-		VGAwSEQ (0x00, 0x01, par);	/* Synchronous Reset */
+		VGAwSEQ(0x00, 0x01, par);	/* Synchronous Reset */
 	else
-		VGAwSEQ (0x00, 0x03, par);	/* End Reset */
+		VGAwSEQ(0x00, 0x03, par);	/* End Reset */
 }
 
-static void vgaHWProtect (struct savagefb_par *par, int on)
+static void vgaHWProtect(struct savagefb_par *par, int on)
 {
 	unsigned char tmp;
 
@@ -102,10 +102,10 @@ static void vgaHWProtect (struct savagef
 		/*
 		 * Turn off screen and disable sequencer.
 		 */
-		tmp = VGArSEQ (0x01, par);
+		tmp = VGArSEQ(0x01, par);
 
-		vgaHWSeqReset (par, 1);	        /* start synchronous reset */
-		VGAwSEQ (0x01, tmp | 0x20, par);/* disable the display */
+		vgaHWSeqReset(par, 1);	        /* start synchronous reset */
+		VGAwSEQ(0x01, tmp | 0x20, par);/* disable the display */
 
 		VGAenablePalette(par);
 	} else {
@@ -113,46 +113,46 @@ static void vgaHWProtect (struct savagef
 		 * Reenable sequencer, then turn on screen.
 		 */
 
-		tmp = VGArSEQ (0x01, par);
+		tmp = VGArSEQ(0x01, par);
 
-		VGAwSEQ (0x01, tmp & ~0x20, par);/* reenable display */
-		vgaHWSeqReset (par, 0);	        /* clear synchronous reset */
+		VGAwSEQ(0x01, tmp & ~0x20, par);/* reenable display */
+		vgaHWSeqReset(par, 0);	        /* clear synchronous reset */
 
 		VGAdisablePalette(par);
 	}
 }
 
-static void vgaHWRestore (struct savagefb_par  *par, struct savage_reg *reg)
+static void vgaHWRestore(struct savagefb_par  *par, struct savage_reg *reg)
 {
 	int i;
 
-	VGAwMISC (reg->MiscOutReg, par);
+	VGAwMISC(reg->MiscOutReg, par);
 
 	for (i = 1; i < 5; i++)
-		VGAwSEQ (i, reg->Sequencer[i], par);
+		VGAwSEQ(i, reg->Sequencer[i], par);
 
 	/* Ensure CRTC registers 0-7 are unlocked by clearing bit 7 or
 	   CRTC[17] */
-	VGAwCR (17, reg->CRTC[17] & ~0x80, par);
+	VGAwCR(17, reg->CRTC[17] & ~0x80, par);
 
 	for (i = 0; i < 25; i++)
-		VGAwCR (i, reg->CRTC[i], par);
+		VGAwCR(i, reg->CRTC[i], par);
 
 	for (i = 0; i < 9; i++)
-		VGAwGR (i, reg->Graphics[i], par);
+		VGAwGR(i, reg->Graphics[i], par);
 
 	VGAenablePalette(par);
 
 	for (i = 0; i < 21; i++)
-		VGAwATTR (i, reg->Attribute[i], par);
+		VGAwATTR(i, reg->Attribute[i], par);
 
 	VGAdisablePalette(par);
 }
 
-static void vgaHWInit (struct fb_var_screeninfo *var,
-		       struct savagefb_par            *par,
-		       struct xtimings                *timings,
-		       struct savage_reg              *reg)
+static void vgaHWInit(struct fb_var_screeninfo *var,
+		      struct savagefb_par            *par,
+		      struct xtimings                *timings,
+		      struct savage_reg              *reg)
 {
 	reg->MiscOutReg = 0x23;
 
@@ -307,13 +307,13 @@ savage2000_waitidle(struct savagefb_par 
 
 #ifdef CONFIG_FB_SAVAGE_ACCEL
 static void
-SavageSetup2DEngine (struct savagefb_par  *par)
+SavageSetup2DEngine(struct savagefb_par  *par)
 {
 	unsigned long GlobalBitmapDescriptor;
 
 	GlobalBitmapDescriptor = 1 | 8 | BCI_BD_BW_DISABLE;
-	BCI_BD_SET_BPP (GlobalBitmapDescriptor, par->depth);
-	BCI_BD_SET_STRIDE (GlobalBitmapDescriptor, par->vwidth);
+	BCI_BD_SET_BPP(GlobalBitmapDescriptor, par->depth);
+	BCI_BD_SET_STRIDE(GlobalBitmapDescriptor, par->vwidth);
 
 	switch(par->chip) {
 	case S3_SAVAGE3D:
@@ -362,30 +362,30 @@ SavageSetup2DEngine (struct savagefb_par
 	vga_out8(0x3d5, 0x0c, par);
 
 	/* Set stride to use GBD. */
-	vga_out8 (0x3d4, 0x50, par);
-	vga_out8 (0x3d5, vga_in8(0x3d5, par) | 0xC1, par);
+	vga_out8(0x3d4, 0x50, par);
+	vga_out8(0x3d5, vga_in8(0x3d5, par) | 0xC1, par);
 
 	/* Enable 2D engine. */
-	vga_out8 (0x3d4, 0x40, par);
-	vga_out8 (0x3d5, 0x01, par);
+	vga_out8(0x3d4, 0x40, par);
+	vga_out8(0x3d5, 0x01, par);
 
-	savage_out32 (MONO_PAT_0, ~0, par);
-	savage_out32 (MONO_PAT_1, ~0, par);
+	savage_out32(MONO_PAT_0, ~0, par);
+	savage_out32(MONO_PAT_1, ~0, par);
 
 	/* Setup plane masks */
-	savage_out32 (0x8128, ~0, par); /* enable all write planes */
-	savage_out32 (0x812C, ~0, par); /* enable all read planes */
-	savage_out16 (0x8134, 0x27, par);
-	savage_out16 (0x8136, 0x07, par);
+	savage_out32(0x8128, ~0, par); /* enable all write planes */
+	savage_out32(0x812C, ~0, par); /* enable all read planes */
+	savage_out16(0x8134, 0x27, par);
+	savage_out16(0x8136, 0x07, par);
 
 	/* Now set the GBD */
 	par->bci_ptr = 0;
-	par->SavageWaitFifo (par, 4);
+	par->SavageWaitFifo(par, 4);
 
-	BCI_SEND( BCI_CMD_SETREG | (1 << 16) | BCI_GBD1 );
-	BCI_SEND( 0 );
-	BCI_SEND( BCI_CMD_SETREG | (1 << 16) | BCI_GBD2 );
-	BCI_SEND( GlobalBitmapDescriptor );
+	BCI_SEND(BCI_CMD_SETREG | (1 << 16) | BCI_GBD1);
+	BCI_SEND(0);
+	BCI_SEND(BCI_CMD_SETREG | (1 << 16) | BCI_GBD2);
+	BCI_SEND(GlobalBitmapDescriptor);
 }
 
 static void savagefb_set_clip(struct fb_info *info)
@@ -401,7 +401,7 @@ static void savagefb_set_clip(struct fb_
 	BCI_SEND(BCI_CLIP_BR(0xfff, 0xfff));
 }
 #else
-static void SavageSetup2DEngine (struct savagefb_par  *par) {}
+static void SavageSetup2DEngine(struct savagefb_par  *par) {}
 
 #endif
 
@@ -415,11 +415,11 @@ static void SavageCalcClock(long freq, i
 	unsigned char n1, n2, best_n1=16+2, best_n2=2, best_m=125+2;
 
 	if (freq < freq_min / (1 << max_n2)) {
-		printk (KERN_ERR "invalid frequency %ld Khz\n", freq);
+		printk(KERN_ERR "invalid frequency %ld Khz\n", freq);
 		freq = freq_min / (1 << max_n2);
 	}
 	if (freq > freq_max / (1 << min_n2)) {
-		printk (KERN_ERR "invalid frequency %ld Khz\n", freq);
+		printk(KERN_ERR "invalid frequency %ld Khz\n", freq);
 		freq = freq_max / (1 << min_n2);
 	}
 
@@ -470,12 +470,12 @@ static int common_calc_clock(long freq, 
 				BASE_FREQ;
 			if (m < min_m + 2 || m > 127+2)
 				continue;
-			if((m * BASE_FREQ >= freq_min * n1) &&
-			   (m * BASE_FREQ <= freq_max * n1)) {
+			if ((m * BASE_FREQ >= freq_min * n1) &&
+			    (m * BASE_FREQ <= freq_max * n1)) {
 				diff = freq * (1 << n2) * n1 - BASE_FREQ * m;
-				if(diff < 0)
+				if (diff < 0)
 					diff = -diff;
-				if(diff < best_diff) {
+				if (diff < best_diff) {
 					best_diff = diff;
 					best_m = m;
 					best_n1 = n1;
@@ -485,7 +485,7 @@ static int common_calc_clock(long freq, 
 		}
 	}
 
-	if(max_n1 == 63)
+	if (max_n1 == 63)
 		*ndiv = (best_n1 - 2) | (best_n2 << 6);
 	else
 		*ndiv = (best_n1 - 2) | (best_n2 << 5);
@@ -505,23 +505,23 @@ static void SavagePrintRegs(void)
 	int vgaCRReg = 0x3d5;
 
 	printk(KERN_DEBUG "SR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE "
-	       "xF" );
+	       "xF");
 
-	for( i = 0; i < 0x70; i++ ) {
-		if( !(i % 16) )
-			printk(KERN_DEBUG "\nSR%xx ", i >> 4 );
-		vga_out8( 0x3c4, i, par);
-		printk(KERN_DEBUG " %02x", vga_in8(0x3c5, par) );
+	for (i = 0; i < 0x70; i++) {
+		if (!(i % 16))
+			printk(KERN_DEBUG "\nSR%xx ", i >> 4);
+		vga_out8(0x3c4, i, par);
+		printk(KERN_DEBUG " %02x", vga_in8(0x3c5, par));
 	}
 
 	printk(KERN_DEBUG "\n\nCR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC "
-	       "xD xE xF" );
+	       "xD xE xF");
 
-	for( i = 0; i < 0xB7; i++ ) {
-		if( !(i % 16) )
-			printk(KERN_DEBUG "\nCR%xx ", i >> 4 );
-		vga_out8( vgaCRIndex, i, par);
-		printk(KERN_DEBUG " %02x", vga_in8(vgaCRReg, par) );
+	for (i = 0; i < 0xB7; i++) {
+		if (!(i % 16))
+			printk(KERN_DEBUG "\nCR%xx ", i >> 4);
+		vga_out8(vgaCRIndex, i, par);
+		printk(KERN_DEBUG " %02x", vga_in8(vgaCRReg, par));
 	}
 
 	printk(KERN_DEBUG "\n\n");
@@ -534,139 +534,139 @@ static void savage_get_default_par(struc
 {
 	unsigned char cr3a, cr53, cr66;
 
-	vga_out16 (0x3d4, 0x4838, par);
-	vga_out16 (0x3d4, 0xa039, par);
-	vga_out16 (0x3c4, 0x0608, par);
-
-	vga_out8 (0x3d4, 0x66, par);
-	cr66 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr66 | 0x80, par);
-	vga_out8 (0x3d4, 0x3a, par);
-	cr3a = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr3a | 0x80, par);
-	vga_out8 (0x3d4, 0x53, par);
-	cr53 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr53 & 0x7f, par);
-
-	vga_out8 (0x3d4, 0x66, par);
-	vga_out8 (0x3d5, cr66, par);
-	vga_out8 (0x3d4, 0x3a, par);
-	vga_out8 (0x3d5, cr3a, par);
-
-	vga_out8 (0x3d4, 0x66, par);
-	vga_out8 (0x3d5, cr66, par);
-	vga_out8 (0x3d4, 0x3a, par);
-	vga_out8 (0x3d5, cr3a, par);
+	vga_out16(0x3d4, 0x4838, par);
+	vga_out16(0x3d4, 0xa039, par);
+	vga_out16(0x3c4, 0x0608, par);
+
+	vga_out8(0x3d4, 0x66, par);
+	cr66 = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr66 | 0x80, par);
+	vga_out8(0x3d4, 0x3a, par);
+	cr3a = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr3a | 0x80, par);
+	vga_out8(0x3d4, 0x53, par);
+	cr53 = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr53 & 0x7f, par);
+
+	vga_out8(0x3d4, 0x66, par);
+	vga_out8(0x3d5, cr66, par);
+	vga_out8(0x3d4, 0x3a, par);
+	vga_out8(0x3d5, cr3a, par);
+
+	vga_out8(0x3d4, 0x66, par);
+	vga_out8(0x3d5, cr66, par);
+	vga_out8(0x3d4, 0x3a, par);
+	vga_out8(0x3d5, cr3a, par);
 
 	/* unlock extended seq regs */
-	vga_out8 (0x3c4, 0x08, par);
-	reg->SR08 = vga_in8 (0x3c5, par);
-	vga_out8 (0x3c5, 0x06, par);
+	vga_out8(0x3c4, 0x08, par);
+	reg->SR08 = vga_in8(0x3c5, par);
+	vga_out8(0x3c5, 0x06, par);
 
 	/* now save all the extended regs we need */
-	vga_out8 (0x3d4, 0x31, par);
-	reg->CR31 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x32, par);
-	reg->CR32 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x34, par);
-	reg->CR34 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x36, par);
-	reg->CR36 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x3a, par);
-	reg->CR3A = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x40, par);
-	reg->CR40 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x42, par);
-	reg->CR42 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x45, par);
-	reg->CR45 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x50, par);
-	reg->CR50 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x51, par);
-	reg->CR51 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x53, par);
-	reg->CR53 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x58, par);
-	reg->CR58 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x60, par);
-	reg->CR60 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x66, par);
-	reg->CR66 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x67, par);
-	reg->CR67 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x68, par);
-	reg->CR68 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x69, par);
-	reg->CR69 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x6f, par);
-	reg->CR6F = vga_in8 (0x3d5, par);
-
-	vga_out8 (0x3d4, 0x33, par);
-	reg->CR33 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x86, par);
-	reg->CR86 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x88, par);
-	reg->CR88 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x90, par);
-	reg->CR90 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x91, par);
-	reg->CR91 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0xb0, par);
-	reg->CRB0 = vga_in8 (0x3d5, par) | 0x80;
+	vga_out8(0x3d4, 0x31, par);
+	reg->CR31 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x32, par);
+	reg->CR32 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x34, par);
+	reg->CR34 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x36, par);
+	reg->CR36 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x3a, par);
+	reg->CR3A = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x40, par);
+	reg->CR40 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x42, par);
+	reg->CR42 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x45, par);
+	reg->CR45 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x50, par);
+	reg->CR50 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x51, par);
+	reg->CR51 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x53, par);
+	reg->CR53 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x58, par);
+	reg->CR58 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x60, par);
+	reg->CR60 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x66, par);
+	reg->CR66 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x67, par);
+	reg->CR67 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x68, par);
+	reg->CR68 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x69, par);
+	reg->CR69 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x6f, par);
+	reg->CR6F = vga_in8(0x3d5, par);
+
+	vga_out8(0x3d4, 0x33, par);
+	reg->CR33 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x86, par);
+	reg->CR86 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x88, par);
+	reg->CR88 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x90, par);
+	reg->CR90 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x91, par);
+	reg->CR91 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0xb0, par);
+	reg->CRB0 = vga_in8(0x3d5, par) | 0x80;
 
 	/* extended mode timing regs */
-	vga_out8 (0x3d4, 0x3b, par);
-	reg->CR3B = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x3c, par);
-	reg->CR3C = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x43, par);
-	reg->CR43 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x5d, par);
-	reg->CR5D = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x5e, par);
-	reg->CR5E = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x65, par);
-	reg->CR65 = vga_in8 (0x3d5, par);
+	vga_out8(0x3d4, 0x3b, par);
+	reg->CR3B = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x3c, par);
+	reg->CR3C = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x43, par);
+	reg->CR43 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x5d, par);
+	reg->CR5D = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x5e, par);
+	reg->CR5E = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x65, par);
+	reg->CR65 = vga_in8(0x3d5, par);
 
 	/* save seq extended regs for DCLK PLL programming */
-	vga_out8 (0x3c4, 0x0e, par);
-	reg->SR0E = vga_in8 (0x3c5, par);
-	vga_out8 (0x3c4, 0x0f, par);
-	reg->SR0F = vga_in8 (0x3c5, par);
-	vga_out8 (0x3c4, 0x10, par);
-	reg->SR10 = vga_in8 (0x3c5, par);
-	vga_out8 (0x3c4, 0x11, par);
-	reg->SR11 = vga_in8 (0x3c5, par);
-	vga_out8 (0x3c4, 0x12, par);
-	reg->SR12 = vga_in8 (0x3c5, par);
-	vga_out8 (0x3c4, 0x13, par);
-	reg->SR13 = vga_in8 (0x3c5, par);
-	vga_out8 (0x3c4, 0x29, par);
-	reg->SR29 = vga_in8 (0x3c5, par);
-
-	vga_out8 (0x3c4, 0x15, par);
-	reg->SR15 = vga_in8 (0x3c5, par);
-	vga_out8 (0x3c4, 0x30, par);
-	reg->SR30 = vga_in8 (0x3c5, par);
-	vga_out8 (0x3c4, 0x18, par);
-	reg->SR18 = vga_in8 (0x3c5, par);
+	vga_out8(0x3c4, 0x0e, par);
+	reg->SR0E = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x0f, par);
+	reg->SR0F = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x10, par);
+	reg->SR10 = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x11, par);
+	reg->SR11 = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x12, par);
+	reg->SR12 = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x13, par);
+	reg->SR13 = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x29, par);
+	reg->SR29 = vga_in8(0x3c5, par);
+
+	vga_out8(0x3c4, 0x15, par);
+	reg->SR15 = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x30, par);
+	reg->SR30 = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x18, par);
+	reg->SR18 = vga_in8(0x3c5, par);
 
 	/* Save flat panel expansion regsters. */
 	if (par->chip == S3_SAVAGE_MX) {
 		int i;
 
 		for (i = 0; i < 8; i++) {
-			vga_out8 (0x3c4, 0x54+i, par);
-			reg->SR54[i] = vga_in8 (0x3c5, par);
+			vga_out8(0x3c4, 0x54+i, par);
+			reg->SR54[i] = vga_in8(0x3c5, par);
 		}
 	}
 
-	vga_out8 (0x3d4, 0x66, par);
-	cr66 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr66 | 0x80, par);
-	vga_out8 (0x3d4, 0x3a, par);
-	cr3a = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr3a | 0x80, par);
+	vga_out8(0x3d4, 0x66, par);
+	cr66 = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr66 | 0x80, par);
+	vga_out8(0x3d4, 0x3a, par);
+	cr3a = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr3a | 0x80, par);
 
 	/* now save MIU regs */
 	if (par->chip != S3_SAVAGE_MX) {
@@ -676,10 +676,10 @@ static void savage_get_default_par(struc
 		reg->MMPR3 = savage_in32(MISC_TIMEOUT_REG, par);
 	}
 
-	vga_out8 (0x3d4, 0x3a, par);
-	vga_out8 (0x3d5, cr3a, par);
-	vga_out8 (0x3d4, 0x66, par);
-	vga_out8 (0x3d5, cr66, par);
+	vga_out8(0x3d4, 0x3a, par);
+	vga_out8(0x3d5, cr3a, par);
+	vga_out8(0x3d4, 0x66, par);
+	vga_out8(0x3d5, cr66, par);
 }
 
 static void savage_set_default_par(struct savagefb_par *par,
@@ -853,8 +853,8 @@ static void savage_update_var(struct fb_
         var->vmode = modedb->vmode;
 }
 
-static int savagefb_check_var (struct fb_var_screeninfo   *var,
-			       struct fb_info *info)
+static int savagefb_check_var(struct fb_var_screeninfo   *var,
+			      struct fb_info *info)
 {
 	struct savagefb_par *par = info->par;
 	int memlen, vramlen, mode_valid = 0;
@@ -920,10 +920,10 @@ static int savagefb_check_var (struct fb
 	if (par->SavagePanelWidth &&
 	    (var->xres > par->SavagePanelWidth ||
 	     var->yres > par->SavagePanelHeight)) {
-		printk (KERN_INFO "Mode (%dx%d) larger than the LCD panel "
-			"(%dx%d)\n", var->xres,  var->yres,
-			par->SavagePanelWidth,
-			par->SavagePanelHeight);
+		printk(KERN_INFO "Mode (%dx%d) larger than the LCD panel "
+		       "(%dx%d)\n", var->xres,  var->yres,
+		       par->SavagePanelWidth,
+		       par->SavagePanelHeight);
 		return -1;
 	}
 
@@ -958,9 +958,9 @@ static int savagefb_check_var (struct fb
 }
 
 
-static int savagefb_decode_var (struct fb_var_screeninfo   *var,
-				struct savagefb_par        *par,
-				struct savage_reg          *reg)
+static int savagefb_decode_var(struct fb_var_screeninfo   *var,
+			       struct savagefb_par        *par,
+			       struct savage_reg          *reg)
 {
 	struct xtimings timings;
 	int width, dclk, i, j; /*, refresh; */
@@ -970,7 +970,7 @@ static int savagefb_decode_var (struct f
 
 	DBG("savagefb_decode_var");
 
-	memset (&timings, 0, sizeof(timings));
+	memset(&timings, 0, sizeof(timings));
 
 	if (!pixclock) pixclock = 10000;	/* 10ns = 100MHz */
 	timings.Clock = 1000000000 / pixclock;
@@ -1002,30 +1002,30 @@ static int savagefb_decode_var (struct f
 	 * This will allocate the datastructure and initialize all of the
 	 * generic VGA registers.
 	 */
-	vgaHWInit (var, par, &timings, reg);
+	vgaHWInit(var, par, &timings, reg);
 
 	/* We need to set CR67 whether or not we use the BIOS. */
 
 	dclk = timings.Clock;
 	reg->CR67 = 0x00;
 
-	switch( var->bits_per_pixel ) {
+	switch(var->bits_per_pixel) {
 	case 8:
-		if( (par->chip == S3_SAVAGE2000) && (dclk >= 230000) )
+		if ((par->chip == S3_SAVAGE2000) && (dclk >= 230000))
 			reg->CR67 = 0x10;	/* 8bpp, 2 pixels/clock */
 		else
 			reg->CR67 = 0x00;	/* 8bpp, 1 pixel/clock */
 		break;
 	case 15:
-		if ( S3_SAVAGE_MOBILE_SERIES(par->chip) ||
-		     ((par->chip == S3_SAVAGE2000) && (dclk >= 230000)) )
+		if (S3_SAVAGE_MOBILE_SERIES(par->chip) ||
+		    ((par->chip == S3_SAVAGE2000) && (dclk >= 230000)))
 			reg->CR67 = 0x30;	/* 15bpp, 2 pixel/clock */
 		else
 			reg->CR67 = 0x20;	/* 15bpp, 1 pixels/clock */
 		break;
 	case 16:
-		if( S3_SAVAGE_MOBILE_SERIES(par->chip) ||
-		    ((par->chip == S3_SAVAGE2000) && (dclk >= 230000)) )
+		if (S3_SAVAGE_MOBILE_SERIES(par->chip) ||
+		   ((par->chip == S3_SAVAGE2000) && (dclk >= 230000)))
 			reg->CR67 = 0x50;	/* 16bpp, 2 pixel/clock */
 		else
 			reg->CR67 = 0x40;	/* 16bpp, 1 pixels/clock */
@@ -1043,8 +1043,8 @@ static int savagefb_decode_var (struct f
 	 * match.  Fall back to traditional register-crunching.
 	 */
 
-	vga_out8 (0x3d4, 0x3a, par);
-	tmp = vga_in8 (0x3d5, par);
+	vga_out8(0x3d4, 0x3a, par);
+	tmp = vga_in8(0x3d5, par);
 	if (1 /*FIXME:psav->pci_burst*/)
 		reg->CR3A = (tmp & 0x7f) | 0x15;
 	else
@@ -1054,30 +1054,30 @@ static int savagefb_decode_var (struct f
 	reg->CR31 = 0x8c;
 	reg->CR66 = 0x89;
 
-	vga_out8 (0x3d4, 0x58, par);
-	reg->CR58 = vga_in8 (0x3d5, par) & 0x80;
+	vga_out8(0x3d4, 0x58, par);
+	reg->CR58 = vga_in8(0x3d5, par) & 0x80;
 	reg->CR58 |= 0x13;
 
 	reg->SR15 = 0x03 | 0x80;
 	reg->SR18 = 0x00;
 	reg->CR43 = reg->CR45 = reg->CR65 = 0x00;
 
-	vga_out8 (0x3d4, 0x40, par);
-	reg->CR40 = vga_in8 (0x3d5, par) & ~0x01;
+	vga_out8(0x3d4, 0x40, par);
+	reg->CR40 = vga_in8(0x3d5, par) & ~0x01;
 
 	reg->MMPR0 = 0x010400;
 	reg->MMPR1 = 0x00;
 	reg->MMPR2 = 0x0808;
 	reg->MMPR3 = 0x08080810;
 
-	SavageCalcClock (dclk, 1, 1, 127, 0, 4, 180000, 360000, &m, &n, &r);
+	SavageCalcClock(dclk, 1, 1, 127, 0, 4, 180000, 360000, &m, &n, &r);
 	/* m = 107; n = 4; r = 2; */
 
 	if (par->MCLK <= 0) {
 		reg->SR10 = 255;
 		reg->SR11 = 255;
 	} else {
-		common_calc_clock (par->MCLK, 1, 1, 31, 0, 3, 135000, 270000,
+		common_calc_clock(par->MCLK, 1, 1, 31, 0, 3, 135000, 270000,
 				   &reg->SR11, &reg->SR10);
 		/*      reg->SR10 = 80; // MCLK == 286000 */
 		/*      reg->SR11 = 125; */
@@ -1158,7 +1158,7 @@ static int savagefb_decode_var (struct f
 	else
 		reg->CR50 |= 0xc1;	/* Use GBD */
 
-	if( par->chip == S3_SAVAGE2000 )
+	if (par->chip == S3_SAVAGE2000)
 		reg->CR33 = 0x08;
 	else
 		reg->CR33 = 0x20;
@@ -1168,18 +1168,18 @@ static int savagefb_decode_var (struct f
 	reg->CR67 |= 1;
 
 	vga_out8(0x3d4, 0x36, par);
-	reg->CR36 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x68, par);
-	reg->CR68 = vga_in8 (0x3d5, par);
+	reg->CR36 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x68, par);
+	reg->CR68 = vga_in8(0x3d5, par);
 	reg->CR69 = 0;
-	vga_out8 (0x3d4, 0x6f, par);
-	reg->CR6F = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x86, par);
-	reg->CR86 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d4, 0x88, par);
-	reg->CR88 = vga_in8 (0x3d5, par) | 0x08;
-	vga_out8 (0x3d4, 0xb0, par);
-	reg->CRB0 = vga_in8 (0x3d5, par) | 0x80;
+	vga_out8(0x3d4, 0x6f, par);
+	reg->CR6F = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x86, par);
+	reg->CR86 = vga_in8(0x3d5, par);
+	vga_out8(0x3d4, 0x88, par);
+	reg->CR88 = vga_in8(0x3d5, par) | 0x08;
+	vga_out8(0x3d4, 0xb0, par);
+	reg->CRB0 = vga_in8(0x3d5, par) | 0x80;
 
 	return 0;
 }
@@ -1208,11 +1208,11 @@ static int savagefb_setcolreg(unsigned  
 
 	switch (info->var.bits_per_pixel) {
 	case 8:
-		vga_out8 (0x3c8, regno, par);
+		vga_out8(0x3c8, regno, par);
 
-		vga_out8 (0x3c9, red   >> 10, par);
-		vga_out8 (0x3c9, green >> 10, par);
-		vga_out8 (0x3c9, blue  >> 10, par);
+		vga_out8(0x3c9, red   >> 10, par);
+		vga_out8(0x3c9, green >> 10, par);
+		vga_out8(0x3c9, blue  >> 10, par);
 		break;
 
 	case 16:
@@ -1246,21 +1246,21 @@ static int savagefb_setcolreg(unsigned  
 	return 0;
 }
 
-static void savagefb_set_par_int (struct savagefb_par  *par, struct savage_reg *reg)
+static void savagefb_set_par_int(struct savagefb_par  *par, struct savage_reg *reg)
 {
 	unsigned char tmp, cr3a, cr66, cr67;
 
-	DBG ("savagefb_set_par_int");
+	DBG("savagefb_set_par_int");
 
-	par->SavageWaitIdle (par);
+	par->SavageWaitIdle(par);
 
-	vga_out8 (0x3c2, 0x23, par);
+	vga_out8(0x3c2, 0x23, par);
 
-	vga_out16 (0x3d4, 0x4838, par);
-	vga_out16 (0x3d4, 0xa539, par);
-	vga_out16 (0x3c4, 0x0608, par);
+	vga_out16(0x3d4, 0x4838, par);
+	vga_out16(0x3d4, 0xa539, par);
+	vga_out16(0x3c4, 0x0608, par);
 
-	vgaHWProtect (par, 1);
+	vgaHWProtect(par, 1);
 
 	/*
 	 * Some Savage/MX and /IX systems go nuts when trying to exit the
@@ -1270,203 +1270,202 @@ static void savagefb_set_par_int (struct
 	 */
 
 	VerticalRetraceWait(par);
-	vga_out8 (0x3d4, 0x67, par);
-	cr67 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr67/*par->CR67*/ & ~0x0c, par); /* no STREAMS yet */
-
-	vga_out8 (0x3d4, 0x23, par);
-	vga_out8 (0x3d5, 0x00, par);
-	vga_out8 (0x3d4, 0x26, par);
-	vga_out8 (0x3d5, 0x00, par);
+	vga_out8(0x3d4, 0x67, par);
+	cr67 = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr67/*par->CR67*/ & ~0x0c, par); /* no STREAMS yet */
+
+	vga_out8(0x3d4, 0x23, par);
+	vga_out8(0x3d5, 0x00, par);
+	vga_out8(0x3d4, 0x26, par);
+	vga_out8(0x3d5, 0x00, par);
 
 	/* restore extended regs */
-	vga_out8 (0x3d4, 0x66, par);
-	vga_out8 (0x3d5, reg->CR66, par);
-	vga_out8 (0x3d4, 0x3a, par);
-	vga_out8 (0x3d5, reg->CR3A, par);
-	vga_out8 (0x3d4, 0x31, par);
-	vga_out8 (0x3d5, reg->CR31, par);
-	vga_out8 (0x3d4, 0x32, par);
-	vga_out8 (0x3d5, reg->CR32, par);
-	vga_out8 (0x3d4, 0x58, par);
-	vga_out8 (0x3d5, reg->CR58, par);
-	vga_out8 (0x3d4, 0x53, par);
-	vga_out8 (0x3d5, reg->CR53 & 0x7f, par);
+	vga_out8(0x3d4, 0x66, par);
+	vga_out8(0x3d5, reg->CR66, par);
+	vga_out8(0x3d4, 0x3a, par);
+	vga_out8(0x3d5, reg->CR3A, par);
+	vga_out8(0x3d4, 0x31, par);
+	vga_out8(0x3d5, reg->CR31, par);
+	vga_out8(0x3d4, 0x32, par);
+	vga_out8(0x3d5, reg->CR32, par);
+	vga_out8(0x3d4, 0x58, par);
+	vga_out8(0x3d5, reg->CR58, par);
+	vga_out8(0x3d4, 0x53, par);
+	vga_out8(0x3d5, reg->CR53 & 0x7f, par);
 
-	vga_out16 (0x3c4, 0x0608, par);
+	vga_out16(0x3c4, 0x0608, par);
 
 	/* Restore DCLK registers. */
 
-	vga_out8 (0x3c4, 0x0e, par);
-	vga_out8 (0x3c5, reg->SR0E, par);
-	vga_out8 (0x3c4, 0x0f, par);
-	vga_out8 (0x3c5, reg->SR0F, par);
-	vga_out8 (0x3c4, 0x29, par);
-	vga_out8 (0x3c5, reg->SR29, par);
-	vga_out8 (0x3c4, 0x15, par);
-	vga_out8 (0x3c5, reg->SR15, par);
+	vga_out8(0x3c4, 0x0e, par);
+	vga_out8(0x3c5, reg->SR0E, par);
+	vga_out8(0x3c4, 0x0f, par);
+	vga_out8(0x3c5, reg->SR0F, par);
+	vga_out8(0x3c4, 0x29, par);
+	vga_out8(0x3c5, reg->SR29, par);
+	vga_out8(0x3c4, 0x15, par);
+	vga_out8(0x3c5, reg->SR15, par);
 
 	/* Restore flat panel expansion regsters. */
-	if( par->chip == S3_SAVAGE_MX ) {
+	if (par->chip == S3_SAVAGE_MX) {
 		int i;
 
-		for( i = 0; i < 8; i++ ) {
-			vga_out8 (0x3c4, 0x54+i, par);
-			vga_out8 (0x3c5, reg->SR54[i], par);
+		for (i = 0; i < 8; i++) {
+			vga_out8(0x3c4, 0x54+i, par);
+			vga_out8(0x3c5, reg->SR54[i], par);
 		}
 	}
 
 	vgaHWRestore (par, reg);
 
 	/* extended mode timing registers */
-	vga_out8 (0x3d4, 0x53, par);
-	vga_out8 (0x3d5, reg->CR53, par);
-	vga_out8 (0x3d4, 0x5d, par);
-	vga_out8 (0x3d5, reg->CR5D, par);
-	vga_out8 (0x3d4, 0x5e, par);
-	vga_out8 (0x3d5, reg->CR5E, par);
-	vga_out8 (0x3d4, 0x3b, par);
-	vga_out8 (0x3d5, reg->CR3B, par);
-	vga_out8 (0x3d4, 0x3c, par);
-	vga_out8 (0x3d5, reg->CR3C, par);
-	vga_out8 (0x3d4, 0x43, par);
-	vga_out8 (0x3d5, reg->CR43, par);
-	vga_out8 (0x3d4, 0x65, par);
-	vga_out8 (0x3d5, reg->CR65, par);
+	vga_out8(0x3d4, 0x53, par);
+	vga_out8(0x3d5, reg->CR53, par);
+	vga_out8(0x3d4, 0x5d, par);
+	vga_out8(0x3d5, reg->CR5D, par);
+	vga_out8(0x3d4, 0x5e, par);
+	vga_out8(0x3d5, reg->CR5E, par);
+	vga_out8(0x3d4, 0x3b, par);
+	vga_out8(0x3d5, reg->CR3B, par);
+	vga_out8(0x3d4, 0x3c, par);
+	vga_out8(0x3d5, reg->CR3C, par);
+	vga_out8(0x3d4, 0x43, par);
+	vga_out8(0x3d5, reg->CR43, par);
+	vga_out8(0x3d4, 0x65, par);
+	vga_out8(0x3d5, reg->CR65, par);
 
 	/* restore the desired video mode with cr67 */
-	vga_out8 (0x3d4, 0x67, par);
+	vga_out8(0x3d4, 0x67, par);
 	/* following part not present in X11 driver */
-	cr67 = vga_in8 (0x3d5, par) & 0xf;
-	vga_out8 (0x3d5, 0x50 | cr67, par);
-	udelay (10000);
-	vga_out8 (0x3d4, 0x67, par);
+	cr67 = vga_in8(0x3d5, par) & 0xf;
+	vga_out8(0x3d5, 0x50 | cr67, par);
+	udelay(10000);
+	vga_out8(0x3d4, 0x67, par);
 	/* end of part */
-	vga_out8 (0x3d5, reg->CR67 & ~0x0c, par);
+	vga_out8(0x3d5, reg->CR67 & ~0x0c, par);
 
 	/* other mode timing and extended regs */
-	vga_out8 (0x3d4, 0x34, par);
-	vga_out8 (0x3d5, reg->CR34, par);
-	vga_out8 (0x3d4, 0x40, par);
-	vga_out8 (0x3d5, reg->CR40, par);
-	vga_out8 (0x3d4, 0x42, par);
-	vga_out8 (0x3d5, reg->CR42, par);
-	vga_out8 (0x3d4, 0x45, par);
-	vga_out8 (0x3d5, reg->CR45, par);
-	vga_out8 (0x3d4, 0x50, par);
-	vga_out8 (0x3d5, reg->CR50, par);
-	vga_out8 (0x3d4, 0x51, par);
-	vga_out8 (0x3d5, reg->CR51, par);
+	vga_out8(0x3d4, 0x34, par);
+	vga_out8(0x3d5, reg->CR34, par);
+	vga_out8(0x3d4, 0x40, par);
+	vga_out8(0x3d5, reg->CR40, par);
+	vga_out8(0x3d4, 0x42, par);
+	vga_out8(0x3d5, reg->CR42, par);
+	vga_out8(0x3d4, 0x45, par);
+	vga_out8(0x3d5, reg->CR45, par);
+	vga_out8(0x3d4, 0x50, par);
+	vga_out8(0x3d5, reg->CR50, par);
+	vga_out8(0x3d4, 0x51, par);
+	vga_out8(0x3d5, reg->CR51, par);
 
 	/* memory timings */
-	vga_out8 (0x3d4, 0x36, par);
-	vga_out8 (0x3d5, reg->CR36, par);
-	vga_out8 (0x3d4, 0x60, par);
-	vga_out8 (0x3d5, reg->CR60, par);
-	vga_out8 (0x3d4, 0x68, par);
-	vga_out8 (0x3d5, reg->CR68, par);
-	vga_out8 (0x3d4, 0x69, par);
-	vga_out8 (0x3d5, reg->CR69, par);
-	vga_out8 (0x3d4, 0x6f, par);
-	vga_out8 (0x3d5, reg->CR6F, par);
-
-	vga_out8 (0x3d4, 0x33, par);
-	vga_out8 (0x3d5, reg->CR33, par);
-	vga_out8 (0x3d4, 0x86, par);
-	vga_out8 (0x3d5, reg->CR86, par);
-	vga_out8 (0x3d4, 0x88, par);
-	vga_out8 (0x3d5, reg->CR88, par);
-	vga_out8 (0x3d4, 0x90, par);
-	vga_out8 (0x3d5, reg->CR90, par);
-	vga_out8 (0x3d4, 0x91, par);
-	vga_out8 (0x3d5, reg->CR91, par);
+	vga_out8(0x3d4, 0x36, par);
+	vga_out8(0x3d5, reg->CR36, par);
+	vga_out8(0x3d4, 0x60, par);
+	vga_out8(0x3d5, reg->CR60, par);
+	vga_out8(0x3d4, 0x68, par);
+	vga_out8(0x3d5, reg->CR68, par);
+	vga_out8(0x3d4, 0x69, par);
+	vga_out8(0x3d5, reg->CR69, par);
+	vga_out8(0x3d4, 0x6f, par);
+	vga_out8(0x3d5, reg->CR6F, par);
+
+	vga_out8(0x3d4, 0x33, par);
+	vga_out8(0x3d5, reg->CR33, par);
+	vga_out8(0x3d4, 0x86, par);
+	vga_out8(0x3d5, reg->CR86, par);
+	vga_out8(0x3d4, 0x88, par);
+	vga_out8(0x3d5, reg->CR88, par);
+	vga_out8(0x3d4, 0x90, par);
+	vga_out8(0x3d5, reg->CR90, par);
+	vga_out8(0x3d4, 0x91, par);
+	vga_out8(0x3d5, reg->CR91, par);
 
 	if (par->chip == S3_SAVAGE4) {
-		vga_out8 (0x3d4, 0xb0, par);
-		vga_out8 (0x3d5, reg->CRB0, par);
+		vga_out8(0x3d4, 0xb0, par);
+		vga_out8(0x3d5, reg->CRB0, par);
 	}
 
-	vga_out8 (0x3d4, 0x32, par);
-	vga_out8 (0x3d5, reg->CR32, par);
+	vga_out8(0x3d4, 0x32, par);
+	vga_out8(0x3d5, reg->CR32, par);
 
 	/* unlock extended seq regs */
-	vga_out8 (0x3c4, 0x08, par);
-	vga_out8 (0x3c5, 0x06, par);
+	vga_out8(0x3c4, 0x08, par);
+	vga_out8(0x3c5, 0x06, par);
 
 	/* Restore extended sequencer regs for MCLK. SR10 == 255 indicates
 	 * that we should leave the default SR10 and SR11 values there.
 	 */
 	if (reg->SR10 != 255) {
-		vga_out8 (0x3c4, 0x10, par);
-		vga_out8 (0x3c5, reg->SR10, par);
-		vga_out8 (0x3c4, 0x11, par);
-		vga_out8 (0x3c5, reg->SR11, par);
+		vga_out8(0x3c4, 0x10, par);
+		vga_out8(0x3c5, reg->SR10, par);
+		vga_out8(0x3c4, 0x11, par);
+		vga_out8(0x3c5, reg->SR11, par);
 	}
 
 	/* restore extended seq regs for dclk */
-	vga_out8 (0x3c4, 0x0e, par);
-	vga_out8 (0x3c5, reg->SR0E, par);
-	vga_out8 (0x3c4, 0x0f, par);
-	vga_out8 (0x3c5, reg->SR0F, par);
-	vga_out8 (0x3c4, 0x12, par);
-	vga_out8 (0x3c5, reg->SR12, par);
-	vga_out8 (0x3c4, 0x13, par);
-	vga_out8 (0x3c5, reg->SR13, par);
-	vga_out8 (0x3c4, 0x29, par);
-	vga_out8 (0x3c5, reg->SR29, par);
-
-	vga_out8 (0x3c4, 0x18, par);
-	vga_out8 (0x3c5, reg->SR18, par);
+	vga_out8(0x3c4, 0x0e, par);
+	vga_out8(0x3c5, reg->SR0E, par);
+	vga_out8(0x3c4, 0x0f, par);
+	vga_out8(0x3c5, reg->SR0F, par);
+	vga_out8(0x3c4, 0x12, par);
+	vga_out8(0x3c5, reg->SR12, par);
+	vga_out8(0x3c4, 0x13, par);
+	vga_out8(0x3c5, reg->SR13, par);
+	vga_out8(0x3c4, 0x29, par);
+	vga_out8(0x3c5, reg->SR29, par);
+	vga_out8(0x3c4, 0x18, par);
+	vga_out8(0x3c5, reg->SR18, par);
 
 	/* load new m, n pll values for dclk & mclk */
-	vga_out8 (0x3c4, 0x15, par);
-	tmp = vga_in8 (0x3c5, par) & ~0x21;
+	vga_out8(0x3c4, 0x15, par);
+	tmp = vga_in8(0x3c5, par) & ~0x21;
+
+	vga_out8(0x3c5, tmp | 0x03, par);
+	vga_out8(0x3c5, tmp | 0x23, par);
+	vga_out8(0x3c5, tmp | 0x03, par);
+	vga_out8(0x3c5, reg->SR15, par);
+	udelay(100);
 
-	vga_out8 (0x3c5, tmp | 0x03, par);
-	vga_out8 (0x3c5, tmp | 0x23, par);
-	vga_out8 (0x3c5, tmp | 0x03, par);
-	vga_out8 (0x3c5, reg->SR15, par);
-	udelay (100);
-
-	vga_out8 (0x3c4, 0x30, par);
-	vga_out8 (0x3c5, reg->SR30, par);
-	vga_out8 (0x3c4, 0x08, par);
-	vga_out8 (0x3c5, reg->SR08, par);
+	vga_out8(0x3c4, 0x30, par);
+	vga_out8(0x3c5, reg->SR30, par);
+	vga_out8(0x3c4, 0x08, par);
+	vga_out8(0x3c5, reg->SR08, par);
 
 	/* now write out cr67 in full, possibly starting STREAMS */
 	VerticalRetraceWait(par);
-	vga_out8 (0x3d4, 0x67, par);
-	vga_out8 (0x3d5, reg->CR67, par);
+	vga_out8(0x3d4, 0x67, par);
+	vga_out8(0x3d5, reg->CR67, par);
 
-	vga_out8 (0x3d4, 0x66, par);
-	cr66 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr66 | 0x80, par);
-	vga_out8 (0x3d4, 0x3a, par);
-	cr3a = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr3a | 0x80, par);
+	vga_out8(0x3d4, 0x66, par);
+	cr66 = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr66 | 0x80, par);
+	vga_out8(0x3d4, 0x3a, par);
+	cr3a = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr3a | 0x80, par);
 
 	if (par->chip != S3_SAVAGE_MX) {
 		VerticalRetraceWait(par);
-		savage_out32 (FIFO_CONTROL_REG, reg->MMPR0, par);
-		par->SavageWaitIdle (par);
-		savage_out32 (MIU_CONTROL_REG, reg->MMPR1, par);
-		par->SavageWaitIdle (par);
-		savage_out32 (STREAMS_TIMEOUT_REG, reg->MMPR2, par);
-		par->SavageWaitIdle (par);
-		savage_out32 (MISC_TIMEOUT_REG, reg->MMPR3, par);
-	}
-
-	vga_out8 (0x3d4, 0x66, par);
-	vga_out8 (0x3d5, cr66, par);
-	vga_out8 (0x3d4, 0x3a, par);
-	vga_out8 (0x3d5, cr3a, par);
+		savage_out32(FIFO_CONTROL_REG, reg->MMPR0, par);
+		par->SavageWaitIdle(par);
+		savage_out32(MIU_CONTROL_REG, reg->MMPR1, par);
+		par->SavageWaitIdle(par);
+		savage_out32(STREAMS_TIMEOUT_REG, reg->MMPR2, par);
+		par->SavageWaitIdle(par);
+		savage_out32(MISC_TIMEOUT_REG, reg->MMPR3, par);
+	}
 
-	SavageSetup2DEngine (par);
-	vgaHWProtect (par, 0);
+	vga_out8(0x3d4, 0x66, par);
+	vga_out8(0x3d5, cr66, par);
+	vga_out8(0x3d4, 0x3a, par);
+	vga_out8(0x3d5, cr3a, par);
+
+	SavageSetup2DEngine(par);
+	vgaHWProtect(par, 0);
 }
 
-static void savagefb_update_start (struct savagefb_par      *par,
-				   struct fb_var_screeninfo *var)
+static void savagefb_update_start(struct savagefb_par      *par,
+				  struct fb_var_screeninfo *var)
 {
 	int base;
 
@@ -1476,8 +1475,8 @@ static void savagefb_update_start (struc
 	/* now program the start address registers */
 	vga_out16(0x3d4, (base & 0x00ff00) | 0x0c, par);
 	vga_out16(0x3d4, ((base & 0x00ff) << 8) | 0x0d, par);
-	vga_out8 (0x3d4, 0x69, par);
-	vga_out8 (0x3d5, (base & 0x7f0000) >> 16, par);
+	vga_out8(0x3d4, 0x69, par);
+	vga_out8(0x3d5, (base & 0x7f0000) >> 16, par);
 }
 
 
@@ -1496,14 +1495,14 @@ static void savagefb_set_fix(struct fb_i
 
 }
 
-static int savagefb_set_par (struct fb_info *info)
+static int savagefb_set_par(struct fb_info *info)
 {
 	struct savagefb_par *par = info->par;
 	struct fb_var_screeninfo *var = &info->var;
 	int err;
 
 	DBG("savagefb_set_par");
-	err = savagefb_decode_var (var, par, &par->state);
+	err = savagefb_decode_var(var, par, &par->state);
 	if (err)
 		return err;
 
@@ -1522,8 +1521,8 @@ static int savagefb_set_par (struct fb_i
 	par->maxClock = par->dacSpeedBpp;
 	par->minClock = 10000;
 
-	savagefb_set_par_int (par, &par->state);
-	fb_set_cmap (&info->cmap, info);
+	savagefb_set_par_int(par, &par->state);
+	fb_set_cmap(&info->cmap, info);
 	savagefb_set_fix(info);
 	savagefb_set_clip(info);
 
@@ -1534,12 +1533,12 @@ static int savagefb_set_par (struct fb_i
 /*
  *    Pan or Wrap the Display
  */
-static int savagefb_pan_display (struct fb_var_screeninfo *var,
-				 struct fb_info           *info)
+static int savagefb_pan_display(struct fb_var_screeninfo *var,
+				struct fb_info           *info)
 {
 	struct savagefb_par *par = info->par;
 
-	savagefb_update_start (par, var);
+	savagefb_update_start(par, var);
 	return 0;
 }
 
@@ -1653,59 +1652,59 @@ static struct fb_var_screeninfo __devini
 	.vmode =	FB_VMODE_NONINTERLACED
 };
 
-static void savage_enable_mmio (struct savagefb_par *par)
+static void savage_enable_mmio(struct savagefb_par *par)
 {
 	unsigned char val;
 
-	DBG ("savage_enable_mmio\n");
+	DBG("savage_enable_mmio\n");
 
-	val = vga_in8 (0x3c3, par);
-	vga_out8 (0x3c3, val | 0x01, par);
-	val = vga_in8 (0x3cc, par);
-	vga_out8 (0x3c2, val | 0x01, par);
+	val = vga_in8(0x3c3, par);
+	vga_out8(0x3c3, val | 0x01, par);
+	val = vga_in8(0x3cc, par);
+	vga_out8(0x3c2, val | 0x01, par);
 
 	if (par->chip >= S3_SAVAGE4) {
-		vga_out8 (0x3d4, 0x40, par);
-		val = vga_in8 (0x3d5, par);
-		vga_out8 (0x3d5, val | 1, par);
+		vga_out8(0x3d4, 0x40, par);
+		val = vga_in8(0x3d5, par);
+		vga_out8(0x3d5, val | 1, par);
 	}
 }
 
 
-static void savage_disable_mmio (struct savagefb_par *par)
+static void savage_disable_mmio(struct savagefb_par *par)
 {
 	unsigned char val;
 
-	DBG ("savage_disable_mmio\n");
+	DBG("savage_disable_mmio\n");
 
-	if(par->chip >= S3_SAVAGE4 ) {
-		vga_out8 (0x3d4, 0x40, par);
-		val = vga_in8 (0x3d5, par);
-		vga_out8 (0x3d5, val | 1, par);
+	if (par->chip >= S3_SAVAGE4) {
+		vga_out8(0x3d4, 0x40, par);
+		val = vga_in8(0x3d5, par);
+		vga_out8(0x3d5, val | 1, par);
 	}
 }
 
 
-static int __devinit savage_map_mmio (struct fb_info *info)
+static int __devinit savage_map_mmio(struct fb_info *info)
 {
 	struct savagefb_par *par = info->par;
-	DBG ("savage_map_mmio");
+	DBG("savage_map_mmio");
 
-	if (S3_SAVAGE3D_SERIES (par->chip))
-		par->mmio.pbase = pci_resource_start (par->pcidev, 0) +
+	if (S3_SAVAGE3D_SERIES(par->chip))
+		par->mmio.pbase = pci_resource_start(par->pcidev, 0) +
 			SAVAGE_NEWMMIO_REGBASE_S3;
 	else
-		par->mmio.pbase = pci_resource_start (par->pcidev, 0) +
+		par->mmio.pbase = pci_resource_start(par->pcidev, 0) +
 			SAVAGE_NEWMMIO_REGBASE_S4;
 
 	par->mmio.len = SAVAGE_NEWMMIO_REGSIZE;
 
-	par->mmio.vbase = ioremap (par->mmio.pbase, par->mmio.len);
+	par->mmio.vbase = ioremap(par->mmio.pbase, par->mmio.len);
 	if (!par->mmio.vbase) {
-		printk ("savagefb: unable to map memory mapped IO\n");
+		printk("savagefb: unable to map memory mapped IO\n");
 		return -ENOMEM;
 	} else
-		printk (KERN_INFO "savagefb: mapped io at %p\n",
+		printk(KERN_INFO "savagefb: mapped io at %p\n",
 			par->mmio.vbase);
 
 	info->fix.mmio_start = par->mmio.pbase;
@@ -1714,15 +1713,15 @@ static int __devinit savage_map_mmio (st
 	par->bci_base = (u32 __iomem *)(par->mmio.vbase + BCI_BUFFER_OFFSET);
 	par->bci_ptr  = 0;
 
-	savage_enable_mmio (par);
+	savage_enable_mmio(par);
 
 	return 0;
 }
 
-static void savage_unmap_mmio (struct fb_info *info)
+static void savage_unmap_mmio(struct fb_info *info)
 {
 	struct savagefb_par *par = info->par;
-	DBG ("savage_unmap_mmio");
+	DBG("savage_unmap_mmio");
 
 	savage_disable_mmio(par);
 
@@ -1732,46 +1731,46 @@ static void savage_unmap_mmio (struct fb
 	}
 }
 
-static int __devinit savage_map_video (struct fb_info *info,
-				       int video_len)
+static int __devinit savage_map_video(struct fb_info *info,
+				      int video_len)
 {
 	struct savagefb_par *par = info->par;
 	int resource;
 
 	DBG("savage_map_video");
 
-	if (S3_SAVAGE3D_SERIES (par->chip))
+	if (S3_SAVAGE3D_SERIES(par->chip))
 		resource = 0;
 	else
 		resource = 1;
 
-	par->video.pbase = pci_resource_start (par->pcidev, resource);
+	par->video.pbase = pci_resource_start(par->pcidev, resource);
 	par->video.len   = video_len;
-	par->video.vbase = ioremap (par->video.pbase, par->video.len);
+	par->video.vbase = ioremap(par->video.pbase, par->video.len);
 
 	if (!par->video.vbase) {
-		printk ("savagefb: unable to map screen memory\n");
+		printk("savagefb: unable to map screen memory\n");
 		return -ENOMEM;
 	} else
-		printk (KERN_INFO "savagefb: mapped framebuffer at %p, "
-			"pbase == %x\n", par->video.vbase, par->video.pbase);
+		printk(KERN_INFO "savagefb: mapped framebuffer at %p, "
+		       "pbase == %x\n", par->video.vbase, par->video.pbase);
 
 	info->fix.smem_start = par->video.pbase;
 	info->fix.smem_len   = par->video.len - par->cob_size;
 	info->screen_base    = par->video.vbase;
 
 #ifdef CONFIG_MTRR
-	par->video.mtrr = mtrr_add (par->video.pbase, video_len,
-				     MTRR_TYPE_WRCOMB, 1);
+	par->video.mtrr = mtrr_add(par->video.pbase, video_len,
+				   MTRR_TYPE_WRCOMB, 1);
 #endif
 
 	/* Clear framebuffer, it's all white in memory after boot */
-	memset_io (par->video.vbase, 0, par->video.len);
+	memset_io(par->video.vbase, 0, par->video.len);
 
 	return 0;
 }
 
-static void savage_unmap_video (struct fb_info *info)
+static void savage_unmap_video(struct fb_info *info)
 {
 	struct savagefb_par *par = info->par;
 
@@ -1779,16 +1778,16 @@ static void savage_unmap_video (struct f
 
 	if (par->video.vbase) {
 #ifdef CONFIG_MTRR
-		mtrr_del (par->video.mtrr, par->video.pbase, par->video.len);
+		mtrr_del(par->video.mtrr, par->video.pbase, par->video.len);
 #endif
 
-		iounmap (par->video.vbase);
+		iounmap(par->video.vbase);
 		par->video.vbase = NULL;
 		info->screen_base = NULL;
 	}
 }
 
-static int savage_init_hw (struct savagefb_par *par)
+static int savage_init_hw(struct savagefb_par *par)
 {
 	unsigned char config1, m, n, n1, n2, sr8, cr3f, cr66 = 0, tmp;
 
@@ -1830,7 +1829,7 @@ static int savage_init_hw (struct savage
 
 	switch  (par->chip) {
 	case S3_SAVAGE3D:
-		videoRam = RamSavage3D[ (config1 & 0xC0) >> 6 ] * 1024;
+		videoRam = RamSavage3D[(config1 & 0xC0) >> 6 ] * 1024;
 		break;
 
 	case S3_SAVAGE4:
@@ -1841,22 +1840,22 @@ static int savage_init_hw (struct savage
 		 * can do it different...
 		 */
 		vga_out8(0x3d4, 0x68, par);	/* memory control 1 */
-		if( (vga_in8(0x3d5, par) & 0xC0) == (0x01 << 6) )
+		if ((vga_in8(0x3d5, par) & 0xC0) == (0x01 << 6))
 			RamSavage4[1] = 8;
 
 		/*FALLTHROUGH*/
 
 	case S3_SAVAGE2000:
-		videoRam = RamSavage4[ (config1 & 0xE0) >> 5 ] * 1024;
+		videoRam = RamSavage4[(config1 & 0xE0) >> 5] * 1024;
 		break;
 
 	case S3_SAVAGE_MX:
 	case S3_SUPERSAVAGE:
-		videoRam = RamSavageMX[ (config1 & 0x0E) >> 1 ] * 1024;
+		videoRam = RamSavageMX[(config1 & 0x0E) >> 1] * 1024;
 		break;
 
 	case S3_PROSAVAGE:
-		videoRam = RamSavageNB[ (config1 & 0xE0) >> 5 ] * 1024;
+		videoRam = RamSavageNB[(config1 & 0xE0) >> 5] * 1024;
 		break;
 
 	default:
@@ -1867,31 +1866,31 @@ static int savage_init_hw (struct savage
 
 	videoRambytes = videoRam * 1024;
 
-	printk (KERN_INFO "savagefb: probed videoram:  %dk\n", videoRam);
+	printk(KERN_INFO "savagefb: probed videoram:  %dk\n", videoRam);
 
 	/* reset graphics engine to avoid memory corruption */
-	vga_out8 (0x3d4, 0x66, par);
-	cr66 = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr66 | 0x02, par);
-	udelay (10000);
-
-	vga_out8 (0x3d4, 0x66, par);
-	vga_out8 (0x3d5, cr66 & ~0x02, par);	/* clear reset flag */
-	udelay (10000);
+	vga_out8(0x3d4, 0x66, par);
+	cr66 = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr66 | 0x02, par);
+	udelay(10000);
+
+	vga_out8(0x3d4, 0x66, par);
+	vga_out8(0x3d5, cr66 & ~0x02, par);	/* clear reset flag */
+	udelay(10000);
 
 
 	/*
 	 * reset memory interface, 3D engine, AGP master, PCI master,
 	 * master engine unit, motion compensation/LPB
 	 */
-	vga_out8 (0x3d4, 0x3f, par);
-	cr3f = vga_in8 (0x3d5, par);
-	vga_out8 (0x3d5, cr3f | 0x08, par);
-	udelay (10000);
-
-	vga_out8 (0x3d4, 0x3f, par);
-	vga_out8 (0x3d5, cr3f & ~0x08, par);	/* clear reset flags */
-	udelay (10000);
+	vga_out8(0x3d4, 0x3f, par);
+	cr3f = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, cr3f | 0x08, par);
+	udelay(10000);
+
+	vga_out8(0x3d4, 0x3f, par);
+	vga_out8(0x3d5, cr3f & ~0x08, par);	/* clear reset flags */
+	udelay(10000);
 
 	/* Savage ramdac speeds */
 	par->numClocks = 4;
@@ -1914,7 +1913,7 @@ static int savage_init_hw (struct savage
 	n1 = n & 0x1f;
 	n2 = (n >> 5) & 0x03;
 	par->MCLK = ((1431818 * (m+2)) / (n1+2) / (1 << n2) + 50) / 100;
-	printk (KERN_INFO "savagefb: Detected current MCLK value of %d kHz\n",
+	printk(KERN_INFO "savagefb: Detected current MCLK value of %d kHz\n",
 		par->MCLK);
 
 	/* check for DVI/flat panel */
@@ -1943,12 +1942,12 @@ static int savage_init_hw (struct savage
 	/* Check LCD panel parrmation */
 
 	if (par->display_type == DISP_LCD) {
-		unsigned char cr6b = VGArCR( 0x6b, par);
+		unsigned char cr6b = VGArCR(0x6b, par);
 
-		int panelX = (VGArSEQ (0x61, par) +
-			      ((VGArSEQ (0x66, par) & 0x02) << 7) + 1) * 8;
-		int panelY = (VGArSEQ (0x69, par) +
-			      ((VGArSEQ (0x6e, par) & 0x70) << 4) + 1);
+		int panelX = (VGArSEQ(0x61, par) +
+			      ((VGArSEQ(0x66, par) & 0x02) << 7) + 1) * 8;
+		int panelY = (VGArSEQ(0x69, par) +
+			      ((VGArSEQ(0x6e, par) & 0x70) << 4) + 1);
 
 		char * sTechnology = "Unknown";
 
@@ -1970,26 +1969,26 @@ static int savage_init_hw (struct savage
 			ActiveDUO = 0x80
 		};
 
-		if ((VGArSEQ (0x39, par) & 0x03) == 0) {
+		if ((VGArSEQ(0x39, par) & 0x03) == 0) {
 			sTechnology = "TFT";
-		} else if ((VGArSEQ (0x30, par) & 0x01) == 0) {
+		} else if ((VGArSEQ(0x30, par) & 0x01) == 0) {
 			sTechnology = "DSTN";
 		} else 	{
 			sTechnology = "STN";
 		}
 
-		printk (KERN_INFO "savagefb: %dx%d %s LCD panel detected %s\n",
-			panelX, panelY, sTechnology,
-			cr6b & ActiveLCD ? "and active" : "but not active");
+		printk(KERN_INFO "savagefb: %dx%d %s LCD panel detected %s\n",
+		       panelX, panelY, sTechnology,
+		       cr6b & ActiveLCD ? "and active" : "but not active");
 
-		if( cr6b & ActiveLCD ) 	{
+		if (cr6b & ActiveLCD) 	{
 			/*
 			 * If the LCD is active and panel expansion is enabled,
 			 * we probably want to kill the HW cursor.
 			 */
 
-			printk (KERN_INFO "savagefb: Limiting video mode to "
-				"%dx%d\n", panelX, panelY );
+			printk(KERN_INFO "savagefb: Limiting video mode to "
+				"%dx%d\n", panelX, panelY);
 
 			par->SavagePanelWidth = panelX;
 			par->SavagePanelHeight = panelY;
@@ -1998,10 +1997,10 @@ static int savage_init_hw (struct savage
 			par->display_type = DISP_CRT;
 	}
 
-	savage_get_default_par (par, &par->state);
+	savage_get_default_par(par, &par->state);
 	par->save = par->state;
 
-	if( S3_SAVAGE4_SERIES(par->chip) ) {
+	if (S3_SAVAGE4_SERIES(par->chip)) {
 		/*
 		 * The Savage4 and ProSavage have COB coherency bugs which
 		 * render the buffer useless.  We disable it.
@@ -2020,9 +2019,9 @@ static int savage_init_hw (struct savage
 	return videoRambytes;
 }
 
-static int __devinit savage_init_fb_info (struct fb_info *info,
-					  struct pci_dev *dev,
-					  const struct pci_device_id *id)
+static int __devinit savage_init_fb_info(struct fb_info *info,
+					 struct pci_dev *dev,
+					 const struct pci_device_id *id)
 {
 	struct savagefb_par *par = info->par;
 	int err = 0;
@@ -2038,63 +2037,63 @@ static int __devinit savage_init_fb_info
 	switch (info->fix.accel) {
 	case FB_ACCEL_SUPERSAVAGE:
 		par->chip = S3_SUPERSAVAGE;
-		snprintf (info->fix.id, 16, "SuperSavage");
+		snprintf(info->fix.id, 16, "SuperSavage");
 		break;
 	case FB_ACCEL_SAVAGE4:
 		par->chip = S3_SAVAGE4;
-		snprintf (info->fix.id, 16, "Savage4");
+		snprintf(info->fix.id, 16, "Savage4");
 		break;
 	case FB_ACCEL_SAVAGE3D:
 		par->chip = S3_SAVAGE3D;
-		snprintf (info->fix.id, 16, "Savage3D");
+		snprintf(info->fix.id, 16, "Savage3D");
 		break;
 	case FB_ACCEL_SAVAGE3D_MV:
 		par->chip = S3_SAVAGE3D;
-		snprintf (info->fix.id, 16, "Savage3D-MV");
+		snprintf(info->fix.id, 16, "Savage3D-MV");
 		break;
 	case FB_ACCEL_SAVAGE2000:
 		par->chip = S3_SAVAGE2000;
-		snprintf (info->fix.id, 16, "Savage2000");
+		snprintf(info->fix.id, 16, "Savage2000");
 		break;
 	case FB_ACCEL_SAVAGE_MX_MV:
 		par->chip = S3_SAVAGE_MX;
-		snprintf (info->fix.id, 16, "Savage/MX-MV");
+		snprintf(info->fix.id, 16, "Savage/MX-MV");
 		break;
 	case FB_ACCEL_SAVAGE_MX:
 		par->chip = S3_SAVAGE_MX;
-		snprintf (info->fix.id, 16, "Savage/MX");
+		snprintf(info->fix.id, 16, "Savage/MX");
 		break;
 	case FB_ACCEL_SAVAGE_IX_MV:
 		par->chip = S3_SAVAGE_MX;
-		snprintf (info->fix.id, 16, "Savage/IX-MV");
+		snprintf(info->fix.id, 16, "Savage/IX-MV");
 		break;
 	case FB_ACCEL_SAVAGE_IX:
 		par->chip = S3_SAVAGE_MX;
-		snprintf (info->fix.id, 16, "Savage/IX");
+		snprintf(info->fix.id, 16, "Savage/IX");
 		break;
 	case FB_ACCEL_PROSAVAGE_PM:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "ProSavagePM");
+		snprintf(info->fix.id, 16, "ProSavagePM");
 		break;
 	case FB_ACCEL_PROSAVAGE_KM:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "ProSavageKM");
+		snprintf(info->fix.id, 16, "ProSavageKM");
 		break;
 	case FB_ACCEL_S3TWISTER_P:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "TwisterP");
+		snprintf(info->fix.id, 16, "TwisterP");
 		break;
 	case FB_ACCEL_S3TWISTER_K:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "TwisterK");
+		snprintf(info->fix.id, 16, "TwisterK");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDR:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "ProSavageDDR");
+		snprintf(info->fix.id, 16, "ProSavageDDR");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDRK:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "ProSavage8");
+		snprintf(info->fix.id, 16, "ProSavage8");
 		break;
 	}
 
@@ -2135,7 +2134,7 @@ static int __devinit savage_init_fb_info
 		info->pixmap.buf_align = 4;
 		info->pixmap.access_align = 32;
 
-		err = fb_alloc_cmap (&info->cmap, NR_PALETTE, 0);
+		err = fb_alloc_cmap(&info->cmap, NR_PALETTE, 0);
 		if (!err)
 		info->flags |= FBINFO_HWACCEL_COPYAREA |
 	                       FBINFO_HWACCEL_FILLRECT |
@@ -2147,8 +2146,8 @@ static int __devinit savage_init_fb_info
 
 /* --------------------------------------------------------------------- */
 
-static int __devinit savagefb_probe (struct pci_dev* dev,
-				     const struct pci_device_id* id)
+static int __devinit savagefb_probe(struct pci_dev* dev,
+				    const struct pci_device_id* id)
 {
 	struct fb_info *info;
 	struct savagefb_par *par;
@@ -2260,12 +2259,12 @@ static int __devinit savagefb_probe (str
 	fb_destroy_modedb(info->monspecs.modedb);
 	info->monspecs.modedb = NULL;
 
-	err = register_framebuffer (info);
+	err = register_framebuffer(info);
 	if (err < 0)
 		goto failed;
 
-	printk (KERN_INFO "fb: S3 %s frame buffer device\n",
-		info->fix.id);
+	printk(KERN_INFO "fb: S3 %s frame buffer device\n",
+	       info->fix.id);
 
 	/*
 	 * Our driver data
@@ -2278,10 +2277,10 @@ static int __devinit savagefb_probe (str
 #ifdef CONFIG_FB_SAVAGE_I2C
 	savagefb_delete_i2c_busses(info);
 #endif
-	fb_alloc_cmap (&info->cmap, 0, 0);
+	fb_alloc_cmap(&info->cmap, 0, 0);
 	savage_unmap_video(info);
  failed_video:
-	savage_unmap_mmio (info);
+	savage_unmap_mmio(info);
  failed_mmio:
 	kfree(info->pixmap.addr);
  failed_init:
@@ -2292,7 +2291,7 @@ static int __devinit savagefb_probe (str
 	return err;
 }
 
-static void __devexit savagefb_remove (struct pci_dev *dev)
+static void __devexit savagefb_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 
@@ -2304,16 +2303,16 @@ static void __devexit savagefb_remove (s
 		 * we will be leaving hooks that could cause
 		 * oopsen laying around.
 		 */
-		if (unregister_framebuffer (info))
-			printk (KERN_WARNING "savagefb: danger danger! "
-				"Oopsen imminent!\n");
+		if (unregister_framebuffer(info))
+			printk(KERN_WARNING "savagefb: danger danger! "
+			       "Oopsen imminent!\n");
 
 #ifdef CONFIG_FB_SAVAGE_I2C
 		savagefb_delete_i2c_busses(info);
 #endif
-		fb_alloc_cmap (&info->cmap, 0, 0);
-		savage_unmap_video (info);
-		savage_unmap_mmio (info);
+		fb_alloc_cmap(&info->cmap, 0, 0);
+		savage_unmap_video(info);
+		savage_unmap_mmio(info);
 		kfree(info->pixmap.addr);
 		pci_release_regions(dev);
 		framebuffer_release(info);
@@ -2326,7 +2325,7 @@ static void __devexit savagefb_remove (s
 	}
 }
 
-static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
+static int savagefb_suspend(struct pci_dev* dev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct savagefb_par *par = info->par;
@@ -2362,7 +2361,7 @@ static int savagefb_suspend (struct pci_
 	return 0;
 }
 
-static int savagefb_resume (struct pci_dev* dev)
+static int savagefb_resume(struct pci_dev* dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct savagefb_par *par = info->par;
@@ -2386,14 +2385,14 @@ static int savagefb_resume (struct pci_d
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
 
-	if(pci_enable_device(dev))
+	if (pci_enable_device(dev))
 		DBG("err");
 
 	pci_set_master(dev);
 	savage_enable_mmio(par);
 	savage_init_hw(par);
 	savagefb_set_par(info);
-	fb_set_suspend (info, 0);
+	fb_set_suspend(info, 0);
 	savagefb_blank(FB_BLANK_UNBLANK, info);
 	release_console_sem();
 
@@ -2487,10 +2486,10 @@ static struct pci_driver savagefb_driver
 
 /* **************************** exit-time only **************************** */
 
-static void __exit savage_done (void)
+static void __exit savage_done(void)
 {
 	DBG("savage_done");
-	pci_unregister_driver (&savagefb_driver);
+	pci_unregister_driver(&savagefb_driver);
 }
 
 
@@ -2521,7 +2520,7 @@ static int __init savagefb_init(void)
 		return -ENODEV;
 
 	savagefb_setup(option);
-	return pci_register_driver (&savagefb_driver);
+	return pci_register_driver(&savagefb_driver);
 
 }
 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
