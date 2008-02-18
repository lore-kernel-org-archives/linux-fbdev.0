From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] add removed option "mode" to keep
	compatibility
Date: Mon, 18 Feb 2008 22:43:00 +0100
Message-ID: <20080218224300.bbcd0cdb.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JREaW-0004Bk-So for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 14:35:54 -0800
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JREaV-0000q8-6o
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 14:35:52 -0800
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

This patch adds removed option "mode" to keep
compatibility with existing setups.
The option is back for pm2fb, tridentfb and vt8623fb drivers.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This patch is against 2.6.25-rc2-mm1 tree.

diff -urp linux-mm-ref/drivers/video/pm2fb.c linux-mm/drivers/video/pm2fb.c
--- linux-mm-ref/drivers/video/pm2fb.c	2008-02-18 21:12:29.000000000 +0100
+++ linux-mm/drivers/video/pm2fb.c	2008-02-18 21:19:25.908465257 +0100
@@ -1835,6 +1835,8 @@ module_exit(pm2fb_exit);
 
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
+module_param_named(mode, mode_option, charp, 0);
+MODULE_PARM_DESC(mode, "Initial video mode e.g. '648x480-8@60' (deprecated)");
 module_param(lowhsync, bool, 0);
 MODULE_PARM_DESC(lowhsync, "Force horizontal sync low regardless of mode");
 module_param(lowvsync, bool, 0);
diff -urp linux-mm-ref/drivers/video/tridentfb.c linux-mm/drivers/video/tridentfb.c
--- linux-mm-ref/drivers/video/tridentfb.c	2008-02-18 21:12:29.000000000 +0100
+++ linux-mm/drivers/video/tridentfb.c	2008-02-18 21:21:39.691805349 +0100
@@ -75,6 +75,8 @@ static int nativex;
 
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
+module_param_named(mode, mode_option, charp, 0);
+MODULE_PARM_DESC(mode, "Initial video mode e.g. '648x480-8@60' (deprecated)");
 module_param(bpp, int, 0);
 module_param(center, int, 0);
 module_param(stretch, int, 0);
diff -urp linux-mm-ref/drivers/video/vt8623fb.c linux-mm/drivers/video/vt8623fb.c
--- linux-mm-ref/drivers/video/vt8623fb.c	2008-02-18 21:12:29.000000000 +0100
+++ linux-mm/drivers/video/vt8623fb.c	2008-02-18 21:22:09.162303810 +0100
@@ -112,6 +112,8 @@ MODULE_DESCRIPTION("fbdev driver for int
 
 module_param(mode_option, charp, 0644);
 MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
+module_param_named(mode, mode_option, charp, 0);
+MODULE_PARM_DESC(mode, "Default video mode e.g. '648x480-8@60' (deprecated)");
 
 #ifdef CONFIG_MTRR
 module_param(mtrr, int, 0444);


---------------------------------------------------------------------- 	
Sprawdz gdzie lezy snieg, czy dzialaja armatki
i jak przygotowane sa stoki >>> http://link.interia.pl/f1cfc



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
