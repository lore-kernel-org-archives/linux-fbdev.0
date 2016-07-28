From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 28 Jul 2016 22:56:13 +0000
Subject: [PATCH] drm/nouveau/fbcon: fix font width not divisible by 8
Message-Id: <alpine.LRH.2.02.1607281849240.21548@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

The patch f045f459d925 ("drm/nouveau/fbcon: fix out-of-bounds memory accesses")
tries to fix some out of memory accesses. Unfortunatelly, the patch breaks the
display when using fonts with width that is not divisiable by 8.

The monochrome bitmap for each character is stored in memory by lines from top
to bottom. Each line is padded to a full byte.

For example, for 22x11 font, each line is padded to 16 bits, so each 
character is consuming 44 bytes total, that is 11 32-bit words. The patch 
f045f459d925 changed the logic to "dsize = ALIGN(image->width * 
image->height, 32) >> 5", that is just 8 words - this is incorrect and it 
causes display corruption.

This patch adds the necesary padding of lines to 8 bytes.

This patch should be backported to stable kernels where f045f459d925 was 
backported.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: f045f459d925 ("drm/nouveau/fbcon: fix out-of-bounds memory accesses")
Cc: stable@vger.kernel.org

Index: linux-2.6/drivers/gpu/drm/nouveau/nvc0_fbcon.c
=================================--- linux-2.6.orig/drivers/gpu/drm/nouveau/nvc0_fbcon.c
+++ linux-2.6/drivers/gpu/drm/nouveau/nvc0_fbcon.c
@@ -125,7 +125,7 @@ nvc0_fbcon_imageblit(struct fb_info *inf
 	OUT_RING  (chan, 0);
 	OUT_RING  (chan, image->dy);
 
-	dwords = ALIGN(image->width * image->height, 32) >> 5;
+	dwords = ALIGN(ALIGN(image->width, 8) * image->height, 32) >> 5;
 	while (dwords) {
 		int push = dwords > 2047 ? 2047 : dwords;
 
Index: linux-2.6/drivers/gpu/drm/nouveau/nv04_fbcon.c
=================================--- linux-2.6.orig/drivers/gpu/drm/nouveau/nv04_fbcon.c
+++ linux-2.6/drivers/gpu/drm/nouveau/nv04_fbcon.c
@@ -107,11 +107,11 @@ nv04_fbcon_imageblit(struct fb_info *inf
 			 ((image->dx + image->width) & 0xffff));
 	OUT_RING(chan, bg);
 	OUT_RING(chan, fg);
-	OUT_RING(chan, (image->height << 16) | image->width);
+	OUT_RING(chan, (image->height << 16) | ALIGN(image->width, 8));
 	OUT_RING(chan, (image->height << 16) | image->width);
 	OUT_RING(chan, (image->dy << 16) | (image->dx & 0xffff));
 
-	dsize = ALIGN(image->width * image->height, 32) >> 5;
+	dsize = ALIGN(ALIGN(image->width, 8) * image->height, 32) >> 5;
 	while (dsize) {
 		int iter_len = dsize > 128 ? 128 : dsize;
 
Index: linux-2.6/drivers/gpu/drm/nouveau/nv50_fbcon.c
=================================--- linux-2.6.orig/drivers/gpu/drm/nouveau/nv50_fbcon.c
+++ linux-2.6/drivers/gpu/drm/nouveau/nv50_fbcon.c
@@ -125,7 +125,7 @@ nv50_fbcon_imageblit(struct fb_info *inf
 	OUT_RING(chan, 0);
 	OUT_RING(chan, image->dy);
 
-	dwords = ALIGN(image->width * image->height, 32) >> 5;
+	dwords = ALIGN(ALIGN(image->width, 8) * image->height, 32) >> 5;
 	while (dwords) {
 		int push = dwords > 2047 ? 2047 : dwords;
 
