Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB51DE8B4
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Feb 2025 04:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902043; cv=none; b=RqmhcLMPozPER0aaJdYbFZFZBsvp5ixYJGhYYJNpcu/mQ3Bvn4cNjG66Prv6YKyJYVqophC07TF/butq0VPXhkMv90Jd0L4jTBSShmjrql69bCKomizL6CQBuy5OsPL7J0WNNd2UHdRWc/+D10SbiXrDzFA1hmD63sz0cYNoKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902043; c=relaxed/simple;
	bh=+q8k1gloU80ImDmu9rIV9mvZm7sNB2SA9DglZyTyozg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CU0mS4TXuak3schsQw5+7Z95TKIh607VZpuiewl6YXoRYBGI0fz8jvgdgqzzdRQ3z9FAHbbl64r8l1BrxRlByzOQVH6br1gIMFYz10+0U52JwO9hxZ+WTVnfEkc2forsE6mbLp8OZo77N6BXaIP6jxlj/FfwZmx5hpe3QyZkqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 38328105CD; Fri,  7 Feb 2025 05:19:52 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH RESEND 08/13] fbdev: core: Use generic fillrect for as sys_fillrect
Date: Fri,  7 Feb 2025 05:18:13 +0100
Message-Id: <20250207041818.4031-9-soci@c64.rulez.org>
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
 drivers/video/fbdev/core/sysfillrect.c | 314 +------------------------
 1 file changed, 9 insertions(+), 305 deletions(-)

diff --git a/drivers/video/fbdev/core/sysfillrect.c b/drivers/video/fbdev/core/sysfillrect.c
index e49221a88..48d0f0efb 100644
--- a/drivers/video/fbdev/core/sysfillrect.c
+++ b/drivers/video/fbdev/core/sysfillrect.c
@@ -12,314 +12,18 @@
  *  more details.
  */
 #include <linux/module.h>
-#include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
-#include "fb_draw.h"
 
