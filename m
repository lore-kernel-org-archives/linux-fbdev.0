From: Juston Li <juston.h.li@gmail.com>
Date: Fri, 12 Jun 2015 07:07:17 +0000
Subject: [PATCH] staging: sm750fb: fix c99 comments
Message-Id: <1434092837-10290-1-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

fixed all checkpatch.pl ERROR: do not use C99 // comments

Any C99 comments used to comment out code are simply removed.
Also some of the errors occur inside '#if 0' blocks which I
might as well fix since checkpatch.pl caught them but the blocks
themselves should probably be cleaned up later.

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c   | 11 ++------
 drivers/staging/sm750fb/ddk750_dvi.c    |  4 +--
 drivers/staging/sm750fb/ddk750_help.c   |  2 --
 drivers/staging/sm750fb/ddk750_sii164.c | 11 --------
 drivers/staging/sm750fb/sm750.h         | 10 +++----
 drivers/staging/sm750fb/sm750_accel.c   | 49 ++++++++++++++++-----------------
 drivers/staging/sm750fb/sm750_accel.h   |  2 +-
 drivers/staging/sm750fb/sm750_cursor.c  |  9 +++---
 drivers/staging/sm750fb/sm750_help.h    | 28 +++----------------
 drivers/staging/sm750fb/sm750_hw.c      |  4 +--
 drivers/staging/sm750fb/sm750_hw.h      |  3 --
 11 files changed, 41 insertions(+), 92 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 8b47c1b..b2137c8 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -17,7 +17,7 @@ logical_chip_type_t getChipType(void)
 	char physicalRev;
 	logical_chip_type_t chip;
 
-	physicalID = devId750;//either 0x718 or 0x750
+	physicalID = devId750; /* either 0x718 or 0x750 /
 	physicalRev = revId750;
 
 	if (physicalID = 0x718)
@@ -257,7 +257,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 
 	unsigned int ulReg;
 #if 0
-	//move the code to map regiter function.
+	/* move the code to map regiter function. */
 	if (getChipType() = SM718) {
 		/* turn on big endian bit*/
 		ulReg = PEEK32(0x74);
@@ -487,8 +487,6 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 			}
 		}
 	}
-
-	//printk("Finally:  pll->n[%lu],m[%lu],od[%lu],pod[%lu]\n",pll->N,pll->M,pll->OD,pll->POD);
 	return ret;
 }
 
@@ -580,14 +578,9 @@ pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
 	}
 
     /* Restore input frequency from Khz to hz unit */
-//    pPLL->inputFreq *= 1000;
 	ulRequestClk *= 1000;
 	pPLL->inputFreq = DEFAULT_INPUT_CLOCK; /* Default reference clock */
 
-    /* Output debug information */
-	//DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Requested Frequency = %d\n", ulRequestClk));
-	//DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Input CLK = %dHz, M=%d, N=%d, OD=%d, POD=%d\n", pPLL->inputFreq, pPLL->M, pPLL->N, pPLL->OD, pPLL->POD));
-
     /* Return actual frequency that the PLL can set */
 	ret = calcPLL(pPLL);
 	return ret;
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index f5932bb..b2bf7e6 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -51,7 +51,7 @@ int dviInit(
                               vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
                               pllFilterEnable, pllFilterValue);
 	}
-	return -1;//error
+	return -1; /* error */
 }
 
 
