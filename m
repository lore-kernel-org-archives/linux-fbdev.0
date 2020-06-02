From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 02 Jun 2020 10:37:27 +0000
Subject: [PATCH 1/2] video: fbdev: amifb: remove dead APUS support
Message-Id: <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
In-Reply-To: <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>


On 5/14/20 10:21 PM, Geert Uytterhoeven wrote:

> These #ifdefs are relics from APUS (Amiga Power-Up System), which
> added a PPC board.  APUS support was killed off a long time ago,
> when arch/ppc/ was still king, but these #ifdefs were missed, because
> they didn't test for CONFIG_APUS.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/amifb.c |   63 --------------------------------------------
 1 file changed, 63 deletions(-)

Index: b/drivers/video/fbdev/amifb.c
=================================--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -576,14 +576,8 @@ static u_short maxfmode, chipset;
 #define modx(x, v)	((v) & ((x) - 1))
 
 /* if x1 is not a constant, this macro won't make real sense :-) */
-#ifdef __mc68000__
 #define DIVUL(x1, x2) ({int res; asm("divul %1,%2,%3": "=d" (res): \
 	"d" (x2), "d" ((long)((x1) / 0x100000000ULL)), "0" ((long)(x1))); res;})
-#else
-/* We know a bit about the numbers, so we can do it this way */
-#define DIVUL(x1, x2) ((((long)((unsigned long long)x1 >> 8) / x2) << 8) + \
-	((((long)((unsigned long long)x1 >> 8) % x2) << 8) / x2))
-#endif
 
 #define highw(x)	((u_long)(x)>>16 & 0xffff)
 #define loww(x)		((u_long)(x) & 0xffff)
@@ -1837,11 +1831,7 @@ static int ami_get_var_cursorinfo(struct
 				  const struct amifb_par *par)
 {
 	register u_short *lspr, *sspr;
-#ifdef __mc68000__
 	register u_long datawords asm ("d2");
-#else
-	register u_long datawords;
-#endif
 	register short delta;
 	register u_char color;
 	short height, width, bits, words;
@@ -1868,24 +1858,14 @@ static int ami_get_var_cursorinfo(struct
 		for (width = (short)var->width - 1; width >= 0; width--) {
 			if (bits = 0) {
 				bits = 16; --words;
-#ifdef __mc68000__
 				asm volatile ("movew %1@(%3:w:2),%0 ; swap %0 ; movew %1@+,%0"
 					: "=d" (datawords), "=a" (lspr) : "1" (lspr), "d" (delta));
-#else
-				datawords = (*(lspr + delta) << 16) | (*lspr++);
-#endif
 			}
 			--bits;
-#ifdef __mc68000__
 			asm volatile (
 				"clrb %0 ; swap %1 ; lslw #1,%1 ; roxlb #1,%0 ; "
 				"swap %1 ; lslw #1,%1 ; roxlb #1,%0"
 				: "=d" (color), "=d" (datawords) : "1" (datawords));
-#else
-			color = (((datawords >> 30) & 2)
-				 | ((datawords >> 15) & 1));
-			datawords <<= 1;
-#endif
 			put_user(color, data++);
 		}
 		if (bits > 0) {
@@ -1893,17 +1873,8 @@ static int ami_get_var_cursorinfo(struct
 		}
 		while (--words >= 0)
 			++lspr;
-#ifdef __mc68000__
 		asm volatile ("lea %0@(%4:w:2),%0 ; tstl %1 ; jeq 1f ; exg %0,%1\n1:"
 			: "=a" (lspr), "=a" (sspr) : "0" (lspr), "1" (sspr), "d" (delta));
-#else
-		lspr += delta;
-		if (sspr) {
-			u_short *tmp = lspr;
-			lspr = sspr;
-			sspr = tmp;
-		}
-#endif
 	}
 	return 0;
 }
@@ -1912,11 +1883,7 @@ static int ami_set_var_cursorinfo(struct
 				  u_char __user *data, struct amifb_par *par)
 {
 	register u_short *lspr, *sspr;
-#ifdef __mc68000__
 	register u_long datawords asm ("d2");
-#else
-	register u_long datawords;
-#endif
 	register short delta;
 	u_short fmode;
 	short height, width, bits, words;
@@ -1958,60 +1925,30 @@ static int ami_set_var_cursorinfo(struct
 			unsigned long tdata = 0;
 			get_user(tdata, data);
 			data++;
-#ifdef __mc68000__
 			asm volatile (
 				"lsrb #1,%2 ; roxlw #1,%0 ; swap %0 ; "
 				"lsrb #1,%2 ; roxlw #1,%0 ; swap %0"
 				: "=d" (datawords)
 				: "0" (datawords), "d" (tdata));
-#else
-			datawords = ((datawords << 1) & 0xfffefffe);
-			datawords |= tdata & 1;
-			datawords |= (tdata & 2) << (16 - 1);
-#endif
 			if (--bits = 0) {
 				bits = 16; --words;
-#ifdef __mc68000__
 				asm volatile ("swap %2 ; movew %2,%0@(%3:w:2) ; swap %2 ; movew %2,%0@+"
 					: "=a" (lspr) : "0" (lspr), "d" (datawords), "d" (delta));
-#else
-				*(lspr + delta) = (u_short) (datawords >> 16);
-				*lspr++ = (u_short) (datawords & 0xffff);
-#endif
 			}
 		}
 		if (bits < 16) {
 			--words;
-#ifdef __mc68000__
 			asm volatile (
 				"swap %2 ; lslw %4,%2 ; movew %2,%0@(%3:w:2) ; "
 				"swap %2 ; lslw %4,%2 ; movew %2,%0@+"
 				: "=a" (lspr) : "0" (lspr), "d" (datawords), "d" (delta), "d" (bits));
-#else
-			*(lspr + delta) = (u_short) (datawords >> (16 + bits));
-			*lspr++ = (u_short) ((datawords & 0x0000ffff) >> bits);
-#endif
 		}
 		while (--words >= 0) {
-#ifdef __mc68000__
 			asm volatile ("moveql #0,%%d0 ; movew %%d0,%0@(%2:w:2) ; movew %%d0,%0@+"
 				: "=a" (lspr) : "0" (lspr), "d" (delta) : "d0");
-#else
-			*(lspr + delta) = 0;
-			*lspr++ = 0;
-#endif
 		}
-#ifdef __mc68000__
 		asm volatile ("lea %0@(%4:w:2),%0 ; tstl %1 ; jeq 1f ; exg %0,%1\n1:"
 			: "=a" (lspr), "=a" (sspr) : "0" (lspr), "1" (sspr), "d" (delta));
-#else
-		lspr += delta;
-		if (sspr) {
-			u_short *tmp = lspr;
-			lspr = sspr;
-			sspr = tmp;
-		}
-#endif
 	}
 	par->crsr.height = var->height;
 	par->crsr.width = var->width;
