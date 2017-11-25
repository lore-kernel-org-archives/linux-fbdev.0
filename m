From: Jeremy Lacomis <j.lacomis@gmail.com>
Date: Sat, 25 Nov 2017 22:48:11 +0000
Subject: [PATCH v2] staging: sm750b: Fix coding style issues in sm750_accel.c
Message-Id: <20171125224812.23914-1-j.lacomis@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1511649387.20482.5.camel@perches.com>
In-Reply-To: <1511649387.20482.5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeremy Lacomis <j.lacomis@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This is a patch to sm750_accel.c that fixes 80-character line length
warnings found by checkpatch.pl. It also fixes some grammatical errors
in comments and moves parameter-specific comments from inline to before
the function.

Signed-off-by: Jeremy Lacomis <j.lacomis@gmail.com>
---
Changes in v2:
- Change function comments to the kernel-doc format

 drivers/staging/sm750fb/sm750_accel.c | 189 ++++++++++++++++++----------------
 1 file changed, 103 insertions(+), 86 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 1035e91e7cd3..42cd920111bf 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -68,11 +68,10 @@ void sm750_hw_de_init(struct lynx_accel *accel)
 }
 
 /*
- * set2dformat only be called from setmode functions
- * but if you need dual framebuffer driver,need call set2dformat
- * every time you use 2d function
+ * set2dformat can only be called from setmode functions, but if you need a dual
+ * framebuffer driver, set2dformat must be called every time a 2D function is
+ * used
  */