@@ -66,7 +66,6 @@ unsigned short dviGetVendorID(void)
 {
     dvi_ctrl_device_t *pCurrentDviCtrl;
 
-    //pCurrentDviCtrl = getDviCtrl();
     pCurrentDviCtrl = g_dcftSupportedDviController;
     if (pCurrentDviCtrl != (dvi_ctrl_device_t *)0)
         return pCurrentDviCtrl->pfnGetVendorId();
@@ -86,7 +85,6 @@ unsigned short dviGetDeviceID(void)
 {
     dvi_ctrl_device_t *pCurrentDviCtrl;
 
-//    pCurrentDviCtrl = getDviCtrl();
 	pCurrentDviCtrl = g_dcftSupportedDviController;
     if (pCurrentDviCtrl != (dvi_ctrl_device_t *)0)
         return pCurrentDviCtrl->pfnGetDeviceId();
diff --git a/drivers/staging/sm750fb/ddk750_help.c b/drivers/staging/sm750fb/ddk750_help.c
index 647004d..96c18eb 100644
--- a/drivers/staging/sm750fb/ddk750_help.c
+++ b/drivers/staging/sm750fb/ddk750_help.c
@@ -1,5 +1,3 @@
-//#include "ddk750_reg.h"
-//#include "ddk750_chip.h"
 #include "ddk750_help.h"
 
 void __iomem * mmio750 = NULL;
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 84464c1..b6395b8 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -125,10 +125,7 @@ long sii164InitChip(
     unsigned char pllFilterValue
 )
 {
-    //unsigned char ucRegIndex, ucRegValue;
-    //unsigned char ucDeviceAddress,
 	unsigned char config;
-    //unsigned long delayCount;
 
     /* Initialize the i2c bus */
 #ifdef USE_HW_I2C
@@ -141,10 +138,6 @@ long sii164InitChip(
     /* Check if SII164 Chip exists */
     if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID))
     {
-
-#ifdef DDKDEBUG
-        //sii164PrintRegisterValues();
-#endif
         /*
          *  Initialize SII164 controller chip.
          */
@@ -241,10 +234,6 @@ long sii164InitChip(
         config |= SII164_CONFIGURATION_POWER_NORMAL;
         i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
-#ifdef DDKDEBUG
-        //sii164PrintRegisterValues();
-#endif
-
         return 0;
     }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 30aa312..273882f 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -7,8 +7,6 @@
 /* please use revision id to distinguish sm750le and sm750*/
 #define SPC_SM750 	0
 
-//#define SPC_SM750LE 8
-
 #define MB(x) ((x)<<20)
 #define MHZ(x) ((x) * 1000000)
 /* align should be 2,4,8,16 */
@@ -95,10 +93,10 @@ struct lynx_cursor{
 };
 
 struct lynxfb_crtc{
-	unsigned char __iomem * vCursor;//virtual address of cursor
-	unsigned char __iomem * vScreen;//virtual address of on_screen
-	int oCursor;//cursor address offset in vidmem
-	int oScreen;//onscreen address offset in vidmem
+	unsigned char __iomem * vCursor; /* virtual address of cursor */
+	unsigned char __iomem * vScreen; /* virtual address of on_screen */
+	int oCursor; /* cursor address offset in vidmem */
+	int oScreen; /* onscreen address offset in vidmem */
 	int channel;/* which channel this crtc stands for*/
 	resource_size_t vidmem_size;/* this view's video memory max size */
 
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 001e980..a2baffd 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -57,10 +57,10 @@ void hw_de_init(struct lynx_accel * accel)
 	write_dpr(accel, DE_STRETCH_FORMAT, (read_dpr(accel, DE_STRETCH_FORMAT) & clr) | reg);
 
 	/* disable clipping and transparent */
-	write_dpr(accel, DE_CLIP_TL, 0);//dpr2c
-	write_dpr(accel, DE_CLIP_BR, 0);//dpr30
+	write_dpr(accel, DE_CLIP_TL, 0); /* dpr2c */
+	write_dpr(accel, DE_CLIP_BR, 0); /* dpr30 */
 
-	write_dpr(accel, DE_COLOR_COMPARE_MASK, 0);//dpr24
+	write_dpr(accel, DE_COLOR_COMPARE_MASK, 0); /* dpr24 */
 	write_dpr(accel, DE_COLOR_COMPARE, 0);
 
 	reg = FIELD_SET(0, DE_CONTROL, TRANSPARENCY, DISABLE)|
@@ -104,25 +104,25 @@ int hw_fillrect(struct lynx_accel * accel,
 		return -1;
 	}
 
-	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base);//dpr40
+	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
 	write_dpr(accel, DE_PITCH,
 			FIELD_VALUE(0, DE_PITCH, DESTINATION, pitch/Bpp)|
-			FIELD_VALUE(0, DE_PITCH, SOURCE, pitch/Bpp));//dpr10
+			FIELD_VALUE(0, DE_PITCH, SOURCE, pitch/Bpp)); /* dpr10 */
 
 	write_dpr(accel, DE_WINDOW_WIDTH,
 			FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, pitch/Bpp)|
-			FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE, pitch/Bpp));//dpr44
+			FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE, pitch/Bpp)); /* dpr44 */
 
