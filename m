From: Joe Turpin <joe.turpin@gmail.com>
Date: Sun, 10 Mar 2019 05:13:27 +0000
Subject: [PATCH] Fix whitespace to conform to coding style
Message-Id: <20190310051327.13976-1-joe.turpin@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Replace spaces with tabs for indentation and add where missing.
Reflow comments to remain within 80 chars line limit.

Signed-off-by: Joe Turpin <joe.turpin@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 160 ++++++++++++++------------
 1 file changed, 88 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index eed840b251da..fbbb406636f3 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -41,7 +41,7 @@ void sm750_hw_de_init(struct lynx_accel *accel)
 	write_dpr(accel, DE_MASKS, 0xFFFFFFFF);
 
 	/* dpr1c */
-	reg =  0x3;
+	reg = 0x3;
 
 	clr = DE_STRETCH_FORMAT_PATTERN_XY |
 	      DE_STRETCH_FORMAT_PATTERN_Y_MASK |
@@ -61,7 +61,7 @@ void sm750_hw_de_init(struct lynx_accel *accel)
 	write_dpr(accel, DE_COLOR_COMPARE, 0);
 
 	clr = DE_CONTROL_TRANSPARENCY | DE_CONTROL_TRANSPARENCY_MATCH |
-		DE_CONTROL_TRANSPARENCY_SELECT;
+	      DE_CONTROL_TRANSPARENCY_SELECT;
 
 	/* dpr0c */
 	write_dpr(accel, DE_CONTROL, read_dpr(accel, DE_CONTROL) & ~clr);
@@ -72,7 +72,6 @@ void sm750_hw_de_init(struct lynx_accel *accel)
  * but if you need dual framebuffer driver,need call set2dformat
  * every time you use 2d function
  */
-
 void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 {
 	u32 reg;
@@ -85,10 +84,8 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 	write_dpr(accel, DE_STRETCH_FORMAT, reg);
 }
 
