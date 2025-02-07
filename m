Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F11DE8B4
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Feb 2025 04:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902052; cv=none; b=EH+M0HnvXzKiHmEgeKZ4dZlLcacR4yXSDcqm7zODRKwuvfif0WPt9UyZG8zfCgOYxqi1IMem0Dzi0KJbVveBxgfJXgaCkrL4rpHjGQIj7M81VYsBEvZHThpL25RFcwDhc2Xoa8wMpvhvarqqvobEIV5gQktkIbZg9gO4vuM+/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902052; c=relaxed/simple;
	bh=z49m1a/bsCRrIOql2AgLHLzhVWek7z5D01VZXdZTfp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fr1WMXeEkhVpClzEPCb75WPDcKx3HVRcCqBgHWcOXD8JTqlAvfghw346+8Z1mwJ0iy8aUaqLKteP37z9LabL/eJITMDZr/pg96jKzDBFZbNkLYa+H7wenYjEILfJE3yFHAI7oedriSZjlKIBJsbCVW7b69+yM+jVeXEL1itYYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 40557105D0; Fri,  7 Feb 2025 05:19:52 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH RESEND 10/13] fbdev: core: Make fb_imageblit generic
Date: Fri,  7 Feb 2025 05:18:15 +0100
Message-Id: <20250207041818.4031-11-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250207041818.4031-1-soci@c64.rulez.org>
References: <20250207041818.4031-1-soci@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/fb_imageblit.h | 52 ++++++++++---------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_imageblit.h b/drivers/video/fbdev/core/fb_imageblit.h
index 129822b6f..b8cd5eb83 100644
--- a/drivers/video/fbdev/core/fb_imageblit.h
+++ b/drivers/video/fbdev/core/fb_imageblit.h
@@ -29,10 +29,6 @@
  *  Also need to add code to deal with cards endians that are different than
  *  the native cpu endians. I also need to deal with MSB position in the word.
  */
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/fb.h>
-#include <asm/types.h>
 #include "fb_draw.h"
 
 #define DEBUG
