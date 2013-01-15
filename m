From: Timur Tabi <timur@tabi.org>
Date: Tue, 15 Jan 2013 20:17:26 +0000
Subject: [PATCH] drivers/video: fsl-diu-fb: add hardware cursor support
Message-Id: <1358281046-31552-1-git-send-email-timur@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Timur Tabi <timur@freescale.com>

The Freescale DIU supports a 32x32 color hardware cursor.  Framebuffer
cursors are monochrome, so the driver converts the image data to the
format that the DIU expects and then programs to hardware accordingly.

The support cursor enabling/disabling, we provide two cursor image buffers.
One is always blank (all zeroes), and the other contains the real cursor
image data.  To disable the cursor (used typically for cursor blinking),
we just tell the hardware to use the blank cursor data.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |  157 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 19cfd7a..acdde17 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -375,7 +375,10 @@ struct fsl_diu_data {
 	struct diu_ad dummy_ad __aligned(8);
 	struct diu_ad ad[NUM_AOIS] __aligned(8);
 	u8 gamma[256 * 3] __aligned(32);
-	u8 cursor[MAX_CURS * MAX_CURS * 2] __aligned(32);
+	/* It's easier to parse the cursor data as little-endian */
+	__le16 cursor[MAX_CURS * MAX_CURS] __aligned(32);
+	/* Blank cursor data -- used to hide the cursor */
+	__le16 blank_cursor[MAX_CURS * MAX_CURS] __aligned(32);
 	uint8_t edid_data[EDID_LENGTH];
 	bool has_edid;
 } __aligned(32);
@@ -824,7 +827,6 @@ static void update_lcdc(struct fb_info *info)
 	/* Program DIU registers */
 
 	out_be32(&hw->gamma, DMA_ADDR(data, gamma));
-	out_be32(&hw->cursor, DMA_ADDR(data, cursor));
 
 	out_be32(&hw->bgnd, 0x007F7F7F); /* Set background to grey */
 	out_be32(&hw->disp_size, (var->yres << 16) | var->xres);
