From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: preserve memory type settings
Date: Tue, 13 May 2008 07:44:15 +0200
Message-ID: <20080513074415.204c3dcd.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvnIn-0000Zv-3W for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 May 2008 22:43:53 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JvnIi-0006t7-AL
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 May 2008 22:43:51 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Do not overwrite bits which contain memory type settings. 
It removes noise pixels ("snow") on Blade3D and 3DImage
chips.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-11 18:27:52.858665205 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-11 18:27:38.158668768 +0200
@@ -1095,7 +1095,10 @@ static int tridentfb_set_par(struct fb_i
 	vga_mm_wseq(par->io_virt, 4, 0x0E); /* memory mode enable bitmaps ?? */
 
 	/* divide clock by 2 if 32bpp chain4 mode display and CPU path */
-	write3CE(par, MiscExtFunc, (bpp == 32) ? 0x1A : 0x12);
+	tmp = read3CE(par, MiscExtFunc) & 0xF0;
+	if (bpp == 32)
+		tmp |= 8;
+	write3CE(par, MiscExtFunc, tmp | 0x12);
 	write3CE(par, 0x5, 0x40);	/* no CGA compat, allow 256 col */
 	write3CE(par, 0x6, 0x05);	/* graphics mode */
 	write3CE(par, 0x7, 0x0F);	/* planes? */

----------------------------------------------------------------------
Od Ani z Wieliczki czerwone papryczki!
http://link.interia.pl/f1de3


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
