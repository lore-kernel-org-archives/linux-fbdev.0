From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/17] savagefb: Convert from VGA IO access to MMIO access
Date: Tue, 18 Oct 2005 17:19:05 +0800
Message-ID: <4354BE09.6090206@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyIg-0000cu-Gk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:10 -0700
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyIe-0002Fg-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:10 -0700
Received: by zproxy.gmail.com with SMTP id 14so1395674nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:43:04 -0700 (PDT)
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

Use MMIO registers instead of banging the VGA IO registers.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 savagefb.h        |  232 +++++++++------
 savagefb_driver.c |  820 +++++++++++++++++++++++++++---------------------------
 2 files changed, 551 insertions(+), 501 deletions(-)


diff --git a/drivers/video/savage/savagefb.h b/drivers/video/savage/savagefb.h
--- a/drivers/video/savage/savagefb.h
+++ b/drivers/video/savage/savagefb.h
@@ -169,6 +169,7 @@ struct savagefb_par {
 	struct savagefb_i2c_chan chan;
 	unsigned char   *edid;
 	u32 pseudo_palette[16];
+	int paletteEnabled;
 	int pm_state;
 	int display_type;
 	int dvi;
@@ -244,105 +245,150 @@ struct savagefb_par {
 
 
 /* IO functions */
+static inline u8 savage_in8(u32 addr, struct savagefb_par *par)
+{
+	return readb(par->mmio.vbase + addr);
+}
+
+static inline u16 savage_in16(u32 addr, struct savagefb_par *par)
+{
+	return readw(par->mmio.vbase + addr);
+}
+
+static inline u32 savage_in32(u32 addr, struct savagefb_par *par)
+{
+	return readl(par->mmio.vbase + addr);
+}
+
+static inline void savage_out8(u32 addr, u8 val, struct savagefb_par *par)
+{
+	writeb(val, par->mmio.vbase + addr);
+}
+
+static inline void savage_out16(u32 addr, u16 val, struct savagefb_par *par)
+{
+	writew(val, par->mmio.vbase + addr);
+}
+
+static inline void savage_out32(u32 addr, u32 val, struct savagefb_par *par)
+{
+	writel(val, par->mmio.vbase + addr);
+}
+
+static inline u8 vga_in8(int addr, struct savagefb_par *par)
+{
+	return savage_in8(0x8000 + addr, par);
+}
+
+static inline u16 vga_in16(int addr, struct savagefb_par *par)
+{
+	return savage_in16(0x8000 + addr, par);
+}
+
+static inline u8 vga_in32(int addr, struct savagefb_par *par)
+{
+	return savage_in32(0x8000 + addr, par);
+}
+
+static inline void vga_out8(int addr, u8 val, struct savagefb_par *par)
+{
+	savage_out8(0x8000 + addr, val, par);
+}
+
+static inline void vga_out16(int addr, u16 val, struct savagefb_par *par)
+{
+	savage_out16(0x8000 + addr, val, par);
+}
+
+static inline void vga_out32(int addr, u32 val, struct savagefb_par *par)
+{
+	savage_out32(0x8000 + addr, val, par);
+}
+
+static inline u8 VGArCR (u8 index, struct savagefb_par *par)
+{
+	vga_out8(0x3d4, index,  par);
+	return vga_in8(0x3d5, par);
+}
+
+static inline u8 VGArGR (u8 index, struct savagefb_par *par)
+{
+	vga_out8(0x3ce, index, par);
+	return vga_in8(0x3cf, par);
+}
+
+static inline u8 VGArSEQ (u8 index, struct savagefb_par *par)
+{
+	vga_out8(0x3c4, index, par);
+	return vga_in8(0x3c5, par);
+}
+
+static inline void VGAwCR(u8 index, u8 val, struct savagefb_par *par)
+{
+	vga_out8(0x3d4, index, par);
+	vga_out8(0x3d5, val, par);
+}
+
+static inline void VGAwGR(u8 index, u8 val, struct savagefb_par *par)
+{
+	vga_out8(0x3ce, index, par);
+	vga_out8(0x3cf, val, par);
+}
+
+static inline void VGAwSEQ(u8 index, u8 val, struct savagefb_par *par)
+{
+	vga_out8(0x3c4, index, par);
+	vga_out8 (0x3c5, val, par);
+}
 
-#define  vga_in8(addr)         (inb (addr))
-#define vga_in16(addr)         (inw (addr))
-#define vga_in32(addr)         (inl (addr))
-
-#define  vga_out8(addr,val)    (outb ((val), (addr)))
-#define vga_out16(addr,val)    (outw ((val), (addr)))
-#define vga_out32(addr,val)    (outl ((val), (addr)))
-
-#define savage_in16(addr)      readw(par->mmio.vbase + (addr))
-#define savage_in32(addr)      readl(par->mmio.vbase + (addr))
-
-#define savage_out16(addr,val) writew((val), par->mmio.vbase + (addr))
-#define savage_out32(addr,val) writel((val), par->mmio.vbase + (addr))
-
-static inline u8 VGArCR (u8 index)
-{
-  outb (index, 0x3d4);
-  return inb (0x3d5);
-}
-
-static inline u8 VGArGR (u8 index)
-{
-  outb (index, 0x3ce);
-  return inb (0x3cf);
-}
-
-static inline u8 VGArSEQ (u8 index)
-{
-  outb (index, 0x3c4);
-  return inb (0x3c5);
-}
-
-#define VGAwCR(index, val) \
-do {                       \
-  vga_out8 (0x3d4, index); \
-  vga_out8 (0x3d5, val);   \
-} while (0)
-
-#define VGAwGR(index, val) \
-do {                       \
-  vga_out8 (0x3ce, index); \
-  vga_out8 (0x3cf, val);   \
-} while (0)
-
-#define VGAwSEQ(index, val) \
-do {                        \
-  vga_out8 (0x3c4, index);  \
-  vga_out8 (0x3c5, val);    \
-} while (0)
-
-#define VGAenablePalette() \
-do {                       \
-  u8 tmp;                  \
-                           \
-  tmp = vga_in8 (0x3da);   \
-  vga_out8 (0x3c0, 0x00);  \
-  paletteEnabled = 1;      \
-} while (0)
-
-#define VGAdisablePalette() \
-do {                        \
-  u8 tmp;                   \
-                            \
-  tmp = vga_in8 (0x3da);    \
-  vga_out8 (0x3c0, 0x20);   \
-  paletteEnabled = 0;       \
-} while (0)
-
-#define VGAwATTR(index, value) \
-do {                           \
-  u8 tmp;                      \
-                               \
-  if (paletteEnabled)          \
-    index &= ~0x20;            \
-  else                         \
-    index |= 0x20;             \
-                               \
-  tmp = vga_in8 (0x3da);       \
-  vga_out8 (0x3c0, index);     \
-  vga_out8 (0x3c0, value);     \
-} while (0)
-
-#define VGAwMISC(value)    \
-do {                       \
-  vga_out8 (0x3c2, value); \
-} while (0)
+static inline void VGAenablePalette(struct savagefb_par *par)
+{
+	u8 tmp;
+
+	tmp = vga_in8(0x3da, par);
+	vga_out8(0x3c0, 0x00, par);
+	par->paletteEnabled = 1;
+}
+
+static inline void VGAdisablePalette(struct savagefb_par *par)
+{
+	u8 tmp;
+
+	tmp = vga_in8(0x3da, par);
+	vga_out8(0x3c0, 0x20, par);
+	par->paletteEnabled = 0;
+}
+
+static inline void VGAwATTR(u8 index, u8 value, struct savagefb_par *par)
+{
+	u8 tmp;
+
+	if (par->paletteEnabled)
+		index &= ~0x20;
+	else
+		index |= 0x20;
+
+	tmp = vga_in8(0x3da, par);
+	vga_out8(0x3c0, index, par);
+	vga_out8 (0x3c0, value, par);
+}
+
+static inline void VGAwMISC(u8 value, struct savagefb_par *par)
+{
+	vga_out8(0x3c2, value, par);
+}
 
 #ifndef CONFIG_FB_SAVAGE_ACCEL
 #define savagefb_set_clip(x)
 #endif
 
-#define VerticalRetraceWait() \
-{ \
-	vga_out8 (0x3d4, 0x17); \
-	if (vga_in8 (0x3d5) & 0x80) { \
-		while ((vga_in8(0x3da) & 0x08) == 0x08) ; \
-		while ((vga_in8(0x3da) & 0x08) == 0x00) ; \
-	} \
+static inline void VerticalRetraceWait(struct savagefb_par *par)
+{
+	vga_out8(0x3d4, 0x17, par);
+	if (vga_in8(0x3d5, par) & 0x80) {
+		while ((vga_in8(0x3da, par) & 0x08) == 0x08);
+		while ((vga_in8(0x3da, par) & 0x08) == 0x00);
+	}
 }
 
 extern int savagefb_probe_i2c_connector(struct fb_info *info,
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -74,7 +74,6 @@
 
 
 static char *mode_option __initdata = NULL;
-static int   paletteEnabled = 0;
 
 #ifdef MODULE
 
@@ -90,9 +89,9 @@ MODULE_DESCRIPTION("FBDev driver for S3 
 static void vgaHWSeqReset (struct savagefb_par *par, int start)
 {
 	if (start)
-		VGAwSEQ (0x00, 0x01);		/* Synchronous Reset */
+		VGAwSEQ (0x00, 0x01, par);	/* Synchronous Reset */
 	else
-		VGAwSEQ (0x00, 0x03);		/* End Reset */
+		VGAwSEQ (0x00, 0x03, par);	/* End Reset */
 }
 
 static void vgaHWProtect (struct savagefb_par *par, int on)
@@ -103,23 +102,23 @@ static void vgaHWProtect (struct savagef
 		/*
 		 * Turn off screen and disable sequencer.
 		 */
-		tmp = VGArSEQ (0x01);
+		tmp = VGArSEQ (0x01, par);
 
 		vgaHWSeqReset (par, 1);	        /* start synchronous reset */
-		VGAwSEQ (0x01, tmp | 0x20);	/* disable the display */
+		VGAwSEQ (0x01, tmp | 0x20, par);/* disable the display */
 
-		VGAenablePalette();
+		VGAenablePalette(par);
 	} else {
 		/*
 		 * Reenable sequencer, then turn on screen.
 		 */
 
-		tmp = VGArSEQ (0x01);
+		tmp = VGArSEQ (0x01, par);
 
-		VGAwSEQ (0x01, tmp & ~0x20);	/* reenable display */
+		VGAwSEQ (0x01, tmp & ~0x20, par);/* reenable display */
 		vgaHWSeqReset (par, 0);	        /* clear synchronous reset */
 
-		VGAdisablePalette();
+		VGAdisablePalette(par);
 	}
 }
 
@@ -127,27 +126,27 @@ static void vgaHWRestore (struct savagef
 {
 	int i;
 
-	VGAwMISC (par->MiscOutReg);
+	VGAwMISC (par->MiscOutReg, par);
 
 	for (i = 1; i < 5; i++)
-		VGAwSEQ (i, par->Sequencer[i]);
+		VGAwSEQ (i, par->Sequencer[i], par);
 
 	/* Ensure CRTC registers 0-7 are unlocked by clearing bit 7 or
 	   CRTC[17] */
-	VGAwCR (17, par->CRTC[17] & ~0x80);
+	VGAwCR (17, par->CRTC[17] & ~0x80, par);
 
 	for (i = 0; i < 25; i++)
-		VGAwCR (i, par->CRTC[i]);
+		VGAwCR (i, par->CRTC[i], par);
 
 	for (i = 0; i < 9; i++)
-		VGAwGR (i, par->Graphics[i]);
+		VGAwGR (i, par->Graphics[i], par);
 
-	VGAenablePalette();
+	VGAenablePalette(par);
 
 	for (i = 0; i < 21; i++)
-		VGAwATTR (i, par->Attribute[i]);
+		VGAwATTR (i, par->Attribute[i], par);
 
-	VGAdisablePalette();
+	VGAdisablePalette(par);
 }
 
 static void vgaHWInit (struct fb_var_screeninfo *var,
@@ -267,7 +266,7 @@ savage3D_waitfifo(struct savagefb_par *p
 {
 	int slots = MAXFIFO - space;
 
-	while ((savage_in32(0x48C00) & 0x0000ffff) > slots);
+	while ((savage_in32(0x48C00, par) & 0x0000ffff) > slots);
 }
 
 static void
@@ -275,7 +274,7 @@ savage4_waitfifo(struct savagefb_par *pa
 {
 	int slots = MAXFIFO - space;
 
-	while ((savage_in32(0x48C60) & 0x001fffff) > slots);
+	while ((savage_in32(0x48C60, par) & 0x001fffff) > slots);
 }
 
 static void
@@ -283,26 +282,26 @@ savage2000_waitfifo(struct savagefb_par 
 {
 	int slots = MAXFIFO - space;
 
-	while ((savage_in32(0x48C60) & 0x0000ffff) > slots);
+	while ((savage_in32(0x48C60, par) & 0x0000ffff) > slots);
 }
 
 /* Wait for idle accelerator */
 static void
 savage3D_waitidle(struct savagefb_par *par)
 {
-	while ((savage_in32(0x48C00) & 0x0008ffff) != 0x80000);
+	while ((savage_in32(0x48C00, par) & 0x0008ffff) != 0x80000);
 }
 
 static void
 savage4_waitidle(struct savagefb_par *par)
 {
-	while ((savage_in32(0x48C60) & 0x00a00000) != 0x00a00000);
+	while ((savage_in32(0x48C60, par) & 0x00a00000) != 0x00a00000);
 }
 
 static void
 savage2000_waitidle(struct savagefb_par *par)
 {
-	while ((savage_in32(0x48C60) & 0x009fffff));
+	while ((savage_in32(0x48C60, par) & 0x009fffff));
 }
 
 
@@ -319,59 +318,64 @@ SavageSetup2DEngine (struct savagefb_par
 	case S3_SAVAGE3D:
 	case S3_SAVAGE_MX:
 		/* Disable BCI */
-		savage_out32(0x48C18, savage_in32(0x48C18) & 0x3FF0);
+		savage_out32(0x48C18, savage_in32(0x48C18, par) & 0x3FF0, par);
 		/* Setup BCI command overflow buffer */
-		savage_out32(0x48C14, (par->cob_offset >> 11) | (par->cob_index << 29));
+		savage_out32(0x48C14,
+			     (par->cob_offset >> 11) | (par->cob_index << 29),
+			     par);
 		/* Program shadow status update. */
-		savage_out32(0x48C10, 0x78207220);
-		savage_out32(0x48C0C, 0);
+		savage_out32(0x48C10, 0x78207220, par);
+		savage_out32(0x48C0C, 0, par);
 		/* Enable BCI and command overflow buffer */
-		savage_out32(0x48C18, savage_in32(0x48C18) | 0x0C);
+		savage_out32(0x48C18, savage_in32(0x48C18, par) | 0x0C, par);
 		break;
 	case S3_SAVAGE4:
 	case S3_PROSAVAGE:
 	case S3_SUPERSAVAGE:
 		/* Disable BCI */
-		savage_out32(0x48C18, savage_in32(0x48C18) & 0x3FF0);
+		savage_out32(0x48C18, savage_in32(0x48C18, par) & 0x3FF0, par);
 		/* Program shadow status update */
-		savage_out32(0x48C10, 0x00700040);
-		savage_out32(0x48C0C, 0);
+		savage_out32(0x48C10, 0x00700040, par);
+		savage_out32(0x48C0C, 0, par);
 		/* Enable BCI without the COB */
-		savage_out32(0x48C18, savage_in32(0x48C18) | 0x08);
+		savage_out32(0x48C18, savage_in32(0x48C18, par) | 0x08, par);
 		break;
 	case S3_SAVAGE2000:
 		/* Disable BCI */
-		savage_out32(0x48C18, 0);
+		savage_out32(0x48C18, 0, par);
 		/* Setup BCI command overflow buffer */
-		savage_out32(0x48C18, (par->cob_offset >> 7) | (par->cob_index));
+		savage_out32(0x48C18,
+			     (par->cob_offset >> 7) | (par->cob_index),
+			     par);
 		/* Disable shadow status update */
-		savage_out32(0x48A30, 0);
+		savage_out32(0x48A30, 0, par);
 		/* Enable BCI and command overflow buffer */
-		savage_out32(0x48C18, savage_in32(0x48C18) | 0x00280000 );
+		savage_out32(0x48C18, savage_in32(0x48C18, par) | 0x00280000,
+			     par);
 		break;
 	    default:
 		break;
 	}
 	/* Turn on 16-bit register access. */
-	vga_out8(0x3d4, 0x31);
-	vga_out8(0x3d5, 0x0c);
+	vga_out8(0x3d4, 0x31, par);
+	vga_out8(0x3d5, 0x0c, par);
 
 	/* Set stride to use GBD. */
-	vga_out8 (0x3d4, 0x50);
-	vga_out8 (0x3d5, vga_in8 (0x3d5 ) | 0xC1);
+	vga_out8 (0x3d4, 0x50, par);
+	vga_out8 (0x3d5, vga_in8(0x3d5, par) | 0xC1, par);
 
 	/* Enable 2D engine. */
-	vga_out8 (0x3d4, 0x40 );
-	vga_out8 (0x3d5, 0x01 );
+	vga_out8 (0x3d4, 0x40, par);
+	vga_out8 (0x3d5, 0x01, par);
 
-	savage_out32 (MONO_PAT_0, ~0);
-	savage_out32 (MONO_PAT_1, ~0);
+	savage_out32 (MONO_PAT_0, ~0, par);
+	savage_out32 (MONO_PAT_1, ~0, par);
 
 	/* Setup plane masks */
-	savage_out32 (0x8128, ~0 ); /* enable all write planes */
-	savage_out32 (0x812C, ~0 ); /* enable all read planes */
-	savage_out16 (0x8134, 0x27 );
-	savage_out16 (0x8136, 0x07 );
+	savage_out32 (0x8128, ~0, par); /* enable all write planes */
+	savage_out32 (0x812C, ~0, par); /* enable all read planes */
+	savage_out16 (0x8134, 0x27, par);
+	savage_out16 (0x8136, 0x07, par);
 
 	/* Now set the GBD */
 	par->bci_ptr = 0;
@@ -489,8 +493,8 @@ static void SavagePrintRegs(void)
 	for( i = 0; i < 0x70; i++ ) {
 		if( !(i % 16) )
 			printk(KERN_DEBUG "\nSR%xx ", i >> 4 );
-		vga_out8( 0x3c4, i );
-		printk(KERN_DEBUG " %02x", vga_in8(0x3c5) );
+		vga_out8( 0x3c4, i, par);
+		printk(KERN_DEBUG " %02x", vga_in8(0x3c5, par) );
 	}
 
 	printk(KERN_DEBUG "\n\nCR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC "
@@ -499,8 +503,8 @@ static void SavagePrintRegs(void)
 	for( i = 0; i < 0xB7; i++ ) {
 		if( !(i % 16) )
 			printk(KERN_DEBUG "\nCR%xx ", i >> 4 );
-		vga_out8( vgaCRIndex, i );
-		printk(KERN_DEBUG " %02x", vga_in8(vgaCRReg) );
+		vga_out8( vgaCRIndex, i, par);
+		printk(KERN_DEBUG " %02x", vga_in8(vgaCRReg, par) );
 	}
 
 	printk(KERN_DEBUG "\n\n");
@@ -513,152 +517,152 @@ static void savage_get_default_par(struc
 {
 	unsigned char cr3a, cr53, cr66;
 
-	vga_out16 (0x3d4, 0x4838);
-	vga_out16 (0x3d4, 0xa039);
-	vga_out16 (0x3c4, 0x0608);
-
-	vga_out8 (0x3d4, 0x66);
-	cr66 = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr66 | 0x80);
-	vga_out8 (0x3d4, 0x3a);
-	cr3a = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr3a | 0x80);
-	vga_out8 (0x3d4, 0x53);
-	cr53 = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr53 & 0x7f);
-
-	vga_out8 (0x3d4, 0x66);
-	vga_out8 (0x3d5, cr66);
-	vga_out8 (0x3d4, 0x3a);
-	vga_out8 (0x3d5, cr3a);
-
-	vga_out8 (0x3d4, 0x66);
-	vga_out8 (0x3d5, cr66);
-	vga_out8 (0x3d4, 0x3a);
-	vga_out8 (0x3d5, cr3a);
+	vga_out16 (0x3d4, 0x4838, par);
+	vga_out16 (0x3d4, 0xa039, par);
+	vga_out16 (0x3c4, 0x0608, par);
+
+	vga_out8 (0x3d4, 0x66, par);
+	cr66 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr66 | 0x80, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	cr3a = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr3a | 0x80, par);
+	vga_out8 (0x3d4, 0x53, par);
+	cr53 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr53 & 0x7f, par);
+
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, cr66, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	vga_out8 (0x3d5, cr3a, par);
+
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, cr66, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	vga_out8 (0x3d5, cr3a, par);
 
 	/* unlock extended seq regs */
-	vga_out8 (0x3c4, 0x08);
-	par->SR08 = vga_in8 (0x3c5);
-	vga_out8 (0x3c5, 0x06);
+	vga_out8 (0x3c4, 0x08, par);
+	par->SR08 = vga_in8 (0x3c5, par);
+	vga_out8 (0x3c5, 0x06, par);
 
 	/* now save all the extended regs we need */
-	vga_out8 (0x3d4, 0x31);
-	par->CR31 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x32);
-	par->CR32 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x34);
-	par->CR34 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x36);
-	par->CR36 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x3a);
-	par->CR3A = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x40);
-	par->CR40 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x42);
-	par->CR42 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x45);
-	par->CR45 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x50);
-	par->CR50 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x51);
-	par->CR51 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x53);
-	par->CR53 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x58);
-	par->CR58 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x60);
-	par->CR60 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x66);
-	par->CR66 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x67);
-	par->CR67 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x68);
-	par->CR68 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x69);
-	par->CR69 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x6f);
-	par->CR6F = vga_in8 (0x3d5);
-
-	vga_out8 (0x3d4, 0x33);
-	par->CR33 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x86);
-	par->CR86 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x88);
-	par->CR88 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x90);
-	par->CR90 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x91);
-	par->CR91 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0xb0);
-	par->CRB0 = vga_in8 (0x3d5) | 0x80;
+	vga_out8 (0x3d4, 0x31, par);
+	par->CR31 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x32, par);
+	par->CR32 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x34, par);
+	par->CR34 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x36, par);
+	par->CR36 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	par->CR3A = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x40, par);
+	par->CR40 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x42, par);
+	par->CR42 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x45, par);
+	par->CR45 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x50, par);
+	par->CR50 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x51, par);
+	par->CR51 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x53, par);
+	par->CR53 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x58, par);
+	par->CR58 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x60, par);
+	par->CR60 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x66, par);
+	par->CR66 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x67, par);
+	par->CR67 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x68, par);
+	par->CR68 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x69, par);
+	par->CR69 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x6f, par);
+	par->CR6F = vga_in8 (0x3d5, par);
+
+	vga_out8 (0x3d4, 0x33, par);
+	par->CR33 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x86, par);
+	par->CR86 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x88, par);
+	par->CR88 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x90, par);
+	par->CR90 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x91, par);
+	par->CR91 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0xb0, par);
+	par->CRB0 = vga_in8 (0x3d5, par) | 0x80;
 
 	/* extended mode timing regs */
