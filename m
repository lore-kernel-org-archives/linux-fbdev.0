From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:05 +0000
Subject: [PATCH 12/21] udlfb: fix display corruption of the last line
Message-Id: <20180603144223.332517485@twibright.com>
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
 drivers/video/fbdev/udlfb.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

Index: linux-4.17-rc7/drivers/video/fbdev/udlfb.c
=================================--- linux-4.17-rc7.orig/drivers/video/fbdev/udlfb.c	2018-05-31 14:43:13.000000000 +0200
+++ linux-4.17-rc7/drivers/video/fbdev/udlfb.c	2018-05-31 14:46:03.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include <linux/delay.h>
+#include <asm/unaligned.h>
 #include <video/udlfb.h>
 #include "edid.h"
 
@@ -450,17 +451,17 @@ static void dlfb_compress_hline(
 		raw_pixels_count_byte = cmd++; /*  we'll know this later */
 		raw_pixel_start = pixel;
 
-		cmd_pixel_end = pixel + min(MAX_CMD_PIXELS + 1,
-			min((int)(pixel_end - pixel),
-			    (int)(cmd_buffer_end - cmd) / BPP));
+		cmd_pixel_end = pixel + min3(MAX_CMD_PIXELS + 1UL,
+					(unsigned long)(pixel_end - pixel),
+					(unsigned long)(cmd_buffer_end - 1 - cmd) / BPP);
 
-		prefetch_range((void *) pixel, (cmd_pixel_end - pixel) * BPP);
+		prefetch_range((void *) pixel, (u8 *)cmd_pixel_end - (u8 *)pixel);
 
 		while (pixel < cmd_pixel_end) {
 			const uint16_t * const repeating_pixel = pixel;
 
-			*cmd++ = *pixel >> 8;
-			*cmd++ = *pixel;
+			put_unaligned_be16(*pixel, cmd);
+			cmd += 2;
 			pixel++;
 
 			if (unlikely((pixel < cmd_pixel_end) &&
@@ -486,13 +487,16 @@ static void dlfb_compress_hline(
 		if (pixel > raw_pixel_start) {
 			/* finalize last RAW span */
 			*raw_pixels_count_byte = (pixel-raw_pixel_start) & 0xFF;
+		} else {
+			/* undo unused byte */
+			cmd--;
 		}
 
 		*cmd_pixels_count_byte = (pixel - cmd_pixel_start) & 0xFF;
-		dev_addr += (pixel - cmd_pixel_start) * BPP;
+		dev_addr += (u8 *)pixel - (u8 *)cmd_pixel_start;
 	}
 
-	if (cmd_buffer_end <= MIN_RLX_CMD_BYTES + cmd) {
+	if (cmd_buffer_end - MIN_RLX_CMD_BYTES <= cmd) {
 		/* Fill leftover bytes with no-ops */
 		if (cmd_buffer_end > cmd)
 			memset(cmd, 0xAF, cmd_buffer_end - cmd);
@@ -610,8 +614,11 @@ static int dlfb_handle_damage(struct dlf
 	}
 
 	if (cmd > (char *) urb->transfer_buffer) {
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ = 0xAF;
 		/* Send partial buffer remaining before exiting */
-		int len = cmd - (char *) urb->transfer_buffer;
+		len = cmd - (char *) urb->transfer_buffer;
 		ret = dlfb_submit_urb(dlfb, urb, len);
 		bytes_sent += len;
 	} else
@@ -735,8 +742,11 @@ static void dlfb_dpy_deferred_io(struct
 	}
 
 	if (cmd > (char *) urb->transfer_buffer) {
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ = 0xAF;
 		/* Send partial buffer remaining before exiting */
-		int len = cmd - (char *) urb->transfer_buffer;
+		len = cmd - (char *) urb->transfer_buffer;
 		dlfb_submit_urb(dlfb, urb, len);
 		bytes_sent += len;
 	} else

