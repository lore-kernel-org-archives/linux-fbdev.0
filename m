From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 02 Jun 2020 11:52:13 +0000
Subject: [PATCH v2 2/2] video: fbdev: amifb: add FIXMEs about {put,get}_user() failures
Message-Id: <380c0494-ed02-b2be-65b0-d385627fb894@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
In-Reply-To: <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Since we lack the hardware (or proper emulator setup) for
testing needed changes add FIXMEs to document the issues
(so at least they are not forgotten).

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- rebased on top of updated patch #1/2

 drivers/video/fbdev/amifb.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/video/fbdev/amifb.c
=================================--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -1892,6 +1892,7 @@ static int ami_get_var_cursorinfo(struct
 				 | ((datawords >> 15) & 1));
 			datawords <<= 1;
 #endif
+			/* FIXME: check the return value + test the change */
 			put_user(color, data++);
 		}
 		if (bits > 0) {
@@ -1962,6 +1963,7 @@ static int ami_set_var_cursorinfo(struct
 		bits = 16; words = delta; datawords = 0;
 		for (width = (short)var->width - 1; width >= 0; width--) {
 			unsigned long tdata = 0;
+			/* FIXME: check the return value + test the change */
 			get_user(tdata, data);
 			data++;
 #ifdef __mc68000__
