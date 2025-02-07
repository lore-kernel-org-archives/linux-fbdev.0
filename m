Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F541DE8B4
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Feb 2025 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902023; cv=none; b=HoF82OT7fcAN/dlUA4ozUkvyYT84eNnoSTKdg9eO7mO8jiN13lt8ct+B7xLS1HlandY+ZylsJY2sIhKgALeMxoXRjUDnboYcbC3qNmJZUrxRM6wl5jrA7R8i+K/dxhR7L2ew5HryKMVs5mEXZq6mzvrO3KVYWOtp04860BZpm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902023; c=relaxed/simple;
	bh=Z7UgPWL8QeOTdlxORu78xf9o0rgvbFFrqn5kHITPdzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TikTE2ps3NzjfJNeeRvRzJe8wVqEfaYQ35HDN/sJJ45I7zHQu5LxeRjYIlpnYO/TgM5aMV6UnjZ3Zr7rWkf5NsGDXG8REJ3g6bNJivDUhgSmPSirls/Nd/DCjb+JcL4vphHtm/qgcR3dkYQHAfFRdqKrX60c42CjuOZI+o6g/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 22523105C7; Fri,  7 Feb 2025 05:19:52 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH RESEND 04/13] fbdev: core: Use generic copyarea for as sys_copyarea
Date: Fri,  7 Feb 2025 05:18:09 +0100
Message-Id: <20250207041818.4031-5-soci@c64.rulez.org>
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
 drivers/video/fbdev/core/syscopyarea.c | 357 +------------------------
 1 file changed, 8 insertions(+), 349 deletions(-)

diff --git a/drivers/video/fbdev/core/syscopyarea.c b/drivers/video/fbdev/core/syscopyarea.c
index 75e7001e8..124831eed 100644
--- a/drivers/video/fbdev/core/syscopyarea.c
+++ b/drivers/video/fbdev/core/syscopyarea.c
@@ -13,361 +13,20 @@
  *
  */
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
-#include <asm/io.h>
-#include "fb_draw.h"
 
