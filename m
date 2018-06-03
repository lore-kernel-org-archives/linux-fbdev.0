From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:12 +0000
Subject: [PATCH 19/21] udlfb: optimization - test the backing buffer
Message-Id: <20180603144225.839044928@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Currently, the udlfb driver only tests for identical bytes at the
beginning or at the end of a page and renders anything between the first
and last mismatching pixel. But pages are not the same as lines, so this
is quite suboptimal - if there is something modified at the beginning of a
page and at the end of a page, the whole page is rendered, even if most of
the page is not modified.

This patch makes it test for identical pixels at the beginning and end of
each rendering command. This patch improves identical byte detection by
41% when playing video in a window.

This patch also fixes a possible screen corruption if the user is writing
to the framebuffer while dlfb_render_hline is in progress - the pixel data
that is copied to the backbuffer with memcpy may be different from the
pixel data that is actually rendered to the hardware (because the content
of the framebuffer may change between memcpy and the rendering command).
We must make sure that we copy exactly the same pixel as the pixel that is
being rendered.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/fbdev/udlfb.c |   45 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

Index: linux-4.17-rc7/drivers/video/fbdev/udlfb.c
=================================--- linux-4.17-rc7.orig/drivers/video/fbdev/udlfb.c	2018-05-31 14:51:43.000000000 +0200
+++ linux-4.17-rc7/drivers/video/fbdev/udlfb.c	2018-05-31 14:51:43.000000000 +0200
@@ -431,7 +431,9 @@ static void dlfb_compress_hline(
 	const uint16_t *const pixel_end,
 	uint32_t *device_address_ptr,
 	uint8_t **command_buffer_ptr,
-	const uint8_t *const cmd_buffer_end)
+	const uint8_t *const cmd_buffer_end,
+	unsigned long back_buffer_offset,
+	int *ident_ptr)
 {
 	const uint16_t *pixel = *pixel_start_ptr;
 	uint32_t dev_addr  = *device_address_ptr;
@@ -444,6 +446,14 @@ static void dlfb_compress_hline(
 		const uint16_t *raw_pixel_start = NULL;
 		const uint16_t *cmd_pixel_start, *cmd_pixel_end = NULL;
 
+		if (back_buffer_offset &&
+		    *pixel = *(u16 *)((u8 *)pixel + back_buffer_offset)) {
+			pixel++;
+			dev_addr += BPP;
+			(*ident_ptr)++;
+			continue;
+		}
+
 		prefetchw((void *) cmd); /* pull in one cache line at least */
 
 		*cmd++ = 0xAF;
@@ -462,25 +472,37 @@ static void dlfb_compress_hline(
 					(unsigned long)(pixel_end - pixel),
 					(unsigned long)(cmd_buffer_end - 1 - cmd) / BPP);
 
+		if (back_buffer_offset) {
+			/* note: the framebuffer may change under us, so we must test for underflow */
+			while (cmd_pixel_end - 1 > pixel &&
+			       *(cmd_pixel_end - 1) = *(u16 *)((u8 *)(cmd_pixel_end - 1) + back_buffer_offset))
+				cmd_pixel_end--;
+		}
+
 		prefetch_range((void *) pixel, (u8 *)cmd_pixel_end - (u8 *)pixel);
 
 		while (pixel < cmd_pixel_end) {
 			const uint16_t * const repeating_pixel = pixel;
+			u16 pixel_value = *pixel;
 
-			put_unaligned_be16(*pixel, cmd);
+			put_unaligned_be16(pixel_value, cmd);
+			if (back_buffer_offset)
+				*(u16 *)((u8 *)pixel + back_buffer_offset) = pixel_value;
 			cmd += 2;
 			pixel++;
 
 			if (unlikely((pixel < cmd_pixel_end) &&
-				     (*pixel = *repeating_pixel))) {
+				     (*pixel = pixel_value))) {
 				/* go back and fill in raw pixel count */
 				*raw_pixels_count_byte = ((repeating_pixel -
 						raw_pixel_start) + 1) & 0xFF;
 
-				while ((pixel < cmd_pixel_end)
-				       && (*pixel = *repeating_pixel)) {
-					pixel++;
-				}
+				do {
+					if (back_buffer_offset)
+						*(u16 *)((u8 *)pixel + back_buffer_offset) = pixel_value;
+ 					pixel++;
+				} while ((pixel < cmd_pixel_end) &&
+					 (*pixel = pixel_value));
 
 				/* immediately after raw data is repeat byte */
 				*cmd++ = ((pixel - repeating_pixel) - 1) & 0xFF;
@@ -531,6 +553,7 @@ static int dlfb_render_hline(struct dlfb
 	struct urb *urb = *urb_ptr;
 	u8 *cmd = *urb_buf_ptr;
 	u8 *cmd_end = (u8 *) urb->transfer_buffer + urb->transfer_buffer_length;
+	unsigned long back_buffer_offset = 0;
 
 	line_start = (u8 *) (front + byte_offset);
 	next_pixel = line_start;
@@ -541,6 +564,8 @@ static int dlfb_render_hline(struct dlfb
 		const u8 *back_start = (u8 *) (dlfb->backing_buffer
 						+ byte_offset);
 
+		back_buffer_offset = (unsigned long)back_start - (unsigned long)line_start;
+
 		*ident_ptr += dlfb_trim_hline(back_start, &next_pixel,
 			&byte_width);
 
@@ -549,16 +574,14 @@ static int dlfb_render_hline(struct dlfb
 		dev_addr += offset;
 		back_start += offset;
 		line_start += offset;
-
-		memcpy((char *)back_start, (char *) line_start,
-		       byte_width);
 	}
 
 	while (next_pixel < line_end) {
 
 		dlfb_compress_hline((const uint16_t **) &next_pixel,
 			     (const uint16_t *) line_end, &dev_addr,
-			(u8 **) &cmd, (u8 *) cmd_end);
+			(u8 **) &cmd, (u8 *) cmd_end, back_buffer_offset,
+			ident_ptr);
 
 		if (cmd >= cmd_end) {
 			int len = cmd - (u8 *) urb->transfer_buffer;

