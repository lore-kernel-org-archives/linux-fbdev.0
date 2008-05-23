From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] uvesafb: change mode parameter to
	mode_option
Date: Fri, 23 May 2008 07:51:43 +0200
Message-ID: <20080523075143.1673c1ff.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JzQAL-00027y-Hi for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 22:50:10 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JzQAJ-0002yn-SE
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 22:50:09 -0700
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
Cc: Andrew Morton <akpm@linux-foundation.org>, spock@gentoo.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Try making more drivers using the "mode_option" parameter.
This one is quite new so drop the old "mode" parameter
before someone will start using it seriously.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/uvesafb.c linux-new/drivers/video/uvesafb.c
--- linux-2.6.25/drivers/video/uvesafb.c	2008-05-17 07:54:43.396205454 +0200
+++ linux-new/drivers/video/uvesafb.c	2008-05-23 07:33:41.281991131 +0200
@@ -2054,8 +2054,8 @@ MODULE_PARM_DESC(maxhf,
 module_param(maxvf, ushort, 0);
 MODULE_PARM_DESC(maxvf,
 	"Maximum vertical frequency [Hz], overrides EDID data");
-module_param_named(mode, mode_option, charp, 0);
-MODULE_PARM_DESC(mode,
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option,
 	"Specify initial video mode as \"<xres>x<yres>[-<bpp>][@<refresh>]\"");
 module_param(vbemode, ushort, 0);
 MODULE_PARM_DESC(vbemode,

----------------------------------------------------------------------
Wez udzial w konkursie i wygraj odlotowe nagrody!
Sprawdz sie >> http://link.interia.pl/f1e04


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
