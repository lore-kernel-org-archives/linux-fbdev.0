From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] modedb: fix incorrect sync and vmode
	flags for CVT modes
Date: Wed, 28 May 2008 22:49:21 +0200
Message-ID: <20080528224921.da1f0f15.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1SYS-0003bt-SW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 13:47:29 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1SYR-0002yf-C7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 13:47:28 -0700
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

The temporary structure for calculated CVT mode
is not initialized. Few fields have only bits or-ed
or and-ed so they may be left in incorrect (random) state.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
It would be good to have this fix in 2.6.26.

Testing of the tridentfb seems like a good exercise
for the fbdev layer.

diff -urp linux-2.6.25/drivers/video/modedb.c linux-new/drivers/video/modedb.c
--- linux-2.6.25/drivers/video/modedb.c	2008-05-27 21:57:38.644359809 +0200
+++ linux-new/drivers/video/modedb.c	2008-05-28 22:40:26.149499108 +0200
@@ -590,6 +590,7 @@ done:
 		    "", (margins) ? " with margins" : "", (interlace) ?
 		    " interlaced" : "");
 
+	    memset(&cvt_mode, 0, sizeof(struct fb_videomode));
 	    cvt_mode.xres = xres;
 	    cvt_mode.yres = yres;
 	    cvt_mode.refresh = (refresh) ? refresh : 60;

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e13  


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
