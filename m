From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tdfxfb: remove ypan checks done by a
	higher layer
Date: Wed, 28 May 2008 22:56:32 +0200
Message-ID: <20080528225632.5286e274.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1SfJ-0004Iy-KJ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 13:54:34 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1SfI-0003Mu-QD
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 13:54:33 -0700
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

These checks and assignments are done by
a higher layer so remove them from the driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-rc2/drivers/video/tdfxfb.c linux-new/drivers/video/tdfxfb.c
--- linux-rc2/drivers/video/tdfxfb.c	2008-05-12 18:16:24.541623784 +0200
+++ linux-new/drivers/video/tdfxfb.c	2008-05-27 18:14:09.731595627 +0200
@@ -836,16 +836,12 @@ static int tdfxfb_pan_display(struct fb_
 	struct tdfx_par *par = info->par;
 	u32 addr = var->yoffset * info->fix.line_length;
 
-	if (nopan || var->xoffset || (var->yoffset > var->yres_virtual))
-		return -EINVAL;
-	if ((var->yoffset + var->yres > var->yres_virtual && nowrap))
+	if (nopan || var->xoffset)
 		return -EINVAL;
 
 	banshee_make_room(par, 1);
 	tdfx_outl(par, VIDDESKSTART, addr);
 
-	info->var.xoffset = var->xoffset;
-	info->var.yoffset = var->yoffset;
 	return 0;
 }

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e13  


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
