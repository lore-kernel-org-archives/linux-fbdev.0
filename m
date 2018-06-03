From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:13 +0000
Subject: [PATCH 20/21] udlfb: avoid prefetch
Message-Id: <20180603144226.196194017@twibright.com>
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
 drivers/video/fbdev/udlfb.c |    8 --------
 1 file changed, 8 deletions(-)

Index: linux-4.17-rc7/drivers/video/fbdev/udlfb.c
=================================--- linux-4.17-rc7.orig/drivers/video/fbdev/udlfb.c	2018-05-31 12:48:35.000000000 +0200
+++ linux-4.17-rc7/drivers/video/fbdev/udlfb.c	2018-05-31 12:48:35.000000000 +0200
@@ -25,7 +25,6 @@
 #include <linux/fb.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
-#include <linux/prefetch.h>
 #include <linux/delay.h>
 #include <asm/unaligned.h>
 #include <video/udlfb.h>
@@ -375,9 +374,6 @@ static int dlfb_trim_hline(const u8 *bba
 	int start = width;
 	int end = width;
 
-	prefetch((void *) front);
-	prefetch((void *) back);
-
 	for (j = 0; j < width; j++) {
 		if (back[j] != front[j]) {
 			start = j;
@@ -454,8 +450,6 @@ static void dlfb_compress_hline(
 			continue;
 		}
 
-		prefetchw((void *) cmd); /* pull in one cache line at least */
-
 		*cmd++ = 0xAF;
 		*cmd++ = 0x6B;
 		*cmd++ = dev_addr >> 16;
@@ -479,8 +473,6 @@ static void dlfb_compress_hline(
 				cmd_pixel_end--;
 		}
 
-		prefetch_range((void *) pixel, (u8 *)cmd_pixel_end - (u8 *)pixel);
-
 		while (pixel < cmd_pixel_end) {
 			const uint16_t * const repeating_pixel = pixel;
 			u16 pixel_value = *pixel;

