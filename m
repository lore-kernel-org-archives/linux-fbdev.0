From: Vinay Simha BN <simhavcs@gmail.com>
Date: Tue, 21 Jul 2015 07:52:00 +0000
Subject: [PATCH 1/2] sm750fb: coding style fixes lines over 80 chars
Message-Id: <1437464402-18451-1-git-send-email-simhavcs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437461084-17565-1-git-send-email-simhavcs@gmail.com>
In-Reply-To: <1437461084-17565-1-git-send-email-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vinay Simha BN <simhavcs@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:STAGING - SILICON MOTION SM750
	FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, open list <linux-kernel@vger.kernel.org>

scripts/checkpatch.pl kernel coding style fixes of WARNING

WARNING: line over 80 characters

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.h | 10 +++++-----
 drivers/staging/sm750fb/ddk750_hwi2c.h   |  6 ++++--
 drivers/staging/sm750fb/ddk750_power.h   |  6 +++---
 drivers/staging/sm750fb/ddk750_sii164.h  | 12 +++++++-----
 drivers/staging/sm750fb/sm750.h          | 13 ++++++++-----
 drivers/staging/sm750fb/sm750_accel.h    | 19 ++++++++++++-------
 drivers/staging/sm750fb/sm750_help.h     | 21 ++++++++++++++-------
 drivers/staging/sm750fb/sm750_hw.h       | 21 +++++++++++++--------
 8 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index abccf84..9afa366 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -110,19 +110,19 @@ typedef enum _disp_output_t {
 
 	/* LCD1 show secondary and DSUB show primary */
 	LCD1_DSUB_DUAL_SWAP = PNL_2_SEC|SEC_TP_ON|PNL_SEQ_ON|
-							CRT_2_PRI|PRI_TP_ON|DAC_ON,
+				CRT_2_PRI|PRI_TP_ON|DAC_ON,
 
 	LCD1_LCD2_PRI = PNL_2_PRI|PRI_TP_ON|PNL_SEQ_ON|
-					CRT_2_PRI|SEC_TP_OFF|DPMS_OFF|DUAL_TFT_ON,
+				CRT_2_PRI|SEC_TP_OFF|DPMS_OFF|DUAL_TFT_ON,
 
 	LCD1_LCD2_SEC = PNL_2_SEC|SEC_TP_ON|PNL_SEQ_ON|
-					CRT_2_SEC|PRI_TP_OFF|DPMS_OFF|DUAL_TFT_ON,
+				CRT_2_SEC|PRI_TP_OFF|DPMS_OFF|DUAL_TFT_ON,
 
 	LCD1_LCD2_DSUB_PRI = PNL_2_PRI|PRI_TP_ON|PNL_SEQ_ON|DAC_ON|
-						CRT_2_PRI|SEC_TP_OFF|DPMS_ON|DUAL_TFT_ON,
+				CRT_2_PRI|SEC_TP_OFF|DPMS_ON|DUAL_TFT_ON,
 
 	LCD1_LCD2_DSUB_SEC = PNL_2_SEC|SEC_TP_ON|PNL_SEQ_ON|DAC_ON|
-						CRT_2_SEC|PRI_TP_OFF|DPMS_ON|DUAL_TFT_ON,
+				CRT_2_SEC|PRI_TP_OFF|DPMS_ON|DUAL_TFT_ON,
 
 
 }
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.h b/drivers/staging/sm750fb/ddk750_hwi2c.h
index 0b830ba6..3d4e48b 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.h
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.h
@@ -5,6 +5,8 @@
 int hwI2CInit(unsigned char busSpeedMode);
 void hwI2CClose(void);
 
-unsigned char hwI2CReadReg(unsigned char deviceAddress, unsigned char registerIndex);
-int hwI2CWriteReg(unsigned char deviceAddress, unsigned char registerIndex, unsigned char data);
+unsigned char hwI2CReadReg(unsigned char deviceAddress,
+	unsigned char registerIndex);
+int hwI2CWriteReg(unsigned char deviceAddress, unsigned char registerIndex,
+	unsigned char data);
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index b7cf6b2..abad4fe 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -12,9 +12,9 @@ DPMS_t;
 #define setDAC(off) \
 		{	\
 		POKE32(MISC_CTRL, FIELD_VALUE(PEEK32(MISC_CTRL), \
-									MISC_CTRL,	\
-									DAC_POWER,	\
-									off));	\
+			MISC_CTRL,	\
+			DAC_POWER,	\
+			off));		\
 		}
 
 void ddk750_setDPMS(DPMS_t);
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index f2610c9..a5246bd 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -5,10 +5,11 @@
 
 /* Hot Plug detection mode structure */
 typedef enum _sii164_hot_plug_mode_t {
-	SII164_HOTPLUG_DISABLE = 0,         /* Disable Hot Plug output bit (always high). */
-	SII164_HOTPLUG_USE_MDI,             /* Use Monitor Detect Interrupt bit. */
-	SII164_HOTPLUG_USE_RSEN,            /* Use Receiver Sense detect bit. */
-	SII164_HOTPLUG_USE_HTPLG            /* Use Hot Plug detect bit. */
+	SII164_HOTPLUG_DISABLE = 0, /* Disable Hot Plug output bit
+					(always high) */
+	SII164_HOTPLUG_USE_MDI,     /* Use Monitor Detect Interrupt bit. */
+	SII164_HOTPLUG_USE_RSEN,    /* Use Receiver Sense detect bit. */
+	SII164_HOTPLUG_USE_HTPLG    /* Use Hot Plug detect bit. */
 } sii164_hot_plug_mode_t;
 
 
