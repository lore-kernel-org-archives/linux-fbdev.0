From: Vinay Simha BN <simhavcs@gmail.com>
Date: Tue, 21 Jul 2015 06:56:43 +0000
Subject: [PATCH] sm750fb: coding style fixes in _accel.h,__help.h
Message-Id: <1437461084-17565-1-git-send-email-simhavcs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437118721.2495.54.camel@perches.com>
In-Reply-To: <1437118721.2495.54.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Vinay Simha BN <simhavcs@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:STAGING - SILICON MOTION SM750
	FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, open list <linux-kernel@vger.kernel.org>

WARNING: line over 80 characters
comment block , odd statement fixes

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 30 ++++++++++++++++++++----------
 drivers/staging/sm750fb/sm750_help.h  | 23 +----------------------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index da067a0..c56fa99 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -259,12 +259,18 @@ unsigned int height, /* width and height of rectangle in pixel value */
 unsigned int rop2);
 
 int hw_imageblit(struct lynx_accel *accel,
-		 const char *pSrcbuf, /* pointer to start of source
-					buffer in system memory */
-		 u32 srcDelta, /* Pitch value (in bytes) of the source buffer,
-				+ive means top down and -ive mean button up */
-		 u32 startBit, /* Mono data can start at any bit in a byte,
-				 this value should be 0 to 7 */
+		 const char *pSrcbuf,  /*
+					* pointer to start of source
+					* buffer in system memory
+					*/
+		 u32 srcDelta, /*
+				* Pitch value (in bytes) of the source buffer,
+				* +ive means top down and -ive mean button up
+				*/
+		 u32 startBit, /*
+				* Mono data can start at any bit in a byte,
+				* this value should be 0 to 7
+				*/
 		 u32 dBase, /* Address of destination: offset in frame buffer */
 		 u32 dPitch,   /* Pitch value of destination surface in BYTE */
 		 u32 bytePerPixel,      /* Color depth of destination surface */
@@ -272,9 +278,13 @@ int hw_imageblit(struct lynx_accel *accel,
 		 u32 dy,       /* Starting coordinate of destination surface */
 		 u32 width,
 		 u32 height,   /* width and height of rectange in pixel value */
-		 u32 fColor,   /* Foreground color (corresponding to a 1 in the
-				 monochrome data */
-		 u32 bColor,   /* Background color (corresponding to a 0 in the
-				 monochrome data */
+		 u32 fColor,   /*
+				* Foreground color (corresponding to a 1 in the
+				* monochrome data
+				*/
+		 u32 bColor,   /*
+				* Background color (corresponding to a 0 in the
+				* monochrome data
+				*/
 		 u32 rop2);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
index 43d700b..c9378e2 100644
--- a/drivers/staging/sm750fb/sm750_help.h
+++ b/drivers/staging/sm750fb/sm750_help.h
@@ -1,7 +1,7 @@
 #ifndef LYNX_HELP_H__
 #define LYNX_HELP_H__
 
-/*  FIELD MACROS */
+/* FIELD MACROS */
 #define _LSB(f)             (0 ? f)
 #define _MSB(f)             (1 ? f)
 #define _COUNT(f)           (_MSB(f) - _LSB(f) + 1)
@@ -46,27 +46,6 @@
 	~ _F_MASK(reg ## _ ## field) \
 )
 
-/* Field Macros */
-#define FIELD_START(field)              (0 ? field)
-#define FIELD_END(field)                (1 ? field)
-#define FIELD_SIZE(field)               (1 + FIELD_END(field) - \
-						FIELD_START(field))
-#define FIELD_MASK(field)               (((1 << (FIELD_SIZE(field)-1)) \
-					| ((1 << (FIELD_SIZE(field)-1)) - 1)) \
-					<< FIELD_START(field))
-#define FIELD_NORMALIZE(reg, field)     (((reg) & FIELD_MASK(field)) >> \
-					FIELD_START(field))
-#define FIELD_DENORMALIZE(field, value) (((value) << FIELD_START(field)) & \
-					 FIELD_MASK(field))
-
-#define FIELD_INIT(reg, field, value)   FIELD_DENORMALIZE(reg ## _ ## field, \
-					  reg ## _ ## field ## _ ## value)
-#define FIELD_INIT_VAL(reg, field, value) \
-	(FIELD_DENORMALIZE(reg ## _ ## field, value))
-#define FIELD_VAL_SET(x, r, f, v)       x = x & ~FIELD_MASK(r ## _ ## f) \
-					| FIELD_DENORMALIZE(r ## _ ## f, \
-					 r ## _ ## f ## _ ## v)
-
 #define RGB(r, g, b) \
 ( \
 	(unsigned long) (((r) << 16) | ((g) << 8) | (b)) \
-- 
2.1.2

