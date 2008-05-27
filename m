From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tdfxfb: add mode_option module parameter
Date: Tue, 27 May 2008 19:02:28 +0200
Message-ID: <20080527190228.c0de7b4f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K12XO-0005pB-Np for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 May 2008 10:00:39 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K12XN-0006UI-1P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 May 2008 10:00:38 -0700
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

Small step toward unification of mode setting parameter.
This is required to fix the Bugzilla's bug 9847

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/tdfxfb.c linux-new/drivers/video/tdfxfb.c
--- linux-2.6.25/drivers/video/tdfxfb.c	2008-05-17 07:54:43.388206192 +0200
+++ linux-new/drivers/video/tdfxfb.c	2008-05-27 18:51:26.874974261 +0200
@@ -1426,6 +1426,8 @@ MODULE_LICENSE("GPL");
 module_param(hwcursor, int, 0644);
 MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
 			"(1=enable, 0=disable, default=1)");
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disable MTRR support (default: enabled)");


----------------------------------------------------------------------
Mucha powraca!
Sprawdz >>> http://link.interia.pl/f1e0d


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