-	vga_out8 (0x3d4, 0x3b);
-	par->CR3B = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x3c);
-	par->CR3C = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x43);
-	par->CR43 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x5d);
-	par->CR5D = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x5e);
-	par->CR5E = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x65);
-	par->CR65 = vga_in8 (0x3d5);
+	vga_out8 (0x3d4, 0x3b, par);
+	par->CR3B = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x3c, par);
+	par->CR3C = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x43, par);
+	par->CR43 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x5d, par);
+	par->CR5D = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x5e, par);
+	par->CR5E = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x65, par);
+	par->CR65 = vga_in8 (0x3d5, par);
 
 	/* save seq extended regs for DCLK PLL programming */
-	vga_out8 (0x3c4, 0x0e);
-	par->SR0E = vga_in8 (0x3c5);
-	vga_out8 (0x3c4, 0x0f);
-	par->SR0F = vga_in8 (0x3c5);
-	vga_out8 (0x3c4, 0x10);
-	par->SR10 = vga_in8 (0x3c5);
-	vga_out8 (0x3c4, 0x11);
-	par->SR11 = vga_in8 (0x3c5);
-	vga_out8 (0x3c4, 0x12);
-	par->SR12 = vga_in8 (0x3c5);
-	vga_out8 (0x3c4, 0x13);
-	par->SR13 = vga_in8 (0x3c5);
-	vga_out8 (0x3c4, 0x29);
-	par->SR29 = vga_in8 (0x3c5);
-
-	vga_out8 (0x3c4, 0x15);
-	par->SR15 = vga_in8 (0x3c5);
-	vga_out8 (0x3c4, 0x30);
-	par->SR30 = vga_in8 (0x3c5);
-	vga_out8 (0x3c4, 0x18);
-	par->SR18 = vga_in8 (0x3c5);
+	vga_out8 (0x3c4, 0x0e, par);
+	par->SR0E = vga_in8 (0x3c5, par);
+	vga_out8 (0x3c4, 0x0f, par);
+	par->SR0F = vga_in8 (0x3c5, par);
+	vga_out8 (0x3c4, 0x10, par);
+	par->SR10 = vga_in8 (0x3c5, par);
+	vga_out8 (0x3c4, 0x11, par);
+	par->SR11 = vga_in8 (0x3c5, par);
+	vga_out8 (0x3c4, 0x12, par);
+	par->SR12 = vga_in8 (0x3c5, par);
+	vga_out8 (0x3c4, 0x13, par);
+	par->SR13 = vga_in8 (0x3c5, par);
+	vga_out8 (0x3c4, 0x29, par);
+	par->SR29 = vga_in8 (0x3c5, par);
+
+	vga_out8 (0x3c4, 0x15, par);
+	par->SR15 = vga_in8 (0x3c5, par);
+	vga_out8 (0x3c4, 0x30, par);
+	par->SR30 = vga_in8 (0x3c5, par);
+	vga_out8 (0x3c4, 0x18, par);
+	par->SR18 = vga_in8 (0x3c5, par);
 
 	/* Save flat panel expansion regsters. */
 	if (par->chip == S3_SAVAGE_MX) {
 		int i;
 
 		for (i = 0; i < 8; i++) {
-			vga_out8 (0x3c4, 0x54+i);
-			par->SR54[i] = vga_in8 (0x3c5);
+			vga_out8 (0x3c4, 0x54+i, par);
+			par->SR54[i] = vga_in8 (0x3c5, par);
 		}
 	}
 
