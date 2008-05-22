From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: fix 224 color logo at 8 bpp
Date: Thu, 22 May 2008 13:27:08 +0200
Message-ID: <20080522132708.eb94c542.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jz9MK-00042E-CE for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 04:53:24 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jz9MI-0000BN-Sl
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 04:53:24 -0700
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

This patch fixes depth setting for 8 bpp mode.
The nice 224 color logo is not displayed in 8 bpp
depth without this fix.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-22 13:18:57.252927596 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-22 13:20:03.132927921 +0200
@@ -878,11 +878,9 @@ static int tridentfb_check_var(struct fb
 	switch (bpp) {
 	case 8:
 		var->red.offset = 0;
-		var->green.offset = 0;
-		var->blue.offset = 0;
-		var->red.length = 6;
-		var->green.length = 6;
-		var->blue.length = 6;
+		var->red.length = 8;
+		var->green = var->red;
+		var->blue = var->red;
 		break;
 	case 16:
 		var->red.offset = 11;


----------------------------------------------------------------------
Wyslij video i wygraj aparat!
Kliknij >>> http://link.interia.pl/f1df4


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
