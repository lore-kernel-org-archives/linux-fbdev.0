From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: fix memory size detection
Date: Wed, 5 Mar 2008 22:07:44 +0100
Message-ID: <20080305220744.824e839e.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JX0ji-00064q-5P for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 13:01:14 -0800
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JX0jg-0001wz-Lg
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 13:01:14 -0800
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

Tiny patch which fixes memory size multiplier
during detection.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---


diff -urp linux-ref/drivers/video/tridentfb.c linux-2.6.23/drivers/video/tridentfb.c
--- linux-ref/drivers/video/tridentfb.c	2007-11-01 14:07:27.461666762 +0100
+++ linux-2.6.23/drivers/video/tridentfb.c	2007-11-01 15:02:17.622078751 +0100
@@ -755,7 +754,7 @@ static unsigned int __devinit get_memsiz
 			switch (tmp) {
 
 			case 0x01:
-				k = 512;
+				k = 512 * Kb;
 				break;
 			case 0x02:
 				k = 6 * Mb;	/* XP */

----------------------------------------------------------------------
Kochasz kobiety? Nie zapomnij o nich!
kliknij >> http://link.interia.pl/f1d47 	



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