-	vga_out8 (0x3d4, 0x66);
-	cr66 = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr66 | 0x80);
-	vga_out8 (0x3d4, 0x3a);
-	cr3a = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr3a | 0x80);
+	vga_out8 (0x3d4, 0x66, par);
+	cr66 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr66 | 0x80, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	cr3a = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr3a | 0x80, par);
 
 	/* now save MIU regs */
 	if (par->chip != S3_SAVAGE_MX) {
-		par->MMPR0 = savage_in32(FIFO_CONTROL_REG);
-		par->MMPR1 = savage_in32(MIU_CONTROL_REG);
-		par->MMPR2 = savage_in32(STREAMS_TIMEOUT_REG);
-		par->MMPR3 = savage_in32(MISC_TIMEOUT_REG);
+		par->MMPR0 = savage_in32(FIFO_CONTROL_REG, par);
+		par->MMPR1 = savage_in32(MIU_CONTROL_REG, par);
+		par->MMPR2 = savage_in32(STREAMS_TIMEOUT_REG, par);
+		par->MMPR3 = savage_in32(MISC_TIMEOUT_REG, par);
 	}
 
-	vga_out8 (0x3d4, 0x3a);
-	vga_out8 (0x3d5, cr3a);
-	vga_out8 (0x3d4, 0x66);
-	vga_out8 (0x3d5, cr66);
+	vga_out8 (0x3d4, 0x3a, par);
+	vga_out8 (0x3d5, cr3a, par);
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, cr66, par);
 }
 
 static void savage_update_var(struct fb_var_screeninfo *var, struct fb_videomode *modedb)
