From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] pm3fb: change option mode to mode_option
Date: Thu, 14 Feb 2008 22:56:13 +0100
Message-ID: <20080214225613.39db9efe.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPlz0-0003ZT-5J for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 13:51:06 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JPlyy-0006Q7-HK
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 13:51:06 -0800
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

This patch was created against 2.6.25-rc1 kernel.

diff -urp linux-ref/drivers/video/pm3fb.c linux-pc/drivers/video/pm3fb.c
--- linux-ref/drivers/video/pm3fb.c	2008-02-04 20:46:27.000000000 +0100
+++ linux-pc/drivers/video/pm3fb.c	2008-02-05 21:41:15.000000000 +0100
@@ -1571,6 +1571,8 @@ module_exit(pm3fb_exit);
 #endif
 module_init(pm3fb_init);
 
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
 module_param(noaccel, bool, 0);
 MODULE_PARM_DESC(noaccel, "Disable acceleration");
 module_param(hwcursor, int, 0644);

----------------------------------------------------------------------
Potega i sila na wyciagniecie reki - sprawdz!
Zagraj >>> http://link.interia.pl/f1cf3


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
