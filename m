From: gregkh@suse.de
Subject: [patch 19/26] fbcon: Fix big-endian bogosity in slow_imageblit()
Date: Tue, 4 Apr 2006 17:01:00 -0700
Message-ID: <20060405000100.GT27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750968AbWDEAGR@vger.kernel.org>
Content-Disposition: inline; filename="fbcon-fix-big-endian-bogosity-in.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Antonino Daplas <adaplas@pol.net>, Herbert Poetzl <herbert@13thfloor.at>, Greg Kroah-Hartman <gregkh@suse.de>

The monochrome->color expansion routine that handles bitmaps which have
(widths % 8) != 0 (slow_imageblit) produces corrupt characters in big-endian.
This is caused by a bogus bit test in slow_imageblit().

Fix.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
Acked-by: Herbert Poetzl <herbert@13thfloor.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/video/cfbimgblt.c |    2 +-
 include/linux/fb.h        |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.16.1.orig/drivers/video/cfbimgblt.c
+++ linux-2.6.16.1/drivers/video/cfbimgblt.c
@@ -169,7 +169,7 @@ static inline void slow_imageblit(const 
 
 		while (j--) {
 			l--;
-			color = (*s & 1 << (FB_BIT_NR(l))) ? fgcolor : bgcolor;
+			color = (*s & (1 << l)) ? fgcolor : bgcolor;
 			val |= FB_SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
--- linux-2.6.16.1.orig/include/linux/fb.h
+++ linux-2.6.16.1/include/linux/fb.h
@@ -839,12 +839,10 @@ struct fb_info {
 #define FB_LEFT_POS(bpp)          (32 - bpp)
 #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
-#define FB_BIT_NR(b)              (7 - (b))
 #else
 #define FB_LEFT_POS(bpp)          (0)
 #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
-#define FB_BIT_NR(b)              (b)
 #endif
 
     /*

--
