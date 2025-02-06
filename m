Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BA1A7253
	for <linux-fbdev@vger.kernel.org>; Thu,  6 Feb 2025 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871480; cv=none; b=n1WuvwOqBuVg2RmQeWvlTrJyerS9i48oaemFXWdnOgtaZnx8SysvQ0GiUqspA/pW4H1xoPoF8MWeFZOAf8yd8UjjHHh6mxdFkT3buw0scovyQQULOaiJVir8phWjBkX9/rmIBQHW+0aQ0oZtImGX+nFt+GaT01o6/2JWdgC0VVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871480; c=relaxed/simple;
	bh=HedB7UxM5Rx5dnIxdhn0iJBQm4C/Ld9tcKCog4yIt1s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=r8wnfJ578UadGAA4QU1ttq+kFBlT7w2i0Vy1898zzWkisBOKmMxxIyaGfzL3LGfRYh1eZZBAdHyrGfMCIB4fkclIvJG/pCttTXmSPeLn/vNKSvwxfwEqRQtHOEUdkW2GHTbl36237zlG+C7oYPG2E5fRKPEagT937HIZ8hiyVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 26B69100FA; Thu,  6 Feb 2025 20:51:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by c64.rulez.org (Postfix) with ESMTP id 1C971100F6;
	Thu,  6 Feb 2025 20:51:17 +0100 (CET)
Date: Thu, 6 Feb 2025 20:51:17 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 06/13] fbdev: core: Make fb_fillrect generic
Message-ID: <47438384-18aa-b6b8-ed16-404fb943fb91@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

fbdev: core: Make fb_fillrect generic

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
  drivers/video/fbdev/core/fb_fillrect.h | 89 +++++++++++---------------
  1 file changed, 37 insertions(+), 52 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_fillrect.h b/drivers/video/fbdev/core/fb_fillrect.h
index a3bef06ce..5f1123533 100644
--- a/drivers/video/fbdev/core/fb_fillrect.h
+++ b/drivers/video/fbdev/core/fb_fillrect.h
@@ -13,26 +13,14 @@
   *  the native cpu endians. I also need to deal with MSB position in the word.
   *
   */
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/fb.h>
-#include <asm/types.h>
  #include "fb_draw.h"

-#if BITS_PER_LONG == 32
-#  define FB_WRITEL fb_writel
-#  define FB_READL  fb_readl
-#else
-#  define FB_WRITEL fb_writeq
-#  define FB_READL  fb_readq
-#endif
-
      /*
       *  Aligned pattern fill using 32/64-bit memory accesses
       */

  static void
-bitfill_aligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
+bitfill_aligned(struct fb_info *p, unsigned long FB_MEM *dst, int dst_idx,
                  unsigned long pat, unsigned n, int bits, u32 bswapmask)
  {
          unsigned long first, last;
@@ -44,21 +32,21 @@ bitfill_aligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
          last = ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask);

          if (dst_idx+n <= bits) {
-                // Single word
+                /* Single word */
                  if (last)
                          first &= last;
                  FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
          } else {
-                // Multiple destination words
+                /* Multiple destination words */

-                // Leading bits
+                /* Leading bits */
                  if (first!= ~0UL) {
                          FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
                          dst++;
                          n -= bits - dst_idx;
                  }

-                // Main chunk
+                /* Main chunk */
                  n /= bits;
                  while (n >= 8) {
                          FB_WRITEL(pat, dst++);
@@ -74,7 +62,7 @@ bitfill_aligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
                  while (n--)
                          FB_WRITEL(pat, dst++);

-                // Trailing bits
+                /* Trailing bits */
                  if (last)
                          FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
          }
@@ -89,7 +77,7 @@ bitfill_aligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
       */

  static void
-bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
+bitfill_unaligned(struct fb_info *p, unsigned long FB_MEM *dst, int dst_idx,
                    unsigned long pat, int left, int right, unsigned n, int bits)
  {
          unsigned long first, last;
@@ -101,13 +89,13 @@ bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
          last = ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));

          if (dst_idx+n <= bits) {
-                // Single word
+                /* Single word */
                  if (last)
                          first &= last;
                  FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
          } else {
-                // Multiple destination words
-                // Leading bits
+                /* Multiple destination words */
+                /* Leading bits */
                  if (first) {
                          FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
                          dst++;
@@ -115,7 +103,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
                          n -= bits - dst_idx;
                  }

-                // Main chunk
+                /* Main chunk */
                  n /= bits;
                  while (n >= 4) {
                          FB_WRITEL(pat, dst++);
@@ -133,7 +121,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
                          pat = pat << left | pat >> right;
                  }

-                // Trailing bits
+                /* Trailing bits */
                  if (last)
                          FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
          }
