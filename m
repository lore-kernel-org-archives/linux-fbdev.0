From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] pm2fb: change option mode to mode_option
Date: Thu, 14 Feb 2008 22:52:13 +0100
Message-ID: <20080214225213.19ab943b.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPmIq-0005fD-8Z for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 14:11:36 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JPmIo-0003SI-II
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 14:11:36 -0800
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

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This is one step toward changing all fb drivers to have common "mode_option" parameter.

This patch was created against 2.6.25-rc1 kernel.

diff -urp linux-ref/drivers/video/pm2fb.c linux-2.6.25/drivers/video/pm2fb.c
--- linux-ref/drivers/video/pm2fb.c	2008-02-13 22:42:55.493782146 +0100
+++ linux-2.6.25/drivers/video/pm2fb.c	2008-02-14 21:43:53.238762148 +0100
@@ -67,7 +67,7 @@
  * Driver data
  */
 static int hwcursor = 1;
-static char *mode __devinitdata;
+static char *mode_option __devinitdata;
 
 /*
  * The XFree GLINT driver will (I think to implement hardware cursor
@@ -1680,10 +1680,10 @@ static int __devinit pm2fb_probe(struct 
 		info->pixmap.scan_align = 1;
 	}
 
-	if (!mode)
-		mode = "640x480@60";
+	if (!mode_option)
+		mode_option = "640x480@60";
 
-	err = fb_find_mode(&info->var, info, mode, NULL, 0, NULL, 8);
+	err = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL, 8);
 	if (!err || err == 4)
 		info->var = pm2fb_var;
 
@@ -1797,7 +1797,7 @@ static int __init pm2fb_setup(char *opti
 		else if (!strncmp(this_opt, "noaccel", 7))
 			noaccel = 1;
 		else
-			mode = this_opt;
+			mode_option = this_opt;
 	}
 	return 0;
 }
@@ -1833,8 +1833,8 @@ static void __exit pm2fb_exit(void)
 #ifdef MODULE
 module_exit(pm2fb_exit);
 
-module_param(mode, charp, 0);
-MODULE_PARM_DESC(mode, "Preferred video mode e.g. '648x480-8@60'");
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
 module_param(lowhsync, bool, 0);
 MODULE_PARM_DESC(lowhsync, "Force horizontal sync low regardless of mode");
 module_param(lowvsync, bool, 0);


---------------------------------------------------------------------- 	
Sprawdz gdzie lezy snieg, czy dzialaja armatki
i jak przygotowane sa stoki >>> http://link.interia.pl/f1cfc



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