@@ -69,16 +65,13 @@ static const u32 cfb_tab32[] = {
         0x00000000, 0xffffffff
 };
 
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
-
 static inline void color_imageblit(const struct fb_image *image,
-                                   struct fb_info *p, u8 __iomem *dst1,
+                                   struct fb_info *p, u8 FB_MEM *dst1,
                                    u32 start_index,
                                    u32 pitch_index)
 {
         /* Draw the penguin */
-        u32 __iomem *dst, *dst2;
+        u32 FB_MEM *dst, *dst2;
         u32 color = 0, val, shift;
         int i, n, bpp = p->var.bits_per_pixel;
         u32 null_bits = 32 - bpp;
@@ -86,10 +79,10 @@ static inline void color_imageblit(const struct fb_image *image,
         const u8 *src = image->data;
         u32 bswapmask = fb_compute_bswapmask(p);
 
-        dst2 = (u32 __iomem *) dst1;
+        dst2 = (u32 FB_MEM *) dst1;
         for (i = image->height; i--; ) {
                 n = image->width;
-                dst = (u32 __iomem *) dst1;
+                dst = (u32 FB_MEM *) dst1;
                 shift = 0;
                 val = 0;
 
@@ -126,7 +119,7 @@ static inline void color_imageblit(const struct fb_image *image,
                 dst1 += p->fix.line_length;
                 if (pitch_index) {
                         dst2 += p->fix.line_length;
-                        dst1 = (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
+                        dst1 = (u8 FB_MEM *)((long __force)dst2 & ~(sizeof(u32) - 1));
 
                         start_index += pitch_index;
                         start_index &= 32 - 1;
@@ -135,13 +128,13 @@ static inline void color_imageblit(const struct fb_image *image,
 }
 
 static inline void slow_imageblit(const struct fb_image *image, struct fb_info *p,
-                                  u8 __iomem *dst1, u32 fgcolor,
+                                  u8 FB_MEM *dst1, u32 fgcolor,
                                   u32 bgcolor,
                                   u32 start_index,
                                   u32 pitch_index)
 {
         u32 shift, color = 0, bpp = p->var.bits_per_pixel;
-        u32 __iomem *dst, *dst2;
+        u32 FB_MEM *dst, *dst2;
         u32 val, pitch = p->fix.line_length;
         u32 null_bits = 32 - bpp;
         u32 spitch = (image->width+7)/8;
@@ -149,7 +142,7 @@ static inline void slow_imageblit(const struct fb_image *image, struct fb_info *
         u32 i, j, l;
         u32 bswapmask = fb_compute_bswapmask(p);
 
-        dst2 = (u32 __iomem *) dst1;
+        dst2 = (u32 FB_MEM *) dst1;
         fgcolor <<= FB_LEFT_POS(p, bpp);
         bgcolor <<= FB_LEFT_POS(p, bpp);
 
@@ -157,7 +150,7 @@ static inline void slow_imageblit(const struct fb_image *image, struct fb_info *
                 shift = val = 0;
                 l = 8;
                 j = image->width;
-                dst = (u32 __iomem *) dst1;
+                dst = (u32 FB_MEM *) dst1;
                 s = src;
 
                 /* write leading bits */
@@ -196,7 +189,7 @@ static inline void slow_imageblit(const struct fb_image *image, struct fb_info *
                 src += spitch;
                 if (pitch_index) {
                         dst2 += pitch;
-                        dst1 = (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
+                        dst1 = (u8 FB_MEM *)((long __force)dst2 & ~(sizeof(u32) - 1));
                         start_index += pitch_index;
                         start_index &= 32 - 1;
                 }
@@ -213,14 +206,14 @@ static inline void slow_imageblit(const struct fb_image *image, struct fb_info *
  *           beginning and end of a scanline is dword aligned
  */
 static inline void fast_imageblit(const struct fb_image *image, struct fb_info *p,
-                                  u8 __iomem *dst1, u32 fgcolor,
+                                  u8 FB_MEM *dst1, u32 fgcolor,
                                   u32 bgcolor)
 {
         u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
         u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
         u32 bit_mask, eorx, shift;
-        const char *s = image->data, *src;
-        u32 __iomem *dst;
+        const u8 *s = image->data, *src;
+        u32 FB_MEM *dst;
         const u32 *tab = NULL;
         size_t tablen;
         u32 colortab[16];
@@ -258,7 +251,7 @@ static inline void fast_imageblit(const struct fb_image *image, struct fb_info *
                 colortab[i] = (tab[i] & eorx) ^ bgx;
 
         for (i = image->height; i--; ) {
-                dst = (u32 __iomem *)dst1;
+                dst = (u32 FB_MEM *)dst1;
                 shift = 8;
                 src = s;
 
@@ -315,19 +308,20 @@ static inline void fast_imageblit(const struct fb_image *image, struct fb_info *
         }
 }
 
-void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
+void FB_IMAGEBLIT (struct fb_info *p, const struct fb_image *image)
 {
         u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
         u32 bpl = sizeof(u32), bpp = p->var.bits_per_pixel;
         u32 width = image->width;
         u32 dx = image->dx, dy = image->dy;
-        u8 __iomem *dst1;
+        u8 FB_MEM *dst1;
 
         if (p->state != FBINFO_STATE_RUNNING)
                 return;
 
-        if (p->flags & FBINFO_VIRTFB)
-                fb_warn_once(p, "Framebuffer is not in I/O address space.");
+        if ((p->flags & FBINFO_VIRTFB) != FB_SPACE)
+                fb_warn_once(p, "Framebuffer is not in " FB_SPACE_NAME
+                             " address space.");
 
         bitstart = (dy * p->fix.line_length * 8) + (dx * bpp);
         start_index = bitstart & (32 - 1);
@@ -335,7 +329,7 @@ void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 
         bitstart /= 8;
         bitstart &= ~(bpl - 1);
-        dst1 = p->screen_base + bitstart;
+        dst1 = (void __force *)FB_SCREEN_BASE(p) + bitstart;
 
         if (p->fbops->fb_sync)
                 p->fbops->fb_sync(p);
@@ -360,9 +354,3 @@ void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
         } else
                 color_imageblit(image, p, dst1, start_index, pitch_index);
 }
-
-EXPORT_SYMBOL(cfb_imageblit);
-
-MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
-MODULE_DESCRIPTION("Generic software accelerated imaging drawing");
-MODULE_LICENSE("GPL");
-- 
2.30.2

