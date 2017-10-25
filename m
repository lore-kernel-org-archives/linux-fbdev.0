From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:45:57 +0000
Subject: [RFC 09/14] bootsplash: Add corner positioning
Message-Id: <20171025124602.28292-10-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

This allows showing multiple logos, each in its own position,
relative to the eight screen corners.

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/video/fbdev/core/bootsplash_file.h   | 42 ++++++++++++++++++++-
 drivers/video/fbdev/core/bootsplash_render.c | 55 +++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/bootsplash_file.h b/drivers/video/fbdev/core/bootsplash_file.h
index f33577e062ca..59a084a05171 100644
--- a/drivers/video/fbdev/core/bootsplash_file.h
+++ b/drivers/video/fbdev/core/bootsplash_file.h
@@ -87,7 +87,28 @@ struct splash_pic_header {
 	 */
 	u8 num_blobs;
 
-	u8 padding[11];
+
+	/* Corner to paint the picture in.
+	 *  0 - Center
+	 *  1 - Top left
+	 *  2 - Top
+	 *  3 - Top right
+	 *  4 - Right
+	 *  5 - Bottom right
+	 *  6 - Bottom
+	 *  7 - Bottom left
+	 *  8 - Left
+	 */
+	u8 corner;
+
+	/* Pixel offset from the screen margins.
+	 * Example: If the picture is in the top right corner, it will
+	 *          be places corner_offset pixels from the top and
+	 *          corner_pixels from the right margin.
+	 */
+	u8 corner_offset;
+
+	u8 padding[9];
 } __attribute__((__packed__));
 
 
@@ -109,4 +130,23 @@ struct splash_blob_header {
 	u8 padding[9];
 } __attribute__((__packed__));
 
+
+
+
+/*
+ * Enums for on-disk types
+ */
+
+enum splash_corner {
+	SPLASH_CORNER_CENTER = 0,
+	SPLASH_CORNER_TOP_LEFT = 1,
+	SPLASH_CORNER_TOP = 2,
+	SPLASH_CORNER_TOP_RIGHT = 3,
+	SPLASH_CORNER_RIGHT = 4,
+	SPLASH_CORNER_BOTTOM_RIGHT = 5,
+	SPLASH_CORNER_BOTTOM = 6,
+	SPLASH_CORNER_BOTTOM_LEFT = 7,
+	SPLASH_CORNER_LEFT = 8,
+};
+
 #endif
diff --git a/drivers/video/fbdev/core/bootsplash_render.c b/drivers/video/fbdev/core/bootsplash_render.c
index 72d9867c4656..444233583f6f 100644
--- a/drivers/video/fbdev/core/bootsplash_render.c
+++ b/drivers/video/fbdev/core/bootsplash_render.c
@@ -161,6 +161,7 @@ void bootsplash_do_render_pictures(struct fb_info *info)
 	for (i = 0; i < splash_global.header->num_pics; i++) {
 		struct splash_blob_priv *bp;
 		struct splash_pic_priv *pp = &splash_global.pics[i];
+		struct splash_pic_header *ph = pp->pic_header;
 		long dst_xoff, dst_yoff;
 
 		if (pp->blobs_loaded < 1)
@@ -171,8 +172,58 @@ void bootsplash_do_render_pictures(struct fb_info *info)
 		if (!bp || bp->blob_header->type != 0)
 			continue;
 
-		dst_xoff = (info->var.xres - pp->pic_header->width) / 2;
-		dst_yoff = (info->var.yres - pp->pic_header->height) / 2;
+		switch (ph->corner) {
+		case SPLASH_CORNER_TOP_LEFT:
+			dst_xoff = 0 + ph->corner_offset;
+			dst_yoff = 0 + ph->corner_offset;
+			break;
+		case SPLASH_CORNER_TOP:
+			dst_xoff = info->var.xres - pp->pic_header->width;
+			dst_xoff /= 2;
+			dst_yoff = 0 + ph->corner_offset;
+			break;
+		case SPLASH_CORNER_TOP_RIGHT:
+			dst_xoff = info->var.xres - pp->pic_header->width
+						  - ph->corner_offset;
+			dst_yoff = 0 + ph->corner_offset;
+			break;
+		case SPLASH_CORNER_RIGHT:
+			dst_xoff = info->var.xres - pp->pic_header->width
+						  - ph->corner_offset;
+			dst_yoff = info->var.yres - pp->pic_header->height;
+			dst_yoff /= 2;
+			break;
+		case SPLASH_CORNER_BOTTOM_RIGHT:
+			dst_xoff = info->var.xres - pp->pic_header->width
+						  - ph->corner_offset;
+			dst_yoff = info->var.yres - pp->pic_header->height
+						  - ph->corner_offset;
+			break;
+		case SPLASH_CORNER_BOTTOM:
+			dst_xoff = info->var.xres - pp->pic_header->width;
+			dst_xoff /= 2;
+			dst_yoff = info->var.yres - pp->pic_header->height
+						  - ph->corner_offset;
+			break;
+		case SPLASH_CORNER_BOTTOM_LEFT:
+			dst_xoff = 0 + ph->corner_offset;
+			dst_yoff = info->var.yres - pp->pic_header->height
+						  - ph->corner_offset;
+			break;
+		case SPLASH_CORNER_LEFT:
+			dst_xoff = 0 + ph->corner_offset;
+			dst_yoff = info->var.yres - pp->pic_header->height;
+			dst_yoff /= 2;
+			break;
+
+		case SPLASH_CORNER_CENTER:
+		default:
+			dst_xoff = info->var.xres - pp->pic_header->width;
+			dst_xoff /= 2;
+			dst_yoff = info->var.yres - pp->pic_header->height;
+			dst_yoff /= 2;
+			break;
+		}
 
 		if (dst_xoff < 0
 		    || dst_yoff < 0
-- 
2.12.3