@@ -143,7 +131,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
       *  Aligned pattern invert using 32/64-bit memory accesses
       */
  static void
-bitfill_aligned_rev(struct fb_info *p, unsigned long __iomem *dst,
+bitfill_aligned_rev(struct fb_info *p, unsigned long FB_MEM *dst,
                      int dst_idx, unsigned long pat, unsigned n, int bits,
                      u32 bswapmask)
  {
@@ -157,14 +145,14 @@ bitfill_aligned_rev(struct fb_info *p, unsigned long __iomem *dst,
          last = ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask);

          if (dst_idx+n <= bits) {
-                // Single word
+                /* Single word */
                  if (last)
                          first &= last;
                  dat = FB_READL(dst);
                  FB_WRITEL(comp(dat ^ val, dat, first), dst);
          } else {
-                // Multiple destination words
-                // Leading bits
+                /* Multiple destination words */
+                /* Leading bits */
                  if (first!=0UL) {
                          dat = FB_READL(dst);
                          FB_WRITEL(comp(dat ^ val, dat, first), dst);
@@ -172,7 +160,7 @@ bitfill_aligned_rev(struct fb_info *p, unsigned long __iomem *dst,
                          n -= bits - dst_idx;
                  }

-                // Main chunk
+                /* Main chunk */
                  n /= bits;
                  while (n >= 8) {
                          FB_WRITEL(FB_READL(dst) ^ val, dst);
@@ -197,7 +185,7 @@ bitfill_aligned_rev(struct fb_info *p, unsigned long __iomem *dst,
                          FB_WRITEL(FB_READL(dst) ^ val, dst);
                          dst++;
                  }
-                // Trailing bits
+                /* Trailing bits */
                  if (last) {
                          dat = FB_READL(dst);
                          FB_WRITEL(comp(dat ^ val, dat, last), dst);
@@ -214,7 +202,7 @@ bitfill_aligned_rev(struct fb_info *p, unsigned long __iomem *dst,
       */

  static void
-bitfill_unaligned_rev(struct fb_info *p, unsigned long __iomem *dst,
+bitfill_unaligned_rev(struct fb_info *p, unsigned long FB_MEM *dst,
                        int dst_idx, unsigned long pat, int left, int right,
                        unsigned n, int bits)
  {
@@ -227,15 +215,15 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned long __iomem *dst,
          last = ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));

          if (dst_idx+n <= bits) {
-                // Single word
+                /* Single word */
                  if (last)
                          first &= last;
                  dat = FB_READL(dst);
                  FB_WRITEL(comp(dat ^ pat, dat, first), dst);
          } else {
-                // Multiple destination words
+                /* Multiple destination words */

-                // Leading bits
+                /* Leading bits */
                  if (first != 0UL) {
                          dat = FB_READL(dst);
                          FB_WRITEL(comp(dat ^ pat, dat, first), dst);
@@ -244,7 +232,7 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned long __iomem *dst,
                          n -= bits - dst_idx;
                  }

-                // Main chunk
+                /* Main chunk */
                  n /= bits;
                  while (n >= 4) {
                          FB_WRITEL(FB_READL(dst) ^ pat, dst);
@@ -267,7 +255,7 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned long __iomem *dst,
                          pat = pat << left | pat >> right;
                  }

-                // Trailing bits
+                /* Trailing bits */
                  if (last) {
                          dat = FB_READL(dst);
                          FB_WRITEL(comp(dat ^ pat, dat, last), dst);
@@ -275,20 +263,21 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned long __iomem *dst,
          }
  }

-void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
+void FB_FILLRECT(struct fb_info *p, const struct fb_fillrect *rect)
  {
          unsigned long pat, pat2, fg;
          unsigned long width = rect->width, height = rect->height;
          int bits = BITS_PER_LONG, bytes = bits >> 3;
          u32 bpp = p->var.bits_per_pixel;
-        unsigned long __iomem *dst;
+        unsigned long FB_MEM *dst;
          int dst_idx, left;

          if (p->state != FBINFO_STATE_RUNNING)
                  return;

-        if (p->flags & FBINFO_VIRTFB)
-                fb_warn_once(p, "Framebuffer is not in I/O address space.");
+        if ((p->flags & FBINFO_VIRTFB) != FB_SPACE)
+                fb_warn_once(p, "Framebuffer is not in " FB_SPACE_NAME
+                             " address space.");

          if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
              p->fix.visual == FB_VISUAL_DIRECTCOLOR )
@@ -298,8 +287,8 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)

          pat = pixel_to_pat(bpp, fg);

-        dst = (unsigned long __iomem *)((unsigned long)p->screen_base & ~(bytes-1));
-        dst_idx = ((unsigned long)p->screen_base & (bytes - 1))*8;
+        dst = (unsigned long FB_MEM *)((unsigned long)FB_SCREEN_BASE(p) & ~(bytes-1));
+        dst_idx = ((unsigned long)FB_SCREEN_BASE(p) & (bytes - 1))*8;
          dst_idx += rect->dy*p->fix.line_length*8+rect->dx*bpp;
          /* FIXME For now we support 1-32 bpp only */
          left = bits % bpp;
@@ -308,7 +297,7 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
          if (!left) {
                  u32 bswapmask = fb_compute_bswapmask(p);
                  void (*fill_op32)(struct fb_info *p,
-                                  unsigned long __iomem *dst, int dst_idx,
+                                  unsigned long FB_MEM *dst, int dst_idx,
                                    unsigned long pat, unsigned n, int bits,
                                    u32 bswapmask) = NULL;

@@ -320,7 +309,8 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
                          fill_op32 = bitfill_aligned;
                          break;
                  default:
-                        printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\n");
+                        printk( KERN_ERR FB_FILLRECT_NAME "(): unknown rop, "
+                                "defaulting to ROP_COPY\n");
                          fill_op32 = bitfill_aligned;
                          break;
                  }
@@ -333,7 +323,7 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
                  }
          } else {
                  int right, r;
-                void (*fill_op)(struct fb_info *p, unsigned long __iomem *dst,
+                void (*fill_op)(struct fb_info *p, unsigned long FB_MEM *dst,
                                  int dst_idx, unsigned long pat, int left,
                                  int right, unsigned n, int bits) = NULL;
  #ifdef __LITTLE_ENDIAN
@@ -350,7 +340,8 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
                          fill_op = bitfill_unaligned;
                          break;
                  default:
-                        printk(KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\n");
+                        printk(KERN_ERR FB_FILLRECT_NAME "(): unknown rop, "
+                                "defaulting to ROP_COPY\n");
                          fill_op = bitfill_unaligned;
                          break;
                  }
@@ -366,9 +357,3 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
                  }
          }
  }
-
-EXPORT_SYMBOL(cfb_fillrect);
-
-MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
-MODULE_DESCRIPTION("Generic software accelerated fill rectangle");
-MODULE_LICENSE("GPL");
-- 
2.30.2