-	write_dpr(accel, DE_FOREGROUND, color);//DPR14
+	write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */
 
 	write_dpr(accel, DE_DESTINATION,
 			FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE)|
 			FIELD_VALUE(0, DE_DESTINATION, X, x)|
-			FIELD_VALUE(0, DE_DESTINATION, Y, y));//dpr4
+			FIELD_VALUE(0, DE_DESTINATION, Y, y)); /* dpr4 */
 
 	write_dpr(accel, DE_DIMENSION,
 			FIELD_VALUE(0, DE_DIMENSION, X, width)|
-			FIELD_VALUE(0, DE_DIMENSION, Y_ET, height));//dpr8
+			FIELD_VALUE(0, DE_DIMENSION, Y_ET, height)); /* dpr8 */
 
 	deCtrl  		FIELD_SET(0, DE_CONTROL, STATUS, START)|
@@ -130,7 +130,7 @@ int hw_fillrect(struct lynx_accel * accel,
 		FIELD_SET(0, DE_CONTROL, LAST_PIXEL, ON)|
 		FIELD_SET(0, DE_CONTROL, COMMAND, RECTANGLE_FILL)|
 		FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2)|
-		FIELD_VALUE(0, DE_CONTROL, ROP, rop);//dpr0xc
+		FIELD_VALUE(0, DE_CONTROL, ROP, rop); /* dpr0xc */
 
 	write_dpr(accel, DE_CONTROL, deCtrl);
 	return 0;
@@ -236,12 +236,12 @@ unsigned int rop2)   /* ROP value */
     /* 2D Source Base.
        It is an address offset (128 bit aligned) from the beginning of frame buffer.
     */
-    write_dpr(accel, DE_WINDOW_SOURCE_BASE, sBase);//dpr40
+    write_dpr(accel, DE_WINDOW_SOURCE_BASE, sBase); /* dpr40 */
 
     /* 2D Destination Base.
        It is an address offset (128 bit aligned) from the beginning of frame buffer.
     */
-    write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase);//dpr44
+    write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
 
 #if 0
     /* Program pitch (distance between the 1st points of two adjacent lines).
@@ -254,14 +254,14 @@ unsigned int rop2)   /* ROP value */
 			width *= 3;
 		write_dpr(accel, DE_PITCH,
 				FIELD_VALUE(0, DE_PITCH, DESTINATION, dPitch) |
-				FIELD_VALUE(0, DE_PITCH, SOURCE,      sPitch));//dpr10
+				FIELD_VALUE(0, DE_PITCH, SOURCE,      sPitch)); /* dpr10 */
 	}
 	else
 #endif
 	{
 		write_dpr(accel, DE_PITCH,
 				FIELD_VALUE(0, DE_PITCH, DESTINATION, (dPitch/Bpp)) |
-				FIELD_VALUE(0, DE_PITCH, SOURCE,      (sPitch/Bpp)));//dpr10
+				FIELD_VALUE(0, DE_PITCH, SOURCE,      (sPitch/Bpp))); /* dpr10 */
 	}
 
     /* Screen Window width in Pixels.
@@ -269,7 +269,7 @@ unsigned int rop2)   /* ROP value */
     */
     write_dpr(accel, DE_WINDOW_WIDTH,
         FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/Bpp)) |
-        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (sPitch/Bpp)));//dpr3c
+        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (sPitch/Bpp))); /* dpr3c */
 
 	if (accel->de_wait() != 0){
 		return -1;
@@ -280,14 +280,14 @@ unsigned int rop2)   /* ROP value */
         write_dpr(accel, DE_SOURCE,
             FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
             FIELD_VALUE(0, DE_SOURCE, X_K1, sx)   |
-            FIELD_VALUE(0, DE_SOURCE, Y_K2, sy));//dpr0
+            FIELD_VALUE(0, DE_SOURCE, Y_K2, sy)); /* dpr0 */
         write_dpr(accel, DE_DESTINATION,
             FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
             FIELD_VALUE(0, DE_DESTINATION, X,    dx)  |
-            FIELD_VALUE(0, DE_DESTINATION, Y,    dy));//dpr04
+            FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
         write_dpr(accel, DE_DIMENSION,
             FIELD_VALUE(0, DE_DIMENSION, X,    width) |
-            FIELD_VALUE(0, DE_DIMENSION, Y_ET, height));//dpr08
+            FIELD_VALUE(0, DE_DIMENSION, Y_ET, height)); /* dpr08 */
 
         de_ctrl              FIELD_VALUE(0, DE_CONTROL, ROP, rop2) |