@@ -868,8 +872,8 @@ static int savagefb_decode_var (struct f
 	 * match.  Fall back to traditional register-crunching.
 	 */
 
-	vga_out8 (0x3d4, 0x3a);
-	tmp = vga_in8 (0x3d5);
+	vga_out8 (0x3d4, 0x3a, par);
+	tmp = vga_in8 (0x3d5, par);
 	if (1 /*FIXME:psav->pci_burst*/)
 		par->CR3A = (tmp & 0x7f) | 0x15;
 	else
@@ -879,16 +883,16 @@ static int savagefb_decode_var (struct f
 	par->CR31 = 0x8c;
 	par->CR66 = 0x89;
 
-	vga_out8 (0x3d4, 0x58);
-	par->CR58 = vga_in8 (0x3d5) & 0x80;
+	vga_out8 (0x3d4, 0x58, par);
+	par->CR58 = vga_in8 (0x3d5, par) & 0x80;
 	par->CR58 |= 0x13;
 
 	par->SR15 = 0x03 | 0x80;
 	par->SR18 = 0x00;
 	par->CR43 = par->CR45 = par->CR65 = 0x00;
 
-	vga_out8 (0x3d4, 0x40);
-	par->CR40 = vga_in8 (0x3d5) & ~0x01;
+	vga_out8 (0x3d4, 0x40, par);
+	par->CR40 = vga_in8 (0x3d5, par) & ~0x01;
 
 	par->MMPR0 = 0x010400;
 	par->MMPR1 = 0x00;
@@ -992,19 +996,19 @@ static int savagefb_decode_var (struct f
 
 	par->CR67 |= 1;
 
-	vga_out8(0x3d4, 0x36);
-	par->CR36 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x68);
-	par->CR68 = vga_in8 (0x3d5);
+	vga_out8(0x3d4, 0x36, par);
+	par->CR36 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x68, par);
+	par->CR68 = vga_in8 (0x3d5, par);
 	par->CR69 = 0;
-	vga_out8 (0x3d4, 0x6f);
-	par->CR6F = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x86);
-	par->CR86 = vga_in8 (0x3d5);
-	vga_out8 (0x3d4, 0x88);
-	par->CR88 = vga_in8 (0x3d5) | 0x08;
-	vga_out8 (0x3d4, 0xb0);
-	par->CRB0 = vga_in8 (0x3d5) | 0x80;
+	vga_out8 (0x3d4, 0x6f, par);
+	par->CR6F = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x86, par);
+	par->CR86 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d4, 0x88, par);
+	par->CR88 = vga_in8 (0x3d5, par) | 0x08;
+	vga_out8 (0x3d4, 0xb0, par);
+	par->CRB0 = vga_in8 (0x3d5, par) | 0x80;
 
 	return 0;
 }