-
 void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 {
 	u32 reg;
@@ -94,7 +93,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
 	if (accel->de_wait() != 0) {
 		/*
-		 * int time wait and always busy,seems hardware
+		 * int time wait and always busy, seems hardware
 		 * got something error
 		 */
 		pr_debug("De engine always busy\n");
@@ -130,80 +129,88 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 	return 0;
 }
 
-int sm750_hw_copyarea(
-struct lynx_accel *accel,
-unsigned int sBase,  /* Address of source: offset in frame buffer */
-unsigned int sPitch, /* Pitch value of source surface in BYTE */
-unsigned int sx,
-unsigned int sy,     /* Starting coordinate of source surface */
-unsigned int dBase,  /* Address of destination: offset in frame buffer */
-unsigned int dPitch, /* Pitch value of destination surface in BYTE */
-unsigned int Bpp,    /* Color depth of destination surface */
-unsigned int dx,
-unsigned int dy,     /* Starting coordinate of destination surface */
-unsigned int width,
-unsigned int height, /* width and height of rectangle in pixel value */
-unsigned int rop2)   /* ROP value */
+/**
+ * sm750_hw_copyarea()
+ * @sBase: Address of the source offset in the frame buffer
+ * @sPitch: Pitch value of the source surface in BYTE
+ * @sx: Starting x-coordinate of the source surface
+ * @sy: Starting y-coordinate of the source surface
+ * @dBase: Address of the destination offset in the frame buffer
+ * @dPitch: Pitch value of the destination surface in BYTE
+ * @Bpp: Color depth of the destination surface
+ * @dx: Starting x-coordinate of the destination surface
+ * @dy: Starting y-coordinate of the destination surface
+ * @width: Width of the rectangle in pixels
+ * @height: Height of the rectangle in pixels
+ * @rop2: ROP value
+ */
+int sm750_hw_copyarea(struct lynx_accel *accel, unsigned int sBase,
+		      unsigned int sPitch, unsigned int sx, unsigned int sy,
+		      unsigned int dBase, unsigned int dPitch, unsigned int Bpp,
+		      unsigned int dx, unsigned int dy, unsigned int width,
+		      unsigned int height, unsigned int rop2)
 {
 	unsigned int nDirection, de_ctrl;
 
 	nDirection = LEFT_TO_RIGHT;
-	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
+	/*
+	 * Direction of ROP2 operation:
+	 *         1  = Left to Right
+	 *         -1 = Right to Left
+	 */
 	de_ctrl = 0;
 
-	/* If source and destination are the same surface, need to check for overlay cases */
+	/*
+	 * If the source and destination are the same surface, need to check for
+	 * overlay cases
+	 */
 	if (sBase = dBase && sPitch = dPitch) {
 		/* Determine direction of operation */
-		if (sy < dy) {
-			/* +----------+
-			 * |S         |
-			 * |   +----------+
-			 * |   |      |   |
-			 * |   |      |   |
-			 * +---|------+   |
-			 * |         D|
-			 * +----------+
-			 */
 
+		/* +----------+
+		 * |S         |
+		 * |   +----------+
+		 * |   |      |   |
+		 * |   |      |   |
+		 * +---|------+   |
+		 * |         D|
+		 * +----------+
+		 */
+		if (sy < dy) {
 			nDirection = BOTTOM_TO_TOP;
-		} else if (sy > dy) {
-			/* +----------+
-			 * |D         |
-			 * |   +----------+
-			 * |   |      |   |
-			 * |   |      |   |
-			 * +---|------+   |
-			 * |         S|
-			 * +----------+
-			 */
 
+		/* +----------+
+		 * |D         |
+		 * |   +----------+
+		 * |   |      |   |
+		 * |   |      |   |
+		 * +---|------+   |
+		 * |         S|
+		 * +----------+
+		 */
+		} else if (sy > dy) {
 			nDirection = TOP_TO_BOTTOM;
-		} else {
-			/* sy = dy */
-
-			if (sx <= dx) {
-				/* +------+---+------+
-				 * |S     |   |     D|
-				 * |      |   |      |
-				 * |      |   |      |
-				 * |      |   |      |
-				 * +------+---+------+
-				 */
 
+		} else {
+			/* +------+---+------+
+			 * |S     |   |     D|
+			 * |      |   |      |
+			 * |      |   |      |
+			 * |      |   |      |
+			 * +------+---+------+
+			 */
+			if (sx <= dx)
 				nDirection = RIGHT_TO_LEFT;
-			} else {
-			/* sx > dx */
-
-				/* +------+---+------+
-				 * |D     |   |     S|
-				 * |      |   |      |
-				 * |      |   |      |
-				 * |      |   |      |
-				 * +------+---+------+
-				 */
 
+			/* +------+---+------+
+			 * |D     |   |     S|
+			 * |      |   |      |
+			 * |      |   |      |
+			 * |      |   |      |
+			 * +------+---+------+
+			 */
+			else
 				nDirection = LEFT_TO_RIGHT;
-			}
 		}
 	}
 
@@ -288,20 +295,28 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
 	return de_ctrl;
 }
 
-int sm750_hw_imageblit(struct lynx_accel *accel,
-		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
-		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
-		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
-		 u32 dBase,    /* Address of destination: offset in frame buffer */
-		 u32 dPitch,   /* Pitch value of destination surface in BYTE */
-		 u32 bytePerPixel,      /* Color depth of destination surface */
-		 u32 dx,
-		 u32 dy,       /* Starting coordinate of destination surface */
-		 u32 width,
-		 u32 height,   /* width and height of rectangle in pixel value */
-		 u32 fColor,   /* Foreground color (corresponding to a 1 in the monochrome data */
-		 u32 bColor,   /* Background color (corresponding to a 0 in the monochrome data */
-		 u32 rop2)     /* ROP value */
+/**
+ * sm750_hw_imageblit()
+ * @pSrcbuf: Start of the source buffer in system memory
+ * @srcDelta: Pitch value of the source buffer in bytes. A positive value means
+ *            top-down, while a negative value means bottom-up
+ * @startBit: Mono data can start at any bit in a byte, this value should be in
+ *            the range 0-7
+ * @dBase: Address of the destination offset in the frame buffer
+ * @dPitch: Pitch value of the destination surface in BYTE
+ * @bytePerPixel: Color depth of the destination surface
+ * @dx: Starting x-coordinate of the destination surface
+ * @dy: Starting y-coordinate of the destination surface
+ * @width: Width of the rectangle in pixels
+ * @height: Height of the rectangle in pixels
+ * @fColor: Foreground color (cooresponding to a 1 in monochrome data)
+ * @bColor: Background color (corresponding to a 0 in monochrome data)
+ * @rop2: ROP value
+ */
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
+		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
+		       u32 bytePerPixel, u32 dx, u32 dy, u32 width, u32 height,
+		       u32 fColor, u32 bColor, u32 rop2)
 {
 	unsigned int ulBytesPerScan;
 	unsigned int ul4BytesPerScan;
@@ -310,7 +325,8 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 	unsigned char ajRemain[4];
 	int i, j;
 
-	startBit &= 7; /* Just make sure the start bit is within legal range */
+    /* Make sure that the start bit is within legal range */
+	startBit &= 7;
 	ulBytesPerScan = (width + startBit + 7) / 8;
 	ul4BytesPerScan = ulBytesPerScan & ~3;
 	ulBytesRemain = ulBytesPerScan & 3;
@@ -324,9 +340,9 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 	 */
 	write_dpr(accel, DE_WINDOW_SOURCE_BASE, 0);
 
-	/* 2D Destination Base.
-	 * It is an address offset (128 bit aligned)
-	 * from the beginning of frame buffer.
+	/*
+	 * 2D Destination Base.
+	 * 128 bit aligned offset from the beginning of frame buffer.
 	 */
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase);
 
@@ -352,8 +368,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 
 	 /*
 	  * Note: For 2D Source in Host Write, only X_K1_MONO field is needed,
-	  * and Y_K2 field is not used.
-	  * For mono bitmap, use startBit for X_K1.
+	  * and Y_K2 field is not used. For mono bitmap, use startBit for X_K1.
 	  */
 	write_dpr(accel, DE_SOURCE,
 		  (startBit << DE_SOURCE_X_K1_SHIFT) &
@@ -380,10 +395,12 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 	for (i = 0; i < height; i++) {
 		/* For each line, send the data in chunks of 4 bytes */
 		for (j = 0; j < (ul4BytesPerScan / 4); j++)
-			write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
+			write_dpPort(accel,
+				     *(unsigned int *)(pSrcbuf + (j * 4)));
 
 		if (ulBytesRemain) {
-			memcpy(ajRemain, pSrcbuf+ul4BytesPerScan, ulBytesRemain);
+			memcpy(ajRemain, pSrcbuf + ul4BytesPerScan,
+			       ulBytesRemain);
 			write_dpPort(accel, *(unsigned int *)ajRemain);
 		}
 
-- 
2.11.0