-    /*
-     *  Generic bitwise copy algorithm
-     */
-
-static void
-bitcpy(struct fb_info *p, unsigned long *dst, unsigned dst_idx,
-	const unsigned long *src, unsigned src_idx, int bits, unsigned n)
-{
-	unsigned long first, last;
-	int const shift = dst_idx-src_idx;
-	int left, right;
-
-	first = FB_SHIFT_HIGH(p, ~0UL, dst_idx);
-	last = ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
-
-	if (!shift) {
-		/* Same alignment for source and dest */
-		if (dst_idx+n <= bits) {
-			/* Single word */
-			if (last)
-				first &= last;
-			*dst = comp(*src, *dst, first);
-		} else {
-			/* Multiple destination words */
-			/* Leading bits */
- 			if (first != ~0UL) {
-				*dst = comp(*src, *dst, first);
-				dst++;
-				src++;
-				n -= bits - dst_idx;
-			}
-
-			/* Main chunk */
-			n /= bits;
-			while (n >= 8) {
-				*dst++ = *src++;
-				*dst++ = *src++;
-				*dst++ = *src++;
-				*dst++ = *src++;
-				*dst++ = *src++;
-				*dst++ = *src++;
-				*dst++ = *src++;
-				*dst++ = *src++;
-				n -= 8;
-			}
-			while (n--)
-				*dst++ = *src++;
-
-			/* Trailing bits */
-			if (last)
-				*dst = comp(*src, *dst, last);
-		}
-	} else {
-		unsigned long d0, d1;
-		int m;
-
-		/* Different alignment for source and dest */
-		right = shift & (bits - 1);
-		left = -shift & (bits - 1);
-
-		if (dst_idx+n <= bits) {
-			/* Single destination word */
-			if (last)
-				first &= last;
-			if (shift > 0) {
-				/* Single source word */
-				*dst = comp(*src << left, *dst, first);
-			} else if (src_idx+n <= bits) {
-				/* Single source word */
-				*dst = comp(*src >> right, *dst, first);
-			} else {
-				/* 2 source words */
-				d0 = *src++;
-				d1 = *src;
-				*dst = comp(d0 >> right | d1 << left, *dst,
-					    first);
-			}
-		} else {
-			/* Multiple destination words */
-			/** We must always remember the last value read,
-			    because in case SRC and DST overlap bitwise (e.g.
-			    when moving just one pixel in 1bpp), we always
-			    collect one full long for DST and that might
-			    overlap with the current long from SRC. We store
-			    this value in 'd0'. */
-			d0 = *src++;
-			/* Leading bits */
-			if (shift > 0) {
-				/* Single source word */
-				*dst = comp(d0 << left, *dst, first);
-				dst++;
-				n -= bits - dst_idx;
-			} else {
-				/* 2 source words */
-				d1 = *src++;
-				*dst = comp(d0 >> right | d1 << left, *dst,
-					    first);
-				d0 = d1;
-				dst++;
-				n -= bits - dst_idx;
-			}
-
-			/* Main chunk */
-			m = n % bits;
-			n /= bits;
-			while (n >= 4) {
-				d1 = *src++;
-				*dst++ = d0 >> right | d1 << left;
-				d0 = d1;
-				d1 = *src++;
-				*dst++ = d0 >> right | d1 << left;
-				d0 = d1;
-				d1 = *src++;
-				*dst++ = d0 >> right | d1 << left;
-				d0 = d1;
-				d1 = *src++;
-				*dst++ = d0 >> right | d1 << left;
-				d0 = d1;
-				n -= 4;
-			}
-			while (n--) {
-				d1 = *src++;
-				*dst++ = d0 >> right | d1 << left;
-				d0 = d1;
-			}
-
-			/* Trailing bits */
-			if (m) {
-				if (m <= bits - right) {
-					/* Single source word */
-					d0 >>= right;
-				} else {
-					/* 2 source words */
- 					d1 = *src;
-					d0 = d0 >> right | d1 << left;
-				}
-				*dst = comp(d0, *dst, last);
-			}
-		}
-	}
-}
-
-    /*
-     *  Generic bitwise copy algorithm, operating backward
-     */
-
-static void
-bitcpy_rev(struct fb_info *p, unsigned long *dst, unsigned dst_idx,
-	   const unsigned long *src, unsigned src_idx, unsigned bits,
-	   unsigned n)
-{
-	unsigned long first, last;
-	int shift;
-
-	dst += (dst_idx + n - 1) / bits;
-	src += (src_idx + n - 1) / bits;
-	dst_idx = (dst_idx + n - 1) % bits;
-	src_idx = (src_idx + n - 1) % bits;
-
-	shift = dst_idx-src_idx;
-
-	first = ~FB_SHIFT_HIGH(p, ~0UL, (dst_idx + 1) % bits);
-	last = FB_SHIFT_HIGH(p, ~0UL, (bits + dst_idx + 1 - n) % bits);
-
-	if (!shift) {
-		/* Same alignment for source and dest */
-		if ((unsigned long)dst_idx+1 >= n) {
-			/* Single word */
-			if (first)
-				last &= first;
-			*dst = comp(*src, *dst, last);
-		} else {
-			/* Multiple destination words */
-
-			/* Leading bits */
-			if (first) {
-				*dst = comp(*src, *dst, first);
-				dst--;
-				src--;
-				n -= dst_idx+1;
-			}
-
-			/* Main chunk */
-			n /= bits;
-			while (n >= 8) {
-				*dst-- = *src--;
-				*dst-- = *src--;
-				*dst-- = *src--;
-				*dst-- = *src--;
-				*dst-- = *src--;
-				*dst-- = *src--;
-				*dst-- = *src--;
-				*dst-- = *src--;
-				n -= 8;
-			}
-			while (n--)
-				*dst-- = *src--;
-			/* Trailing bits */
-			if (last != -1UL)
-				*dst = comp(*src, *dst, last);
-		}
-	} else {
-		/* Different alignment for source and dest */
-
-		int const left = shift & (bits-1);
-		int const right = -shift & (bits-1);
-
-		if ((unsigned long)dst_idx+1 >= n) {
-			/* Single destination word */
-			if (first)
-				last &= first;
-			if (shift < 0) {
-				/* Single source word */
-				*dst = comp(*src >> right, *dst, last);
-			} else if (1+(unsigned long)src_idx >= n) {
-				/* Single source word */
-				*dst = comp(*src << left, *dst, last);
-			} else {
-				/* 2 source words */
-				*dst = comp(*src << left | *(src-1) >> right,
-					    *dst, last);
-			}
-		} else {
-			/* Multiple destination words */
-			/** We must always remember the last value read,
-			    because in case SRC and DST overlap bitwise (e.g.
-			    when moving just one pixel in 1bpp), we always
-			    collect one full long for DST and that might
-			    overlap with the current long from SRC. We store
-			    this value in 'd0'. */
-			unsigned long d0, d1;
-			int m;
-
-			d0 = *src--;
-			/* Leading bits */
-			if (shift < 0) {
-				/* Single source word */
-				d1 = d0;
-				d0 >>= right;
-			} else {
-				/* 2 source words */
-				d1 = *src--;
-				d0 = d0 << left | d1 >> right;
-			}
-			if (!first)
-				*dst = d0;
-			else
-				*dst = comp(d0, *dst, first);
-			d0 = d1;
-			dst--;
-			n -= dst_idx+1;
-
-			/* Main chunk */
-			m = n % bits;
-			n /= bits;
-			while (n >= 4) {
-				d1 = *src--;
-				*dst-- = d0 << left | d1 >> right;
-				d0 = d1;
-				d1 = *src--;
-				*dst-- = d0 << left | d1 >> right;
-				d0 = d1;
-				d1 = *src--;
-				*dst-- = d0 << left | d1 >> right;
-				d0 = d1;
-				d1 = *src--;
-				*dst-- = d0 << left | d1 >> right;
-				d0 = d1;
-				n -= 4;
-			}
-			while (n--) {
-				d1 = *src--;
-				*dst-- = d0 << left | d1 >> right;
-				d0 = d1;
-			}
-
-			/* Trailing bits */
-			if (m) {
-				if (m <= bits - left) {
-					/* Single source word */
-					d0 <<= left;
-				} else {
-					/* 2 source words */
-					d1 = *src;
-					d0 = d0 << left | d1 >> right;
-				}
-				*dst = comp(d0, *dst, last);
-			}
-		}
-	}
-}
-
-void sys_copyarea(struct fb_info *p, const struct fb_copyarea *area)
-{
-	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
-	u32 height = area->height, width = area->width;
-	unsigned int const bits_per_line = p->fix.line_length * 8u;
-	unsigned long *base = NULL;
-	int bits = BITS_PER_LONG, bytes = bits >> 3;
-	unsigned dst_idx = 0, src_idx = 0, rev_copy = 0;
-
-	if (p->state != FBINFO_STATE_RUNNING)
-		return;
-
-	if (!(p->flags & FBINFO_VIRTFB))
-		fb_warn_once(p, "Framebuffer is not in virtual address space.");
-
-	/* if the beginning of the target area might overlap with the end of
-	the source area, be have to copy the area reverse. */
-	if ((dy == sy && dx > sx) || (dy > sy)) {
-		dy += height;
-		sy += height;
-		rev_copy = 1;
-	}
-
-	/* split the base of the framebuffer into a long-aligned address and
-	   the index of the first bit */
-	base = (unsigned long *)((unsigned long)p->screen_base & ~(bytes-1));
-	dst_idx = src_idx = 8*((unsigned long)p->screen_base & (bytes-1));
-	/* add offset of source and target area */
-	dst_idx += dy*bits_per_line + dx*p->var.bits_per_pixel;
-	src_idx += sy*bits_per_line + sx*p->var.bits_per_pixel;
-
-	if (p->fbops->fb_sync)
-		p->fbops->fb_sync(p);
-
-	if (rev_copy) {
-		while (height--) {
-			dst_idx -= bits_per_line;
-			src_idx -= bits_per_line;
-			bitcpy_rev(p, base + (dst_idx / bits), dst_idx % bits,
-				base + (src_idx / bits), src_idx % bits, bits,
-				width*p->var.bits_per_pixel);
-		}
-	} else {
-		while (height--) {
-			bitcpy(p, base + (dst_idx / bits), dst_idx % bits,
-				base + (src_idx / bits), src_idx % bits, bits,
-				width*p->var.bits_per_pixel);
-			dst_idx += bits_per_line;
-			src_idx += bits_per_line;
-		}
-	}
-}
+#define FB_READL(a)       (*a)
+#define FB_WRITEL(a,b)    do { *(b) = (a); } while (false)
+#define FB_MEM            /* nothing */
+#define FB_COPYAREA       sys_copyarea
+#define FB_SPACE          FBINFO_VIRTFB
+#define FB_SPACE_NAME     "virtual"
+#define FB_SCREEN_BASE(a) ((a)->screen_buffer)
+#include "fb_copyarea.h"
 
 EXPORT_SYMBOL(sys_copyarea);
 
 MODULE_AUTHOR("Antonino Daplas <adaplas@pol.net>");
 MODULE_DESCRIPTION("Generic copyarea (sys-to-sys)");
 MODULE_LICENSE("GPL");
-
-- 
2.30.2

