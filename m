From: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Date: Sat, 12 Oct 2019 01:19:56 +0000
Subject: [PATCH] staging: sm750fb: align arguments with open parenthesis
Message-Id: <20191012011956.9452-1-gabrielabittencourt00@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Cc: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Cleans up checks of "Alignment should match open parenthesis" in tree sm750fb

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c |  2 +-
 drivers/staging/sm750fb/sm750_accel.c    |  2 +-
 drivers/staging/sm750fb/sm750_accel.h    |  8 ++++----
 drivers/staging/sm750fb/sm750_cursor.h   | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 887ea8aef43f..8be98a1058d6 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -148,7 +148,7 @@ void ddk750_set_logical_disp_out(enum disp_output output)
 	if (output & PNL_SEQ_USAGE) {
 		/* set  panel sequence */
 		sw_panel_power_sequence((output & PNL_SEQ_MASK) >> PNL_SEQ_OFFSET,
-		4);
+					4);
 	}
 
 	if (output & DAC_USAGE)
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index dbcbbd1055da..1a9555bb9edd 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -289,7 +289,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
 }
 
 int sm750_hw_imageblit(struct lynx_accel *accel,
-		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
+		       const char *pSrcbuf, /* pointer to start of source buffer in system memory */
 		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
 		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
 		 u32 dBase,    /* Address of destination: offset in frame buffer */
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index c4f42002a50f..8fb79b09fdd0 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,9 +190,9 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 void sm750_hw_de_init(struct lynx_accel *accel);
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-				u32 base, u32 pitch, u32 Bpp,
-				u32 x, u32 y, u32 width, u32 height,
-				u32 color, u32 rop);
+		      u32 base, u32 pitch, u32 Bpp,
+		      u32 x, u32 y, u32 width, u32 height,
+		      u32 color, u32 rop);
 
 int sm750_hw_copyarea(
 struct lynx_accel *accel,
@@ -210,7 +210,7 @@ unsigned int height, /* width and height of rectangle in pixel value */
 unsigned int rop2);
 
 int sm750_hw_imageblit(struct lynx_accel *accel,
-		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
+		       const char *pSrcbuf, /* pointer to start of source buffer in system memory */
 		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
 		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
 		 u32 dBase,    /* Address of destination: offset in frame buffer */
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index 16ac07eb58d6..039ebfdf0bd9 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -6,13 +6,13 @@
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
-						int w, int h);
+			     int w, int h);
 void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
-						int x, int y);
+			    int x, int y);
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
-						u32 fg, u32 bg);
+			      u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
-			u16 rop, const u8 *data, const u8 *mask);
+			     u16 rop, const u8 *data, const u8 *mask);
 void sm750_hw_cursor_setData2(struct lynx_cursor *cursor,
-			u16 rop, const u8 *data, const u8 *mask);
+			      u16 rop, const u8 *data, const u8 *mask);
 #endif
-- 
2.20.1