-    /*
-     *  Aligned pattern fill using 32/64-bit memory accesses
-     */
-
-static void
-bitfill_aligned(struct fb_info *p, unsigned long *dst, int dst_idx,
-		unsigned long pat, unsigned n, int bits)
-{
-	unsigned long first, last;
-
-	if (!n)
-		return;
-
-	first = FB_SHIFT_HIGH(p, ~0UL, dst_idx);
-	last = ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
-
-	if (dst_idx+n <= bits) {
-		/* Single word */
-		if (last)
-			first &= last;
-		*dst = comp(pat, *dst, first);
-	} else {
-		/* Multiple destination words */
-
-		/* Leading bits */
- 		if (first!= ~0UL) {
-			*dst = comp(pat, *dst, first);
-			dst++;
-			n -= bits - dst_idx;
-		}
-
-		/* Main chunk */
-		n /= bits;
-		memset_l(dst, pat, n);
-		dst += n;
-
-		/* Trailing bits */
-		if (last)
-			*dst = comp(pat, *dst, last);
-	}
-}
-
-
-    /*
-     *  Unaligned generic pattern fill using 32/64-bit memory accesses
-     *  The pattern must have been expanded to a full 32/64-bit value
-     *  Left/right are the appropriate shifts to convert to the pattern to be
-     *  used for the next 32/64-bit word
-     */
-
-static void
-bitfill_unaligned(struct fb_info *p, unsigned long *dst, int dst_idx,
-		  unsigned long pat, int left, int right, unsigned n, int bits)
-{
-	unsigned long first, last;
-
-	if (!n)
-		return;
-
-	first = FB_SHIFT_HIGH(p, ~0UL, dst_idx);
-	last = ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
-
-	if (dst_idx+n <= bits) {
-		/* Single word */
-		if (last)
-			first &= last;
-		*dst = comp(pat, *dst, first);
-	} else {
-		/* Multiple destination words */
-		/* Leading bits */
-		if (first) {
-			*dst = comp(pat, *dst, first);
-			dst++;
-			pat = pat << left | pat >> right;
-			n -= bits - dst_idx;
-		}
-
-		/* Main chunk */
-		n /= bits;
-		while (n >= 4) {
-			*dst++ = pat;
-			pat = pat << left | pat >> right;
-			*dst++ = pat;
-			pat = pat << left | pat >> right;
-			*dst++ = pat;
-			pat = pat << left | pat >> right;
-			*dst++ = pat;
-			pat = pat << left | pat >> right;
-			n -= 4;
-		}
-		while (n--) {
-			*dst++ = pat;
-			pat = pat << left | pat >> right;
-		}
-
-		/* Trailing bits */
-		if (last)
-			*dst = comp(pat, *dst, last);
-	}
-}
-
-    /*
-     *  Aligned pattern invert using 32/64-bit memory accesses
-     */
-static void
-bitfill_aligned_rev(struct fb_info *p, unsigned long *dst, int dst_idx,
-		    unsigned long pat, unsigned n, int bits)
-{
-	unsigned long val = pat;
-	unsigned long first, last;
-
-	if (!n)
-		return;
-
-	first = FB_SHIFT_HIGH(p, ~0UL, dst_idx);
-	last = ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
-
-	if (dst_idx+n <= bits) {
-		/* Single word */
-		if (last)
-			first &= last;
-		*dst = comp(*dst ^ val, *dst, first);
-	} else {
-		/* Multiple destination words */
-		/* Leading bits */
-		if (first!=0UL) {
-			*dst = comp(*dst ^ val, *dst, first);
-			dst++;
-			n -= bits - dst_idx;
-		}
-
-		/* Main chunk */
-		n /= bits;
-		while (n >= 8) {
-			*dst++ ^= val;
-			*dst++ ^= val;
-			*dst++ ^= val;
-			*dst++ ^= val;
-			*dst++ ^= val;
-			*dst++ ^= val;
-			*dst++ ^= val;
-			*dst++ ^= val;
-			n -= 8;
-		}
-		while (n--)
-			*dst++ ^= val;
-		/* Trailing bits */
-		if (last)
-			*dst = comp(*dst ^ val, *dst, last);
-	}
-}
-
-
-    /*
-     *  Unaligned generic pattern invert using 32/64-bit memory accesses
-     *  The pattern must have been expanded to a full 32/64-bit value
-     *  Left/right are the appropriate shifts to convert to the pattern to be
-     *  used for the next 32/64-bit word
-     */
-
-static void
-bitfill_unaligned_rev(struct fb_info *p, unsigned long *dst, int dst_idx,
-		      unsigned long pat, int left, int right, unsigned n,
-		      int bits)
-{
-	unsigned long first, last;
-
-	if (!n)
-		return;
-
-	first = FB_SHIFT_HIGH(p, ~0UL, dst_idx);
-	last = ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
-
-	if (dst_idx+n <= bits) {
-		/* Single word */
-		if (last)
-			first &= last;
-		*dst = comp(*dst ^ pat, *dst, first);
-	} else {
-		/* Multiple destination words */
-
-		/* Leading bits */
-		if (first != 0UL) {
-			*dst = comp(*dst ^ pat, *dst, first);
-			dst++;
-			pat = pat << left | pat >> right;
-			n -= bits - dst_idx;
-		}
-
-		/* Main chunk */
-		n /= bits;
-		while (n >= 4) {
-			*dst++ ^= pat;
-			pat = pat << left | pat >> right;
-			*dst++ ^= pat;
-			pat = pat << left | pat >> right;
-			*dst++ ^= pat;
-			pat = pat << left | pat >> right;
-			*dst++ ^= pat;
-			pat = pat << left | pat >> right;
-			n -= 4;
-		}
-		while (n--) {
-			*dst ^= pat;
-			pat = pat << left | pat >> right;
-		}
-
-		/* Trailing bits */
-		if (last)
-			*dst = comp(*dst ^ pat, *dst, last);
-	}
-}
-
-void sys_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
-{
-	unsigned long pat, pat2, fg;
-	unsigned long width = rect->width, height = rect->height;
-	int bits = BITS_PER_LONG, bytes = bits >> 3;
-	u32 bpp = p->var.bits_per_pixel;
-	unsigned long *dst;
-	int dst_idx, left;
-
-	if (p->state != FBINFO_STATE_RUNNING)
-		return;
-
-	if (!(p->flags & FBINFO_VIRTFB))
-		fb_warn_once(p, "Framebuffer is not in virtual address space.");
-
-	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
-	    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
-		fg = ((u32 *) (p->pseudo_palette))[rect->color];
-	else
-		fg = rect->color;
-
-	pat = pixel_to_pat( bpp, fg);
-
-	dst = (unsigned long *)((unsigned long)p->screen_base & ~(bytes-1));
-	dst_idx = ((unsigned long)p->screen_base & (bytes - 1))*8;
-	dst_idx += rect->dy*p->fix.line_length*8+rect->dx*bpp;
-	/* FIXME For now we support 1-32 bpp only */
-	left = bits % bpp;
-	if (p->fbops->fb_sync)
-		p->fbops->fb_sync(p);
-	if (!left) {
-		void (*fill_op32)(struct fb_info *p, unsigned long *dst,
-				  int dst_idx, unsigned long pat, unsigned n,
-				  int bits) = NULL;
-
-		switch (rect->rop) {
-		case ROP_XOR:
-			fill_op32 = bitfill_aligned_rev;
-			break;
-		case ROP_COPY:
-			fill_op32 = bitfill_aligned;
-			break;
-		default:
-			printk( KERN_ERR "cfb_fillrect(): unknown rop, "
-				"defaulting to ROP_COPY\n");
-			fill_op32 = bitfill_aligned;
-			break;
-		}
-		while (height--) {
-			dst += dst_idx >> (ffs(bits) - 1);
-			dst_idx &= (bits - 1);
-			fill_op32(p, dst, dst_idx, pat, width*bpp, bits);
-			dst_idx += p->fix.line_length*8;
-		}
-	} else {
-		int right, r;
-		void (*fill_op)(struct fb_info *p, unsigned long *dst,
-				int dst_idx, unsigned long pat, int left,
-				int right, unsigned n, int bits) = NULL;
-#ifdef __LITTLE_ENDIAN
-		right = left;
-		left = bpp - right;
-#else
-		right = bpp - left;
-#endif
-		switch (rect->rop) {
-		case ROP_XOR:
-			fill_op = bitfill_unaligned_rev;
-			break;
-		case ROP_COPY:
-			fill_op = bitfill_unaligned;
-			break;
-		default:
-			printk(KERN_ERR "sys_fillrect(): unknown rop, "
-				"defaulting to ROP_COPY\n");
-			fill_op = bitfill_unaligned;
-			break;
-		}
-		while (height--) {
-			dst += dst_idx / bits;
-			dst_idx &= (bits - 1);
-			r = dst_idx % bpp;
-			/* rotate pattern to the correct start position */
-			pat2 = le_long_to_cpu(rolx(cpu_to_le_long(pat), r, bpp));
-			fill_op(p, dst, dst_idx, pat2, left, right,
-				width*bpp, bits);
-			dst_idx += p->fix.line_length*8;
-		}
-	}
-}
+#define FB_READL(a)       (*a)
+#define FB_WRITEL(a,b)    do { *(b) = (a); } while (false)
+#define FB_MEM            /* nothing */
+#define FB_FILLRECT       sys_fillrect
+#define FB_FILLRECT_NAME  "sys_fillrect"
+#define FB_SPACE          FBINFO_VIRTFB
+#define FB_SPACE_NAME     "virtual"
+#define FB_SCREEN_BASE(a) ((a)->screen_buffer)
+#include "fb_fillrect.h"
 
 EXPORT_SYMBOL(sys_fillrect);
 
-- 
2.30.2