@@ -968,6 +970,156 @@ static u32 fsl_diu_get_pixel_format(unsigned int bits_per_pixel)
 }
 
 /*
+ * Copies a cursor image from user space to the proper place in driver
+ * memory so that the hardware can display the cursor image.
+ *
+ * Cursor data is represented as a sequence of 'width' bits packed into bytes.
+ * That is, the first 8 bits are in the first byte, the second 8 bits in the
+ * second byte, and so on.  Therefore, the each row of the cursor is (width +
+ * 7) / 8 bytes of 'data'
+ *
+ * The DIU only supports cursors up to 32x32 (MAX_CURS).  We reject cursors
+ * larger than this, so we already know that 'width' <= 32.  Therefore, we can
+ * simplify our code by using a 32-bit big-endian integer ("line") to read in
+ * a single line of pixels, and only look at the top 'width' bits of that
+ * integer.
+ *
+ * This could result in an unaligned 32-bit read.  For example, if the cursor
+ * is 24x24, then the first three bytes of 'image' contain the pixel data for
+ * the top line of the cursor.  We do a 32-bit read of 'image', but we look
+ * only at the top 24 bits.  Then we increment 'image' by 3 bytes.  The next
+ * read is unaligned.  The only problem is that we might read past the end of
+ * 'image' by 1-3 bytes, but that should not cause any problems.
+ */
+static void fsl_diu_load_cursor_image(struct fb_info *info,
+	const void *image, uint16_t bg, uint16_t fg,
+	unsigned int width, unsigned int height)
+{
+	struct mfb_info *mfbi = info->par;
+	struct fsl_diu_data *data = mfbi->parent;
+	__le16 *cursor = data->cursor;
+	__le16 _fg = cpu_to_le16(fg);
+	__le16 _bg = cpu_to_le16(bg);
+	unsigned int h, w;
+
+	for (h = 0; h < height; h++) {
+		uint32_t mask = 1 << 31;
+		uint32_t line = be32_to_cpup(image);
+
+		for (w = 0; w < width; w++) {
+			cursor[w] = (line & mask) ? _fg : _bg;
+			mask >>= 1;
+		}
+
+		cursor += MAX_CURS;
+		image += DIV_ROUND_UP(width, 8);
+	}
+}
+
+/*
+ * Set a hardware cursor.  The image data for the cursor is passed via the
+ * fb_cursor object.
+ */
+static int fsl_diu_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	struct mfb_info *mfbi = info->par;
+	struct fsl_diu_data *data = mfbi->parent;
+	struct diu __iomem *hw = data->diu_reg;
+
+	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
+		return -EINVAL;
+
+	/* The cursor size has changed */
+	if (cursor->set & FB_CUR_SETSIZE) {
+		/*
+		 * The DIU cursor is a fixed size, so when we get this
+		 * message, instead of resizing the cursor, we just clear
+		 * all the image data, in expectation of new data.  However,
+		 * in tests this control does not appear to be normally
+		 * called.
+		 */
+		memset(data->cursor, 0, sizeof(data->cursor));
+	}
+
+	/* The cursor position has changed (cursor->image.dx|dy) */
+	if (cursor->set & FB_CUR_SETPOS) {
+		uint32_t xx, yy;
+
+		yy = (cursor->image.dy - info->var.yoffset) & 0x7ff;
+		xx = (cursor->image.dx - info->var.xoffset) & 0x7ff;
+
+		out_be32(&hw->curs_pos, yy << 16 | xx);
+	}
+
+	/*
+	 * FB_CUR_SETIMAGE - the cursor image has changed
+	 * FB_CUR_SETCMAP  - the cursor colors has changed
+	 * FB_CUR_SETSHAPE - the cursor bitmask has changed
+	 */
+	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP | FB_CUR_SETIMAGE)) {
+		unsigned int image_size +			DIV_ROUND_UP(cursor->image.width, 8) * cursor->image.height;
+		unsigned int image_words +			DIV_ROUND_UP(image_size, sizeof(uint32_t));
+		unsigned int bg_idx = cursor->image.bg_color;
+		unsigned int fg_idx = cursor->image.fg_color;
+		uint8_t buffer[image_size];
+		uint32_t *image, *source, *mask;
+		uint16_t fg, bg;
+		unsigned int i;
+
+		if (info->state != FBINFO_STATE_RUNNING)
+			return 0;
+
+		/*
+		 * Determine the size of the cursor image data.  Normally,
+		 * it's 8x16.
+		 */
+		image_size = DIV_ROUND_UP(cursor->image.width, 8) *
+			cursor->image.height;
+
+		bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
+		     ((info->cmap.green[bg_idx] & 0xf8) << 2) |
+		     ((info->cmap.blue[bg_idx] & 0xf8) >> 3) |
+		     1 << 15;
+
+		fg = ((info->cmap.red[fg_idx] & 0xf8) << 7) |
+		     ((info->cmap.green[fg_idx] & 0xf8) << 2) |
+		     ((info->cmap.blue[fg_idx] & 0xf8) >> 3) |
+		     1 << 15;
+
+		/* Use 32-bit operations on the data to improve performance */
+		image = (uint32_t *)buffer;
+		source = (uint32_t *)cursor->image.data;
+		mask = (uint32_t *)cursor->mask;
+
+		if (cursor->rop = ROP_XOR)
+			for (i = 0; i < image_words; i++)
+				image[i] = source[i] ^ mask[i];
+		else
+			for (i = 0; i < image_words; i++)
+				image[i] = source[i] & mask[i];
+
+		fsl_diu_load_cursor_image(info, image, bg, fg,
+			cursor->image.width, cursor->image.height);
+	};
+
+	/*
+	 * Show or hide the cursor.  The cursor data is always stored in the
+	 * 'cursor' memory block, and the actual cursor position is always in
+	 * the DIU's CURS_POS register.  To hide the cursor, we redirect the
+	 * CURSOR register to a blank cursor.  The show the cursor, we
+	 * redirect the CURSOR register to the real cursor data.
+	 */
+	if (cursor->enable)
+		out_be32(&hw->cursor, DMA_ADDR(data, cursor));
+	else
+		out_be32(&hw->cursor, DMA_ADDR(data, blank_cursor));
+
+	return 0;
+}
+
+/*
  * Using the fb_var_screeninfo in fb_info we set the resolution of this
  * particular framebuffer. This function alters the fb_fix_screeninfo stored
  * in fb_info. It does not alter var in fb_info since we are using that
@@ -1305,6 +1457,7 @@ static struct fb_ops fsl_diu_ops = {
 	.fb_ioctl = fsl_diu_ioctl,
 	.fb_open = fsl_diu_open,
 	.fb_release = fsl_diu_release,
+	.fb_cursor = fsl_diu_cursor,
 };
 
 static int install_fb(struct fb_info *info)
-- 
1.7.3.4

