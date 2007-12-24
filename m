From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: pm2fb: big endian fix
Date: Mon, 24 Dec 2007 11:34:56 +0100
Message-ID: <20071224113456.faa212a1.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J6kyI-0005F4-Bk for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Dec 2007 02:55:46 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J6kyG-0007H1-PV
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Dec 2007 02:55:46 -0800
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
To: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes garbled letters on big endian
machines with acceleration enabled.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-ref/drivers/video/pm2fb.c	2007-12-23 20:39:09.000000000 +0100
+++ linux-new/drivers/video/pm2fb.c	2007-12-24 00:41:32.000000000 +0100
@@ -1210,7 +1210,11 @@ static void pm2fb_imageblit(struct fb_in
 			PM2F_INCREASE_X | PM2F_INCREASE_Y);
 		/* BitMapPackEachScanline & invert bits and byte order*/
 		/* force background */
+#ifdef __LITTLE_ENDIAN
 		pm2_WR(par, PM2R_RASTERIZER_MODE,  (1 << 9) | 1 | (3 << 7));
+#else
+		pm2_WR(par, PM2R_RASTERIZER_MODE,  (1 << 9) | 1);
+#endif
 		pm2_WR(par, PM2R_CONSTANT_COLOR, fgx);
 		pm2_WR(par, PM2R_RENDER,
 			PM2F_RENDER_RECTANGLE |
@@ -1225,7 +1229,11 @@ static void pm2fb_imageblit(struct fb_in
 			PM2F_RENDER_FASTFILL |
 			PM2F_INCREASE_X | PM2F_INCREASE_Y);
 		/* invert bits and byte order*/
+#ifdef __LITTLE_ENDIAN
 		pm2_WR(par, PM2R_RASTERIZER_MODE,  1 | (3 << 7));
+#else
+		pm2_WR(par, PM2R_RASTERIZER_MODE,  1);
+#endif
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