@@ -1033,11 +1037,11 @@ static int savagefb_setcolreg(unsigned  
 
 	switch (info->var.bits_per_pixel) {
 	case 8:
-		vga_out8 (0x3c8, regno);
+		vga_out8 (0x3c8, regno, par);
 
-		vga_out8 (0x3c9, red   >> 10);
-		vga_out8 (0x3c9, green >> 10);
-		vga_out8 (0x3c9, blue  >> 10);
+		vga_out8 (0x3c9, red   >> 10, par);
+		vga_out8 (0x3c9, green >> 10, par);
+		vga_out8 (0x3c9, blue  >> 10, par);
 		break;
 
 	case 16:
@@ -1079,11 +1083,11 @@ static void savagefb_set_par_int (struct
 
 	par->SavageWaitIdle (par);
 
-	vga_out8 (0x3c2, 0x23);
+	vga_out8 (0x3c2, 0x23, par);
 
-	vga_out16 (0x3d4, 0x4838);
-	vga_out16 (0x3d4, 0xa539);
-	vga_out16 (0x3c4, 0x0608);
+	vga_out16 (0x3d4, 0x4838, par);
+	vga_out16 (0x3d4, 0xa539, par);
+	vga_out16 (0x3c4, 0x0608, par);
 
 	vgaHWProtect (par, 1);
 
@@ -1094,197 +1098,197 @@ static void savagefb_set_par_int (struct
 	 * switch to mode 3 here seems to eliminate the issue.
 	 */
 
-	VerticalRetraceWait();
-	vga_out8 (0x3d4, 0x67);
-	cr67 = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr67/*par->CR67*/ & ~0x0c); /* no STREAMS yet */
-
-	vga_out8 (0x3d4, 0x23);
-	vga_out8 (0x3d5, 0x00);
-	vga_out8 (0x3d4, 0x26);
-	vga_out8 (0x3d5, 0x00);
+	VerticalRetraceWait(par);
+	vga_out8 (0x3d4, 0x67, par);
+	cr67 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr67/*par->CR67*/ & ~0x0c, par); /* no STREAMS yet */
+
+	vga_out8 (0x3d4, 0x23, par);
+	vga_out8 (0x3d5, 0x00, par);
+	vga_out8 (0x3d4, 0x26, par);
+	vga_out8 (0x3d5, 0x00, par);
 
 	/* restore extended regs */
-	vga_out8 (0x3d4, 0x66);
-	vga_out8 (0x3d5, par->CR66);
-	vga_out8 (0x3d4, 0x3a);
-	vga_out8 (0x3d5, par->CR3A);
-	vga_out8 (0x3d4, 0x31);
-	vga_out8 (0x3d5, par->CR31);
-	vga_out8 (0x3d4, 0x32);
-	vga_out8 (0x3d5, par->CR32);
-	vga_out8 (0x3d4, 0x58);
-	vga_out8 (0x3d5, par->CR58);
-	vga_out8 (0x3d4, 0x53);
-	vga_out8 (0x3d5, par->CR53 & 0x7f);
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, par->CR66, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	vga_out8 (0x3d5, par->CR3A, par);
+	vga_out8 (0x3d4, 0x31, par);
+	vga_out8 (0x3d5, par->CR31, par);
+	vga_out8 (0x3d4, 0x32, par);
+	vga_out8 (0x3d5, par->CR32, par);
+	vga_out8 (0x3d4, 0x58, par);
+	vga_out8 (0x3d5, par->CR58, par);
+	vga_out8 (0x3d4, 0x53, par);
+	vga_out8 (0x3d5, par->CR53 & 0x7f, par);
 
-	vga_out16 (0x3c4, 0x0608);
+	vga_out16 (0x3c4, 0x0608, par);
 
 	/* Restore DCLK registers. */
 
-	vga_out8 (0x3c4, 0x0e);
-	vga_out8 (0x3c5, par->SR0E);
-	vga_out8 (0x3c4, 0x0f);
-	vga_out8 (0x3c5, par->SR0F);
-	vga_out8 (0x3c4, 0x29);
-	vga_out8 (0x3c5, par->SR29);
-	vga_out8 (0x3c4, 0x15);
-	vga_out8 (0x3c5, par->SR15);
+	vga_out8 (0x3c4, 0x0e, par);
+	vga_out8 (0x3c5, par->SR0E, par);
+	vga_out8 (0x3c4, 0x0f, par);
+	vga_out8 (0x3c5, par->SR0F, par);
+	vga_out8 (0x3c4, 0x29, par);
+	vga_out8 (0x3c5, par->SR29, par);
+	vga_out8 (0x3c4, 0x15, par);
+	vga_out8 (0x3c5, par->SR15, par);
 
 	/* Restore flat panel expansion regsters. */
 	if( par->chip == S3_SAVAGE_MX ) {
 		int i;
 
 		for( i = 0; i < 8; i++ ) {
-			vga_out8 (0x3c4, 0x54+i);
-			vga_out8 (0x3c5, par->SR54[i]);
+			vga_out8 (0x3c4, 0x54+i, par);
+			vga_out8 (0x3c5, par->SR54[i], par);
 		}
 	}
 
 	vgaHWRestore (par);
 
 	/* extended mode timing registers */
-	vga_out8 (0x3d4, 0x53);
-	vga_out8 (0x3d5, par->CR53);
-	vga_out8 (0x3d4, 0x5d);
-	vga_out8 (0x3d5, par->CR5D);
-	vga_out8 (0x3d4, 0x5e);
-	vga_out8 (0x3d5, par->CR5E);
-	vga_out8 (0x3d4, 0x3b);
-	vga_out8 (0x3d5, par->CR3B);
-	vga_out8 (0x3d4, 0x3c);
-	vga_out8 (0x3d5, par->CR3C);
-	vga_out8 (0x3d4, 0x43);
-	vga_out8 (0x3d5, par->CR43);
-	vga_out8 (0x3d4, 0x65);
-	vga_out8 (0x3d5, par->CR65);
+	vga_out8 (0x3d4, 0x53, par);
+	vga_out8 (0x3d5, par->CR53, par);
+	vga_out8 (0x3d4, 0x5d, par);
+	vga_out8 (0x3d5, par->CR5D, par);
+	vga_out8 (0x3d4, 0x5e, par);
+	vga_out8 (0x3d5, par->CR5E, par);
+	vga_out8 (0x3d4, 0x3b, par);
+	vga_out8 (0x3d5, par->CR3B, par);
+	vga_out8 (0x3d4, 0x3c, par);
+	vga_out8 (0x3d5, par->CR3C, par);
+	vga_out8 (0x3d4, 0x43, par);
+	vga_out8 (0x3d5, par->CR43, par);
+	vga_out8 (0x3d4, 0x65, par);
+	vga_out8 (0x3d5, par->CR65, par);
 
 	/* restore the desired video mode with cr67 */
-	vga_out8 (0x3d4, 0x67);
+	vga_out8 (0x3d4, 0x67, par);
 	/* following part not present in X11 driver */
-	cr67 = vga_in8 (0x3d5) & 0xf;
-	vga_out8 (0x3d5, 0x50 | cr67);
+	cr67 = vga_in8 (0x3d5, par) & 0xf;
+	vga_out8 (0x3d5, 0x50 | cr67, par);
 	udelay (10000);
-	vga_out8 (0x3d4, 0x67);
+	vga_out8 (0x3d4, 0x67, par);
 	/* end of part */
-	vga_out8 (0x3d5, par->CR67 & ~0x0c);
+	vga_out8 (0x3d5, par->CR67 & ~0x0c, par);
 
 	/* other mode timing and extended regs */
-	vga_out8 (0x3d4, 0x34);
-	vga_out8 (0x3d5, par->CR34);
-	vga_out8 (0x3d4, 0x40);
-	vga_out8 (0x3d5, par->CR40);
-	vga_out8 (0x3d4, 0x42);
-	vga_out8 (0x3d5, par->CR42);
-	vga_out8 (0x3d4, 0x45);
-	vga_out8 (0x3d5, par->CR45);
-	vga_out8 (0x3d4, 0x50);
-	vga_out8 (0x3d5, par->CR50);
-	vga_out8 (0x3d4, 0x51);
-	vga_out8 (0x3d5, par->CR51);
+	vga_out8 (0x3d4, 0x34, par);
+	vga_out8 (0x3d5, par->CR34, par);
+	vga_out8 (0x3d4, 0x40, par);
+	vga_out8 (0x3d5, par->CR40, par);
+	vga_out8 (0x3d4, 0x42, par);
+	vga_out8 (0x3d5, par->CR42, par);
+	vga_out8 (0x3d4, 0x45, par);
+	vga_out8 (0x3d5, par->CR45, par);
+	vga_out8 (0x3d4, 0x50, par);
+	vga_out8 (0x3d5, par->CR50, par);
+	vga_out8 (0x3d4, 0x51, par);
+	vga_out8 (0x3d5, par->CR51, par);
 
 	/* memory timings */
-	vga_out8 (0x3d4, 0x36);
-	vga_out8 (0x3d5, par->CR36);
-	vga_out8 (0x3d4, 0x60);
-	vga_out8 (0x3d5, par->CR60);
-	vga_out8 (0x3d4, 0x68);
-	vga_out8 (0x3d5, par->CR68);
-	vga_out8 (0x3d4, 0x69);
-	vga_out8 (0x3d5, par->CR69);
-	vga_out8 (0x3d4, 0x6f);
-	vga_out8 (0x3d5, par->CR6F);
-
-	vga_out8 (0x3d4, 0x33);
-	vga_out8 (0x3d5, par->CR33);
-	vga_out8 (0x3d4, 0x86);
-	vga_out8 (0x3d5, par->CR86);
-	vga_out8 (0x3d4, 0x88);
-	vga_out8 (0x3d5, par->CR88);
-	vga_out8 (0x3d4, 0x90);
-	vga_out8 (0x3d5, par->CR90);
-	vga_out8 (0x3d4, 0x91);
-	vga_out8 (0x3d5, par->CR91);
+	vga_out8 (0x3d4, 0x36, par);
+	vga_out8 (0x3d5, par->CR36, par);
+	vga_out8 (0x3d4, 0x60, par);
+	vga_out8 (0x3d5, par->CR60, par);
+	vga_out8 (0x3d4, 0x68, par);
+	vga_out8 (0x3d5, par->CR68, par);
+	vga_out8 (0x3d4, 0x69, par);
+	vga_out8 (0x3d5, par->CR69, par);
+	vga_out8 (0x3d4, 0x6f, par);
+	vga_out8 (0x3d5, par->CR6F, par);
+
+	vga_out8 (0x3d4, 0x33, par);
+	vga_out8 (0x3d5, par->CR33, par);
+	vga_out8 (0x3d4, 0x86, par);
+	vga_out8 (0x3d5, par->CR86, par);
+	vga_out8 (0x3d4, 0x88, par);
+	vga_out8 (0x3d5, par->CR88, par);
+	vga_out8 (0x3d4, 0x90, par);
+	vga_out8 (0x3d5, par->CR90, par);
+	vga_out8 (0x3d4, 0x91, par);
+	vga_out8 (0x3d5, par->CR91, par);
 
 	if (par->chip == S3_SAVAGE4) {
-		vga_out8 (0x3d4, 0xb0);
-		vga_out8 (0x3d5, par->CRB0);
+		vga_out8 (0x3d4, 0xb0, par);
+		vga_out8 (0x3d5, par->CRB0, par);
 	}
 
-	vga_out8 (0x3d4, 0x32);
-	vga_out8 (0x3d5, par->CR32);
+	vga_out8 (0x3d4, 0x32, par);
+	vga_out8 (0x3d5, par->CR32, par);
 
 	/* unlock extended seq regs */
-	vga_out8 (0x3c4, 0x08);
-	vga_out8 (0x3c5, 0x06);
+	vga_out8 (0x3c4, 0x08, par);
+	vga_out8 (0x3c5, 0x06, par);
 
 	/* Restore extended sequencer regs for MCLK. SR10 == 255 indicates
 	 * that we should leave the default SR10 and SR11 values there.
 	 */
 	if (par->SR10 != 255) {
-		vga_out8 (0x3c4, 0x10);
-		vga_out8 (0x3c5, par->SR10);
-		vga_out8 (0x3c4, 0x11);
-		vga_out8 (0x3c5, par->SR11);
+		vga_out8 (0x3c4, 0x10, par);
+		vga_out8 (0x3c5, par->SR10, par);
+		vga_out8 (0x3c4, 0x11, par);
+		vga_out8 (0x3c5, par->SR11, par);
 	}
 
 	/* restore extended seq regs for dclk */
-	vga_out8 (0x3c4, 0x0e);
-	vga_out8 (0x3c5, par->SR0E);
-	vga_out8 (0x3c4, 0x0f);
-	vga_out8 (0x3c5, par->SR0F);
-	vga_out8 (0x3c4, 0x12);
-	vga_out8 (0x3c5, par->SR12);
-	vga_out8 (0x3c4, 0x13);
-	vga_out8 (0x3c5, par->SR13);
-	vga_out8 (0x3c4, 0x29);
-	vga_out8 (0x3c5, par->SR29);
+	vga_out8 (0x3c4, 0x0e, par);
+	vga_out8 (0x3c5, par->SR0E, par);
+	vga_out8 (0x3c4, 0x0f, par);
+	vga_out8 (0x3c5, par->SR0F, par);
+	vga_out8 (0x3c4, 0x12, par);
+	vga_out8 (0x3c5, par->SR12, par);
+	vga_out8 (0x3c4, 0x13, par);
+	vga_out8 (0x3c5, par->SR13, par);
+	vga_out8 (0x3c4, 0x29, par);
+	vga_out8 (0x3c5, par->SR29, par);
 
-	vga_out8 (0x3c4, 0x18);
-	vga_out8 (0x3c5, par->SR18);
+	vga_out8 (0x3c4, 0x18, par);
+	vga_out8 (0x3c5, par->SR18, par);
 
 	/* load new m, n pll values for dclk & mclk */
-	vga_out8 (0x3c4, 0x15);
-	tmp = vga_in8 (0x3c5) & ~0x21;
+	vga_out8 (0x3c4, 0x15, par);
+	tmp = vga_in8 (0x3c5, par) & ~0x21;
 
-	vga_out8 (0x3c5, tmp | 0x03);
-	vga_out8 (0x3c5, tmp | 0x23);
-	vga_out8 (0x3c5, tmp | 0x03);
-	vga_out8 (0x3c5, par->SR15);
+	vga_out8 (0x3c5, tmp | 0x03, par);
+	vga_out8 (0x3c5, tmp | 0x23, par);
+	vga_out8 (0x3c5, tmp | 0x03, par);
+	vga_out8 (0x3c5, par->SR15, par);
 	udelay (100);
 
-	vga_out8 (0x3c4, 0x30);
-	vga_out8 (0x3c5, par->SR30);
-	vga_out8 (0x3c4, 0x08);
-	vga_out8 (0x3c5, par->SR08);
+	vga_out8 (0x3c4, 0x30, par);
+	vga_out8 (0x3c5, par->SR30, par);
+	vga_out8 (0x3c4, 0x08, par);
+	vga_out8 (0x3c5, par->SR08, par);
 
 	/* now write out cr67 in full, possibly starting STREAMS */
-	VerticalRetraceWait();
-	vga_out8 (0x3d4, 0x67);
-	vga_out8 (0x3d5, par->CR67);
-
-	vga_out8 (0x3d4, 0x66);
-	cr66 = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr66 | 0x80);
-	vga_out8 (0x3d4, 0x3a);
-	cr3a = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr3a | 0x80);
+	VerticalRetraceWait(par);
+	vga_out8 (0x3d4, 0x67, par);
+	vga_out8 (0x3d5, par->CR67, par);
+
+	vga_out8 (0x3d4, 0x66, par);
+	cr66 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr66 | 0x80, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	cr3a = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr3a | 0x80, par);
 
 	if (par->chip != S3_SAVAGE_MX) {
-		VerticalRetraceWait();
-		savage_out32 (FIFO_CONTROL_REG, par->MMPR0);
+		VerticalRetraceWait(par);
+		savage_out32 (FIFO_CONTROL_REG, par->MMPR0, par);
 		par->SavageWaitIdle (par);
-		savage_out32 (MIU_CONTROL_REG, par->MMPR1);
+		savage_out32 (MIU_CONTROL_REG, par->MMPR1, par);
 		par->SavageWaitIdle (par);
-		savage_out32 (STREAMS_TIMEOUT_REG, par->MMPR2);
+		savage_out32 (STREAMS_TIMEOUT_REG, par->MMPR2, par);
 		par->SavageWaitIdle (par);
-		savage_out32 (MISC_TIMEOUT_REG, par->MMPR3);
+		savage_out32 (MISC_TIMEOUT_REG, par->MMPR3, par);
 	}
 
