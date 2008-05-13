From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: improve check_var function
Date: Tue, 13 May 2008 07:40:33 +0200
Message-ID: <20080513074033.62ef637b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvnlK-0003kr-90 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 May 2008 23:13:22 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JvnlI-0001CI-Q1
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 May 2008 23:13:22 -0700
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

Do some additional checks (like pixelclock versus ramdac speed)
to eliminate modes which do not work.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-11 18:25:16.026663831 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-11 18:26:19.574663241 +0200
@@ -829,6 +829,7 @@ static int tridentfb_check_var(struct fb
 {
 	struct tridentfb_par *par = info->par;
 	int bpp = var->bits_per_pixel;
+	int ramdac = 230000; /* 230MHz for most 3D chips */
 	debug("enter\n");
 
 	/* check color depth */
@@ -837,6 +838,12 @@ static int tridentfb_check_var(struct fb
 	/* check whether resolution fits on panel and in memory */
 	if (par->flatpanel && nativex && var->xres > nativex)
 		return -EINVAL;
+	/* various resolution checks */
+	var->xres = (var->xres + 7) & ~0x7;
+	if (var->xres != var->xres_virtual)
+		var->xres_virtual = var->xres;
+	if (var->yres > var->yres_virtual)
+		var->yres_virtual = var->yres;
 	if (var->xres * var->yres_virtual * bpp / 8 > info->fix.smem_len)
 		return -EINVAL;
 
@@ -868,6 +875,33 @@ static int tridentfb_check_var(struct fb
 	default:
 		return -EINVAL;
 	}
+
+	if (is_xp(par->chip_id))
+		ramdac = 350000;
+
+	switch (par->chip_id) {
+	case TGUI9440:
+		ramdac = 90000;
+		break;
+	case CYBER9320:
+	case TGUI9660:
+		ramdac = 135000;
+		break;
+	case PROVIDIA9685:
+	case CYBER9388:
+	case CYBER9382:
+	case CYBER9385:
+		ramdac = 170000;
+		break;
+	}
+
+	/* The clock is doubled for 32 bpp */
+	if (bpp == 32)
+		ramdac /= 2;
+
+	if (PICOS2KHZ(var->pixclock) > ramdac)
+		return -EINVAL;
+
 	debug("exit\n");
 
 	return 0;

----------------------------------------------------------------------
> Blachara + solarium = ...sam zobacz!
> Video>> http://link.interia.pl/f1ddd


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
