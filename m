From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] vt8623fb: change option mode to
	mode_option
Date: Thu, 14 Feb 2008 22:58:51 +0100
Message-ID: <20080214225851.1706f4b5.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPm1U-0003nd-Qw for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 13:53:40 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JPm1T-00070x-Bi
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 13:53:40 -0800
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

This patch changes the option "mode" into "mode_option".

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This is one step toward changing all fb drivers to have common "mode_option" parameter.

This patch was created against 2.6.25-rc1 kernel.

diff -urp linux-ref/drivers/video/vt8623fb.c linux-pc/drivers/video/vt8623fb.c
--- linux-ref/drivers/video/vt8623fb.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-pc/drivers/video/vt8623fb.c	2008-02-05 21:33:41.000000000 +0100
@@ -100,7 +100,7 @@ static struct svga_timing_regs vt8623_ti
 
 /* Module parameters */
 
-static char *mode = "640x480-8@60";
+static char *mode_option = "640x480-8@60";
 
 #ifdef CONFIG_MTRR
 static int mtrr = 1;
@@ -110,8 +110,8 @@ MODULE_AUTHOR("(c) 2006 Ondrej Zajicek <
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("fbdev driver for integrated graphics core in VIA VT8623 [CLE266]");
 
-module_param(mode, charp, 0644);
-MODULE_PARM_DESC(mode, "Default video mode ('640x480-8@60', etc)");
+module_param(mode_option, charp, 0644);
+MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
 
 #ifdef CONFIG_MTRR
 module_param(mtrr, int, 0444);
@@ -722,10 +722,10 @@ static int __devinit vt8623_pci_probe(st
 
 	/* Prepare startup mode */
 
-	rc = fb_find_mode(&(info->var), info, mode, NULL, 0, NULL, 8);
+	rc = fb_find_mode(&(info->var), info, mode_option, NULL, 0, NULL, 8);
 	if (! ((rc == 1) || (rc == 2))) {
 		rc = -EINVAL;
-		dev_err(&(dev->dev), "mode %s not found\n", mode);
+		dev_err(&(dev->dev), "mode %s not found\n", mode_option);
 		goto err_find_mode;
 	}
 
@@ -913,7 +913,7 @@ static int __init vt8623fb_init(void)
 		return -ENODEV;
 
 	if (option && *option)
-		mode = option;
+		mode_option = option;
 #endif
 
 	pr_debug("vt8623fb: initializing\n");


---------------------------------------------------------------------- 	
Sprawdz gdzie lezy snieg, czy dzialaja armatki
i jak przygotowane sa stoki >>> http://link.interia.pl/f1cfc



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
