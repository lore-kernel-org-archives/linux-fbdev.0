From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: y-panning fixes
Date: Thu, 29 May 2008 21:00:45 +0200
Message-ID: <20080529210045.67c680a1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1nKu-0001Bp-CF for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 May 2008 11:58:52 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1nKm-00057K-PS
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 May 2008 11:58:47 -0700
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

The Trident cards uses only 14-bit counter of screen 
start address in quad words. This allows addressing
for only 4MB of video memory so check this.

Also remove some redundant checks and assignments.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-old/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-29 00:11:27.177498740 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-29 00:08:02.957495446 +0200
@@ -870,8 +870,10 @@ static int tridentfb_check_var(struct fb
 		line_length = var->xres_virtual * bpp / 8;
 	}
 
-	if (var->yres > var->yres_virtual)
-		var->yres_virtual = var->yres;
+	/* datasheet specifies how to set panning only up to 4 MB */
+	if (line_length * (var->yres_virtual - var->yres) > (4 << 20))
+		var->yres_virtual = ((4 << 20) / line_length) + var->yres;
+
 	if (line_length * var->yres_virtual > info->fix.smem_len)
 		return -EINVAL;
 
@@ -944,8 +946,6 @@ static int tridentfb_pan_display(struct 
 	debug("enter\n");
 	offset = (var->xoffset + (var->yoffset * var->xres_virtual))
 		* var->bits_per_pixel / 32;
-	info->var.xoffset = var->xoffset;
-	info->var.yoffset = var->yoffset;
 	set_screen_start(par, offset);
 	debug("exit\n");
 	return 0;
@@ -1225,7 +1225,6 @@ static int tridentfb_setcolreg(unsigned 
 				((blue & 0xFF00) >> 8);
 	}
 
-/* 	debug("exit\n"); */
 	return 0;
 }
 


----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
