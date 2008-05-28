From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fix scrolling after logo is cleared
Date: Wed, 28 May 2008 22:53:37 +0200
Message-ID: <20080528225337.9e01d40e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1Sd9-00046u-90 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 13:52:19 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1Sd7-0002o4-S0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 13:52:19 -0700
Received: from poczta.interia.pl (mi06.poczta.interia.pl [10.217.12.6])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 7C38D31B450
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 May 2008 22:51:35 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 21DF61324AA
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 May 2008 22:51:35 +0200 (CEST)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

If the 'clear' command is used on the frame buffer
with a logo the upper area is filled by few lines but
not scrolled anymore.
Fix this by removing the protected area for the logo
if any part of the logo is cleared.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-rc2/drivers/video/console/fbcon.c linux-new/drivers/video/console/fbcon.c
--- linux-rc2/drivers/video/console/fbcon.c	2008-05-12 18:16:23.193553990 +0200
+++ linux-new/drivers/video/console/fbcon.c	2008-05-26 21:10:17.592997192 +0200
@@ -1312,6 +1310,9 @@ static void fbcon_clear(struct vc_data *
 	if (!height || !width)
 		return;
 
+	if (sy < vc->vc_top && vc->vc_top == logo_lines)
+		vc->vc_top = 0;
+
 	/* Split blits that cross physical y_wrap boundary */
 
 	y_break = p->vrows - p->yscroll;

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e13  


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