-int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
-		      u32 x, u32 y, u32 width, u32 height,
-		      u32 color, u32 rop)
+int sm750_hw_fillrect(struct lynx_accel *accel, u32 base, u32 pitch, u32 Bpp,
+		      u32 x, u32 y, u32 width, u32 height, u32 color, u32 rop)
 {
 	u32 deCtrl;
 
@@ -105,45 +102,52 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 	write_dpr(accel, DE_PITCH,
 		  ((pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+			  (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	write_dpr(accel, DE_WINDOW_WIDTH,
 		  ((pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		   (pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
+			  (pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
 
 	write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */
 
 	write_dpr(accel, DE_DESTINATION,
 		  ((x << DE_DESTINATION_X_SHIFT) & DE_DESTINATION_X_MASK) |
-		  (y & DE_DESTINATION_Y_MASK)); /* dpr4 */
+			  (y & DE_DESTINATION_Y_MASK)); /* dpr4 */
 
 	write_dpr(accel, DE_DIMENSION,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
-		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr8 */
+			  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr8 */
 
 	deCtrl = DE_CONTROL_STATUS | DE_CONTROL_LAST_PIXEL |
-		DE_CONTROL_COMMAND_RECTANGLE_FILL | DE_CONTROL_ROP_SELECT |
-		(rop & DE_CONTROL_ROP_MASK); /* dpr0xc */
+		 DE_CONTROL_COMMAND_RECTANGLE_FILL | DE_CONTROL_ROP_SELECT |
+		 (rop & DE_CONTROL_ROP_MASK); /* dpr0xc */
 
 	write_dpr(accel, DE_CONTROL, deCtrl);
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
+ * @accel:
+ * @sBase:	Address of source: offset in frame buffer
+ * @sPitch:	Pitch value of source surface in BYTE
+ * @sx:		Starting x-coordinate of source surface
+ * @sy:		Starting y-coordinate of source surface
+ * @dBase:	Address of destination: offset in frame buffer
+ * @dPitch:	Pitch value of destination surface in BYTE
+ * @Bpp:	Color depth of destination surface
+ * @dx:		Starting x-coordinate of destination surface
+ * @dy:		Starting y-coordinate of destination surface
+ * @width:	width and height of rectangle in pixel value
+ * @height:	width and height of rectangle in pixel value
+ * @rop2:	ROP value
+ */
+int sm750_hw_copyarea(struct lynx_accel *accel, unsigned int sBase,
+		      unsigned int sPitch, unsigned int sx, unsigned int sy,
+		      unsigned int dBase, unsigned int dPitch, unsigned int Bpp,
+		      unsigned int dx, unsigned int dy, unsigned int width,
+		      unsigned int height, unsigned int rop2)
 {
 	unsigned int nDirection, de_ctrl;
 
@@ -235,42 +239,43 @@ unsigned int rop2)   /* ROP value */
 	 */
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
 
-    /*
-     * Program pitch (distance between the 1st points of two adjacent lines).
-     * Note that input pitch is BYTE value, but the 2D Pitch register uses
-     * pixel values. Need Byte to pixel conversion.
-     */
+	/*
+	 * Program pitch (distance between the 1st points of 2 adjacent lines).
+	 * Note that input pitch is BYTE value, but the 2D Pitch register uses
+	 * pixel values. Need Byte to pixel conversion.
+	 */
 	write_dpr(accel, DE_PITCH,
 		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+			  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
-    /*
-     * Screen Window width in Pixels.
-     * 2D engine uses this value to calculate the linear address in frame buffer
-     * for a given point.
-     */
+	/*
+	 * Screen Window width in Pixels.
+	 * 2D engine uses this value to calculate the linear address
+	 * in frame buffer for a given point.
+	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
 		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+			  (sPitch / Bpp &
+			   DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
 		return -1;
 
 	write_dpr(accel, DE_SOURCE,
 		  ((sx << DE_SOURCE_X_K1_SHIFT) & DE_SOURCE_X_K1_MASK) |
-		  (sy & DE_SOURCE_Y_K2_MASK)); /* dpr0 */
+			  (sy & DE_SOURCE_Y_K2_MASK)); /* dpr0 */
 	write_dpr(accel, DE_DESTINATION,
 		  ((dx << DE_DESTINATION_X_SHIFT) & DE_DESTINATION_X_MASK) |
-		  (dy & DE_DESTINATION_Y_MASK)); /* dpr04 */
+			  (dy & DE_DESTINATION_Y_MASK)); /* dpr04 */
 	write_dpr(accel, DE_DIMENSION,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
-		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
+			  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
 	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) | DE_CONTROL_ROP_SELECT |
-		((nDirection = RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
-		DE_CONTROL_COMMAND_BITBLT | DE_CONTROL_STATUS;
+		  ((nDirection = RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
+		  DE_CONTROL_COMMAND_BITBLT | DE_CONTROL_STATUS;
 	write_dpr(accel, DE_CONTROL, de_ctrl); /* dpr0c */
 
 	return 0;
@@ -288,20 +293,31 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
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
+ * @accel:
+ * @pSrcbuf:		pointer to start of source buffer in system memory
+ * @srcDelta:		Pitch value (in bytes) of the source buffer,
+ *			+ive means top down and -ive mean button up
+ * @startBit:		Mono data can start at any bit in a byte,
+ *			this value should be 0 to 7
+ * @dBase:		Address of destination: offset in frame buffer
+ * @dPitch:		Pitch value of destination surface in BYTE
+ * @bytePerPixel:	Color depth of destination surface
+ * @dx:			Starting x-coordinate of destination surface
+ * @dy:			Starting y-coordinate of destination surface
+ * @width:		width of rectangle in pixel value
+ * @height:		height of rectangle in pixel value
+ * @fColor:		Foreground color
+ *			(corresponding to a 1 in the monochrome data)
+ * @bColor:		Background color
+ *			(corresponding to a 0 in the monochrome data)
+ * @rop2:		ROP value
+ */
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
+		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
+		       u32 bytePerPixel, u32 dx, u32 dy, u32 width, u32 height,
+		       u32 fColor, u32 bColor, u32 rop2)
 {
 	unsigned int ulBytesPerScan;
 	unsigned int ul4BytesPerScan;
@@ -338,7 +354,8 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 	write_dpr(accel, DE_PITCH,
 		  ((dPitch / bytePerPixel << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (dPitch / bytePerPixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+			  (dPitch / bytePerPixel &
+			   DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -348,31 +365,31 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 	write_dpr(accel, DE_WINDOW_WIDTH,
 		  ((dPitch / bytePerPixel << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (dPitch / bytePerPixel & DE_WINDOW_WIDTH_SRC_MASK));
+			  (dPitch / bytePerPixel & DE_WINDOW_WIDTH_SRC_MASK));
 
-	 /*
-	  * Note: For 2D Source in Host Write, only X_K1_MONO field is needed,
-	  * and Y_K2 field is not used.
-	  * For mono bitmap, use startBit for X_K1.
-	  */
+	/*
+	 * Note: For 2D Source in Host Write, only X_K1_MONO field is needed,
+	 * and Y_K2 field is not used.
+	 * For mono bitmap, use startBit for X_K1.
+	 */
 	write_dpr(accel, DE_SOURCE,
 		  (startBit << DE_SOURCE_X_K1_SHIFT) &
-		  DE_SOURCE_X_K1_MONO_MASK); /* dpr00 */
+			  DE_SOURCE_X_K1_MONO_MASK); /* dpr00 */
 
 	write_dpr(accel, DE_DESTINATION,
 		  ((dx << DE_DESTINATION_X_SHIFT) & DE_DESTINATION_X_MASK) |
-		  (dy & DE_DESTINATION_Y_MASK)); /* dpr04 */
+			  (dy & DE_DESTINATION_Y_MASK)); /* dpr04 */
 
 	write_dpr(accel, DE_DIMENSION,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
-		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
+			  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
 	write_dpr(accel, DE_FOREGROUND, fColor);
 	write_dpr(accel, DE_BACKGROUND, bColor);
 
-	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) |
-		DE_CONTROL_ROP_SELECT | DE_CONTROL_COMMAND_HOST_WRITE |
-		DE_CONTROL_HOST | DE_CONTROL_STATUS;
+	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) | DE_CONTROL_ROP_SELECT |
+		  DE_CONTROL_COMMAND_HOST_WRITE | DE_CONTROL_HOST |
+		  DE_CONTROL_STATUS;
 
 	write_dpr(accel, DE_CONTROL, de_ctrl | deGetTransparency(accel));
 
@@ -393,4 +410,3 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 
 	return 0;
 }
-
-- 
2.20.1
