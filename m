From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fbcon: fix wrong vmode bits copied on
	console switch
Date: Fri, 23 May 2008 10:09:34 +0200
Message-ID: <20080523100934.27232c7b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JzSJh-0007rw-HV for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 May 2008 01:07:57 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JzSJg-00046D-0m
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 May 2008 01:07:57 -0700
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The interlaced and double line mode bits should not be
copied to new console when the console is switched.
Otherwise, the new console may be set to incorrect refresh
rate.

Also, the x and y offsets does not need to be copied.


Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/console/fbcon.c linux-new/drivers/video/console/fbcon.c
--- linux-2.6.25/drivers/video/console/fbcon.c	2008-05-23 10:06:04.144074130 +0200
+++ linux-new/drivers/video/console/fbcon.c	2008-05-23 09:44:50.544333721 +0200
@@ -2274,9 +2274,7 @@ static int fbcon_switch(struct vc_data *
 	 * in fb_set_var()
 	 */
 	info->var.activate = var.activate;
-	var.yoffset = info->var.yoffset;
-	var.xoffset = info->var.xoffset;
-	var.vmode = info->var.vmode;
+	var.vmode |= info->var.vmode & ~FB_VMODE_MASK;
 	fb_set_var(info, &var);
 	ops->var = info->var;
 


----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
