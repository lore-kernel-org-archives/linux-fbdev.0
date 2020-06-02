From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 02 Jun 2020 11:50:50 +0000
Subject: [PATCH v2 1/2] video: fbdev: amifb: add FIXME about dead APUS support
Message-Id: <767d36ff-22ec-8136-7ebc-1d9d0d3ac98d@samsung.com>
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

Add FIXME about using the C code variants (APUS ones) in the future.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- added FIXME comment instead of removing the C code variants

 drivers/video/fbdev/amifb.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/drivers/video/fbdev/amifb.c
=================================--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -575,6 +575,12 @@ static u_short maxfmode, chipset;
 #define downx(x, v)	((v) & -(x))
 #define modx(x, v)	((v) & ((x) - 1))
 
+/*
+ * FIXME: Use C variants of the code marked with #ifdef __mc68000__
+ * in the driver. It shouldn't negatively affect the performance and
+ * is required for APUS support (once it is re-added to the kernel).
+ * Needs to be tested on the hardware though..
+ */
 /* if x1 is not a constant, this macro won't make real sense :-) */
 #ifdef __mc68000__
 #define DIVUL(x1, x2) ({int res; asm("divul %1,%2,%3": "=d" (res): \