@@ -39,7 +40,8 @@ unsigned char sii164IsConnected(void);
 unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
 #endif
-/* below register definination is used for Silicon Image SiI164 DVI controller chip */
+/* below register definination is used for Silicon Image
+	SiI164 DVI controller chip */
 /*
  * Vendor ID registers
  */
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 9b101a9..e2bd920 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -32,9 +32,10 @@ struct lynx_accel {
 						u32, u32, u32, u32,
 						u32, u32, u32, u32);
 
-	int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32, u32,
-							       u32, u32, u32, u32,
-							       u32, u32, u32, u32);
+	int (*de_imageblit)(struct lynx_accel *, const char *,
+						u32, u32, u32, u32,
+						u32, u32, u32, u32,
+						u32, u32, u32, u32);
 
 };
 
@@ -100,7 +101,8 @@ struct lynxfb_crtc {
 	int channel;/* which channel this crtc stands for*/
 	resource_size_t vidmem_size;/* this view's video memory max size */
 
-	/* below attributes belong to info->fix, their value depends on specific adaptor*/
+	/* below attributes belong to info->fix, their value depends on
+		 specific adaptor*/
 	u16 line_pad;/* padding information:0,1,2,4,8,16,... */
 	u16 xpanstep;
 	u16 ypanstep;
@@ -113,7 +115,8 @@ struct lynxfb_crtc {
 						struct fb_fix_screeninfo*);
 
 	int (*proc_checkMode)(struct lynxfb_crtc*, struct fb_var_screeninfo*);
-	int (*proc_setColReg)(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
+	int (*proc_setColReg)(struct lynxfb_crtc*, ushort, ushort, ushort,
+				 ushort);
 	void (*clear)(struct lynxfb_crtc*);
 	/* pan display */
 	int (*proc_panDisplay)(struct lynxfb_crtc *,
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index f252e47..da067a0 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -26,7 +26,7 @@
 #define DE_SOURCE_WRAP_ENABLE                           1
 #define DE_SOURCE_X_K1                                  29:16
 #define DE_SOURCE_Y_K2                                  15:0
-#define DE_SOURCE_X_K1_MONO				20:16
+#define DE_SOURCE_X_K1_MONO				{ 20:16 }
 
 #define DE_DESTINATION                                  0x4
 #define DE_DESTINATION_WRAP                             31:31
@@ -259,17 +259,22 @@ unsigned int height, /* width and height of rectangle in pixel value */
 unsigned int rop2);
 
 int hw_imageblit(struct lynx_accel *accel,
-		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
-		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
-		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
-		 u32 dBase,    /* Address of destination: offset in frame buffer */
+		 const char *pSrcbuf, /* pointer to start of source
+					buffer in system memory */
+		 u32 srcDelta, /* Pitch value (in bytes) of the source buffer,
+				+ive means top down and -ive mean button up */
+		 u32 startBit, /* Mono data can start at any bit in a byte,
+				 this value should be 0 to 7 */
+		 u32 dBase, /* Address of destination: offset in frame buffer */
 		 u32 dPitch,   /* Pitch value of destination surface in BYTE */
 		 u32 bytePerPixel,      /* Color depth of destination surface */
 		 u32 dx,
 		 u32 dy,       /* Starting coordinate of destination surface */
 		 u32 width,
 		 u32 height,   /* width and height of rectange in pixel value */
-		 u32 fColor,   /* Foreground color (corresponding to a 1 in the monochrome data */
-		 u32 bColor,   /* Background color (corresponding to a 0 in the monochrome data */
+		 u32 fColor,   /* Foreground color (corresponding to a 1 in the
+				 monochrome data */
+		 u32 bColor,   /* Background color (corresponding to a 0 in the
+				 monochrome data */
 		 u32 rop2);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
index 8dc6bd2..43d700b 100644
--- a/drivers/staging/sm750fb/sm750_help.h
+++ b/drivers/staging/sm750fb/sm750_help.h
@@ -49,17 +49,23 @@
 /* Field Macros */
 #define FIELD_START(field)              (0 ? field)
 #define FIELD_END(field)                (1 ? field)
-#define FIELD_SIZE(field)               (1 + FIELD_END(field) - FIELD_START(field))
-#define FIELD_MASK(field)               (((1 << (FIELD_SIZE(field)-1)) | ((1 << (FIELD_SIZE(field)-1)) - 1)) << FIELD_START(field))
-#define FIELD_NORMALIZE(reg, field)     (((reg) & FIELD_MASK(field)) >> FIELD_START(field))
-#define FIELD_DENORMALIZE(field, value) (((value) << FIELD_START(field)) & FIELD_MASK(field))
+#define FIELD_SIZE(field)               (1 + FIELD_END(field) - \
+						FIELD_START(field))
+#define FIELD_MASK(field)               (((1 << (FIELD_SIZE(field)-1)) \
+					| ((1 << (FIELD_SIZE(field)-1)) - 1)) \
+					<< FIELD_START(field))
+#define FIELD_NORMALIZE(reg, field)     (((reg) & FIELD_MASK(field)) >> \
+					FIELD_START(field))
+#define FIELD_DENORMALIZE(field, value) (((value) << FIELD_START(field)) & \
+					 FIELD_MASK(field))
 
 #define FIELD_INIT(reg, field, value)   FIELD_DENORMALIZE(reg ## _ ## field, \
