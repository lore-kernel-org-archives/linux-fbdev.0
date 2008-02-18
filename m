From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] s3fb: add option mode_option
Date: Mon, 18 Feb 2008 22:44:52 +0100
Message-ID: <20080218224452.d06c2bf8.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JRE0Q-0000WH-I4 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 13:58:34 -0800
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JRE0O-00057i-4B
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 13:58:34 -0800
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
It also moves mtrr variable to devinitdata section.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This is one step toward changing all fb drivers to have common "mode_option" parameter.

This patch was created against 2.6.25-rc2-mm1 kernel.

diff -urp linux-mm-ref/drivers/video/s3fb.c linux-mm/drivers/video/s3fb.c
--- linux-mm-ref/drivers/video/s3fb.c	2008-01-24 23:58:37.000000000 +0100
+++ linux-mm/drivers/video/s3fb.c	2008-02-18 22:21:42.101155675 +0100
@@ -132,10 +132,10 @@ static const struct svga_timing_regs s3_
 /* Module parameters */
 
 
-static char *mode = "640x480-8@60";
+static char *mode_option __devinitdata = "640x480-8@60";
 
 #ifdef CONFIG_MTRR
-static int mtrr = 1;
+static int mtrr __devinitdata = 1;
 #endif
 
 static int fasttext = 1;
@@ -145,8 +145,10 @@ MODULE_AUTHOR("(c) 2006-2007 Ondrej Zaji
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("fbdev driver for S3 Trio/Virge");
 
-module_param(mode, charp, 0444);
-MODULE_PARM_DESC(mode, "Default video mode ('640x480-8@60', etc)");
+module_param(mode_option, charp, 0444);
+MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
+module_param_named(mode, mode_option, charp, 0444);
+MODULE_PARM_DESC(mode, "Default video mode ('640x480-8@60', etc) (deprecated)");
 
 #ifdef CONFIG_MTRR
 module_param(mtrr, int, 0444);
@@ -960,10 +962,10 @@ static int __devinit s3_pci_probe(struct
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
 
@@ -1168,7 +1170,7 @@ static int  __init s3fb_setup(char *opti
 		else if (!strncmp(opt, "fasttext:", 9))
 			fasttext = simple_strtoul(opt + 9, NULL, 0);
 		else
-			mode = opt;
+			mode_option = opt;
 	}
 
 	return 0;

----------------------------------------------------------------------
Masz ostatnia szanse !
Sprawdz >>> http://link.interia.pl/f1d02  


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