-	vga_out8 (0x3d4, 0x66);
-	vga_out8 (0x3d5, cr66);
-	vga_out8 (0x3d4, 0x3a);
-	vga_out8 (0x3d5, cr3a);
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, cr66, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	vga_out8 (0x3d5, cr3a, par);
 
 	SavageSetup2DEngine (par);
 	vgaHWProtect (par, 0);
@@ -1299,10 +1303,10 @@ static void savagefb_update_start (struc
 		* ((var->bits_per_pixel+7) / 8)) >> 2;
 
 	/* now program the start address registers */
-	vga_out16(0x3d4, (base & 0x00ff00) | 0x0c);
-	vga_out16(0x3d4, ((base & 0x00ff) << 8) | 0x0d);
-	vga_out8 (0x3d4, 0x69);
-	vga_out8 (0x3d5, (base & 0x7f0000) >> 16);
+	vga_out16(0x3d4, (base & 0x00ff00) | 0x0c, par);
+	vga_out16(0x3d4, ((base & 0x00ff) << 8) | 0x0d, par);
+	vga_out8 (0x3d4, 0x69, par);
+	vga_out8 (0x3d5, (base & 0x7f0000) >> 16, par);
 }
 
 
@@ -1406,12 +1410,12 @@ static int savagefb_blank(int blank, str
 	u8 sr8 = 0, srd = 0;
 
 	if (par->display_type == DISP_CRT) {
-		vga_out8(0x3c4, 0x08);
-		sr8 = vga_in8(0x3c5);
+		vga_out8(0x3c4, 0x08, par);
+		sr8 = vga_in8(0x3c5, par);
 		sr8 |= 0x06;
-		vga_out8(0x3c5, sr8);
-		vga_out8(0x3c4, 0x0d);
-		srd = vga_in8(0x3c5);
+		vga_out8(0x3c5, sr8, par);
+		vga_out8(0x3c4, 0x0d, par);
+		srd = vga_in8(0x3c5, par);
 		srd &= 0x03;
 
 		switch (blank) {
@@ -1429,8 +1433,8 @@ static int savagefb_blank(int blank, str
 			break;
 		}
 
-		vga_out8(0x3c4, 0x0d);
-		vga_out8(0x3c5, srd);
+		vga_out8(0x3c4, 0x0d, par);
+		vga_out8(0x3c5, srd, par);
 	}
 
 	if (par->display_type == DISP_LCD ||
@@ -1438,14 +1442,14 @@ static int savagefb_blank(int blank, str
 		switch(blank) {
 		case FB_BLANK_UNBLANK:
 		case FB_BLANK_NORMAL:
-			vga_out8(0x3c4, 0x31); /* SR31 bit 4 - FP enable */
-			vga_out8(0x3c5, vga_in8(0x3c5) | 0x10);
+			vga_out8(0x3c4, 0x31, par); /* SR31 bit 4 - FP enable */
+			vga_out8(0x3c5, vga_in8(0x3c5, par) | 0x10, par);
 			break;
 		case FB_BLANK_VSYNC_SUSPEND:
 		case FB_BLANK_HSYNC_SUSPEND:
 		case FB_BLANK_POWERDOWN:
-			vga_out8(0x3c4, 0x31); /* SR31 bit 4 - FP enable */
-			vga_out8(0x3c5, vga_in8(0x3c5) & ~0x10);
+			vga_out8(0x3c4, 0x31, par); /* SR31 bit 4 - FP enable */
+			vga_out8(0x3c5, vga_in8(0x3c5, par) & ~0x10, par);
 			break;
 		}
 	}
@@ -1498,15 +1502,15 @@ static void savage_enable_mmio (struct s
 
 	DBG ("savage_enable_mmio\n");
 
-	val = vga_in8 (0x3c3);
-	vga_out8 (0x3c3, val | 0x01);
-	val = vga_in8 (0x3cc);
-	vga_out8 (0x3c2, val | 0x01);
+	val = vga_in8 (0x3c3, par);
+	vga_out8 (0x3c3, val | 0x01, par);
+	val = vga_in8 (0x3cc, par);
+	vga_out8 (0x3c2, val | 0x01, par);
 
 	if (par->chip >= S3_SAVAGE4) {
-		vga_out8 (0x3d4, 0x40);
-		val = vga_in8 (0x3d5);
-		vga_out8 (0x3d5, val | 1);
+		vga_out8 (0x3d4, 0x40, par);
+		val = vga_in8 (0x3d5, par);
+		vga_out8 (0x3d5, val | 1, par);
 	}
 }
 
@@ -1518,9 +1522,9 @@ static void savage_disable_mmio (struct 
 	DBG ("savage_disable_mmio\n");
 
 	if(par->chip >= S3_SAVAGE4 ) {
-		vga_out8 (0x3d4, 0x40);
-		val = vga_in8 (0x3d5);
-		vga_out8 (0x3d5, val | 1);
+		vga_out8 (0x3d4, 0x40, par);
+		val = vga_in8 (0x3d5, par);
+		vga_out8 (0x3d5, val | 1, par);
 	}
 }
 
@@ -1640,30 +1644,30 @@ static int __devinit savage_init_hw (str
 	DBG("savage_init_hw");
 
 	/* unprotect CRTC[0-7] */
-	vga_out8(0x3d4, 0x11);
-	tmp = vga_in8(0x3d5);
-	vga_out8(0x3d5, tmp & 0x7f);
+	vga_out8(0x3d4, 0x11, par);
+	tmp = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, tmp & 0x7f, par);
 
 	/* unlock extended regs */
-	vga_out16(0x3d4, 0x4838);
-	vga_out16(0x3d4, 0xa039);
-	vga_out16(0x3c4, 0x0608);
-
-	vga_out8(0x3d4, 0x40);
-	tmp = vga_in8(0x3d5);
-	vga_out8(0x3d5, tmp & ~0x01);
+	vga_out16(0x3d4, 0x4838, par);
+	vga_out16(0x3d4, 0xa039, par);
+	vga_out16(0x3c4, 0x0608, par);
+
+	vga_out8(0x3d4, 0x40, par);
+	tmp = vga_in8(0x3d5, par);
+	vga_out8(0x3d5, tmp & ~0x01, par);
 
 	/* unlock sys regs */
-	vga_out8(0x3d4, 0x38);
-	vga_out8(0x3d5, 0x48);
+	vga_out8(0x3d4, 0x38, par);
+	vga_out8(0x3d5, 0x48, par);
 
 	/* Unlock system registers. */
-	vga_out16(0x3d4, 0x4838);
+	vga_out16(0x3d4, 0x4838, par);
 
 	/* Next go on to detect amount of installed ram */
 
-	vga_out8(0x3d4, 0x36);            /* for register CR36 (CONFG_REG1), */
-	config1 = vga_in8(0x3d5);           /* get amount of vram installed */
+	vga_out8(0x3d4, 0x36, par);            /* for register CR36 (CONFG_REG1), */
+	config1 = vga_in8(0x3d5, par);    /* get amount of vram installed */
 
 	/* Compute the amount of video memory and offscreen memory. */
 
@@ -1679,8 +1683,8 @@ static int __devinit savage_init_hw (str
 		 * when it really means 8MB.  Why do it the same when you
 		 * can do it different...
 		 */
-		vga_out8(0x3d4, 0x68);	/* memory control 1 */
-		if( (vga_in8(0x3d5) & 0xC0) == (0x01 << 6) )
+		vga_out8(0x3d4, 0x68, par);	/* memory control 1 */
+		if( (vga_in8(0x3d5, par) & 0xC0) == (0x01 << 6) )
 			RamSavage4[1] = 8;
 
 		/*FALLTHROUGH*/
@@ -1709,13 +1713,13 @@ static int __devinit savage_init_hw (str
 	printk (KERN_INFO "savagefb: probed videoram:  %dk\n", videoRam);
 
 	/* reset graphics engine to avoid memory corruption */
-	vga_out8 (0x3d4, 0x66);
-	cr66 = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr66 | 0x02);
+	vga_out8 (0x3d4, 0x66, par);
+	cr66 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr66 | 0x02, par);
 	udelay (10000);
 
-	vga_out8 (0x3d4, 0x66);
-	vga_out8 (0x3d5, cr66 & ~0x02);	/* clear reset flag */
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, cr66 & ~0x02, par);	/* clear reset flag */
 	udelay (10000);
 
 
@@ -1723,13 +1727,13 @@ static int __devinit savage_init_hw (str
 	 * reset memory interface, 3D engine, AGP master, PCI master,
 	 * master engine unit, motion compensation/LPB
 	 */
-	vga_out8 (0x3d4, 0x3f);
-	cr3f = vga_in8 (0x3d5);
-	vga_out8 (0x3d5, cr3f | 0x08);
+	vga_out8 (0x3d4, 0x3f, par);
+	cr3f = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr3f | 0x08, par);
 	udelay (10000);
 
-	vga_out8 (0x3d4, 0x3f);
-	vga_out8 (0x3d5, cr3f & ~0x08);	/* clear reset flags */
+	vga_out8 (0x3d4, 0x3f, par);
+	vga_out8 (0x3d5, cr3f & ~0x08, par);	/* clear reset flags */
 	udelay (10000);
 
 	/* Savage ramdac speeds */
@@ -1740,15 +1744,15 @@ static int __devinit savage_init_hw (str
 	par->clock[3] = 220000;
 
 	/* detect current mclk */
-	vga_out8(0x3c4, 0x08);
-	sr8 = vga_in8(0x3c5);
-	vga_out8(0x3c5, 0x06);
-	vga_out8(0x3c4, 0x10);
-	n = vga_in8(0x3c5);
-	vga_out8(0x3c4, 0x11);
-	m = vga_in8(0x3c5);
-	vga_out8(0x3c4, 0x08);
-	vga_out8(0x3c5, sr8);
+	vga_out8(0x3c4, 0x08, par);
+	sr8 = vga_in8(0x3c5, par);
+	vga_out8(0x3c5, 0x06, par);
+	vga_out8(0x3c4, 0x10, par);
+	n = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x11, par);
+	m = vga_in8(0x3c5, par);
+	vga_out8(0x3c4, 0x08, par);
+	vga_out8(0x3c5, sr8, par);
 	m &= 0x7f;
 	n1 = n & 0x1f;
 	n2 = (n >> 5) & 0x03;
@@ -1762,10 +1766,10 @@ static int __devinit savage_init_hw (str
 	if (par->chip == S3_SAVAGE4) {
 		unsigned char sr30 = 0x00;
 
-		vga_out8(0x3c4, 0x30);
+		vga_out8(0x3c4, 0x30, par);
 		/* clear bit 1 */
-		vga_out8(0x3c5, vga_in8(0x3c5) & ~0x02);
-		sr30 = vga_in8(0x3c5);
+		vga_out8(0x3c5, vga_in8(0x3c5, par) & ~0x02, par);
+		sr30 = vga_in8(0x3c5, par);
 		if (sr30 & 0x02 /*0x04 */) {
 			dvi = 1;
 			printk("savagefb: Digital Flat Panel Detected\n");
@@ -1782,12 +1786,12 @@ static int __devinit savage_init_hw (str
 	/* Check LCD panel parrmation */
 
 	if (par->display_type == DISP_LCD) {
-		unsigned char cr6b = VGArCR( 0x6b );
+		unsigned char cr6b = VGArCR( 0x6b, par);
 
-		int panelX = (VGArSEQ (0x61) +
-			      ((VGArSEQ (0x66) & 0x02) << 7) + 1) * 8;
-		int panelY = (VGArSEQ (0x69) +
-			      ((VGArSEQ (0x6e) & 0x70) << 4) + 1);
+		int panelX = (VGArSEQ (0x61, par) +
+			      ((VGArSEQ (0x66, par) & 0x02) << 7) + 1) * 8;
+		int panelY = (VGArSEQ (0x69, par) +
+			      ((VGArSEQ (0x6e, par) & 0x70) << 4) + 1);
 
 		char * sTechnology = "Unknown";
 
@@ -1809,9 +1813,9 @@ static int __devinit savage_init_hw (str
 			ActiveDUO = 0x80
 		};
 
-		if ((VGArSEQ (0x39) & 0x03) == 0) {
+		if ((VGArSEQ (0x39, par) & 0x03) == 0) {
 			sTechnology = "TFT";
-		} else if ((VGArSEQ (0x30) & 0x01) == 0) {
+		} else if ((VGArSEQ (0x30, par) & 0x01) == 0) {
 			sTechnology = "DSTN";
 		} else 	{
 			sTechnology = "STN";




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