@@ -297,7 +297,7 @@ unsigned int rop2)   /* ROP value */
             FIELD_SET(0, DE_CONTROL, DIRECTION, RIGHT_TO_LEFT)
             : FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT)) |
             FIELD_SET(0, DE_CONTROL, STATUS, START);
-		write_dpr(accel, DE_CONTROL, de_ctrl);//dpr0c
+		write_dpr(accel, DE_CONTROL, de_ctrl); /* dpr0c */
     }
 
     return 0;
@@ -346,7 +346,6 @@ int hw_imageblit(struct lynx_accel *accel,
 
 	if(accel->de_wait() != 0)
     {
-//		inf_msg("*** ImageBlit return -1 ***\n");
         return -1;
     }
 
@@ -370,7 +369,7 @@ int hw_imageblit(struct lynx_accel *accel,
 		startBit *= 3;
 		write_dpr(accel, DE_PITCH,
 				FIELD_VALUE(0, DE_PITCH, DESTINATION, dPitch) |
-				FIELD_VALUE(0, DE_PITCH, SOURCE,      dPitch));//dpr10
+				FIELD_VALUE(0, DE_PITCH, SOURCE,      dPitch)); /* dpr10 */
 
 	}
 	else
@@ -378,7 +377,7 @@ int hw_imageblit(struct lynx_accel *accel,
 	{
 		write_dpr(accel, DE_PITCH,
 				FIELD_VALUE(0, DE_PITCH, DESTINATION, dPitch/bytePerPixel) |
-				FIELD_VALUE(0, DE_PITCH, SOURCE,      dPitch/bytePerPixel));//dpr10
+				FIELD_VALUE(0, DE_PITCH, SOURCE,      dPitch/bytePerPixel)); /* dpr10 */
 	}
 
     /* Screen Window width in Pixels.
@@ -392,16 +391,16 @@ int hw_imageblit(struct lynx_accel *accel,
              For mono bitmap, use startBit for X_K1. */
     write_dpr(accel, DE_SOURCE,
         FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE)       |
-        FIELD_VALUE(0, DE_SOURCE, X_K1_MONO, startBit));//dpr00
+        FIELD_VALUE(0, DE_SOURCE, X_K1_MONO, startBit)); /* dpr00 */
 
     write_dpr(accel, DE_DESTINATION,
         FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
         FIELD_VALUE(0, DE_DESTINATION, X,    dx)    |
-        FIELD_VALUE(0, DE_DESTINATION, Y,    dy));//dpr04
+        FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
 
     write_dpr(accel, DE_DIMENSION,
         FIELD_VALUE(0, DE_DIMENSION, X,    width) |
-        FIELD_VALUE(0, DE_DIMENSION, Y_ET, height));//dpr08
+        FIELD_VALUE(0, DE_DIMENSION, Y_ET, height)); /* dpr08 */
 
     write_dpr(accel, DE_FOREGROUND, fColor);
     write_dpr(accel, DE_BACKGROUND, bColor);
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index e9d217b..57e20fb 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -113,7 +113,7 @@
 #define DE_CONTROL_TRANSPARENCY_ENABLE                  1
 #define DE_CONTROL_ROP                                  7:0
 
