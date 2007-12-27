From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: pm2fb: big endian fix
Date: Thu, 27 Dec 2007 09:50:57 +0100
Message-ID: <20071227095057.70b7a7b9.krzysztof.h1@poczta.fm>
References: <20071224113456.faa212a1.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0712241204210.24252@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J7oQH-0008W3-8s for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 00:49:01 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J7oQF-0005AU-L4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 00:49:01 -0800
In-Reply-To: <Pine.LNX.4.64.0712241204210.24252@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes garbled letters on big endian
machines with acceleration enabled.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

The sent patch is not that bad that it looks. The both ifdefs are close to each other 
in if-else clouse (one for if and one for else). I considered another version of the fix.
The sent one was clearer to me.

Anyway, this is the second version. I hope that it address your concern to set
byte ordering at one place only (hence with only one #ifdef).

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

----------------------------------------------------------------------
Bedac w toalecie korzystala z ...

>>>   http://link.interia.pl/f1cbc


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
