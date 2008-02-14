From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: change option mode to
	mode_option
Date: Thu, 14 Feb 2008 22:54:35 +0100
Message-ID: <20080214225435.5099f3de.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPmJT-0005lh-4X for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 14:12:15 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JPmJR-0003cc-KK
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 14:12:15 -0800
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: adaplas@gmail.com

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch changes the option "mode_option" into "mode".
It also adds __init attribute to tridentfb_setup function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This is one step toward changing all fb drivers to have common "mode_option" parameter.

This patch was created against 2.6.25-rc1 kernel.

diff -urp linux-ref/drivers/video/tridentfb.c linux-2.6.25/drivers/video/tridentfb.c
--- linux-ref/drivers/video/tridentfb.c	2008-01-24 23:58:37.000000000 +0100
+++ linux-2.6.25/drivers/video/tridentfb.c	2008-02-14 22:43:00.911687562 +0100
@@ -58,7 +58,7 @@ static int displaytype;
 /* defaults which are normally overriden by user values */
 
 /* video mode */
-static char *mode = "640x480";
+static char *mode_option __devinitdata = "640x480";
 static int bpp = 8;
 
 static int noaccel;
@@ -73,7 +73,8 @@ static int memsize;
 static int memdiff;
 static int nativex;
 
-module_param(mode, charp, 0);
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
 module_param(bpp, int, 0);
 module_param(center, int, 0);
 module_param(stretch, int, 0);
@@ -1286,7 +1287,8 @@ static int __devinit trident_pci_probe(s
 #endif
 	fb_info.pseudo_palette = pseudo_pal;
 
-	if (!fb_find_mode(&default_var, &fb_info, mode, NULL, 0, NULL, bpp)) {
+	if (!fb_find_mode(&default_var, &fb_info,
+			  mode_option, NULL, 0, NULL, bpp)) {
 		err = -EINVAL;
 		goto out_unmap;
 	}
@@ -1366,7 +1368,7 @@ static struct pci_driver tridentfb_pci_d
  *	video=trident:800x600,bpp=16,noaccel
  */
 #ifndef MODULE
-static int tridentfb_setup(char *options)
+static int __init tridentfb_setup(char *options)
 {
 	char *opt;
 	if (!options || !*options)
@@ -1393,7 +1395,7 @@ static int tridentfb_setup(char *options
 		else if (!strncmp(opt, "nativex=", 8))
 			nativex = simple_strtoul(opt + 8, NULL, 0);
 		else
-			mode = opt;
+			mode_option = opt;
 	}
 	return 0;
 }

----------------------------------------------------------------------
Darmowe rozmowy!
Sprawdz >>>  http://link.interia.pl/f1d0b


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