-// Pseudo fields.
+/* Pseudo fields. */
 
 #define DE_CONTROL_SHORT_STROKE_DIR                     27:24
 #define DE_CONTROL_SHORT_STROKE_DIR_225                 0
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index b145285..cb37ea3 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -141,10 +141,10 @@ void hw_cursor_setData(struct lynx_cursor * cursor,
 		{
 
 			if(opr & (0x80 >> j))
-			{	//use fg color,id = 2
+			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
 			}else{
-				//use bg color,id = 1
+				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
 		}
@@ -221,10 +221,10 @@ void hw_cursor_setData2(struct lynx_cursor * cursor,
 		{
 
 			if(opr & (0x80 >> j))
-			{	//use fg color,id = 2
+			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
 			}else{
-				//use bg color,id = 1
+				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
 		}
@@ -238,7 +238,6 @@ void hw_cursor_setData2(struct lynx_cursor * cursor,
 
 		/* assume pitch is 1,2,4,8,...*/
 		if(!(i&(pitch-1)))
-		//if((i+1) % pitch = 0)
 		{
 			/* need a return */
 			pstart += offset;
diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
index ebc946c..05777f7 100644
--- a/drivers/staging/sm750fb/sm750_help.h
+++ b/drivers/staging/sm750fb/sm750_help.h
@@ -1,9 +1,7 @@
 #ifndef LYNX_HELP_H__
 #define LYNX_HELP_H__
-/*****************************************************************************\
- *                                FIELD MACROS                               *
-\*****************************************************************************/
 
+/*  FIELD MACROS */
 #define _LSB(f)             (0 ? f)
 #define _MSB(f)             (1 ? f)
 #define _COUNT(f)           (_MSB(f) - _LSB(f) + 1)
@@ -17,13 +15,7 @@
 #define SET_FIELDV(d, f, v) (((d) & ~GET_MASK(f)) | \
                             (((v) & RAW_MASK(f)) << _LSB(f)))
 
-
-////////////////////////////////////////////////////////////////////////////////
-//                                                                            //
-// Internal macros                                                            //
-//                                                                            //
-////////////////////////////////////////////////////////////////////////////////
-
+/* Internal macros */
 #define _F_START(f)             (0 ? f)
 #define _F_END(f)               (1 ? f)
 #define _F_SIZE(f)              (1 + _F_END(f) - _F_START(f))
@@ -31,13 +23,7 @@
 #define _F_NORMALIZE(v, f)      (((v) & _F_MASK(f)) >> _F_START(f))
 #define _F_DENORMALIZE(v, f)    (((v) << _F_START(f)) & _F_MASK(f))
 
-
-////////////////////////////////////////////////////////////////////////////////
-//                                                                            //
-// Global macros                                                              //
-//                                                                            //
-////////////////////////////////////////////////////////////////////////////////
-
+/* Global macros */
 #define FIELD_GET(x, reg, field) \
 ( \
     _F_NORMALIZE((x), reg ## _ ## field) \
@@ -60,13 +46,7 @@
     ~ _F_MASK(reg ## _ ## field) \
 )
 
-
-////////////////////////////////////////////////////////////////////////////////
-//                                                                            //
-// Field Macros                                                               //
-//                                                                            //
-////////////////////////////////////////////////////////////////////////////////
-
+/* Field Macros */
 #define FIELD_START(field)              (0 ? field)
 #define FIELD_END(field)                (1 ? field)
 #define FIELD_SIZE(field)               (1 + FIELD_END(field) - FIELD_START(field))
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 131125c..e70961e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -193,7 +193,6 @@ int hw_sm750_inithw(struct lynx_share* share, struct pci_dev * pdev)
 	/* init 2d engine */
 	if(!share->accel_off){
 		hw_sm750_initAccel(share);
-//		share->accel.de_wait = hw_sm750_deWait;
 	}
 
 	return 0;
@@ -328,7 +327,6 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 #endif
 
 	/* set timing */
-//	modparm.pixel_clock = PS_TO_HZ(var->pixclock);
 	modparm.pixel_clock = ps_to_hz(var->pixclock);
 	modparm.vertical_sync_polarity = (var->sync & FB_SYNC_HOR_HIGH_ACT) ? POS:NEG;
 	modparm.horizontal_sync_polarity = (var->sync & FB_SYNC_VERT_HIGH_ACT) ? POS:NEG;
@@ -618,7 +616,7 @@ int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
         const struct fb_info *info)
 {
     uint32_t total;
-    //check params
+    /* check params */
     if ((var->xoffset + var->xres > var->xres_virtual) ||
             (var->yoffset + var->yres > var->yres_virtual)) {
         return -EINVAL;
diff --git a/drivers/staging/sm750fb/sm750_hw.h b/drivers/staging/sm750fb/sm750_hw.h
index 4fee28d..93288b3 100644
--- a/drivers/staging/sm750fb/sm750_hw.h
+++ b/drivers/staging/sm750fb/sm750_hw.h
@@ -8,9 +8,6 @@
 #define SM750LE_REVISION_ID (unsigned char)0xfe
 #endif
 
-//#define DEFAULT_MEM_CLOCK	(DEFAULT_SM750_CHIP_CLOCK/1)
-//#define DEFAULT_MASTER_CLOCK	(DEFAULT_SM750_CHIP_CLOCK/3)
-
 
 enum sm750_pnltype{
 
-- 
2.4.3