-							  reg ## _ ## field ## _ ## value)
+					  reg ## _ ## field ## _ ## value)
 #define FIELD_INIT_VAL(reg, field, value) \
 	(FIELD_DENORMALIZE(reg ## _ ## field, value))
 #define FIELD_VAL_SET(x, r, f, v)       x = x & ~FIELD_MASK(r ## _ ## f) \
-					| FIELD_DENORMALIZE(r ## _ ## f, r ## _ ## f ## _ ## v)
+					| FIELD_DENORMALIZE(r ## _ ## f, \
+					 r ## _ ## f ## _ ## v)
 
 #define RGB(r, g, b) \
 ( \
@@ -68,7 +74,8 @@
 
 #define RGB16(r, g, b) \
 ( \
-	(unsigned short) ((((r) & 0xF8) << 8) | (((g) & 0xFC) << 3) | (((b) & 0xF8) >> 3)) \
+	(unsigned short) ((((r) & 0xF8) << 8) | (((g) & 0xFC) << 3) | \
+			 (((b) & 0xF8) >> 3)) \
 )
 
 static inline unsigned int absDiff(unsigned int a, unsigned int b)
diff --git a/drivers/staging/sm750fb/sm750_hw.h b/drivers/staging/sm750fb/sm750_hw.h
index ef0a16f..eceea39 100644
--- a/drivers/staging/sm750fb/sm750_hw.h
+++ b/drivers/staging/sm750fb/sm750_hw.h
@@ -61,13 +61,15 @@ struct sm750_state {
 	int yLCD;
 };
 
-/* sm750_share stands for a presentation of two frame buffer
-   that use one sm750 adaptor, it is similar to the super class of lynx_share
-   in C++
- */
+/*
+ sm750_share stands for a presentation of two frame buffer
+ that use one sm750 adaptor, it is similar to the super
+ class of lynx_share in C++
+*/
 
 struct sm750_share {
-	/* it's better to put lynx_share struct to the first place of sm750_share */
+	/* it's better to put lynx_share struct to the first place of
+	sm750_share */
 	struct lynx_share share;
 	struct sm750_state state;
 	int hwCursor;
@@ -85,10 +87,13 @@ int hw_sm750_deWait(void);
 int hw_sm750le_deWait(void);
 
 resource_size_t hw_sm750_getVMSize(struct lynx_share *);
-int hw_sm750_output_checkMode(struct lynxfb_output*, struct fb_var_screeninfo*);
-int hw_sm750_output_setMode(struct lynxfb_output*, struct fb_var_screeninfo*, struct fb_fix_screeninfo*);
+int hw_sm750_output_checkMode(struct lynxfb_output*,
+		struct fb_var_screeninfo*);
+int hw_sm750_output_setMode(struct lynxfb_output*,
+		struct fb_var_screeninfo*, struct fb_fix_screeninfo*);
 int hw_sm750_crtc_checkMode(struct lynxfb_crtc*, struct fb_var_screeninfo*);
-int hw_sm750_crtc_setMode(struct lynxfb_crtc*, struct fb_var_screeninfo*, struct fb_fix_screeninfo*);
+int hw_sm750_crtc_setMode(struct lynxfb_crtc*, struct fb_var_screeninfo*,
+		struct fb_fix_screeninfo*);
 int hw_sm750_setColReg(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
 int hw_sm750_setBLANK(struct lynxfb_output*, int);
 int hw_sm750le_setBLANK(struct lynxfb_output*, int);
-- 
2.1.2

