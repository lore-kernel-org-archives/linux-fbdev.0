From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] [RESEND] pm2fb: big endian fix
Date: Sat, 26 Jan 2008 11:29:11 +0100
Message-ID: <20080126112911.f6b5adc0.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JIigZ-0001LH-BX for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 02:54:55 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JIigX-0002zr-N6
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 02:54:55 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, David Miller <davem@davemloft.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes garbled letters on big endian
machines with acceleration enabled.

This patch makes pm2fb works fine with full acceleration
on sparc machine (card known as Sun PGX-32 or
TechSource Raptor GFX-8P).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This patch is reworked after Geert Uytterhoeven's suggestion.

diff -urp linux-ref/drivers/video/pm2fb.c linux-new/drivers/video/pm2fb.c
--- linux-ref/drivers/video/pm2fb.c	2007-12-24 14:28:01.000000000 +0100
+++ linux-new/drivers/video/pm2fb.c	2007-12-25 01:09:42.000000000 +0100
@@ -1159,6 +1159,11 @@ static void pm2fb_imageblit(struct fb_in
 	u32 fgx, bgx;
 	const u32 *src = (const u32 *)image->data;
 	u32 xres = (info->var.xres + 31) & ~31;
+	int raster_mode = 1; /* invert bits */
+
+#ifdef __LITTLE_ENDIAN
+	raster_mode |= 3 << 7; /* reverse byte order */
+#endif
 
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
@@ -1208,9 +1213,8 @@ static void pm2fb_imageblit(struct fb_in
 		pm2_WR(par, PM2R_RENDER,
 			PM2F_RENDER_RECTANGLE |
 			PM2F_INCREASE_X | PM2F_INCREASE_Y);
-		/* BitMapPackEachScanline & invert bits and byte order*/
-		/* force background */
-		pm2_WR(par, PM2R_RASTERIZER_MODE,  (1 << 9) | 1 | (3 << 7));
+		/* BitMapPackEachScanline */
+		pm2_WR(par, PM2R_RASTERIZER_MODE, raster_mode | (1 << 9));
 		pm2_WR(par, PM2R_CONSTANT_COLOR, fgx);
 		pm2_WR(par, PM2R_RENDER,
 			PM2F_RENDER_RECTANGLE |
@@ -1224,8 +1228,7 @@ static void pm2fb_imageblit(struct fb_in
 			PM2F_RENDER_RECTANGLE |
 			PM2F_RENDER_FASTFILL |
 			PM2F_INCREASE_X | PM2F_INCREASE_Y);
-		/* invert bits and byte order*/
-		pm2_WR(par, PM2R_RASTERIZER_MODE,  1 | (3 << 7));
+		pm2_WR(par, PM2R_RASTERIZER_MODE, raster_mode);
 		pm2_WR(par, PM2R_FB_BLOCK_COLOR, fgx);
 		pm2_WR(par, PM2R_RENDER,
 			PM2F_RENDER_RECTANGLE |


Pogoda na najblizsze dni.
Sprawdz >>> http://link.interia.pl/f1ce1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
