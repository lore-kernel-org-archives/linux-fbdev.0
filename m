From: Kees Cook <keescook@chromium.org>
Date: Fri, 29 Jun 2018 18:46:55 +0000
Subject: [PATCH] video: fbdev: fsl-diu-fb: Remove VLA usage
Message-Id: <20180629184655.GA37391@beast>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@tabi.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this moves
the buffer off the stack (since it could be as much as 1024 bytes), and
uses a new area in the cursor data structure. Additionally adds missed
documentation and removes redundant assignments.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/fsl-diu-fb.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 1bfd13cbd4e3..bc9eb8afc313 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -360,6 +360,10 @@ struct mfb_info {
  * @ad[]: Area Descriptors for each real AOI
  * @gamma: gamma color table
  * @cursor: hardware cursor data
+ * @blank_cursor: blank cursor for hiding cursor
+ * @next_cursor: scratch space to build load cursor
+ * @edid_data: EDID information buffer
+ * @has_edid: whether or not the EDID buffer is valid
  *
  * This data structure must be allocated with 32-byte alignment, so that the
  * internal fields can be aligned properly.
@@ -381,6 +385,8 @@ struct fsl_diu_data {
 	__le16 cursor[MAX_CURS * MAX_CURS] __aligned(32);
 	/* Blank cursor data -- used to hide the cursor */
 	__le16 blank_cursor[MAX_CURS * MAX_CURS] __aligned(32);
+	/* Scratch cursor data -- used to build new cursor */
+	__le16 next_cursor[MAX_CURS * MAX_CURS] __aligned(32);
 	uint8_t edid_data[EDID_LENGTH];
 	bool has_edid;
 } __aligned(32);
@@ -1056,13 +1062,17 @@ static int fsl_diu_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	 * FB_CUR_SETSHAPE - the cursor bitmask has changed
 	 */
 	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP | FB_CUR_SETIMAGE)) {
+		/*
+		 * Determine the size of the cursor image data.  Normally,
+		 * it's 8x16.
+		 */
 		unsigned int image_size -			DIV_ROUND_UP(cursor->image.width, 8) * cursor->image.height;
+			DIV_ROUND_UP(cursor->image.width, 8) *
+			cursor->image.height;
 		unsigned int image_words  			DIV_ROUND_UP(image_size, sizeof(uint32_t));
 		unsigned int bg_idx = cursor->image.bg_color;
 		unsigned int fg_idx = cursor->image.fg_color;
-		uint8_t buffer[image_size];
 		uint32_t *image, *source, *mask;
 		uint16_t fg, bg;
 		unsigned int i;
@@ -1070,13 +1080,6 @@ static int fsl_diu_cursor(struct fb_info *info, struct fb_cursor *cursor)
 		if (info->state != FBINFO_STATE_RUNNING)
 			return 0;
 
-		/*
-		 * Determine the size of the cursor image data.  Normally,
-		 * it's 8x16.
-		 */
-		image_size = DIV_ROUND_UP(cursor->image.width, 8) *
-			cursor->image.height;
-
 		bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 		     ((info->cmap.green[bg_idx] & 0xf8) << 2) |
 		     ((info->cmap.blue[bg_idx] & 0xf8) >> 3) |
@@ -1088,7 +1091,7 @@ static int fsl_diu_cursor(struct fb_info *info, struct fb_cursor *cursor)
 		     1 << 15;
 
 		/* Use 32-bit operations on the data to improve performance */
-		image = (uint32_t *)buffer;
+		image = (uint32_t *)data->next_cursor;
 		source = (uint32_t *)cursor->image.data;
 		mask = (uint32_t *)cursor->mask;
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
