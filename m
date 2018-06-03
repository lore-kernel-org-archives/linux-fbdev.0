From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:01 +0000
Subject: [PATCH 08/21] udl-kms: avoid prefetch
Message-Id: <20180603144221.959741603@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Modern processors can detect linear memory accesses and prefetch data
automatically, so there's no need to use prefetch.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/gpu/drm/udl/udl_transfer.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-4.16.12/drivers/gpu/drm/udl/udl_transfer.c
=================================--- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_transfer.c	2018-05-31 14:48:12.000000000 +0200
+++ linux-4.16.12/drivers/gpu/drm/udl/udl_transfer.c	2018-05-31 14:48:12.000000000 +0200
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
-#include <linux/prefetch.h>
 #include <asm/unaligned.h>
 
 #include <drm/drmP.h>
@@ -51,9 +50,6 @@ static int udl_trim_hline(const u8 *bbac
 	int start = width;
 	int end = width;
 
-	prefetch((void *) front);
-	prefetch((void *) back);
-
 	for (j = 0; j < width; j++) {
 		if (back[j] != front[j]) {
 			start = j;
@@ -140,8 +136,6 @@ static void udl_compress_hline16(
 		const u8 *cmd_pixel_start, *cmd_pixel_end = NULL;
 		uint16_t pixel_val16;
 
-		prefetchw((void *) cmd); /* pull in one cache line at least */
-
 		*cmd++ = 0xaf;
 		*cmd++ = 0x6b;
 		*cmd++ = (uint8_t) ((dev_addr >> 16) & 0xFF);
@@ -158,7 +152,6 @@ static void udl_compress_hline16(
 					(unsigned long)(pixel_end - pixel) >> log_bpp,
 					(unsigned long)(cmd_buffer_end - 1 - cmd) / 2) << log_bpp);
 
-		prefetch_range((void *) pixel, cmd_pixel_end - pixel);
 		pixel_val16 = get_pixel_val16(pixel, log_bpp);
 
 		while (pixel < cmd_pixel_end) {

