From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] arkfb: add option mode_option
Date: Tue, 19 Feb 2008 21:21:36 +0100
Message-ID: <20080219212136.bd1817a8.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JRYst-0002ME-5q for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Feb 2008 12:16:11 -0800
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JRYsr-0005mm-MF
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Feb 2008 12:16:11 -0800
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

This patch adds the option "mode_option".

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This is one step toward changing all fb drivers to have common "mode_option" parameter.

This patch was created against 2.6.25-rc2-mm1 kernel.

diff -urp -urp linux-mm-ref/drivers/video/arkfb.c linux-mm/drivers/video/arkfb.c
--- linux-mm-ref/drivers/video/arkfb.c	2008-01-24 23:58:37.000000000 +0100
+++ linux-mm/drivers/video/arkfb.c	2008-02-19 19:03:56.565900657 +0100
@@ -101,7 +101,7 @@ static const struct svga_timing_regs ark
 
 /* Module parameters */
 
-static char *mode = "640x480-8@60";
+static char *mode_option __devinitdata = "640x480-8@60";
 
 #ifdef CONFIG_MTRR
 static int mtrr = 1;
@@ -111,8 +111,10 @@ MODULE_AUTHOR("(c) 2007 Ondrej Zajicek <
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("fbdev driver for ARK 2000PV");
 
-module_param(mode, charp, 0444);
-MODULE_PARM_DESC(mode, "Default video mode ('640x480-8@60', etc)");
+module_param(mode_option, charp, 0444);
+MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
+module_param_named(mode, mode_option, charp, 0444);
+MODULE_PARM_DESC(mode, "Default video mode ('640x480-8@60', etc) (deprecated)");
 
 #ifdef CONFIG_MTRR
 module_param(mtrr, int, 0444);
@@ -999,10 +1001,10 @@ static int __devinit ark_pci_probe(struc
 	info->pseudo_palette = (void*) (par->pseudo_palette);
 
 	/* Prepare startup mode */
-	rc = fb_find_mode(&(info->var), info, mode, NULL, 0, NULL, 8);
+	rc = fb_find_mode(&(info->var), info, mode_option, NULL, 0, NULL, 8);
 	if (! ((rc == 1) || (rc == 2))) {
 		rc = -EINVAL;
-		dev_err(&(dev->dev), "mode %s not found\n", mode);
+		dev_err(&(dev->dev), "mode %s not found\n", mode_option);
 		goto err_find_mode;
 	}
 
@@ -1190,7 +1192,7 @@ static int __init arkfb_init(void)
 		return -ENODEV;
 
 	if (option && *option)
-		mode = option;
+		mode_option = option;
 #endif
 
 	pr_debug("arkfb: initializing\n");


---------------------------------------------------------------------- 	
Sprawdz gdzie lezy snieg, czy dzialaja armatki
i jak przygotowane sa stoki >>> http://link.interia.pl/f1cfc



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
