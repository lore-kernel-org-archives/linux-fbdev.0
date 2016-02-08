From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Feb 2016 06:09:23 +0000
Subject: patch "staging: sm750fb, fix typos" added to staging-next
Message-Id: <145491176366145@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <14549000707369@kroah.com>
In-Reply-To: <14549000707369@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    staging: sm750fb, fix typos

to my staging git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
in the staging-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From fbb8c963573926bceb5c59e2a7d74e5ce7669e78 Mon Sep 17 00:00:00 2001
From: Matej Vasek <xvasek1@fi.muni.cz>
Date: Mon, 25 Jan 2016 16:02:33 +0100
Subject: staging: sm750fb, fix typos

The code contained typos like "structur", "fointers", etc. Fix that.

No code change, only comments.

Signed-off-by: Matej Vasek <xvasek1@fi.muni.cz>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-fbdev@vger.kernel.org>
Cc: <devel@driverdev.osuosl.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/sm750fb/ddk750_hwi2c.c  | 4 ++--
 drivers/staging/sm750fb/ddk750_mode.c   | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.h | 5 ++++-
 drivers/staging/sm750fb/sm750.c         | 2 +-
 drivers/staging/sm750fb/sm750.h         | 2 +-
 drivers/staging/sm750fb/sm750_accel.c   | 4 ++--
 drivers/staging/sm750fb/sm750_accel.h   | 2 +-
 drivers/staging/sm750fb/sm750_hw.c      | 2 +-
 8 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
index b824681e55a7..40253bd8cf2a 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
@@ -127,7 +127,7 @@ static unsigned int hw_i2c_write_data(
 		if (hw_i2c_wait_tx_done() != 0)
 			break;
 
-		/* Substract length */
+		/* Subtract length */
 		length -= (count + 1);
 
 		/* Total byte written */
@@ -194,7 +194,7 @@ static unsigned int hw_i2c_read_data(
 		for (i = 0; i <= count; i++)
 			*buf++ = PEEK32(I2C_DATA0 + i);
 
-		/* Substract length by 16 */
+		/* Subtract length by 16 */
 		length -= (count + 1);
 
 		/* Number of bytes read. */
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 0fd34fa93a41..d0e3935654ff 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -42,7 +42,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 	dispControl &= FIELD_CLEAR(CRT_DISPLAY_CTRL, CLK);
 
 	/* Set bit 29:27 of display control register for the right clock */
-	/* Note that SM750LE only need to supported 7 resoluitons. */
+	/* Note that SM750LE only need to supported 7 resolutions. */
 	if (x = 800 && y = 600)
 		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL41);
 	else if (x = 1024 && y = 768)
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index f2610c90eeb4..664ad089f753 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -39,7 +39,10 @@ unsigned char sii164IsConnected(void);
 unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
 #endif
-/* below register definination is used for Silicon Image SiI164 DVI controller chip */
+/*
+ * below register definition is used for
+ * Silicon Image SiI164 DVI controller chip
+ */
 /*
  * Vendor ID registers
  */
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 2ae2a522136f..c9d4871cd62d 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -319,7 +319,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	var = &info->var;
 	fix = &info->fix;
 
-	/* fix structur is not so FIX ... */
+	/* fix structure is not so FIX ... */
 	line_length = var->xres_virtual * var->bits_per_pixel / 8;
 	line_length = ALIGN(line_length, crtc->line_pad);
 	fix->line_length = line_length;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index fddffac6930f..8e70ce0d6da4 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -53,7 +53,7 @@ struct lynx_accel {
 	/* base virtual address of de data port */
 	volatile unsigned char __iomem *dpPortBase;
 
-	/* function fointers */
+	/* function pointers */
 	void (*de_init)(struct lynx_accel *);
 
 	int (*de_wait)(void);/* see if hardware ready to work */
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 43e59725920c..e150680a8cd1 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -53,7 +53,7 @@ void hw_de_init(struct lynx_accel *accel)
 		FIELD_CLEAR(DE_STRETCH_FORMAT, ADDRESSING)&
 		FIELD_CLEAR(DE_STRETCH_FORMAT, SOURCE_HEIGHT);
 
-	/* DE_STRETCH bpp format need be initilized in setMode routine */
+	/* DE_STRETCH bpp format need be initialized in setMode routine */
 	write_dpr(accel, DE_STRETCH_FORMAT, (read_dpr(accel, DE_STRETCH_FORMAT) & clr) | reg);
 
 	/* disable clipping and transparent */
@@ -305,7 +305,7 @@ int hw_imageblit(struct lynx_accel *accel,
 		 u32 dx,
 		 u32 dy,       /* Starting coordinate of destination surface */
 		 u32 width,
-		 u32 height,   /* width and height of rectange in pixel value */
+		 u32 height,   /* width and height of rectangle in pixel value */
 		 u32 fColor,   /* Foreground color (corresponding to a 1 in the monochrome data */
 		 u32 bColor,   /* Background color (corresponding to a 0 in the monochrome data */
 		 u32 rop2)     /* ROP value */
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index f252e47d5ee9..1ec66d28f456 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -268,7 +268,7 @@ int hw_imageblit(struct lynx_accel *accel,
 		 u32 dx,
 		 u32 dy,       /* Starting coordinate of destination surface */
 		 u32 width,
-		 u32 height,   /* width and height of rectange in pixel value */
+		 u32 height,   /* width and height of rectangle in pixel value */
 		 u32 fColor,   /* Foreground color (corresponding to a 1 in the monochrome data */
 		 u32 bColor,   /* Background color (corresponding to a 0 in the monochrome data */
 		 u32 rop2);
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index b33ec076f3f5..c0c2f1c4de82 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -142,7 +142,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		break;
 		}
 	} else {
-		/* for 750LE ,no DVI chip initilization makes Monitor no signal */
+		/* for 750LE ,no DVI chip initialization makes Monitor no signal */
 		/* Set up GPIO for software I2C to program DVI chip in the
 		   Xilinx SP605 board, in order to have video signal.
 		 */
-- 
2.7.1


