From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:40:54 +0000
Subject: [PATCH 01/21] udl-kms: fix display corruption of the last line
Message-Id: <20180603144219.405627951@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

The displaylink hardware has such a peculiarity that it doesn't render a
command until next command is received. This produces occasional
corruption, such as when setting 22x11 font on the console, only the first
line of the cursor will be blinking if the cursor is located at some
specific columns.

When we end up with a repeating pixel, the driver has a bug that it leaves
one uninitialized byte after the command (and this byte is enough to flush
the command and render it - thus it fixes the screen corruption), however
whe we end up with a non-repeating pixel, there is no byte appended and
this results in temporary screen corruption.

This patch fixes the screen corruption by always appending a byte 0xAF at
the end of URB. It also removes the uninitialized byte.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/gpu/drm/udl/udl_fb.c       |    5 ++++-
 drivers/gpu/drm/udl/udl_transfer.c |   11 +++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

Index: linux-4.16.12/drivers/gpu/drm/udl/udl_transfer.c
=================================--- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_transfer.c	2018-05-31 14:47:07.000000000 +0200
+++ linux-4.16.12/drivers/gpu/drm/udl/udl_transfer.c	2018-05-31 14:53:31.000000000 +0200
@@ -153,11 +153,11 @@ static void udl_compress_hline16(
 		raw_pixels_count_byte = cmd++; /*  we'll know this later */
 		raw_pixel_start = pixel;
 
-		cmd_pixel_end = pixel + (min(MAX_CMD_PIXELS + 1,
-			min((int)(pixel_end - pixel) / bpp,
-			    (int)(cmd_buffer_end - cmd) / 2))) * bpp;
+		cmd_pixel_end = pixel + min3(MAX_CMD_PIXELS + 1UL,
+					(unsigned long)(pixel_end - pixel) / bpp,
+					(unsigned long)(cmd_buffer_end - 1 - cmd) / 2) * bpp;
 
-		prefetch_range((void *) pixel, (cmd_pixel_end - pixel) * bpp);
+		prefetch_range((void *) pixel, cmd_pixel_end - pixel);
 		pixel_val16 = get_pixel_val16(pixel, bpp);
 
 		while (pixel < cmd_pixel_end) {
@@ -193,6 +193,9 @@ static void udl_compress_hline16(
 		if (pixel > raw_pixel_start) {
 			/* finalize last RAW span */
 			*raw_pixels_count_byte = ((pixel-raw_pixel_start) / bpp) & 0xFF;
+		} else {
+			/* undo unused byte */
+			cmd--;
 		}
 
 		*cmd_pixels_count_byte = ((pixel - cmd_pixel_start) / bpp) & 0xFF;
Index: linux-4.16.12/drivers/gpu/drm/udl/udl_fb.c
=================================--- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_fb.c	2018-05-31 14:47:07.000000000 +0200
+++ linux-4.16.12/drivers/gpu/drm/udl/udl_fb.c	2018-05-31 14:53:32.000000000 +0200
@@ -137,7 +137,10 @@ int udl_handle_damage(struct udl_framebu
 
 	if (cmd > (char *) urb->transfer_buffer) {
 		/* Send partial buffer remaining before exiting */
-		int len = cmd - (char *) urb->transfer_buffer;
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ = 0xAF;
+		len = cmd - (char *) urb->transfer_buffer;
 		ret = udl_submit_urb(dev, urb, len);
 		bytes_sent += len;
 	} else

